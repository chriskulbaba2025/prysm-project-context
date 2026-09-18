# Current State

Project: PRYSM

Current objective: Validate and complete the staging tenant-scope continuity repair for candidate `68ff63266efe1f91212e27b62f97c394383146c5`, then perform the one bounded staging lifecycle ownership migration and rerun browser equivalence without touching production.

Verified checkpoint:
- Accepted frozen application production baseline remains `60169bf23eec37c29683937d459d7d96f82aba73`.
- Authoritative TBK audit ID: `6dca53ed-ae00-484c-bf77-b59c059eef51`.
- Frozen recovered TBK dataset remains authoritative: 51/51 objects; no dataset mutation authorized.
- Stage 1 report/presentation work is CLOSED — PASS.
- Stage 2 local plumbing is CLOSED — PASS.
- Previous exact candidate before tenant-scope source repair: `d91432dc7dd63c222651cd676dbded9cc21e60d0`.
- Tenant-scope root cause is proven: authoritative local registration was unconditionally bound to `local-sandbox`, while the authenticated staging principal is correctly scoped to `prysm-stage2-staging`.
- ChatGPT applied the authorized bounded source repair directly on branch `repair/prysm-stage2-candidate-2026-09-18`.
- New candidate SHA: `68ff63266efe1f91212e27b62f97c394383146c5`.
- Parent SHA: `d91432dc7dd63c222651cd676dbded9cc21e60d0`.
- Exact changed source files only:
  - `services/worker/src/server.js`;
  - `services/worker/src/local/authoritative-audit-registration.js`.
- Diff scope verified: 2 files, 21 changed lines total (20 additions / 1 deletion).
- Implemented source contract:
  - local sandbox remains the default authoritative registration tenant;
  - new explicit `PRYSM_LOCAL_AUTHORITATIVE_TENANT_ID` may select the isolated staging tenant;
  - staging selection is accepted only when the requested tenant is exactly `prysm-stage2-staging` and matches configured `VANTAGE_TENANT_ID`;
  - unsupported tenant values fail closed;
  - lifecycle registration and artifact bridge continue to use one identical registered tenant.
- No tests, Railway changes, Vercel changes, lifecycle metadata migration, restart, deployment, dataset mutation, production mutation, provider/model call, or fresh audit were performed by the chat-side source edit.
- Existing staging resources remain as previously verified; production remains frozen.

Completed:
- Tenant-scope diagnosis and repair-boundary freeze.
- Bounded two-file source repair committed and published to the existing candidate branch.
- Before/after GitHub diff scope verification.

In progress:
- None. Candidate source change is awaiting local regression validation and staging-only lifecycle ownership migration.

Blocked:
- Staging browser path still cannot discover the frozen audit until the existing staging lifecycle record for audit `6dca53ed-ae00-484c-bf77-b59c059eef51` is migrated from `local-sandbox` to `prysm-stage2-staging` and the repaired worker is deployed.
- The new candidate has not yet been test-validated or deployed.
- Production remains frozen.

Important constraints:
- Preserve all 51 frozen audit objects byte-for-byte.
- Preserve audit ID, client ID, recovered source tenant, lifecycle status, report content, scores, findings, evidence semantics, and seven-section viewer.
- Do not create a duplicate audit identity.
- Lifecycle migration must be staging-only and limited to this one audit.
- Use Terra Medium for the mechanical validation/migration/deploy step; reserve Astra for the final independent tip-to-tail adversarial audit after staging is fully green.
- Do not use production Cognito/Railway/Postgres/S3/secrets/providers/models or start a fresh audit.

Exact next action: Using Terra Medium, verify candidate SHA `68ff63266efe1f91212e27b62f97c394383146c5`, run the frozen local acceptance/regression suite, configure the isolated staging worker with `PRYSM_LOCAL_AUTHORITATIVE_TENANT_ID=prysm-stage2-staging`, back up and migrate only the target audit's lifecycle ownership in `/data/lifecycle.json` from `local-sandbox` to `prysm-stage2-staging`, redeploy the existing isolated Railway worker, and rerun the staging browser path. Stop at the first new material defect or complete PASS.

Last verified: 2026-09-18 America/Toronto
