# PDV5 Writer Audit-Completion Repair Protocol — 2026-09-01

Status: ACTIVE / BUILDER AUTHORIZED

## Single objective

Make a normal PRYSM audit reliably get through the Writer/Narrative stage and complete.

Current failed production audit:

`aab3c6f9-0cfd-44fb-a263-5c02f6834d8d`

Observed failure:

`narrative_pending -> narrative_failed`

Writer failed on pass 1. The visible error begins at:

`writerOutput.aiSearch.citationReadiness.text ...`

The exact full Writer validation error must be recovered from the persisted Writer artifacts.

This checkpoint is **not** a governance redesign, release-process redesign, crawler redesign, scoring redesign, report redesign, or general PRYSM architecture review.

The audit already reaches Writer. Fix Writer/Narrative completion.

## Owner instruction

Reliability matters more than Writer/Judge call cost for this repair.

Paid Writer/Judge calls are authorized when needed to prove the Writer process actually works.

Do not avoid a useful Writer/Judge test to save money.

Do not repeatedly recrawl the site unless the Writer investigation proves new evidence collection is required. The preferred test input is already-persisted production evidence so Writer can be exercised quickly and repeatedly.

## Governing execution method

Use the existing governed PRYSM autorun controller:

`tools/autorun/PRYSM-AUTORUN.ps1`

Do not replace the PowerShell Builder/Auditor flow with an ad-hoc standalone Codex workflow.

## Hard scope boundary

PDV5 Builder may investigate and repair only what can materially cause a correctly collected/scored audit to fail or stall from Writer input through completed Narrative/report finalization.

Primary path:

`persisted evidence/scores -> WriterInput -> Writer prompt/schema -> Writer provider response -> normalization -> Writer validation -> Judge/revision if required -> finalization -> completed report state`

In scope when proven relevant:

- WriterInput construction;
- Writer reference index/evidence context;
- Writer prompt instructions;
- Writer structured-output/schema contract;
- model output parsing;
- Writer normalization;
- Writer structural validation;
- Writer semantic validation;
- word/character/field limits;
- evidence-reference rules;
- statement-class rules;
- PARTIAL/UNKNOWN/UNAVAILABLE wording rules;
- AI-search/citation-readiness wording and evidence support;
- Writer retry/revision behavior after invalid output;
- Judge handoff only to the extent required for the audit to continue;
- finalization only to prove the repaired Writer output can reach the completed report state;
- persisted Narrative artifacts required to resume/complete safely.

Out of scope unless direct Writer-completion evidence proves otherwise:

- crawler/provider acquisition changes;
- scoring redesign;
- unrelated report styling;
- broad governance redesign;
- unrelated branch-matrix expansion;
- unrelated deployment/release-control work;
- general product refactors;
- optimization work unrelated to audit completion.

Do not create work simply because it could theoretically improve PRYSM.

## Phase 1 — reproduce the exact Writer failure

Before editing application source:

1. Recover exact local/GitHub state and preserve dirty work.
2. For audit `aab3c6f9-0cfd-44fb-a263-5c02f6834d8d`, load the exact persisted WriterInput.
3. Load the exact parsed Writer pass-1 provider response persisted before normalization/validation.
4. Run those exact artifacts through the current production Writer normalization/validation boundary.
5. Capture the complete Writer error list.

No guessing from the truncated UI/lifecycle error.

If the exact stored output does not reproduce the Writer failure, diagnose only the Writer-path replay mismatch until it does.

## Phase 2 — find Writer-completion blind spots

Once reproduced, inspect the complete Writer path for **additional defects that can cause the audit not to finish**.

Be aggressive but bounded.

Mandatory blind-spot review:

### A. Prompt vs validator

For every Writer validation rule that can reject model output, verify the Writer is actually told how to satisfy it.

A downstream rule hidden from Writer is a defect.

### B. Schema vs validator

Verify the structured-output schema does not permit values/structures that deterministic Writer validation later rejects.

If schema permits it and validator forbids it, repair the mismatch.

### C. Input sufficiency

Verify WriterInput contains enough evidence/context to generate every required field truthfully.

The model must not be required to infer unavailable evidence just to satisfy schema/validation.

### D. Citation/reference usability

Verify valid evidenceRefs are actually usable by Writer for the required text.

Specifically test the failing AI-search/citation-readiness path.

Reject fabricated refs, but do not make valid Writer output impossible because the prompt/reference index cannot express the supported claim.

### E. Length and formatting traps

Check every required field for prompt/schema/runtime disagreement on:

- word limits;
- character limits;
- minimum text requirements;
- prohibited Markdown/HTML/URLs;
- arrays/enum values;
- null/empty handling.

The Writer must not be routinely asked to produce output that another layer immediately rejects.

### F. Semantic wording traps

Check PARTIAL, UNKNOWN, UNAVAILABLE, NOT ASSESSED, absence wording, bounded language, OPPORTUNITY vs INTERPRETATION, causality and commercial-certainty rules.

Positive truthful wording must be possible.

### G. Normalization damage

Verify normalization does not turn a valid provider response into an invalid one or change its semantic meaning.

### H. Retry/recovery behavior

This is mandatory.

Determine what happens when Writer returns a structurally or semantically invalid response.

The audit must not unnecessarily die on one model miss if the governed design permits a safe correction/retry/revision using the same persisted evidence.

Inspect:

- whether pass 1 validation failure is terminal;
- whether validation errors can be fed back into a bounded correction attempt;
- whether the current two-pass Writer/Judge design actually reaches that correction path;
- whether an invalid Writer result is mistakenly treated as unrecoverable before Judge/revision can act;
- whether retries can loop or duplicate spend;
- whether a corrected result is revalidated before continuing.

Do not weaken evidence rules. Improve the shaping/recovery path if that is the proven reason a normal audit dies.

### I. Model-output variability

Use real Writer calls on the same frozen production WriterInput to find intermittent failures.

A fix that succeeds once and fails on the next equivalent Writer call is not complete.

### J. End-state completion

Do not stop proof at `Writer validation PASS`.

Prove the resulting Narrative continues through the actual downstream path required to reach the normal completed report state without another unrelated failure.

If a downstream failure is caused directly by the repaired Writer output/contract, fix it in PDV5.

If a genuinely unrelated subsystem fails, stop and classify it separately rather than broadening PDV5 silently.

## Phase 3 — smallest coherent Writer repair

After root cause is proven:

- create/recover the PDV5 repair branch;
- repair the Writer path at the actual failing boundary;
- align prompt, schema, input, normalization and validation where they materially disagree;
- preserve evidence integrity;
- do not simply relax validators until bad prose passes;
- do not hardcode TBK-specific content;
- do not special-case the exact failed sentence;
- ensure truthful valid alternatives can pass.

If Writer retry/revision behavior is the material failure mechanism, repair that mechanism as part of the same coherent Writer-completion package.

## Phase 4 — direct acid tests

Create permanent tests for the actual Writer failure plus nearby completion risks.

Required:

1. Exact failed production Writer output reproduces the pre-repair failure.
2. Repaired behavior handles that exact production-shaped condition correctly.
3. Valid bounded AI-search/citation-readiness wording passes.
4. Unsupported AI-search/citation claim fails.
5. Valid evidence ref with wrong semantic support fails where governed.
6. Correct supporting ref passes.
7. PARTIAL/UNKNOWN/UNAVAILABLE truthful bounded wording passes.
8. Unqualified overclaim fails.
9. Prompt/schema/validator rule parity for the root defect passes.
10. Writer normalization cannot corrupt the repaired valid output.
11. Invalid Writer response follows the intended bounded correction/retry path, if such a path is part of the repaired design.
12. Corrected Writer result is revalidated before Narrative continues.
13. Retry count is bounded; no infinite loop or uncontrolled duplicate spend.
14. Repaired Writer output reaches Judge/finalization/completed report state through the real local production composition.

## Phase 5 — real Writer stress test

Use the real configured Writer against frozen stored production-shaped inputs.

Cost is authorized.

At minimum:

### Primary failed TBK input

Run **5 independent Writer generations** using the exact production-shaped WriterInput from audit:

`aab3c6f9-0cfd-44fb-a263-5c02f6834d8d`

Every run must:

- parse successfully;
- pass Writer structural validation;
- pass Writer semantic validation;
- preserve evidence integrity;
- avoid unsupported claims;
- be capable of continuing the Narrative path.

### Additional real input

Use at least **one additional persisted real production WriterInput** if available and run **3 independent Writer generations**.

This is to prevent a TBK-only repair.

Do not spend time building a large corpus if one additional real case is enough to expose or disprove generality.

### Failure rule

If any required Writer generation fails:

- capture the exact output and errors;
- classify whether it is the same root or a new Writer-completion root;
- repair it;
- rerun the direct proving test first;
- then rerun the required Writer stress sample.

Do not dismiss an invalid output as randomness.

## Phase 6 — full Narrative completion test

After Writer stress passes, perform **3 complete Narrative runs** against frozen production-shaped evidence using the real configured Writer and Judge where the production design requires Judge.

At least **2** must use the primary failed TBK input.

Each run must prove:

`WriterInput -> Writer -> validation -> Judge/revision as applicable -> finalization -> completed/renderable report state`

No site recrawl is required for this proof.

Record exact terminal state and any retry/pass sequence.

All 3 must complete.

## Phase 7 — five semantic quality checks

For the generated Writer outputs, score only the areas that determine whether the audit output is actually usable:

1. Evidence Fidelity — /20
2. Semantic Traceability — /20
3. Decision Quality — /20
4. Coherence / Non-Redundancy — /20
5. Client Actionability — /20

Target:

- >=97/100 overall;
- no area below 19/20;
- zero critical evidence-integrity defect.

Do not turn this into an open-ended editorial project. Fix only material Writer defects that could make the report invalid, contradictory, misleading, or materially poor.

## Phase 8 — brutal completion challenge

After it appears fixed, try to make Writer fail again.

Focus only on audit-completion blind spots:

- same input, different Writer generation;
- slightly different valid evidence/reference mix;
- PARTIAL/UNKNOWN evidence;
- AI-search citation-readiness wording;
- maximum allowed text lengths;
- empty/limited evidence cases the Writer must handle truthfully;
- valid but semantically irrelevant evidence refs;
- invalid first Writer output followed by correction/retry;
- Judge REVISE path;
- second Writer pass if implemented;
- finalization of corrected output.

Do not invent unrelated product work.

## Phase 9 — exact candidate verification

Once the Writer path passes:

1. Freeze one exact application SHA.
2. Run the direct PDV5 Writer tests.
3. Run the existing Whole-App gate only to ensure this Writer repair did not break the assembled application.
4. Run applicable Narrative/worker regressions.
5. `git diff --check`.
6. Clean worktree.
7. Same exact SHA throughout.
8. Independent Auditor reviews the exact candidate, focusing on Writer completion and evidence integrity.

Do not broaden this into another governance tranche.

## PDV5 PASS standard

PDV5 Writer repair is PASS only when all are true:

1. Exact production Writer failure reproduced.
2. Exact Writer root cause(s) proven.
3. Writer repair implemented without weakening evidence integrity.
4. Prompt/schema/input/validator are congruent for the repaired rules.
5. Writer correction/retry behavior is proven if needed for reliable completion.
6. Exact failed production-shaped condition passes after repair.
7. 5/5 Writer generations on the primary failed TBK input pass.
8. 3/3 Writer generations on at least one additional real input pass when available.
9. 3/3 full Narrative completion runs pass, including at least two on the primary TBK input.
10. Generated output meets the five semantic quality thresholds.
11. Completion challenge finds no material Writer-path escape.
12. Existing Whole-App and applicable regressions remain green on one exact candidate SHA.
13. Independent Auditor finds no material Writer-completion/evidence-integrity defect.

Then stop at:

`READY_FOR_ONE_AUTHORIZED_LIVE_VALIDATION`

The next action is one fresh normal PRYSM audit in the app.

## What success means

The goal is not "the validator passes."

The goal is:

> A real production-shaped PRYSM audit can repeatedly generate valid Writer output, recover from a bounded bad Writer generation when the governed design allows it, continue through Narrative/Judge/finalization, and reach the normal completed report state.

Nothing outside that outcome should consume PDV5 time.
