# Current State

Project: PRYSM

Current objective: Repair the isolated Vercel Preview environment attachment so exact candidate `d91432dc7dd63c222651cd676dbded9cc21e60d0` receives the staging Cognito variables and staging worker binding, then rerun the full browser-equivalence path without touching production.

Verified checkpoint:
- Accepted frozen application production baseline remains `60169bf23eec37c29683937d459d7d96f82aba73`; production was not touched during the current work.
- Authoritative TBK audit ID: `6dca53ed-ae00-484c-bf77-b59c059eef51`.
- Frozen recovered TBK dataset remains complete and authoritative: 51/51 objects with zero hash drift.
- Stage 1 report/presentation work is CLOSED — PASS.
- Stage 2 local plumbing is CLOSED — PASS.
- Exact candidate remains:
  - branch: `repair/prysm-stage2-candidate-2026-09-18`;
  - SHA: `d91432dc7dd63c222651cd676dbded9cc21e60d0`.
- Linux Railway staging startup and authoritative registration are PASS:
  - deployment ID `eee51575-4520-405a-a717-3385f86303a7`;
  - deployment SHA `d91432dc7dd63c222651cd676dbded9cc21e60d0`;
  - service RUNNING;
  - `/health` HTTP 200;
  - authoritative audit registered read-only.
- First full staging browser-equivalence attempt completed with RESULT: BLOCKED.
- Exact Vercel Preview attempt:
  - project `prysm`;
  - deployment ID `dpl_9q4QqV5ijfPTwJEQ2if7YUAmQHmv`;
  - URL `https://prysm-ph6jrw9dg-chriskulbabas-projects.vercel.app`;
  - status READY;
  - candidate SHA `d91432dc7dd63c222651cd676dbded9cc21e60d0`.
- Preview page load PASS after temporary protected-deployment access.
- Browser login BLOCKED:
  - POST `/api/auth/login` returned HTTP 500;
  - Vercel runtime reported missing `COGNITO_USER_POOL_ID`, `COGNITO_CLIENT_ID`, and `COGNITO_REGION`;
  - no session cookie was issued.
- Proven root cause classification: deployed configuration / environment attachment defect.
- Branch-scoped Preview staging variables had been configured, but the CLI-created deployment identified its Vercel Git ref as `HEAD`, so those branch-scoped variables did not attach at runtime.
- Staging-only auth resources already exist:
  - Cognito region `us-east-1`;
  - staging-only user pool `us-east-1_ZYZ57LwIX`;
  - staging-only app client `4f08gdm0k88lfu3cfhgvgietln`;
  - staging-only test principal exists;
  - production Cognito was not used.
- Intended isolated worker binding is `https://prysm-stage2-worker-staging.up.railway.app`.
- Browser flow stopped at first material defect; dashboard, audit discovery, detail, report, viewer, scores/findings semantics, and restart/reopen persistence were not run.
- Browser network evidence showed only Preview/Vercel hosts and no production Railway endpoint.
- No source writes, source commits, production mutations, production S3 access, provider/model calls, or new audit occurred during the blocked browser attempt.

Completed:
- September 14 TBK audit recovery and reconciliation.
- Stage 1 report/presentation closure.
- Stage 2 local plumbing closure.
- Candidate isolation/freeze and publication.
- Isolated Railway staging creation and frozen dataset transfer.
- Cross-platform path repair.
- Linux Railway startup/authoritative-registration validation.
- First Vercel Preview/browser-equivalence attempt through the login boundary.

In progress:
- None. Awaiting explicit authorization to repair only the Vercel Preview staging environment attachment and rerun.

Blocked:
- Full deployed path equivalence remains blocked at the staging auth/session boundary because the exact Preview deployment did not receive the configured staging Cognito variables.
- Production path equivalence and identity continuity are not claimed.
- Production remains frozen.

Important constraints:
- Preserve exact candidate SHA `d91432dc7dd63c222651cd676dbded9cc21e60d0`; no source repair is indicated by current evidence.
- Repair only the Preview environment attachment/deployment binding; do not modify application source.
- Preview must receive the staging Cognito variables, staging tenant, staging webhook secret, and staging worker URL only.
- Do not use production Cognito, Railway, Postgres, S3, secrets, providers, models, or start a fresh audit.
- Stop at the first new material deployed-path defect rather than entering open-ended repair.
- Follow GACM and `SKILLS/GOVERNED_CODING_UPGRADE.md` v2.1.0.

Exact next action: Obtain explicit bounded authorization to correct the Vercel Preview environment/deployment attachment for exact candidate SHA `d91432dc7dd63c222651cd676dbded9cc21e60d0` so the runtime receives the existing staging Cognito variables, staging tenant/secret, and staging worker binding; then rerun the browser-equivalence flow from login and stop at the first material defect or a complete PASS. Do not promote to production.

Last verified: 2026-09-18 America/Toronto
