# PRYSM Verification Process Blind-Spot Audit — 2026-09-01

Status: COMPLETE / GOVERNANCE CORRECTIONS APPLIED

## Trigger

A fresh production TBK audit `aab3c6f9-0cfd-44fb-a263-5c02f6834d8d` failed at Writer pass 1 after PDV4 had already passed deterministic Whole-App branch coverage and independent audit.

This means the process did not merely miss a product defect. It overstated what its proof actually established.

## Audit question

What process assumptions allowed PRYSM to report strong closure evidence while the real Writer path could still fail immediately in production?

## Material blind spots found

### B1 — Deterministic Whole-App proof was over-interpreted

The existing Whole-App gate is strong at repository-controlled branch composition, persistence/reload, lifecycle, deterministic validation, and controlled Writer/Judge seams.

It does not prove stochastic model generation reliability.

Prior process language did not make that limitation hard enough, allowing Whole-App PASS to carry more confidence than warranted for live Writer shaping.

Correction:
- created permanent `PRYSM_MODEL_BEARING_RELEASE_GATE.md`;
- amended project governance and Whole-App branch coverage to state deterministic PASS is only one proof plane.

### B2 — The efficient “one proving check” rule leaked into release closure

`WORKFLOW_INSTRUCTIONS.md` correctly optimized bounded edit progression around one highest-information proving check.

The process did not sharply distinguish that local efficiency rule from release closure. For high-risk Narrative work, one direct check is insufficient.

Correction:
- `WORKFLOW_INSTRUCTIONS.md` now explicitly separates edit progression from release closure;
- model-bearing release requires layered deterministic, real-artifact, real-model, semantic, deployment, and live-confirmation proof.

### B3 — Real production artifacts were not a mandatory primary Writer corpus

Synthetic fixtures and deterministic controlled outputs can prove code contracts while failing to represent the semantic shapes real models generate.

Correction:
- exact incident replay is mandatory;
- real persisted production artifacts are primary corpus evidence;
- synthetic fixtures are supplemental;
- production artifacts must retain hashes/provenance and may not be silently sanitized to pass.

### B4 — No repeated real-model robustness requirement

One successful Writer/Judge generation can be luck. A stochastic system can pass once and fail on the next equivalent input.

Correction:
- primary escaped input requires at least 5 independent Writer generations;
- at least two additional real corpus inputs require at least 3 generations each when available;
- at least 3 complete Writer -> Judge runs across the corpus;
- a materially invalid required sample is FAIL, not “randomness.”

### B5 — Semantic citation validity could stop at reference existence

A reference ID can exist and still not support the sentence using it.

Correction:
- semantic citation relevance is now a mandatory adversarial and Auditor challenge;
- AI, technical, conversion, trust, competitor, and other claims must cite materially relevant evidence, not merely a valid token.

### B6 — Builder semantic scoring could confirm its own assumptions

A Builder that authored the repair can also rationalize its semantic score.

Correction:
- every required model-bearing output must meet the five-area threshold;
- independent Auditor must re-score at least three outputs when available;
- scoring disagreement thresholds require reconciliation before PASS.

### B7 — Deployment identity was not hard enough

Repository `main`, Vercel UI deployment, and Railway worker execution identity are different facts.

The process previously accepted a Railway-linked success status as stronger evidence of PRYSM worker deployment identity than it actually was.

Correction:
- `DIAGNOSTIC_EVIDENCE_PROTOCOL.md` now requires deployed runtime identity for deployment-sensitive live failures;
- `PRYSM_MODEL_BEARING_RELEASE_GATE.md` makes exact Railway worker identity mandatory before a live audit can count as validation;
- inability to prove worker revision is a release-control defect, not something to infer away.

### B8 — Branch coverage did not explicitly distinguish semantic-distribution escapes

A branch may be represented and executed while the fixture/model-output distribution still misses the real failing semantic condition.

Correction:
- Whole-App branch protocol now defines `semantic-distribution/model-bearing escape`;
- known semantic escapes require exact production-artifact and counterexample coverage in addition to the branch row.

### B9 — No permanent narrative-only real-model harness requirement

Without a governed way to call Writer/Judge on stored production evidence, the team is pushed toward expensive, slow full recrawls just to test downstream narrative shaping.

Correction:
- permanent Model-Bearing Release Gate requires a narrative-only validation harness that uses frozen persisted evidence and isolated test persistence while exercising the real configured Writer/Judge path through finalization/render.

### B10 — No explicit overfitting/holdout requirement

A repair can become TBK-specific or tuned to one visible validation sentence.

Correction:
- model-bearing gate adds holdout expectations when corpus size permits;
- Auditor must independently select/challenge at least part of the model-bearing sample;
- TBK-specific hardcoding and regex overfitting are explicit failure modes.

### B11 — “All tests green” remained too easy to communicate as “works”

Test counts do not describe proof boundaries.

Correction:
- anti-slop release language now prohibits `all tests pass`, `Whole-App PASS`, one Writer call, one Judge PASS, or one render from being sufficient model-bearing release claims;
- release claims must identify the proof planes actually completed.

### B12 — Absolute reliability cannot be truthfully guaranteed

No finite sample can prove a stochastic model will never fail.

Correction:
- governance now requires evidence-backed robustness rather than false certainty;
- hard deterministic rules remain fail-closed;
- model-bearing sample, semantic thresholds, independent challenge, and final live confirmation materially reduce risk without pretending to create mathematical certainty.

### B13 — Model-bearing status was not separately durable

The autorun state had a deterministic `wholeAppGate` field but no separate durable model-bearing gate state. That made it too easy for future agents or humans to collapse two different proof claims into one green flag.

Correction:
- created `PRYSM_MODEL_BEARING_GATE_STATE.json`;
- it independently tracks incident replay, runtime identity, corpus, narrative-only harness, parity, adversarial/failure injection, required Writer/Judge sample counts, semantic quality, red-team, second verification, Auditor re-score, deterministic Whole-App, deployment identity, and final live-validation eligibility;
- `PROJECT.md`, `CURRENT_STATE.md`, and `PRYSM_AUTORUN_STATE.json` now require this separate state when the Model-Bearing Release Gate applies.

## Files created/updated

Created:
- `PRYSM_MODEL_BEARING_RELEASE_GATE.md`
- `PRYSM_MODEL_BEARING_GATE_STATE.json`
- `DECISION_PDV5_RELIABILITY_OVER_COST_AND_GOVERNED_AUTORUN_2026-09-01.md`
- this audit record.

Updated:
- `PROJECT.md`
- `WORKFLOW_INSTRUCTIONS.md`
- `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`
- `PRYSM_WHOLE_APP_BRANCH_COVERAGE_PROTOCOL.md`
- `PRYSM_POSTRUN_AUDIT_PROTOCOL.md`
- `PRYSM_INTEGRATION_ESCAPE_LEDGER.md`
- `CURRENT_STATE.md`
- `PRYSM_AUTORUN_STATE.json`

## Resulting release-proof model

For model-bearing work the durable sequence is now:

`exact failure evidence -> root-cause map -> direct repair proof -> exact-SHA deterministic Whole-App/branch coverage -> exact production-artifact replay -> repeated real Writer/Judge runs on frozen production-shaped inputs -> five-area semantic gate -> red-team/counterexample challenge -> independent Auditor re-score -> deployment identity -> one authorized live end-to-end confirmation`

No earlier step may be silently substituted for a later one.

## Remaining uncertainty

The governance changes improve the proof process but do not themselves fix PDV5 application behavior.

PDV5 still must:

- reproduce the exact stored Writer failure;
- classify the root(s);
- prove the worker revision that executed the failure or record it as unproven;
- implement the narrative-only model-bearing harness if not already sufficient;
- repair the application/contract/proof defect(s);
- execute all newly required gates.

## Verdict

The previous verification process was materially incomplete for stochastic Writer reliability even though it had strong deterministic integration controls.

The governance gap is now explicitly closed at the protocol level.

Application reliability remains **UNPROVEN / PDV5 ACTIVE** until the new process executes successfully.