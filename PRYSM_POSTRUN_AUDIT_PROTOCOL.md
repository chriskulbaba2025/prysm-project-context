# PRYSM Independent Post-Run Audit Protocol

Version: 1.1.0
Status: ACTIVE / MANDATORY FOR PRODUCTION CLOSURE
Effective: 2026-08-31

## Purpose

Provide a fresh-context independent challenge after every application-changing Production Closure tranche so Builder self-verification cannot be the sole authority for PASS.

The Auditor does not repair application code. It attempts to falsify the tranche's closure claim.

## Audit target contract

One audit target must resolve to:
- application repository `chriskulbaba2025/vantage-platform`;
- dedicated repair branch;
- one exact pushed application SHA;
- one closure tranche T1-T7 or active PDV checkpoint;
- corresponding Builder checkpoint evidence;
- corresponding PRYSM Whole-App Tranche Gate evidence;
- applicable model-bearing release evidence when required;
- applicable local/composite verification evidence.

If one exact target cannot be established, verdict is BLOCKED.

## Required audit dimensions

1. **Identity and scope**
   - exact branch/SHA;
   - local/remote equality;
   - clean candidate tree;
   - changed files match tranche objective;
   - no unrelated user work discarded.

2. **Producer-contract-consumer closure**
   - changed producer semantics persisted;
   - persisted contract defines release-critical fields;
   - read boundary validates current compatible artifact;
   - every consumer receives the current governed state;
   - no later consumer independently re-derives a contradictory answer.

3. **Single-source-of-truth review**
   - no duplicated current hierarchy/root-cause/report-model authority;
   - no base/V2/replay copy that can drift silently;
   - helper abstractions actually govern the production paths they claim.

4. **Semantic honesty**
   - UNKNOWN/UNAVAILABLE/PARTIAL/not-deeply-parsed remains explicit;
   - no missing -> 0/false/empty/Complete/AVAILABLE/NOT_CONNECTED coercion where meaning changes;
   - source status coherent across current artifacts and report surfaces.

5. **Version/compatibility integrity**
   - incompatible semantics have truthful versions;
   - current validator does not ambiguously accept historical shape;
   - legacy replay is separate from current release proof;
   - replay does not recompute historical business decisions using current algorithms without an explicit migration contract.

6. **Narrative governance**
   - WriterInput current required context is produced by current production path;
   - production-shaped fixtures activate current hierarchy checks;
   - Writer action order/rank/effort comes from governed current decision state;
   - Judge uses required current hierarchy evidence;
   - persisted release candidate is revalidated before render/recovery;
   - invalid terminal artifacts do not authorize another model spend unless an active durable decision explicitly authorizes a governed continuation.

7. **False-PASS audit**
   - no hardcoded `valid: true` at the production acceptance boundary;
   - no pre-seeded near-terminal state pretending to prove tip-to-tail production path;
   - no empty findings/hierarchy fixture when action parity is under test;
   - no synthetic richer-than-production input satisfying a validator;
   - no omitted test family hidden behind a label such as "full";
   - changed production path is exercised by Whole-App gate.

8. **Persistence/recovery**
   - write validation and read validation both exist for current release-critical artifacts;
   - exact identities survive persistence/reload;
   - recovery uses verified persisted state rather than reconstructed defaults;
   - repeat/recovery behavior does not trigger unauthorized paid work.

9. **Release controls**
   - exact-SHA gates precede PASS;
   - no PASS based on queued/stale CI;
   - application branch is synchronized;
   - governance is synchronized;
   - no merge/deploy/live audit was performed without explicit authorization;
   - model-bearing release proof is present whenever the change/escape touches Writer/Judge/model behavior.

10. **Blind-spot challenge**
   - ask what another consumer, restart path, historical artifact, fixture, model generation, or deployment variant could do with the changed contract;
   - search for the same field/semantic concept repository-wide;
   - inspect comments/docs that claim direct use while implementation reconstructs;
   - stop when the bounded audit has no material unresolved line of inquiry; do not turn the audit into open-ended redesign.

## Defect severity

CRITICAL:
- can produce materially wrong client-facing conclusion, evidence-status mutation, unauthorized spend, corrupted persistence/recovery, materially unsupported narrative, or false production readiness.

MAJOR:
- breaks a required current contract/path, leaves duplicate current authority, allows current false-PASS, omits required model-bearing proof, or prevents deterministic/model-bearing production closure.

MINOR:
- real issue that does not invalidate tranche safety/semantic correctness and can be scheduled separately.

Only zero CRITICAL/MAJOR findings permits verdict PASS.

## Verdicts

PASS:
No open CRITICAL/MAJOR findings and required proof is sufficient.

PASS_WITH_MINOR:
No CRITICAL/MAJOR findings, but one or more bounded MINOR findings require Builder disposition before automatic advance under this closure roadmap.

FAIL:
At least one CRITICAL/MAJOR finding.

BLOCKED:
Exact target/evidence cannot be established or required proof cannot safely be executed.

## Evidence standard

Prefer direct evidence in this order:
1. exact candidate source/diff;
2. persisted current artifact/schema;
3. executable test/gate at exact SHA;
4. real production-shaped model-bearing sample evidence when applicable;
5. local/remote Git/deployment identity;
6. current governance state;
7. historical artifacts only for compatibility comparison.

Do not infer PASS from comments, names, prior chats, previous green SHAs, Builder scoring, or a single successful model generation.

## Audit write contract

The Auditor owns only:
- `PRYSM_POSTRUN_AUDIT_STATE.json`;
- `AUDIT_PRYSM_PRODUCTION_CLOSURE_<TRANCHE>_<YYYY-MM-DD>.md` or active PDV audit file;
- bounded audit evidence summaries explicitly referenced by the report.

The Auditor does not edit application code or shared Builder state.

## Final audit

T7 final audit repeats the audit across the combined candidate, not merely the latest diff.

It must explicitly review all known systemic escape classes discovered on 2026-08-31 and later:
- missing Writer DecisionEvidence propagation;
- effort/rank fixture drift;
- Judge hierarchy reference drift;
- rootCauseRuleId producer/persistence/consumer loss;
- multiple model reconstructions;
- incomplete/permissive ScoreSet contract;
- stale WriterInput/current-historical version identity;
- replay compatibility contamination;
- semantic defaults in downstream packages;
- incomplete `npm test`/CI coverage;
- weak exact-head release control;
- deterministic Whole-App PASS being over-interpreted as stochastic Writer reliability;
- valid evidence IDs being semantically irrelevant to Writer prose;
- deployment/UI/worker SHA identity being conflated;
- one lucky Writer/Judge run being treated as robustness proof.

Final PASS requires one exact combined candidate SHA with no open material repository-controlled defect and every applicable deterministic/model-bearing release gate satisfied.

---

## Whole-App Branch Coverage Audit Amendment — mandatory after 2026-08-31

The Auditor must also read and enforce:

- `PRYSM_WHOLE_APP_BRANCH_COVERAGE_PROTOCOL.md`;
- `PRYSM_WHOLE_APP_BRANCH_MATRIX.md`.

A numeric Whole-App result such as `6/6 PASS` is not sufficient evidence of branch completeness.

For every application-changing candidate, the Auditor must independently challenge:

1. whether the matrix inventories every materially distinct currently implemented production branch relevant to persisted state, scoring eligibility, evidence semantics, hierarchy/root-cause, Narrative sequence, publication, recovery, replay, or rendering;
2. whether every required implemented branch ID is mapped to executable deterministic whole-app scenarios;
3. whether those scenarios actually traversed the real current producer -> persistence -> validated reload -> consumer boundaries rather than only leaf validators or richer-than-production fixtures;
4. whether each required branch executed and passed on the exact audited SHA;
5. whether gate evidence names the branch IDs covered rather than relying only on scenario names/counts;
6. whether a new or changed contract has an alternate producer/path that can emit a different shape;
7. whether any known live/UAT branch coverage or semantic-distribution escape has a permanent branch row plus realistic production-shaped/counterexample regression.

If a required implemented branch is `UNMAPPED`, `UNEXECUTED`, materially `UNKNOWN`, or omitted from the matrix, verdict cannot be PASS or PASS_WITH_MINOR. Return FAIL/BLOCKED according to whether the missing coverage is a repairable verification defect or cannot safely be established.

The known PDV1, PDV2, PDV3, PDV4, and subsequent production escapes are mandatory false-PASS challenge examples. The Auditor must verify that their escaped classes remain represented permanently; do not treat the immediate source repair alone as closure.

---

## Model-Bearing Release Audit Amendment — mandatory when applicable

The Auditor must read and enforce `PRYSM_MODEL_BEARING_RELEASE_GATE.md` whenever Writer/Judge/model-bearing behavior or Narrative semantic quality is changed or implicated by a production escape.

Deterministic Whole-App PASS is Plane 1 only. It cannot substitute for real model-bearing proof.

The Auditor must independently verify:

1. **Exact incident replay**
   - the original persisted production WriterInput/output identities and hashes are recorded;
   - the candidate replays the exact material boundary rather than a hand-rewritten approximation;
   - fixture preparation did not silently sanitize the failing semantics.

2. **Real corpus quality**
   - the primary escaped production input is present;
   - additional real production-shaped corpus inputs are used when they actually exist;
   - synthetic fixtures supplement rather than replace the real corpus;
   - any holdout limitation is explicit.

3. **Required model-bearing sample**
   - primary escaped input has at least 5 independent Writer generations;
   - each of at least 2 additional real corpus inputs has at least 3 Writer generations when available;
   - at least 3 complete Writer -> Judge orchestration runs exist across the corpus, including at least one on the primary escaped input;
   - model, prompt, schema/output-contract, validator identity, artifact hashes, outcomes, and usage/cost are recorded.

4. **No weak sample hidden by averaging**
   - every required scored sample is at least 97/100 overall;
   - no semantic area is below 19/20;
   - any critical evidence-integrity defect is automatic FAIL;
   - a materially invalid generation cannot be dismissed as randomness or averaged away.

5. **Independent semantic re-score**
   - independently select and re-score at least 3 model-bearing outputs when at least 3 exist;
   - include the primary escaped-input output and at least one additional corpus output when available;
   - independently inspect evidenceRefs for semantic relevance, not just existence;
   - challenge root-cause/action alignment, bounded language, contradictions, and redundancy;
   - any Builder/Auditor disagreement greater than 2 total points or greater than 1 point in any dimension must be reconciled before PASS.

6. **Variance/consistency**
   - repeated outputs on identical frozen input preserve materially governed decisions and evidence boundaries even when wording differs;
   - inconsistent root cause, action order, evidence scope, or major factual claims is a robustness defect.

7. **Deployment identity**
   - before a post-deployment live audit can count, exact Railway worker SHA/revision and participating UI deployment identity are directly proven;
   - GitHub main, Vercel status, or unrelated Railway status is not accepted as proof of worker identity.

8. **Anti-overfitting challenge**
   - look for TBK-specific hardcoding, regex overfitting, fixture-only preprocessing, prompt phrases tuned only to one failed sentence, and test seams that bypass actual production normalization/validation.

If any applicable Model-Bearing Release Gate plane is missing or materially weak, the Auditor verdict cannot be PASS.
