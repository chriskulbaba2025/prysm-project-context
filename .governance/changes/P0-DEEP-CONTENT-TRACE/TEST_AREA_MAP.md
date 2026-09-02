# P0 Test Area Map

| Area | Status | Proof |
|---|---|---|
| STRUCTURE | ACTIVE | exact branch/tree checks |
| UNIT | ACTIVE | selector/trace helper through adapter fixture |
| CONTRACT | ACTIVE | acquisition ledger and hydration assertions |
| INTEGRATION | ACTIVE | adapter → DecisionEvidence → consumers |
| END_TO_END / ACCEPTANCE | ACTIVE | P0 branch-complete controlled fixture proof |
| DATA / MIGRATION | N/A | additive in-memory/artifact evidence; no migration |
| SECURITY / PRIVACY | N/A | no auth, tenant, or secret boundary changed |
| RELIABILITY / RECOVERY | ACTIVE | failed/empty/disabled parsing fail-closed proof |
| EXTERNAL CALL / COST | ACTIVE | fixture seam only; request budget preserved |
| PERFORMANCE / RESOURCE | ACTIVE | bounded trace and existing content budget |
| COMPATIBILITY | ACTIVE | additive field; legacy absent field remains valid |
| RELEASE / DEPLOYMENT | N/A | CHANGE_ONLY; production release protected |
| MODEL / SEMANTIC ROBUSTNESS | N/A | no prompt/model behavior changed |
