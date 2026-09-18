# Current State

Project: PRYSM

Current objective: Provision the isolated staging worker identity repository with the existing staging tenant, Cognito user, and reviewer membership so exact candidate `d91432dc7dd63c222651cd676dbded9cc21e60d0` can continue the browser-equivalence flow without touching production.

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
- Vercel Preview environment attachment is PASS:
  - deployment ID `dpl_7c8784qR4rGLyYrQY9V8NFTGRAmh`;
  - exact branch/SHA attached;
  - staging Cognito, worker URL, tenant, and webhook secret attached.
- Browser path currently passes:
  - Preview load;
  - staging Cognito login;
  - secure `prysm_session` issuance;
  - session persistence;
  - routing to isolated Railway worker.
- Read-only bounded diagnosis of worker HTTP 401 completed — PASS.
- Proven root cause:
  - staging worker runs with `DATABASE_URL` absent, `VANTAGE_DEV_MEMORY_STORE=true`, and `PRYSM_LOCAL_PERSISTENCE=true`;
  - deployed composition therefore uses an in-memory identity repository;
  - startup seeds only local mock identity/tenant/membership;
  - staging Cognito sub `2408e438-0041-70dd-4a37-8709020a8068` is absent from the Prysm identity repository;
  - staging tenant `prysm-stage2-staging` is absent;
  - target tenant membership list is empty;
  - worker therefore returns unauthenticated/HTTP 401 before tenant selection or audit retrieval.
- Ruled out as root cause:
  - Cognito authentication;
  - Vercel session issuance;
  - HMAC principal construction/verification;
  - shared-secret mismatch;
  - browser tenant selection.
- Direct evidence:
  - internal secret authorization HTTP 200;
  - seeded local mock principal -> `GET /api/v1/audits` HTTP 200 and authoritative audit returned;
  - staging Cognito principal -> `GET /api/v1/audits` HTTP 401;
  - `prysm-stage2-staging` memberships = [];
  - tenant listing contains only `local-sandbox`.
- Smallest frozen repair boundary: staging worker identity bootstrap/provisioning only.
- Required staging bootstrap data:
  - tenant: `prysm-stage2-staging`;
  - Cognito sub: `2408e438-0041-70dd-4a37-8709020a8068`;
  - verified staging email mapped to that sub;
  - one active non-admin reviewer membership for that tenant.
- No repair, membership mutation, secret/config change, deployment, production mutation, provider/model call, or fresh audit occurred during diagnosis.

Completed:
- September 14 TBK audit recovery and reconciliation.
- Stage 1 report/presentation closure.
- Stage 2 local plumbing closure.
- Candidate isolation/freeze and publication.
- Isolated Railway staging creation and frozen dataset transfer.
- Cross-platform path repair.
- Linux Railway startup/authoritative-registration validation.
- Vercel Preview environment attachment repair.
- Browser equivalence through login/session and isolated worker routing.
- Read-only worker authorization 401 diagnosis and repair-boundary freeze.

In progress:
- None. Awaiting explicit authorization for staging-only identity bootstrap/provisioning.

Blocked:
- Full deployed path equivalence remains blocked because the staging Cognito identity is not initialized in the staging worker identity repository.
- Production path equivalence and identity continuity are not claimed.
- Production remains frozen.

Important constraints:
- Preserve exact candidate SHA `d91432dc7dd63c222651cd676dbded9cc21e60d0` unless the authorized bootstrap mechanism itself requires a source change; prefer configuration/provisioning over source change if existing interfaces support it.
- Scope any next repair strictly to staging identity bootstrap/provisioning for the existing isolated worker.
- Create only the staging tenant, exact staging Prysm user identity, and one active reviewer membership needed for browser validation.
- Do not alter Vercel session logic, Cognito pool/client/user, HMAC signing, webhook secret, frozen dataset, report path, or production resources.
- Use lower-tier/mechanical model routing for this bounded repair; reserve Astra for the final independent tip-to-tail adversarial audit after staging is fully green.
- Do not use production Cognito, Railway, Postgres, S3, secrets, providers, models, or start a fresh audit.
- Follow GACM and `SKILLS/GOVERNED_CODING_UPGRADE.md` v2.1.0.

Exact next action: Obtain explicit bounded authorization to initialize only the isolated staging worker identity repository with tenant `prysm-stage2-staging`, staging Cognito sub `2408e438-0041-70dd-4a37-8709020a8068`, its verified staging email, and one active non-admin reviewer membership; verify `GET /api/v1/audits` returns 200 for that principal, then rerun the browser path from login and stop at the first new material defect or complete PASS.

Last verified: 2026-09-18 America/Toronto
