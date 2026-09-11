# PRYSM Live UAT Validator Negation False Positive

Date: 2026-09-10

## Result

`LIVE_UAT_VALIDATION_FAIL / VALIDATOR_FALSE_POSITIVE_DIAGNOSED / HIGH`

## Exact application candidate

- repository: `chriskulbaba2025/vantage-platform`
- branch: `review/prysm-solution-directive-authority-betty`
- application HEAD: `6a87037c3c94a13d5c42ca505d6c6557eb962664`
- Writer prompt version: `2.4.0`
- WriterInput version: `1.2.0`
- ScoreSet contract: `2.0.0`

## Live run result

Execution ID: `live-uat-single-tbk-256c51b4-6a61-446c-ad2c-c4dc9753ac04`

The fresh Writer call completed successfully at the provider boundary but WriterOutput semantic validation rejected `conversion.constraints.text` before Judge invocation.

Exact Writer text:

`No material conversion-path limitation was established from the assessed evidence. A visible invitation and a clear assessed path do not establish visitor completion or conversion performance.`

Validator error:

`writerOutput.conversion.constraints.text states an unmeasured business outcome with causal certainty`

Writer calls: 1.
Judge calls: 0.
Deployment: not attempted.

## Proven first divergence

Root cause: `WRITER_OUTPUT_NEGATION_GRAMMAR_FALSE_POSITIVE`

`services/worker/src/narrative-v2/writer-output.js` uses `establishedOutcomePattern` to detect verbs such as `establish`, then uses `nonEstablishmentOutcomePattern` to exempt explicitly non-establishing statements.

The exemption grammar recognizes forms including:

- `does not establish`
- `did not establish`
- `has/have not established`
- `cannot establish`
- `not established`

It does **not** recognize the grammatically valid form:

- `do not establish`

The Writer's sentence uses exactly `do not establish visitor completion or conversion performance`. Therefore the established-outcome detector fires while the non-establishment exemption fails to match, producing a false positive.

The Writer sentence itself is correctly bounded and consistent with Writer prompt Rule 8d and repaired Rule 11a. It explicitly denies that path evidence establishes visitor completion or conversion performance.

## Not the defect

This is not a defect in:

- WriterInput;
- ScoreSet or scoring;
- decision hierarchy;
- Writer prompt 2.4.0;
- paused GA4 authority;
- provider binding;
- Judge;
- TBK fixture;
- Vercel linkage.

## Minimum legitimate repair

Repair only the non-establishment grammar in `writer-output.js` so explicit negation forms including `do not establish` / `do not confirm` / equivalent governed non-establishment forms are treated as bounded denial rather than established commercial outcomes.

Add focused positive/negative regression proving:

1. `do not establish visitor completion or conversion performance` is accepted;
2. `does not establish conversion performance` remains accepted;
3. `conversion performance is not established` remains accepted;
4. affirmative `establishes conversion performance` remains rejected;
5. causal certainty such as `will increase conversions` remains rejected;
6. mixed text containing a bounded denial plus a separate affirmative unsupported commercial claim remains rejected.

Do not weaken the commercial-outcome guard broadly and do not bypass `establishedOutcomePattern`.

## Authorization consequence

The prior model-bearing and staging authorization was tied to exact application HEAD `6a87037c3c94a13d5c42ca505d6c6557eb962664` and is consumed by the failed execution.

The next step is a zero-model-call local validator repair and deterministic regression only. Any changed application HEAD will require fresh explicit Chris authorization before another Writer/Judge call or staging deployment.

## Exact next action

Run one bounded zero-model-call validator repair against the exact proven negation grammar defect, run focused plus broad deterministic regression, create one local commit, and stop before model/provider/deployment actions.
