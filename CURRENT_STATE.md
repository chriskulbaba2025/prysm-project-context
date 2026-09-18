# Current State

Project: PRYSM

Current objective: Complete the dependency-ordered Stage 2 staging closure after identity continuity PASS. The next repair stage is clean-deploy configuration reproducibility across Vercel target isolation, Railway worker build/root selection, and isolated staging persistence composition.

Verified checkpoint:
- Accepted frozen application production baseline remains `60169bf23eec37c29683937d459d7d96f82aba73`.
- Authoritative TBK audit ID: `6dca53ed-ae00-484c-bf77-b59c059eef51`.
- Frozen recovered TBK dataset remains authoritative: 51/51 objects; zero frozen dataset writes.
- Production remains frozen and untouched.
- Whole-system blind-spot audit is complete.
- Repair branch: `repair/prysm-stage2-candidate-2026-09-18`.
- Current exact application candidate: `97435e9a51a7b880dd0a6691fb20e5b7d25eae27`.
- Stage 2 staging identity continuity repair is CLOSED — PASS.
- Identity-bootstrap direct tests: 2/2 PASS.
- Bounded identity/auth/authoritative-registration regression: 33/33 PASS.
- Exact successful Railway staging deployment: `b158eac1-7def-4250-84c8-3a255d7c1270`.
- Exact deployed SHA: `97435e9a51a7b880dd0a6691fb20e5b7d25eae27`.
- Worker `/health`: HTTP 200 before and after one normal isolated staging restart.
- Staging tenant `prysm-stage2-staging`: present and active before/after restart.
- Staging Cognito sub `2408e438-0041-70dd-4a37-8709020a8068`: present before/after restart.
- Staging reviewer membership: exactly 1 active reviewer; zero admin memberships.
- Signed-principal audit list: HTTP 200 before/after restart.
- Authoritative audit present before/after restart.
- Signed audit detail: HTTP 200 before/after restart.
- Signed report read: HTTP 200 HTML before/after restart.
- Frozen dataset remains 51/51; zero target dataset writes.
- No new audit, provider call, model call, production deployment, production data mutation, or main merge occurred.
- Initial exact-candidate Railway failure was diagnosed and closed:
  - failed step: BUILD_IMAGE;
  - root cause: staging service `rootDirectory=services/worker` conflicted with repository-root Dockerfile COPY paths;
  - staging-only correction cleared rootDirectory and used `services/worker/Dockerfile` with repository-root context;
  - corrected deployment succeeded.
- Production path equivalence for the isolated Stage 2 identity-continuity objective: PASS.
- Production identity continuity for the isolated Stage 2 objective: PASS.
- Broad npm suite observed 1010 PASS / 5 FAIL; the five failures were documented as pre-existing unrelated response-header bridge / score-expectation tests and were not edited.

Remaining blind-spot repair queue:
1. Clean-deploy configuration reproducibility:
   - Vercel target isolation must not depend on repository production defaults plus ad hoc Preview overrides.
   - Railway worker build/root/start selection must be deterministic from a clean staging deployment.
   - Isolated Stage 2 persistence mode and `/data` requirements must be explicit and startup-validated rather than depending on an implicit variable combination.
2. Production database fail-closed startup:
   - when `DATABASE_URL` is configured but PostgreSQL initialization fails, worker startup must fail rather than falling back to memory lifecycle/identity.
3. Clean staging tip-to-tail acceptance:
   - Preview login/session → dashboard → audit discovery → detail → report → seven-section viewer → protected report invariants → restart/reopen repeat.
4. Independent adversarial release audit.
5. Production/Postgres/S3 promotion or confirmation remains a separate explicit authorization boundary.

Current directly verified source/config risks at exact candidate:
- `vercel.json` still contains:
  - `VANTAGE_WORKER_API_URL=https://vantage-platform-production.up.railway.app`;
  - `VANTAGE_TENANT_ID=default`.
  A clean Preview therefore depends on higher-precedence external staging overrides for isolation.
- `railway.toml` selects Dockerfile mode using `services/worker/Dockerfile`, which requires repository-root build context; the successful staging repair proved service-root mismatch can break deployment.
- `services/worker/src/server.js` enables isolated local persistence only through an exact multi-variable composition:
  - `NODE_ENV !== production`;
  - `VANTAGE_DEV_MEMORY_STORE=true`;
  - `PRYSM_LOCAL_PERSISTENCE=true`;
  - no `DATABASE_URL`;
  and uses `PRYSM_LOCAL_DATA_DIR` / default home-relative local path.
  Clean staging must make this mode and `/data` persistence requirement explicit and fail closed if misconfigured.

Important constraints:
- Production remains frozen.
- Preserve all 51 frozen audit objects.
- Do not alter report/scoring/dataset/Narrative/provider behavior in the clean-deploy tranche.
- Do not create a new audit.
- Do not call providers or models.
- Do not merge to application main.
- Use only the isolated staging Railway/Vercel surfaces for deployment verification.
- Diagnose all three clean-deploy configuration risks together before editing; do not return to piecemeal stop-at-first-defect repair.
- Keep the repair boundary to source/executable configuration/startup validation needed to make isolated staging deterministic and safe.
- After the clean-deploy tranche passes, stop before the production DB fail-closed repair unless separately continued.

Exact next action: Run one governed Stage 2 clean-deploy reproducibility repair against application candidate `97435e9a51a7b880dd0a6691fb20e5b7d25eae27`, jointly closing Vercel Preview isolation defaults, Railway worker repository-root Docker build selection, and explicit isolated-staging persistence/`/data` startup validation. Verify from a clean isolated staging deployment without touching production, then write a single proof and stop before the production DB fail-closed tranche.

Last verified: 2026-09-18 America/Toronto
