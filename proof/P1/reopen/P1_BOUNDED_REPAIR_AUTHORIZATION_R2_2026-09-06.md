# P1 Bounded Repair Authorization R2 — Continuous Builder Envelope

Date: 2026-09-06
Decision: APPROVED
Authorized by: Chris

## Binding diagnostic

Governance diagnostic commit: `9d73146e4a8a79797a19e13bd7d5d8a5c2b44e8d`
Diagnostic evidence: `proof/P1/reopen/P1_DIAGNOSTIC_TRUTH_R2_2026-09-06.md`
Application branch: `p1/bounded-build-cross-report-integrity`
Frozen failed application candidate: `8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c`
Diagnostic classification: `VERIFIED_DESIGN_GAP`
Stable root-defect identity: `P1-CROSS-REPORT-PROJECTION-RECONCILIATION`

## Owner decision

Chris authorizes one continuous Builder-owned P1 repair envelope from `BOUNDED_BUILD` through deterministic proof and exact-candidate preparation for Brad `OUTCOME_REVIEW`.

A Codex invocation ending, a focused test completing, a file being repaired, or an intermediate summary is not a human handoff boundary. Builder may continue autonomously while the exact P1 root, branch, scope, lineage, and protected boundaries below remain valid.

Brad `OUTCOME_REVIEW` remains the mandatory human product-quality boundary. This authorization does not authorize Betty Final Audit, P2, closure, deployment, application-main merge, or any production action.

## Exact material repair families

Only these three remaining client-visible families are in scope:

1. CTA / path coherence — distinguish invitation/mechanism presence from usable conversion-path completion at the point of reading.
2. Trust evidence attribution — positive trust language must name only the reassurance signals actually observed and must not imply pricing when pricing evidence is absent.
3. Fail-closed performance/readiness reconciliation — reconcile numeric lab performance, unavailable/incomplete field evidence, and client-facing readiness state without converting incomplete evidence into a broad PASS/no-blocker conclusion.

Robots/indexability is not an authorized repair family in this envelope. If new evidence establishes a new material robots/indexability defect, stop and return a new-boundary blocker rather than repairing it here.

## Authorized application change surface

Builder may modify only the following application paths when causally necessary for the three families above:

- `services/worker/src/report-model/cross-report-interpretation.js`
- `services/worker/src/report-model/cross-report-interpretation.test.js`
- `services/worker/src/report/foundation-readiness.js`
- `services/worker/src/report/report-detail-sections.js`
- `services/worker/src/report/v2-pillars.js`
- `services/worker/src/report/render-report-v2.js`
- `services/worker/src/report/render-report-v2-conversion.test.js`
- `services/worker/src/report/render-report-v2.test.js`
- `services/worker/src/report/render-report-v2-sections.test.js`

Any required application path outside this list is a scope-boundary event. Do not edit it; stop and return the exact path and causal reason.

## Authorized governance/proof surface

During Builder execution, governance writes are limited to:

- new versioned evidence/proof beneath `proof/P1/reopen/`;
- intentional `P1_EXECUTION_GATE.env` rebinding when the repaired candidate is ready for Brad;
- intentional `CURRENT_STATE.md` synchronization when advancing the exact candidate to `OUTCOME_REVIEW`.

Frozen historical P1 evidence and `proof/P1/rendered/*` remain immutable. The P1 frozen-history guard must pass before governance commit/push and before terminal handoff.

## Protected product surfaces

Do not change:

- evidence acquisition or adapters;
- capability-evidence semantics outside the named report consumers;
- scoring policy, score weights, or scoring-service behavior;
- Writer/Judge/model behavior;
- page-selection/search-data policy;
- lifecycle, storage, auth, or deployment behavior;
- application `main`;
- unrelated report features or unrelated copy cleanup.

No paid/live application provider or model calls are authorized.

## Required proof before Brad handoff

Builder must complete, commit, push, and bind proof sufficient to establish all three families together, including:

1. focused positive and negative/fail-closed deterministic tests for each affected family;
2. the focused report suites used in the R2 diagnosis, with any causally required additional in-scope tests;
3. full required P1 deterministic verification and broader required regression/Whole-App verification;
4. regenerated affected rendered scenarios under new versioned `proof/P1/reopen/` paths;
5. exact manifest/hash/provenance and scenario-to-obligation mapping for the repaired candidate;
6. clean pushed application candidate on `p1/bounded-build-cross-report-integrity`;
7. `P1_EXECUTION_GATE.env` rebound to the exact new application SHA and new proof, with `AUTHORIZED_STAGE=OUTCOME_REVIEW`;
8. `CURRENT_STATE.md` synchronized to `OUTCOME_REVIEW` with Brad as the next actor;
9. the official deterministic P1 gate independently PASS for the exact candidate and governance state.

## Autonomy and anti-drift stops

Builder must stop rather than broaden work if any of the following occurs:

- a materially different root cause is established;
- a required application path falls outside the exact allowlist;
- the proposed change would alter a protected product surface;
- paid/live provider/model execution becomes necessary;
- deployment, application-main merge, P2, Betty Final Audit, or closure would be required;
- frozen-history verification fails;
- application/governance lineage or exact-SHA synchronization cannot be proven;
- the same stable root reaches the governed three-attempt limit;
- a destructive Git/recovery decision would be required.

## Pre-repair blind-spot continuity

This authorization does not claim a new Betty review occurred after the R2 diagnostic. The existing committed Betty pre-repair PASS remains a prerequisite in the deterministic build gate. Chris is authorizing this R2 repair only because the R2 diagnostic narrows the work to the remaining portion of the already governed P1 report-projection repair surface rather than opening a new product domain.

If implementation evidence expands the root, dependency set, or product boundary beyond this document, the continuity assumption ends immediately and the run must stop for a fresh governed decision.

## Terminal boundary

The successful terminal state for this autonomous envelope is `READY_FOR_BRAD`, not P1 closure.

Builder may autonomously perform repair, tests, proof generation, commit/push, exact-candidate freeze, and governance rebinding. It must not automate Brad's judgment.
