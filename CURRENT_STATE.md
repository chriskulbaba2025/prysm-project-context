# Current State

Project: PRYSM

Current objective: Repair the proven cross-platform path-containment defect that prevents the exact frozen Stage 2 candidate from starting in the isolated Railway staging environment, then resume staging-equivalence validation without touching production.

Verified checkpoint:
- Accepted frozen application production baseline remains `60169bf23eec37c29683937d459d7d96f82aba73`; production was not touched during the current work.
- Authoritative TBK audit ID: `6dca53ed-ae00-484c-bf77-b59c059eef51`.
- Frozen recovered TBK dataset remains complete and authoritative: 51/51 objects with 0 missing and 0 SHA-256 mismatches.
- Stage 1 report/presentation work is CLOSED — PASS.
- Stage 2 local plumbing is CLOSED — PASS.
- Exact frozen candidate before staging defect repair:
  - branch: `repair/prysm-stage2-candidate-2026-09-18`;
  - SHA: `5b3f82423410cc340e0323c8338cbed0ddadf89c`;
  - parent: `60169bf23eec37c29683937d459d7d96f82aba73`;
  - 20 verified source/test files.
- Candidate verification before staging PASS:
  - authoritative registration 1/1;
  - lifecycle 57/57;
  - artifacts 106/106;
  - WP11 62/62;
  - report suite 143/143;
  - render-v2 projection 1/1;
  - frozen dataset 51/51 with zero hash drift.
- Candidate branch publication PASS:
  - remote branch `origin/repair/prysm-stage2-candidate-2026-09-18`;
  - remote SHA exactly `5b3f82423410cc340e0323c8338cbed0ddadf89c`.
- Isolated non-production Railway staging resources were created:
  - project: `prysm-stage2-staging-2026-09-18`;
  - project ID: `3c94733e-478b-48e8-b66c-8946a6d46064`;
  - environment: `staging`;
  - environment ID: `4dd88e96-0c01-4da5-957b-4068ae83dedd`;
  - service: `prysm-stage2-worker`;
  - service ID: `2d47c305-2056-4327-b5fb-c3d606aaeb19`;
  - volume: `prysm-stage2-worker-volume`;
  - volume ID: `75465807-23a1-4dc2-9dd8-9b187f7b9690`;
  - mount: `/data`.
- Frozen authoritative package transfer to isolated staging volume PASS:
  - destination: `/data/authoritative-audits/6dca53ed-ae00-484c-bf77-b59c059eef51`;
  - 51 objects;
  - source dataset not mutated.
- Staging worker deployment of exact candidate failed and stopped:
  - deployment ID: `45da7443-cded-402c-82ce-4a35332ca472`;
  - result: CRASHED / stopped.
- Proven root cause:
  - file: `services/worker/src/orchestration/recovered-report-input-loader.js`;
  - function: `safeRelativePath(root, artifactPath)`;
  - candidate containment logic appends a Windows-only backslash suffix to the resolved root;
  - Railway/Linux resolves paths with `/`;
  - valid Linux dataset paths are therefore falsely rejected as escaping the dataset root;
  - observed error: `Recovered artifact path escapes dataset root: canonical/audit-request.json`.
- The defect is independent of package relocation and does not require mutation of the frozen dataset.
- Vercel Preview and separate staging authentication were not created because the worker prerequisite failed first.
- No production Railway, production Postgres, production S3, production Cognito, production secrets, provider calls, model calls, or fresh audits were used.

Completed:
- Full September 14 TBK production audit recovery and completeness reconciliation.
- Stage 1 report/presentation closure.
- Stage 2 local plumbing closure.
- Stage 2 candidate isolation and exact local freeze.
- Read-only staging/deployment-path validation.
- Candidate branch publication.
- Isolated Railway staging project/environment/service/volume creation.
- Frozen 51-object package transfer to isolated staging volume.
- First real staging worker execution, which exposed the cross-platform path-containment defect.

In progress:
- None. Repair is not yet authorized.

Blocked:
- Staging-equivalence validation is blocked because the exact candidate crashes during authoritative registration on Linux.
- Vercel Preview, staging authentication, browser equivalence, persistence/restart validation, and report-path equivalence remain unexecuted.
- Source repair, new candidate commit/push, redeployment, and further staging setup require explicit authorization.
- Production remains frozen at the accepted baseline.

Important constraints:
- Preserve accepted Stage 1 semantics, scores, finding IDs/order, evidence states, seven-section viewer, and client-facing wording.
- Preserve the frozen 51-object authoritative TBK dataset; do not mutate it to work around the defect.
- Preserve authoritative registration read-only/idempotent behavior.
- Repair only the proven cross-platform path-containment contract unless direct evidence proves a wider defect boundary.
- Keep production frozen and do not use production Railway, Postgres, S3, Cognito, secrets, providers, models, or a fresh audit.
- Follow GACM and `SKILLS/GOVERNED_CODING_UPGRADE.md` v2.1.0 for the qualifying source repair.
- The failed staging deployment is immutable evidence and must not be represented as a PASS.

Exact next action: Perform a READ-ONLY governed defect review of `services/worker/src/orchestration/recovered-report-input-loader.js` and its directly relevant tests/callers to freeze the smallest cross-platform repair boundary and acceptance tests. Do not edit source yet. After that review, obtain explicit authorization for the bounded repair before changing the candidate.

Last verified: 2026-09-18 America/Toronto
