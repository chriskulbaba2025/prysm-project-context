# Current State

Project: PRYSM

Current objective: Resolve the isolated staging principal-to-worker authorization/membership handoff so exact candidate `d91432dc7dd63c222651cd676dbded9cc21e60d0` can complete the browser-equivalence flow without touching production.

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
- Vercel Preview environment attachment defect was repaired.
- Latest Preview deployment:
  - deployment ID `dpl_7c8784qR4rGLyYrQY9V8NFTGRAmh`;
  - URL `https://prysm-9w96g7f3p-chriskulbabas-projects.vercel.app`;
  - exact Git ref `repair/prysm-stage2-candidate-2026-09-18`;
  - exact SHA `d91432dc7dd63c222651cd676dbded9cc21e60d0`;
  - staging Cognito, worker URL, staging tenant, and staging-only webhook secret attached successfully.
- Browser rerun progressed:
  - Preview load PASS;
  - staging login PASS;
  - secure httpOnly `prysm_session` cookie issued;
  - session persistence PASS after reload;
  - no production endpoint observed.
- New first material blocker:
  - dashboard rendered `Unauthorized`;
  - isolated Railway worker received `GET /api/v1/audits`;
  - worker returned HTTP 401;
  - failure boundary is staging Cognito/session principal -> worker audit authorization/membership handoff.
- No membership repair, secret rotation, source edit, or second deployment was attempted after the 401.
- Full browser equivalence remains incomplete; audit discovery, detail, report, viewer, persistence/reopen, and final report invariant checks were not run.
- No source writes, source commits, production changes, production S3 access, provider/model calls, or new audits occurred during the rerun.

Completed:
- September 14 TBK audit recovery and reconciliation.
- Stage 1 report/presentation closure.
- Stage 2 local plumbing closure.
- Candidate isolation/freeze and publication.
- Isolated Railway staging creation and frozen dataset transfer.
- Cross-platform path repair.
- Linux Railway startup/authoritative-registration validation.
- Vercel Preview environment attachment repair.
- Browser equivalence through successful staging login/session and routing to the isolated worker.

In progress:
- None. Awaiting a separate bounded decision/review for the staging principal-to-worker authorization/membership contract.

Blocked:
- Full deployed path equivalence is blocked at the worker authorization boundary: authenticated staging principal -> `GET /api/v1/audits` returns HTTP 401.
- Production path equivalence and identity continuity are not claimed.
- Production remains frozen.

Important constraints:
- Preserve exact candidate SHA `d91432dc7dd63c222651cd676dbded9cc21e60d0` unless direct evidence proves a source repair is required.
- Diagnose the authorization/membership handoff before changing source, membership, secrets, or staging configuration.
- Use lower-tier/mechanical model routing for bounded diagnosis/repairs; reserve Astra for the final independent tip-to-tail adversarial audit after the full staging path is green.
- Do not use production Cognito, Railway, Postgres, S3, secrets, providers, models, or start a fresh audit.
- Stop at the first new material defect rather than entering open-ended repair.
- Follow GACM and `SKILLS/GOVERNED_CODING_UPGRADE.md` v2.1.0.

Exact next action: Perform a READ-ONLY bounded diagnosis of the staging Cognito/session principal -> worker authorization/membership handoff for `GET /api/v1/audits`, identify the exact cause of the HTTP 401, freeze the smallest repair/configuration boundary, and do not mutate membership, secrets, source, or infrastructure yet.

Last verified: 2026-09-18 America/Toronto
