# Current State

Project: PRYSM

Current objective: Diagnose and repair the isolated staging post-restart worker-route mismatch on exact candidate `68ff63266efe1f91212e27b62f97c394383146c5`, then re-run read-only identity continuity before any further bootstrap or browser-equivalence work.

Verified checkpoint:
- Accepted frozen application production baseline remains `60169bf23eec37c29683937d459d7d96f82aba73`.
- Authoritative TBK audit ID: `6dca53ed-ae00-484c-bf77-b59c059eef51`.
- Frozen recovered TBK dataset remains authoritative: 51/51 objects; zero frozen dataset writes.
- Stage 1 report/presentation work is CLOSED — PASS.
- Stage 2 local plumbing is CLOSED — PASS.
- Exact candidate SHA: `68ff63266efe1f91212e27b62f97c394383146c5`.
- Structured lifecycle migration to tenant `prysm-stage2-staging` is PASS and persisted.
- Initial staging identity bootstrap is PASS:
  - tenant `prysm-stage2-staging`;
  - exact staging Cognito user;
  - exactly one active non-admin reviewer membership.
- PRE-RESTART direct authenticated staging path is PASS:
  - signed principal construction PASS;
  - `GET /api/v1/audits` HTTP 200;
  - authoritative audit present;
  - audit detail HTTP 200;
  - report read path HTTP 200 HTML.
- One normal staging redeploy/restart was performed:
  - deployment ID `094591ab-0151-4846-aa66-44dbdfe0627a`;
  - status SUCCESS;
  - deployed SHA `68ff63266efe1f91212e27b62f97c394383146c5`;
  - mounted volume `/data`.
- POST-RESTART first material defect:
  - configured worker URL returns HTTP 404 for `/health`, `/api/v1/admin/tenants`, and staging memberships route;
  - response body is Next.js 404 HTML, not the worker response;
  - therefore the configured URL is not reaching the expected Railway worker boundary after restart.
- Post-restart identity survival remains UNPROVEN because the route boundary failed before identity readback.
- No second identity bootstrap was performed.
- Immediate proven blocker is route/runtime-boundary mismatch, not yet proven identity loss.
- Known secondary risk remains: staging identity repository is memory-backed and may still have reset after restart once the worker route is restored.
- Production remains frozen and untouched.

Completed:
- Tenant-scope source repair.
- Candidate reconciliation.
- Full local validation.
- Structured lifecycle migration.
- Exact-SHA staging deployment.
- Initial staging-only identity bootstrap.
- Pre-restart signed-principal audit/detail/report validation.
- One staging restart/redeploy attempt.

In progress:
- None.

Blocked:
- Configured staging worker URL is serving a Next.js 404 after restart instead of worker routes.
- Post-restart identity continuity cannot be tested until the worker boundary is restored.
- Browser-equivalence remains blocked.
- Production remains frozen.

Important constraints:
- Preserve exact candidate SHA `68ff63266efe1f91212e27b62f97c394383146c5`.
- Do not reprovision identity again before route-boundary diagnosis.
- Do not change source unless diagnosis proves source change is required.
- Do not mutate lifecycle metadata, frozen dataset, report data, scoring, findings, or evidence.
- Diagnose Railway service/domain/port/runtime routing first.
- After worker routes are restored, perform read-only identity readback before any bootstrap.
- If routes recover and identity is absent, STOP and freeze persistent identity/bootstrap-on-startup as the next repair boundary.
- Use Terra Medium for this bounded diagnosis; reserve Astra for final independent tip-to-tail audit after staging is fully green.
- Do not touch production or start a fresh audit.

Exact next action: Perform a bounded read-only diagnosis of the post-restart staging route/runtime boundary. Verify Railway project/environment/service identity, public domain target, deployment/service mapping, exposed port/start command, recent logs, and whether the URL currently resolves to the worker or the Vercel/Next.js surface. Freeze the smallest repair boundary and STOP before mutation. After route restoration, re-run `/health`, admin identity readback, then signed-principal audit access.

Last verified: 2026-09-18 America/Toronto
