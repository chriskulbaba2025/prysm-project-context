# P1 Bounded Repair Authorization R2 V2 — Continuous Builder Envelope

Date: 2026-09-06
Decision: APPROVED
Authorized by: Chris
Supersedes for active R2 execution: `proof/P1/reopen/P1_BOUNDED_REPAIR_AUTHORIZATION_R2_2026-09-06.md`

## Binding diagnostic and root

Diagnostic evidence: `proof/P1/reopen/P1_DIAGNOSTIC_TRUTH_R2_2026-09-06.md`
Diagnostic commit: `9d73146e4a8a79797a19e13bd7d5d8a5c2b44e8d`
Application branch: `p1/bounded-build-cross-report-integrity`
R2 entry candidate: `8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c`
Classification: `VERIFIED_DESIGN_GAP`
Stable root: `P1-CROSS-REPORT-PROJECTION-RECONCILIATION`
R2 starting repair index: `1`

## Authorized outcome

Builder may run continuously through the remaining P1 repair, deterministic testing, broader required P1 verification, regenerated rendered proof, exact candidate commit/push, governance rebinding, and the deterministic transition to Brad `OUTCOME_REVIEW`.

A Codex invocation ending is not a workflow boundary. The successful human boundary is `READY_FOR_BRAD`, not P1 closure.

## Exact material repair families

Only these three client-visible families are authorized:

1. CTA / path coherence.
2. Trust evidence attribution.
3. Fail-closed performance/readiness reconciliation.

Robots/indexability and unrelated report cleanup are not authorized R2 repair families.

## Authorized application SOURCE/TEST surface

Only these source/test paths may be edited:

- `services/worker/src/report-model/cross-report-interpretation.js`
- `services/worker/src/report-model/cross-report-interpretation.test.js`
- `services/worker/src/report/foundation-readiness.js`
- `services/worker/src/report/report-detail-sections.js`
- `services/worker/src/report/v2-pillars.js`
- `services/worker/src/report/render-report-v2.js`
- `services/worker/src/report/render-report-v2-conversion.test.js`
- `services/worker/src/report/render-report-v2.test.js`
- `services/worker/src/report/render-report-v2-sections.test.js`

Any required source/test path outside this list is a scope-boundary event and must stop the run.

## Authorized application GENERATED-PROOF surface

The application repository historically stores rendered candidate proof under `proof/P1/reopen/`. R2 may therefore add **new versioned** files/directories beneath:

- `proof/P1/reopen/*`

This permission is for generated proof only. Every `proof/P1/reopen/*` application path that exists when the R2 controller starts is immutable for that controller run. It may not be edited, replaced, regenerated in place, renamed, or deleted.

This distinction resolves the prior control-plane false failure in which valid generated rendered proof was incorrectly treated as an unauthorized application source edit. It does not broaden the product repair surface.

## Authorized governance surface

Governance writes are limited to:

- new versioned evidence beneath `proof/P1/reopen/*`;
- intentional `P1_EXECUTION_GATE.env` rebinding;
- intentional `CURRENT_STATE.md` synchronization.

Every governance `proof/P1/reopen/*` path that exists when the R2 controller starts is immutable during that controller run. Frozen historical root P1 evidence and `proof/P1/rendered/*` remain immutable under the existing frozen-history guard.

## Windows execution-state isolation

The prior Windows P1 local transaction journal from the September 5 repair is preserved as historical recovery evidence. It is not current R2 authority.

Windows R2 continuous execution uses a separate local state namespace:

`%LOCALAPPDATA%\PRYSM-P-Autorun\P1-R2`

This prevents stale `repairAttempt=0`, `rootDefectId=NONE`, old entry anchors, or an old `CODEX_EXITED_UNRECONCILED` transaction from contaminating current R2 execution.

The R2 namespace initializes at repair index `1` and stable root `P1-CROSS-REPORT-PROJECTION-RECONCILIATION`. It may never reset below that index. Same-root proof failure may escalate once to index `2` / Sol. No fourth same-root attempt is permitted.

## Protected boundaries

No authorization exists for:

- evidence acquisition/adapters;
- scoring policy/weights/scoring service;
- Writer/Judge/model behavior outside Codex acting as Builder;
- page-selection/search-data redesign;
- lifecycle/storage/auth;
- deployment;
- application `main` merge;
- paid/live application provider/model calls;
- P2;
- Betty Final Audit;
- closure.

A materially new root cause, required source/test path outside the exact list, protected dependency, frozen-history failure, destructive recovery decision, or unprovable Git lineage is a stop condition.

## Required proof before Brad

Builder must produce and durably bind:

- focused positive and negative/fail-closed tests for all three R2 families;
- focused report suites used by the R2 diagnosis and any causally required in-scope tests;
- full required P1 deterministic verification and broader required regression/Whole-App verification;
- new versioned rendered proof under application `proof/P1/reopen/*`;
- exact manifest/hash/provenance and scenario-to-obligation mapping;
- clean pushed exact application candidate;
- new versioned governance proof under governance `proof/P1/reopen/*`;
- `P1_EXECUTION_GATE.env` rebound to the exact repaired candidate and current proof with `AUTHORIZED_STAGE=OUTCOME_REVIEW`;
- `CURRENT_STATE.md` synchronized to Brad `OUTCOME_REVIEW`;
- official deterministic P1 gate PASS for the exact bound state with `Authorized actor: BRAD`.

## Terminal boundary

The controller must stop successfully at:

`PRYSM P1 READY FOR BRAD`

It must not automate Brad's independent outcome judgment.
