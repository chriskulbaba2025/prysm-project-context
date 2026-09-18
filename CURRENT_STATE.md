# Current State

Project: PRYSM

Current objective: Repair the proven cross-platform path-containment defect in the exact frozen Stage 2 candidate, then resume isolated Railway staging validation without touching production.

Verified checkpoint:
- Accepted frozen application production baseline remains `60169bf23eec37c29683937d459d7d96f82aba73`; production was not touched during the current work.
- Authoritative TBK audit ID: `6dca53ed-ae00-484c-bf77-b59c059eef51`.
- Frozen recovered TBK dataset remains complete and authoritative: 51/51 objects with 0 missing and 0 SHA-256 mismatches.
- Stage 1 report/presentation work is CLOSED — PASS.
- Stage 2 local plumbing is CLOSED — PASS.
- Frozen pre-repair candidate:
  - branch: `repair/prysm-stage2-candidate-2026-09-18`;
  - SHA: `5b3f82423410cc340e0323c8338cbed0ddadf89c`;
  - remote SHA matches exactly.
- Candidate verification before staging PASS:
  - authoritative registration 1/1;
  - lifecycle 57/57;
  - artifacts 106/106;
  - WP11 62/62;
  - report suite 143/143;
  - render-v2 projection 1/1;
  - frozen dataset 51/51 with zero hash drift.
- Isolated non-production Railway staging resources exist:
  - project `prysm-stage2-staging-2026-09-18`;
  - environment `staging`;
  - service `prysm-stage2-worker`;
  - persistent volume mounted at `/data`.
- Frozen authoritative package transfer to isolated staging volume PASS: 51 objects, no source mutation.
- First exact-candidate Railway staging deployment failed and remains immutable failure evidence:
  - deployment ID `45da7443-cded-402c-82ce-4a35332ca472`;
  - result CRASHED / stopped.
- Read-only governed defect review completed — PASS.
- Proven repair boundary contains exactly two Windows-only containment helpers:
  1. `services/worker/src/orchestration/recovered-report-input-loader.js` — `safeRelativePath(root, artifactPath)`;
  2. `services/worker/src/local/authoritative-audit-registration.js` — `readFrozenArtifact(rootDir, parts)`.
- Both helpers use hard-coded backslash string-prefix containment, which falsely rejects valid POSIX/Linux child paths.
- No broader recovered-report filesystem defect was found in the directly relevant path.
- Frozen repair boundary:
  - source changes permitted only in those two source files;
  - direct regression coverage permitted in new `services/worker/src/orchestration/recovered-report-input-loader.test.js` and existing `services/worker/src/local/authoritative-audit-registration.test.js`;
  - no helper extraction, dependency change, renderer change, filesystem refactor, dataset mutation, scoring/report/evidence change, lifecycle semantic change, or infrastructure change is justified.
- Frozen acceptance contract requires valid Windows and POSIX containment plus rejection of traversal, external absolute paths, sibling-prefix escapes, and equivalent Windows escape cases.
- Baseline direct tests remain 2 PASS / 0 FAIL but are insufficient for cross-platform acceptance because they lack the required containment matrix.
- Vercel Preview/auth/browser equivalence remain unexecuted pending worker repair.
- No production Railway, production Postgres, production S3, production Cognito, production secrets, provider calls, model calls, or fresh audits were used.

Completed:
- Full September 14 TBK production audit recovery and completeness reconciliation.
- Stage 1 report/presentation closure.
- Stage 2 local plumbing closure.
- Stage 2 candidate isolation and exact local freeze.
- Read-only staging/deployment-path validation.
- Candidate branch publication.
- Isolated Railway staging resource creation and frozen package transfer.
- First real staging worker execution.
- Read-only cross-platform defect review and repair-boundary freeze.

In progress:
- None. Bounded source repair is not yet authorized.

Blocked:
- Staging-equivalence validation remains blocked until the two frozen containment helpers are repaired and the frozen acceptance tests pass.
- Source edit, repair commit/push, and Railway redeployment require explicit authorization.
- Vercel Preview, staging auth, browser equivalence, persistence/restart validation, and report-path equivalence remain gated behind a healthy staging worker.
- Production remains frozen at the accepted baseline.

Important constraints:
- Preserve accepted Stage 1 semantics, scores, finding IDs/order, evidence states, seven-section viewer, and client-facing wording.
- Preserve the frozen 51-object authoritative TBK dataset; do not mutate it.
- Preserve authoritative registration read-only/idempotent behavior.
- Change only the frozen two-source/two-test repair boundary unless direct evidence proves the boundary incomplete.
- Use platform-correct path semantics; do not replace one hard-coded separator with another.
- Keep production frozen and do not use production Railway, Postgres, S3, Cognito, secrets, providers, models, or a fresh audit.
- Follow GACM and `SKILLS/GOVERNED_CODING_UPGRADE.md` v2.1.0.
- The failed staging deployment remains immutable evidence and must not be rewritten as PASS.

Exact next action: Obtain explicit authorization for the frozen bounded cross-platform source repair: update only the two proven containment helpers and their two direct regression-test files, run the frozen acceptance/regression suite, and stop before push or redeployment unless those later actions are separately authorized.

Last verified: 2026-09-18 America/Toronto
