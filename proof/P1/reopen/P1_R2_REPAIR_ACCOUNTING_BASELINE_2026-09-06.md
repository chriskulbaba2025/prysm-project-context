# P1 R2 Repair Accounting Baseline

Date: 2026-09-06
Status: ACTIVE FOR R2 CONTINUOUS BUILDER EXECUTION

Stable root-defect identity: `P1-CROSS-REPORT-PROJECTION-RECONCILIATION`

## Baseline decision

The repaired application candidate `8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c` was independently reviewed by Brad and received a material P1 FAIL. The subsequent R2 diagnostic established that the remaining three material families are still within the report projection/reconciliation design gap rather than a materially new product root.

Therefore the R2 continuous repair does not reset same-root repair accounting to zero.

Controller repair index mapping remains:

- `0` -> Luna
- `1` -> Terra
- `2` -> Sol

R2 begins at repair index `1`.

If R2 returns an evidence-based `REPAIR_PROOF_FAILED` against the same stable root, the controller may advance once to repair index `2` / Sol.

If repair index `2` fails against the same root, the controller must stop. No fourth same-root attempt is permitted.

`PROOF_SETUP_FAILURE`, usage-limit, or external/protocol failure does not consume another repair index. `NEW_ROOT_CAUSE` is not an escalation mechanism; it is an owner/scope boundary and must stop the controller.

## Restart rule

macOS repair accounting is persisted outside both repositories under the P1 controller state directory. A controller restart must reload the durable root + repair index and may not initialize below this R2 baseline.

A missing local repair-state file initializes to index `1` for this R2 authorization. A stored different root or an index below `1` fails closed rather than silently resetting accounting.
