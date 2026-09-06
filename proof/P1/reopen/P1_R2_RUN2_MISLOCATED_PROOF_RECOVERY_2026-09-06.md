# P1 R2 Run 2 Mislocated Generated-Proof Recovery

Date: 2026-09-06
Decision: APPROVED
Classification: CONTROL-PLANE / GENERATED-PROOF PLACEMENT RECOVERY ONLY
Repair accounting: remains repair attempt `1` / `gpt-5.6-terra`
Stable root: `P1-CROSS-REPORT-PROJECTION-RECONCILIATION`

## Observed failure

R2 dirty recovery Run 2 stopped after Builder execution because the application boundary detected:

`services/worker/proof/P1/reopen/render-v2-r2-20260906/assessed.html`

The application repository's governed historical rendered proof is stored at repository-root `proof/P1/reopen/*`, including the prior reopened proof commit `f053f631ee55b70b634e59fbe35a445a2b2656df`.

Therefore the Run 2 path above is a generated-proof placement error caused by creating `proof/P1/reopen/*` relative to `services/worker` rather than relative to the repository root. It is not authorization to expand the generated-proof surface.

## Recovery authorization

A one-time recovery helper may act only when all of the following are proven locally:

- the R2 journal is `CODEX_EXITED_UNRECONCILED`;
- it is a recovery transaction at repair attempt `1` and the same stable root;
- Codex exit code is `0`;
- application branch and HEAD remain the governed R2 branch/candidate lineage;
- every path beneath `services/worker/proof/P1/reopen/render-v2-r2-20260906/*` is untracked generated output;
- no tracked/staged file exists beneath that mislocated prefix;
- every other dirty application path remains inside the exact authorized R2 source/test list or repository-root `proof/P1/reopen/*` generated-proof surface.

If those conditions hold, the helper may:

1. copy the exact mislocated generated-proof directory outside the application repository into the R2 local-state quarantine;
2. write a file/hash manifest for the quarantine copy;
3. remove only the exact mislocated generated-proof directory from the application worktree;
4. update the local recovery journal fingerprint while preserving the previous fingerprint and recording the quarantine disposition;
5. resume the existing Terra / repair-attempt-1 recovery transaction.

The helper must not:

- allow `services/worker/proof/P1/reopen/*` as an authorized generated-proof surface;
- reset, clean, checkout-overwrite, or discard authorized source/test work;
- change application HEAD as part of placement recovery;
- consume repair attempt `2`;
- delete the quarantined copy;
- change frozen application/governance proof.

## Required resumed Builder instruction

Any regenerated rendered proof must be written relative to the application repository root:

`proof/P1/reopen/<new-versioned-proof>/...`

not beneath:

`services/worker/proof/P1/reopen/...`

## Terminal meaning

Successful placement recovery means only that the mislocated generated artifact was safely quarantined and removed from the worktree so the existing R2 recovery transaction can continue. It is not product PASS, proof PASS, or P1 closure.
