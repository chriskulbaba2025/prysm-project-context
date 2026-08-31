# Decision: Version current ReportViewModel contract for T2

Date: 2026-08-31
Status: Active

## Decision

Current production rendering must use a truthfully versioned current ReportViewModel contract rather than adapting current governed semantics back into the frozen v1 ReportViewModel shape.

The current ReportViewModel contract for the repaired production path will be versioned separately from v1 and must explicitly carry the current governed fields required by canonical hydration, including `rootCauseRuleId` and `decisionHierarchy`. The existing v1 ReportViewModel contract remains frozen for historical/legacy compatibility only.

The report design version is a separate concern and does not need to change merely because the data contract changes. This decision authorizes the minimum contract/validator/builder/test migration required to make the current base renderer consume a validated current ReportViewModel without dropping or re-deriving governed semantics.

Do not introduce a compatibility adapter whose purpose is to strip, suppress, or reinterpret current hierarchy/root-cause semantics merely to satisfy the v1 schema.

## Reason

AUD-T2-002 proved that canonical current hydration is working far enough to expose a genuine contract mismatch at the base-renderer boundary. `buildReportViewModel()` currently emits current `rootCauseRuleId` and `decisionHierarchy` semantics while still declaring ReportViewModel `contractVersion: 1.0.0`. The frozen v1 schema has `additionalProperties: false` and does not define those current fields, so assembled acceptance correctly fails closed.

This is not a rendering-style defect. It is an incompatible persisted/current semantic contract being forced through a legacy interface. A compatibility adapter that removes the new semantics would recreate the semantic-drop class that T2 is specifically intended to eliminate.

The central validator already supports registering multiple schemas by stable versioned `$id`, so a versioned current ReportViewModel is compatible with the existing contract architecture.

## Implication

- Treat the ReportViewModel schema-version mismatch as a materially new root-cause boundary discovered by the Level-3 AUD-T2-002 proof.
- Reset the governed repair attempt to 0 / Luna for this new boundary.
- Preserve the entire dirty Level-3 application tree and generated evidence; do not reset, clean, overwrite, or discard it.
- Builder must reconcile the preserved repair into a coherent versioned current ReportViewModel migration.
- Current production/base-render paths validate against the new current ReportViewModel contract.
- Historical/legacy paths may continue to validate v1 only where explicitly compatibility-scoped.
- Current canonical `rootCauseRuleId` and `decisionHierarchy` semantics must survive the base renderer boundary unchanged; do not remove them to obtain PASS.
- The migration must update the schema registry/validator, ReportViewModel builder contract identity, and focused/assembled regression proof as one coherent repair boundary.
- T2 still requires the exact-SHA Whole-App Tranche Gate and independent Auditor PASS before advancing to T3.
