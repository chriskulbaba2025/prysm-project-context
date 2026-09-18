# Current State

Project: PRYSM

Current objective: Resolve tenant/data-scope continuity so exact candidate `d91432dc7dd63c222651cd676dbded9cc21e60d0` can expose the existing frozen authoritative audit to the authorized staging tenant `prysm-stage2-staging` without mutating the frozen dataset or touching production.

Verified checkpoint:
- Accepted frozen application production baseline remains `60169bf23eec37c29683937d459d7d96f82aba73`; production was not touched during the current work.
- Authoritative TBK audit ID: `6dca53ed-ae00-484c-bf77-b59c059eef51`.
- Frozen recovered TBK dataset remains complete and authoritative: 51/51 objects with zero hash drift.
- Stage 1 report/presentation work is CLOSED — PASS.
- Stage 2 local plumbing is CLOSED — PASS.
- Exact candidate remains:
  - branch: `repair/prysm-stage2-candidate-2026-09-18`;
  - SHA: `d91432dc7dd63c222651cd676dbded9cc21e60d0`.
- Linux Railway staging startup and authoritative registration are PASS.
- Vercel Preview environment attachment is PASS.
- Browser login/session and Preview-to-isolated-worker routing are PASS.
- Staging identity bootstrap/provisioning completed successfully through the existing staging admin boundary:
  - tenant `prysm-stage2-staging` created active;
  - staging Prysm user for Cognito sub `2408e438-0041-70dd-4a37-8709020a8068` created active;
  - verified staging email mapped;
  - exactly one active non-admin reviewer membership created.
- Direct authorization now PASS:
  - signed staging principal + `x-prysm-tenant=prysm-stage2-staging` -> `GET /api/v1/audits` HTTP 200.
- Current first material blocker is tenant/data-scope continuity:
  - authorized staging tenant receives an empty audit list;
  - the frozen authoritative audit `6dca53ed-ae00-484c-bf77-b59c059eef51` remains registered under `local-sandbox`;
  - the same audit is returned under the seeded `local-sandbox` identity/tenant path.
- Proven classification: tenant/data-scope continuity defect, not authentication/membership.
- Ruled out as current blocker:
  - Cognito authentication;
  - Vercel session issuance;
  - HMAC principal/signature;
  - shared secret;
  - staging Prysm user lookup;
  - active reviewer membership;
  - requested staging tenant authorization.
- No tenant reassignment, tenant mapping, frozen dataset mutation, source repair, new audit, or second repair was attempted after identifying this boundary.
- Final browser rerun was also impeded by Vercel Deployment Protection before app login; this did not supersede the proven tenant-scope blocker.
- No production resources were used or mutated.

Completed:
- September 14 TBK audit recovery and reconciliation.
- Stage 1 report/presentation closure.
- Stage 2 local plumbing closure.
- Candidate isolation/freeze and publication.
- Isolated Railway staging creation and frozen dataset transfer.
- Cross-platform path repair.
- Linux Railway startup/authoritative-registration validation.
- Vercel Preview environment attachment repair.
- Browser login/session and isolated worker routing.
- Staging worker identity bootstrap: tenant, user, reviewer membership.
- Direct staging principal authorization to `GET /api/v1/audits`.

In progress:
- None. Awaiting a separately governed tenant-scope continuity decision.

Blocked:
- The authorized staging tenant cannot discover the frozen authoritative audit because that audit is registered under `local-sandbox`.
- Audit detail, report, seven-section viewer, report invariants, and persistence/reopen remain unexecuted in the deployed browser path.
- Production path equivalence and identity continuity are not yet claimed.
- Production remains frozen.

Important constraints:
- Preserve exact candidate SHA `d91432dc7dd63c222651cd676dbded9cc21e60d0` unless direct evidence proves source change is required.
- Preserve the frozen 51-object authoritative dataset; do not mutate or regenerate it.
- Do not use `local-sandbox` as a browser workaround.
- The next change must solve staging tenant visibility/ownership/mapping of the existing frozen audit without altering report content or data bytes.
- Use lower-tier/mechanical model routing for bounded diagnosis/repair; reserve Astra for the final independent tip-to-tail adversarial audit after staging is fully green.
- Do not use production Cognito, Railway, Postgres, S3, secrets, providers, models, or start a fresh audit.
- Follow GACM and `SKILLS/GOVERNED_CODING_UPGRADE.md` v2.1.0.

Exact next action: Perform a READ-ONLY bounded tenant-scope continuity diagnosis to determine the supported smallest mechanism for exposing the existing authoritative audit to `prysm-stage2-staging` without mutating the 51 frozen objects: either an existing tenant mapping/registration override or a staging-only representation/metadata registration. Freeze one repair boundary and do not change source, tenant ownership, dataset, or infrastructure yet.

Last verified: 2026-09-18 America/Toronto
