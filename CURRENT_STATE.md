# Current State

Project: PRYSM

Current objective: Repair the isolated staging Railway service attachment so `prysm-stage2-worker` actually runs the worker process for exact candidate `68ff63266efe1f91212e27b62f97c394383146c5`, then re-run worker route and identity continuity checks before any further bootstrap or browser-equivalence work.

Verified checkpoint:
- Accepted frozen application production baseline remains `60169bf23eec37c29683937d459d7d96f82aba73`.
- Authoritative TBK audit ID: `6dca53ed-ae00-484c-bf77-b59c059eef51`.
- Frozen recovered TBK dataset remains authoritative: 51/51 objects; zero frozen dataset writes.
- Stage 1 report/presentation work is CLOSED — PASS.
- Stage 2 local plumbing is CLOSED — PASS.
- Exact candidate SHA: `68ff63266efe1f91212e27b62f97c394383146c5`.
- Structured lifecycle migration to `prysm-stage2-staging` is PASS.
- Pre-restart staging identity bootstrap and signed-principal audit/detail/report path are PASS.
- Latest staging redeploy:
  - deployment ID `094591ab-0151-4846-aa66-44dbdfe0627a`;
  - status SUCCESS;
  - exact SHA `68ff63266efe1f91212e27b62f97c394383146c5`;
  - volume `/data`.
- Post-restart route diagnosis proves the configured Railway service is running the wrong application:
  - project `prysm-stage2-staging-2026-09-18`;
  - environment `staging`;
  - service `prysm-stage2-worker`;
  - public domain `prysm-stage2-worker-staging.up.railway.app` correctly maps to that service on port 3000;
  - deployment metadata has `rootDirectory: null`, no explicit start command, Railpack builder;
  - runtime logs show root app startup: `prysm-web@0.1.0 start`, `next start`, Next.js 14.2.35;
  - worker startup marker `Prysm worker listening` is absent;
  - `/health` and admin endpoints return Next.js 404 HTML.
- Proven root cause classification: wrong application process behind correctly mapped worker service (classification F, manifested by C).
- Disproven current causes:
  - wrong URL;
  - wrong domain-to-service mapping;
  - wrong target port;
  - custom-domain routing defect.
- Smallest repair boundary: one staging-only Railway service build/runtime attachment repair so existing `prysm-stage2-worker` explicitly builds/runs the worker via `services/worker/Dockerfile` or equivalent explicit worker root/start configuration, while preserving current variables, volume, domain, and exact candidate SHA.
- No source change is required by current diagnosis.
- Post-restart identity continuity remains unproven until worker routes are restored.
- Do not reprovision identity before worker routes are reachable.
- Production remains frozen and untouched.

Completed:
- Tenant-scope source repair.
- Candidate reconciliation.
- Full local validation.
- Structured lifecycle migration.
- Initial exact-SHA staging deployment.
- Initial staging identity bootstrap.
- Pre-restart signed-principal audit/detail/report validation.
- Post-restart Railway route/runtime diagnosis.

In progress:
- None.

Blocked:
- Staging worker service is running Next.js instead of the worker process.
- Post-restart identity continuity cannot be tested until worker routes are restored.
- Browser-equivalence remains blocked.
- Production remains frozen.

Important constraints:
- Preserve exact candidate SHA `68ff63266efe1f91212e27b62f97c394383146c5`.
- Preserve current staging variables, volume `/data`, and public domain.
- Do not change source unless a new defect is directly proven.
- Do not reprovision identity before route restoration.
- Do not mutate lifecycle metadata, frozen dataset, report data, scoring, findings, or evidence.
- After worker route restoration, first test `/health` and admin identity readback. If identity is absent, STOP and freeze persistent bootstrap-on-startup as next repair boundary.
- Use Terra Medium for this bounded staging configuration repair; reserve Astra for final independent tip-to-tail audit after staging is fully green.
- Do not touch production or start a fresh audit.

Exact next action: Apply one staging-only Railway service configuration repair on `prysm-stage2-worker` so the service explicitly uses `services/worker/Dockerfile` or equivalent worker root/start configuration; redeploy exact candidate `68ff63266efe1f91212e27b62f97c394383146c5`; verify worker startup log and `/health`; then perform read-only identity readback before any reprovisioning. STOP at first new material defect.

Last verified: 2026-09-18 America/Toronto
