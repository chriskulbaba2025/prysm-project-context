# Current State

Project: PRYSM

Current objective: Restore staging identity continuity after deployment by performing one staging-only identity bootstrap for exact candidate `68ff63266efe1f91212e27b62f97c394383146c5`, then prove signed-principal audit access before any browser-equivalence work.

Verified checkpoint:
- Accepted frozen application production baseline remains `60169bf23eec37c29683937d459d7d96f82aba73`.
- Authoritative TBK audit ID: `6dca53ed-ae00-484c-bf77-b59c059eef51`.
- Frozen recovered TBK dataset remains authoritative: 51/51 objects; zero frozen dataset writes.
- Stage 1 report/presentation work is CLOSED — PASS.
- Stage 2 local plumbing is CLOSED — PASS.
- Exact candidate: `68ff63266efe1f91212e27b62f97c394383146c5`.
- Local validation is PASS:
  - authoritative registration 3/3;
  - recovered loader 4/4;
  - render-v2 projection 1/1;
  - lifecycle 57/57;
  - artifacts 106/106;
  - WP11 62/62;
  - report 143/143.
- Structured lifecycle migration is PASS:
  - lifecycle owner for target audit is now `prysm-stage2-staging`;
  - exactly 19 tenant metadata values changed from `local-sandbox` to `prysm-stage2-staging`;
  - migrated and post-upload files match;
  - no duplicate audit;
  - client/state/event/transition structure preserved.
- Railway staging config is PASS:
  - `PRYSM_LOCAL_AUTHORITATIVE_TENANT_ID=prysm-stage2-staging`;
  - `VANTAGE_TENANT_ID=prysm-stage2-staging`.
- Railway deployment is PASS:
  - deployment ID `3b3748f9-2b90-452c-9cef-209b239afb07`;
  - exact SHA `68ff63266efe1f91212e27b62f97c394383146c5`;
  - status SUCCESS;
  - `/health` HTTP 200;
  - authoritative startup registration read-only/idempotent.
- Post-deploy identity continuity check is BLOCKED:
  - identity repository is in-memory because `DATABASE_URL` is absent and `VANTAGE_DEV_MEMORY_STORE=true`;
  - deployment reset runtime-provisioned staging identity records;
  - read-only tenant listing returned 1 tenant and no `prysm-stage2-staging`;
  - staging user for Cognito sub `2408e438-0041-70dd-4a37-8709020a8068` is absent;
  - staging membership listing returned 0 rows;
  - signed-principal `GET /api/v1/audits` was correctly not attempted after identity readback failed.
- Proven root cause: file-backed lifecycle metadata persisted, but memory-backed identity records did not survive deployment.
- Smallest frozen repair boundary: one staging-only identity bootstrap creating exactly:
  1. tenant `prysm-stage2-staging`;
  2. Prysm user mapped to Cognito sub `2408e438-0041-70dd-4a37-8709020a8068` and staging email;
  3. one active non-admin reviewer membership.
- No source/config/lifecycle/dataset/production changes occurred during the read-only identity continuity check.

Completed:
- Tenant-scope source repair.
- Candidate reconciliation.
- Full local validation.
- Structured lifecycle migration.
- Exact-SHA staging deploy and health check.
- Post-deploy identity continuity diagnosis.

In progress:
- None. Awaiting explicit staging-only identity bootstrap.

Blocked:
- Signed staging-principal audit access cannot be proven until staging tenant/user/membership are reprovisioned.
- Browser-equivalence remains intentionally blocked behind this direct auth gate.
- Production remains frozen.

Important constraints:
- Preserve exact candidate SHA `68ff63266efe1f91212e27b62f97c394383146c5`.
- Do not change source, Railway config, lifecycle metadata, frozen dataset, report data, scoring, findings, or evidence.
- Identity bootstrap must be staging-only, non-admin, and limited to the existing test principal and tenant.
- After bootstrap, verify identity readback and signed-principal `GET /api/v1/audits` before any restart/browser work.
- If a subsequent restart/deploy erases identity again, stop and freeze a persistence/bootstrap-on-startup repair boundary rather than repeatedly reprovisioning manually.
- Use Terra Medium for this bounded mechanical step; reserve Astra for final independent tip-to-tail audit after staging is fully green.
- Do not touch production or start a fresh audit.

Exact next action: Perform one staging-only identity bootstrap through the existing admin provisioning boundary for tenant `prysm-stage2-staging`, the exact staging Cognito user, and one active reviewer membership; then read back all three and run the signed staging-principal `GET /api/v1/audits`. If HTTP 200 includes the authoritative audit, continue to audit detail/report and one restart/reopen check. If restart causes identity loss, STOP and record that persistent identity/bootstrap-on-startup is required.

Last verified: 2026-09-18 America/Toronto
