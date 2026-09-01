# Decision: PDV5 reliability over cost and governed autorun continuity

Date: 2026-09-01
Status: Active

## Decision

PDV5 continues through the existing governed GitHub -> PowerShell -> `tools/autorun/PRYSM-AUTORUN.ps1` -> Builder/Auditor loop.

Do not replace that operating method with an ad-hoc standalone Codex command unless the owner explicitly changes the method.

For PDV5, the owner explicitly prioritizes Writer/Narrative reliability over model-call cost. Materially useful paid Writer/Judge calls are authorized when they are part of the governed diagnostic or model-bearing verification plan.

## Why

The operating loop itself is not the defect. The defect exposed by audit `aab3c6f9-0cfd-44fb-a263-5c02f6834d8d` is that prior verification established deterministic repository integrity more strongly than it established actual stochastic Writer reliability.

Changing execution methods would add process variance without addressing that proof gap.

## Implications

1. Continue to use `PRYSM-AUTORUN.ps1` for PDV5 autonomous Builder/Auditor execution.
2. `PDV5_WRITER_ACID_TEST_REPAIR_PROTOCOL_2026-09-01.md` governs the active repair.
3. `PRYSM_MODEL_BEARING_RELEASE_GATE.md` is mandatory for PDV5 and future materially model-bearing PRYSM changes.
4. Cost minimization must not cause a necessary Writer/Judge robustness test to be skipped.
5. Model calls are not unlimited noise: they must use governed frozen production-shaped inputs, record provenance/results/cost, and satisfy the sample rules in the Model-Bearing Release Gate.
6. Prefer narrative-only/model-bearing runs against stored evidence over repeated full crawls when the defect is downstream of evidence collection.
7. Do not use a new full production audit as the primary mechanism to discover another Writer defect. First pass deterministic, real-artifact, model-bearing, semantic, and deployment-identity gates.
8. Merge/deploy remain separate authorization boundaries unless current state explicitly authorizes them.
9. A final fresh production audit remains a confirmation step after pre-production proof, not a substitute for it.

## Anti-slop rule

For PDV5, no Builder/Auditor may report `fixed`, `works`, `production ready`, or equivalent from any single one of:

- targeted tests;
- broad regression;
- Whole-App PASS;
- one Writer call;
- one Judge PASS;
- one rendered report;
- one semantic score.

The release claim must identify the proof planes completed under `PRYSM_MODEL_BEARING_RELEASE_GATE.md`.

## Stop condition

The highest pre-promotion state is `READY_FOR_AUTHORIZED_PRODUCTION_PROMOTION` only after the exact candidate passes all applicable deterministic and model-bearing gates plus independent audit.

After deployment identity is proven, the next state may be `READY_FOR_ONE_AUTHORIZED_LIVE_VALIDATION`.

A successful final live confirmation closes PDV5. A failed live confirmation creates a new governed escape and reopens diagnosis.