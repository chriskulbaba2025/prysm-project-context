# PRYSM Model-Bearing Release Gate

Gate ID: PRYSM-MODEL-BEARING-RELEASE-GATE-01
Status: ACTIVE / MANDATORY
Effective: 2026-09-01

## Purpose

Prevent a false release PASS in which deterministic repository tests, Whole-App branch coverage, and exact-SHA integration checks are green while the actual stochastic Writer/Judge process still produces invalid, unsupported, contradictory, repetitive, or otherwise unusable client-facing output.

This gate is permanent. It applies whenever a change or production escape materially touches:

- WriterInput or reference semantics;
- Writer prompt/instructions;
- Writer structured-output/schema constraints;
- Writer normalization or validation;
- semantic-fidelity validation;
- Judge prompt/contract/decision handling;
- Narrative orchestration or pass sequence;
- model configuration that can change generated narrative;
- client-facing Narrative quality or action-plan behavior;
- any live production defect that deterministic Narrative tests failed to catch.

## Core rule

> Deterministic Whole-App PASS proves repository-controlled composition. It does not, by itself, prove model-bearing reliability.

For model-bearing changes, release readiness requires separate proof planes. A PASS on one plane never substitutes for another.

## Required proof planes

### Plane 1 — Deterministic repository integrity

The exact candidate SHA must pass:

- direct root-cause proof;
- permanent positive and negative regressions;
- prompt/schema/validator parity checks;
- `PRYSM_WHOLE_APP_TRANCHE_GATE.md`;
- `PRYSM_WHOLE_APP_BRANCH_COVERAGE_PROTOCOL.md`;
- applicable complete regression/build/type/scope checks;
- clean-tree, unchanged-SHA, local/remote synchronization proof.

This plane must remain deterministic and may use controlled Writer/Judge executors.

### Plane 2 — Exact production-artifact replay

For every production escape used to justify the repair:

- recover the exact persisted WriterInput and exact parsed provider response before normalization/validation;
- preserve artifact identity and SHA-256 hashes;
- replay the exact production normalization/validation path without rewriting the fixture;
- reproduce the original failure before repair when technically possible;
- prove the repaired boundary against the same original bytes;
- preserve historically valid real production outputs as positive siblings.

A hand-authored fixture that merely resembles the incident cannot replace this plane.

### Plane 3 — Real model-bearing robustness on frozen inputs

When live/paid model execution is authorized by current durable state, exercise the actual configured Writer/Judge models against frozen production-shaped inputs without recrawling or mutating the original audit.

The required baseline sample for a high-risk Writer/Judge repair is:

- primary escaped production input: at least 5 independent Writer generations;
- each of at least 2 additional real production-shaped corpus inputs, when available: at least 3 independent Writer generations each;
- at least 3 complete Writer -> Judge orchestration runs across the corpus, including at least 1 on the primary escaped input.

If fewer than two additional real inputs exist, record the limitation explicitly and do not fabricate them.

For every required model-bearing run record:

- exact candidate application SHA;
- model identifier;
- prompt version;
- output/contract version;
- structured-output/schema identity or hash where available;
- validator identity/version where available;
- pass number;
- raw/parsed output artifact hash;
- validation result and complete errors;
- Judge result when invoked;
- usage/cost;
- semantic-quality result.

Required outcome:

- zero Writer structural-validation failures;
- zero semantic-fidelity critical defects;
- zero UNKNOWN/UNAVAILABLE/PARTIAL/NOT ASSESSED integrity conversions;
- zero fabricated evidence or unsupported causal/commercial certainty;
- zero materially irrelevant evidence citations;
- no material root-cause/action-plan contradiction;
- no unexplained prompt/schema/validator mismatch.

A single lucky generation is not proof. A single materially invalid generation in the required sample is a gate FAIL and must be diagnosed as model-shaping or contract robustness evidence, not dismissed as randomness.

### Plane 4 — Five-area semantic quality

Score every required model-bearing Writer sample in exactly five areas, 20 points each:

1. Evidence Fidelity.
2. Semantic Traceability.
3. Decision Quality.
4. Coherence and Non-Redundancy.
5. Client Actionability.

For each scored output:

- overall score must be at least 97/100;
- no area may be below 19/20;
- any critical evidence-integrity defect is automatic FAIL regardless of score;
- every deduction must identify the exact output path and reason.

Do not average a weak output away. Each required sample must satisfy the threshold.

### Plane 5 — Independent semantic challenge

Builder self-scoring is not sufficient for final closure.

The independent Auditor must:

- inspect the scoring rubric and evidence;
- independently re-score at least 3 model-bearing outputs when at least 3 exist, including the primary escaped-input output and at least one additional corpus output when available;
- select at least one output/corpus case independently rather than accepting only Builder-selected examples;
- inspect valid-looking evidence references for actual semantic relevance;
- challenge cross-section consistency, repetition, bounded language, and action hierarchy;
- record any scoring disagreement greater than 2 total points or any dimension disagreement greater than 1 point as a review item requiring resolution before PASS.

Any Auditor-discovered critical integrity defect is FAIL.

### Plane 6 — Deployment identity before live validation

Before a post-repair production audit can count as validation, prove the deployed identities independently:

- GitHub application main SHA;
- exact Railway PRYSM worker revision/SHA;
- exact Vercel/UI deployment SHA where the UI participates;
- active model configuration and prompt/contract versions where externally configured.

Do not infer worker identity from GitHub main, Vercel, or an unrelated deployment status.

If the worker SHA cannot be proven, deployment readiness is BLOCKED/UNPROVEN. A live audit against an unproven runtime cannot close the release gate.

Where practical, the application should expose a read-only version/health identity that returns the deployed commit/revision and relevant contract/model configuration identifiers without exposing secrets. If the current production platform cannot prove deployment identity reliably, that is a release-control defect to repair.

### Plane 7 — One final end-to-end production confirmation

Only after Planes 1-6 PASS may one fresh end-to-end production audit be used as confirmation.

The production confirmation is not the primary discovery mechanism for repository-controlled Writer defects.

If that confirmation exposes a new material failure:

- record a new integration/model escape;
- add it to the permanent corpus/matrix as applicable;
- return to diagnosis;
- do not call earlier deterministic/model-bearing PASS evidence proof that production works.

## Permanent narrative-only validation harness

PRYSM must maintain a governed way to exercise the real Writer/Judge shaping path against frozen persisted production evidence without paying to recollect website/provider evidence.

The harness must, as applicable:

`persisted governed evidence/scores -> production WriterInput builder/load boundary -> real configured Writer -> exact normalization -> Writer validation -> real configured Judge -> Judge validation -> finalization -> render`

It must use isolated test/replay persistence and must not mutate the original production audit lifecycle or overwrite historical artifacts.

A harness that starts from a hand-built WriterOutput after the failing model boundary is insufficient for model-bearing proof.

## Holdout / overfitting rule

When the real corpus contains enough cases, reserve at least one real production-shaped input as a holdout not used to tune the initial repair.

The independent Auditor should choose or confirm the holdout after candidate freeze when practical.

If no holdout exists, state that limitation. Do not claim broad distribution robustness from one site/input.

## Corpus safety and provenance

Do not commit secrets, credentials, or sensitive raw client/provider payloads into a public application repository.

For durable corpus evidence:

- prefer hashes/manifests and governed private/local artifact references;
- commit only sanitized/minimized fixtures when they preserve the exact material semantics required by the test;
- prove any sanitized fixture's derivation from the original artifact and retain the original hash;
- never silently edit a production fixture until it passes.

## Prompt/schema/validator parity rule

Every material hard runtime rule must be one of:

1. explicitly instructed to the Writer/Judge;
2. structurally impossible through the configured schema/structured output;
3. an intentional defensive last gate with documented reason and positive/negative regression.

Maintain a deterministic mapping:

`RULE -> PROMPT INSTRUCTION -> SCHEMA/STRUCTURAL CONSTRAINT -> VALIDATOR -> POSITIVE TEST -> NEGATIVE TEST`

A hidden downstream rule that a model can reasonably trigger is a release defect.

## Variance and consistency rule

Model outputs need not be text-identical, but materially governed decisions must remain consistent with deterministic evidence.

Across repeated runs on identical frozen input, challenge at least:

- root-cause identity/meaning;
- action ordering and governed priority constraints;
- evidence-status interpretation;
- limitation scope;
- major factual claims;
- recommendation class and bounded expected effect.

Material contradiction across otherwise valid generations is a robustness defect even when each output individually passes syntax.

## Anti-slop release language

The following are prohibited as sufficient release claims for a model-bearing change:

- `all tests pass`;
- `npm test is green`;
- `Whole-App PASS`;
- `6/6 scenarios PASS`;
- `the prompt looks correct`;
- `one live Writer call passed`;
- `the report rendered`;
- `Judge passed one sample`.

A model-bearing release claim must identify which proof planes passed and the real corpus/sample evidence behind them.

## Relationship to efficient local verification

The normal rule of one highest-information proving check remains correct for progressing a bounded source edit.

It does not define release closure.

Use:

`one direct proving check -> continue implementation`

but require:

`direct proof -> deterministic branch-complete Whole-App -> real artifact replay -> model-bearing robustness -> semantic challenge -> deployment identity -> authorized production confirmation`

for model-bearing release readiness.

## Closure semantics

No finite test can prove that a stochastic model will never fail again. PRYSM must not claim absolute certainty.

The governed target is instead: repeated success against real production-shaped inputs, zero critical integrity failures in the required sample, deterministic enforcement of hard rules, independent semantic challenge, exact deployed-runtime identity, and permanent regressions for every known escape.

For an application-changing model-bearing checkpoint, the highest pre-deployment state is:

`READY_FOR_AUTHORIZED_PRODUCTION_PROMOTION`

After deployment identity is proven and before the one final live audit:

`READY_FOR_ONE_AUTHORIZED_LIVE_VALIDATION`

Only a successful authorized live confirmation may close the post-deployment validation checkpoint.