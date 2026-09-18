# Current State

Project: PRYSM

Current objective: Apply the narrowly bounded staging tenant-scope continuity repair so exact candidate `d91432dc7dd63c222651cd676dbded9cc21e60d0` can expose the existing frozen authoritative audit to `prysm-stage2-staging` without mutating the frozen 51-object dataset or touching production.

Verified checkpoint:
- Accepted frozen application production baseline remains `60169bf23eec37c29683937d459d7d96f82aba73`.
- Authoritative TBK audit ID: `6dca53ed-ae00-484c-bf77-b59c059eef51`.
- Frozen recovered TBK dataset remains authoritative: 51/51 objects, zero hash drift.
- Stage 1 report/presentation work is CLOSED — PASS.
- Stage 2 local plumbing is CLOSED — PASS.
- Exact candidate before tenant-scope repair:
  - branch `repair/prysm-stage2-candidate-2026-09-18`;
  - SHA `d91432dc7dd63c222651cd676dbded9cc21e60d0`.
- Linux Railway staging startup/authoritative registration PASS.
- Vercel Preview attachment PASS.
- Browser login/session PASS.
- Preview-to-isolated-worker routing PASS.
- Staging identity bootstrap PASS:
  - tenant `prysm-stage2-staging` active;
  - staging Cognito/Prysm user active;
  - one active non-admin reviewer membership.
- Direct staging authorization PASS:
  - signed staging principal + `x-prysm-tenant=prysm-stage2-staging` -> `GET /api/v1/audits` HTTP 200.
- Read-only tenant-scope continuity diagnosis completed with RESULT: HOLD.
- Proven root cause:
  - `services/worker/src/local/authoritative-audit-registration.js` defines `LOCAL_REGISTRATION_TENANT = local-sandbox`;
  - `services/worker/src/server.js` explicitly registers the authoritative audit and artifact bridge under that local-sandbox tenant;
  - lifecycle storage owns one audit record by one exact tenantId and rejects mismatched re-registration;
  - therefore `prysm-stage2-staging` is authorized but correctly sees an empty audit list.
- Mechanism analysis:
  - existing runtime tenant override: not operationally supported;
  - metadata-only tenant mapping: not found;
  - second registration/reference: not supported;
  - narrowly bounded source repair plus staging-only lifecycle ownership migration: required.
- Frozen repair boundary:
  - `services/worker/src/server.js`: parameterize authoritative registration target for staging rather than unconditional local-sandbox;
  - `services/worker/src/local/authoritative-audit-registration.js`: preserve/validate tenant parameter and exact audit identity; no artifact copy/rewrite behavior;
  - staging lifecycle metadata `/data/lifecycle.json`: one bounded staging-only ownership migration/re-registration for the existing authoritative audit so lifecycle record/events use `prysm-stage2-staging`;
  - no frozen artifact bytes may change.
- Required acceptance:
  - lifecycle registration and artifact bridge use `prysm-stage2-staging`;
  - audit appears for staging principal;
  - audit detail/report read through unchanged frozen artifacts;
  - 51/51 frozen bytes/hash unchanged;
  - restart/reopen preserves staging ownership and visibility;
  - no cross-tenant alias/admin bypass;
  - no providers/models/new audit/production access.
- No repair, migration, restart, deployment, dataset mutation, production mutation, provider/model call, or fresh audit occurred during diagnosis.

Completed:
- September 14 TBK audit recovery/reconciliation.
- Stage 1 report/presentation closure.
- Stage 2 local plumbing closure.
- Candidate isolation/freeze/publication.
- Isolated Railway staging setup and frozen dataset transfer.
- Cross-platform path repair.
- Linux Railway startup validation.
- Vercel Preview environment repair.
- Browser login/session and worker routing.
- Staging identity bootstrap.
- Tenant-scope continuity diagnosis and repair-boundary freeze.

In progress:
- None. Awaiting explicit authorization for the bounded source + staging lifecycle ownership repair.

Blocked:
- Staging browser path cannot discover the frozen audit until authoritative registration/lifecycle ownership moves from `local-sandbox` to `prysm-stage2-staging`.
- Audit detail, report viewer, report invariants, and restart/reopen remain unproven in deployed browser path.
- Production remains frozen.

Important constraints:
- Preserve the 51 frozen audit objects byte-for-byte.
- Preserve audit ID, client ID, source tenant in recovered request, lifecycle status, report bytes/content, scores, findings, evidence semantics, and seven-section viewer.
- Do not create a duplicate audit identity.
- Do not use local-sandbox as a browser workaround.
- Scope source edits only to the frozen two-file boundary unless direct evidence requires otherwise.
- Lifecycle metadata migration must be staging-only and limited to this one audit.
- Use Terra Medium for this bounded repair; reserve Astra for the final independent tip-to-tail adversarial audit after staging is green.
- Do not use production Cognito/Railway/Postgres/S3/secrets/providers/models or start a fresh audit.
- Follow GACM and `SKILLS/GOVERNED_CODING_UPGRADE.md` v2.1.0.

Exact next action: Obtain explicit authorization for the narrowly bounded tenant-scope repair: update only the authoritative registration target in the two frozen source files, perform one staging-only lifecycle ownership migration for audit `6dca53ed-ae00-484c-bf77-b59c059eef51`, run the frozen acceptance/regression checks, and stop before production promotion.

Last verified: 2026-09-18 America/Toronto
