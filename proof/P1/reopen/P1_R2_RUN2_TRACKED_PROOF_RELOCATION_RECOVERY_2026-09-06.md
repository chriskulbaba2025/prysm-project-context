# P1 R2 Run 2 — Tracked Proof Relocation Recovery

Date: 2026-09-06
Status: APPROVED CONTROL-PLANE / GENERATED-PROOF RELOCATION RECOVERY
Decision: APPROVED

## Exact diagnosed state

R2 Recovery Run 2 advanced the application branch and pushed commit:

`8d2b38e4d8abd959d412b72028e9934dba8ae185`

Commit message:

`fix(p1): reconcile report conclusions`

Its parent is the R2 entry candidate:

`8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c`

The commit contains the authorized five source/test changes from the attributed R2 transaction plus generated rendered proof under the wrong repository-relative prefix:

`services/worker/proof/P1/reopen/render-v2-r2-20260906/*`

The governed application generated-proof surface is repository-root:

`proof/P1/reopen/*`

The application branch `p1/bounded-build-cross-report-integrity` is pushed at `8d2b38e4d8abd959d412b72028e9934dba8ae185`.

## Classification

This is not a new product root and does not consume repair attempt 2.

The source repair progressed and was pushed. The remaining defect is generated-proof placement plus stale execution bookkeeping.

Classification:

`PROCESS_OR_HARNESS / GENERATED_PROOF_PLACEMENT`

Repair accounting remains:

- stable root: `P1-CROSS-REPORT-PROJECTION-RECONCILIATION`
- repair attempt: `1`
- model level: Terra

## Authorized one-time reconciliation

The Windows placement helper may perform exactly this bounded reconciliation:

1. prove current application HEAD and origin branch both equal `8d2b38e4d8abd959d412b72028e9934dba8ae185`;
2. prove that SHA is a direct child of `8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c`;
3. prove the changed path set from `8fa9...` to `8d2b38e...` contains only the five authorized source/test paths plus `services/worker/proof/P1/reopen/render-v2-r2-20260906/*`;
4. require a clean application worktree before relocation;
5. require the misplaced proof to be tracked at `8d2b38e...`;
6. require target `proof/P1/reopen/render-v2-r2-20260906` to be absent before relocation;
7. use Git-aware relocation so all proof content is preserved exactly;
8. commit and push only the proof relocation on the same application branch;
9. update only `APPLICATION_SHA` and `CANDIDATE_APPLICATION_SHA` in `P1_EXECUTION_GATE.env` to the new exact application checkpoint;
10. commit and push that governance binding on `main`;
11. mark the local P1-R2 transaction journal `RECONCILED` at the new clean synchronized checkpoint;
12. return to the standard R2 continuous runner at repair attempt 1.

## Prohibited

This reconciliation must not:

- reset, revert, discard, or rewrite the five authorized source/test changes;
- force-push or rewrite application history;
- delete generated proof rather than relocate it;
- authorize `services/worker/proof/P1/reopen/*` as a future proof surface;
- modify application source/test files;
- change repair attempt from `1`;
- change stable root identity;
- route to Sol solely because of this harness/proof-placement failure;
- advance to Brad merely because relocation succeeds.

## Terminal meaning

Successful relocation means only:

`CLEAN SYNCHRONIZED R2 BUILDER CHECKPOINT`

The standard R2 runner must then continue Builder-owned proof/verification work until the independently gated `READY_FOR_BRAD` boundary is actually satisfied.
