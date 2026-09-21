# Current State

Project: PRYSM

Current objective: Complete the continuous governed MVP client-readiness closure on the dedicated repair branch and reach one exact candidate at `MVP_READY_FOR_PRODUCTION_ACTIVATION`. Production remains frozen.

## Verified candidate

- Authoritative audit: `6dca53ed-ae00-484c-bf77-b59c059eef51`; the complete canonical Sept. 14 persisted dataset is the audit source.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Branch: `repair/prysm-mvp-client-readiness-2026-09-21`.
- Current exact candidate: `bd12a1c7c77ba0e297a8da4c69e331d6456b3748`; GitHub repair branch is at that exact SHA.
- Current `main`: `0e4a97e68f19b974e7ef3dfdd1480cbc390d090b`, already an ancestor of the repair candidate. T6 lineage is satisfied; no merge is required or authorized.
- Local `npm test`: PASS 1,026/1,026, 0 skipped. `npm run verify:prysm-closure`: PASS, including assembled closure checks and Whole-App P-B01–P-B16.
- Hosted Vantage Worker CI run `35572418788` and PRYSM MVP Hosted Verification run `35572418812`: PASS, including full regression, hosted PostgreSQL lifecycle, WP2–WP12, provisioning and closure checks.
- Developer-local PostgreSQL tests previously failed because the local role credential was rejected; hosted PostgreSQL tests passed at the exact candidate. Do not claim local PostgreSQL PASS.

## Railway staging — exact candidate deployed

- Authoritative production-shaped staging path remains the GENSEN process staging environment:
  - Project: `GENSEN process`
  - Project ID: `9dfaead1-79d7-4582-9c58-0999a1d07b84`
  - Environment: `staging`
  - Environment ID: `9d541fe0-5103-4134-98dc-332dae65de7b`
  - Worker service: `vantage-platform-staging`
  - Service ID: `d8504781-cb85-4b09-8999-19852f39be2b`
  - Domain: `vantage-platform-staging-staging.up.railway.app`
- On 2026-09-21 the staging worker source was changed from the old branch `repair/prysm-stage2-candidate-2026-09-18` to `repair/prysm-mvp-client-readiness-2026-09-21`.
- Railway service config now pins exact commit `bd12a1c7c77ba0e297a8da4c69e331d6456b3748`.
- Exact-candidate deployment `95ace217-6c0d-4d65-a42a-209077670b71`: SUCCESS.
- Deployment metadata independently reports branch `repair/prysm-mvp-client-readiness-2026-09-21`, commit `bd12a1c7c77ba0e297a8da4c69e331d6456b3748`, commit message `fix PRYSM closure acceptance boundaries`.
- Startup logs prove staging S3 connectivity, PostgreSQL initialization, governed API runtime initialization, and worker listening on port 8080.
- Exact build image manifest digest from Railway build logs: `sha256:40f926c14c6e85c3a5c234afaab9a57b5dae60bd004189c1d99209d6e90ac0b8`.
- Exact image config digest: `sha256:c629ad67e3700711eee02207b0681919bf6d10ff525689ba53420619260a9e2a`.
- Railway's public API/agent does not expose the running container manifest digest separately. Therefore a byte-level build-manifest-vs-runtime-digest comparison cannot be independently proven through the available Railway API. The earlier `sha256:1ff...` vs `sha256:006...` mismatch is superseded for the exact candidate by the new build evidence; do not reuse those old digests as current-candidate identity.
- Railway reports BUILD_IMAGE, PUBLISH_IMAGE, CREATE_CONTAINER and CONFIGURE_NETWORK completed for deployment `95ace...`. This supports deployment continuity at the exact Git SHA but must not be overstated as an independently exposed runtime digest match.
- No explicit Railway healthcheck path is configured. A HEAD request to `/health` returned 404, so `/health` must not be treated as the application's health contract without source evidence.

## Remaining release gates

- **Closure result: BLOCKED.** Do not claim `MVP_READY_FOR_PRODUCTION_ACTIVATION`.
- Authoritative Vercel project: `prysm` (`prj_o4dQkuESOoTphZkOwVKG49BaLQT9`), team `chriskulbabas-projects`.
- Current exact-candidate GitHub statuses still show `Vercel – prysm` and duplicate `Vercel – vantage-platform` failing.
- Exact-candidate Vercel Preview fails because branch-specific Preview values `VANTAGE_WORKER_API_URL` and `VANTAGE_TENANT_ID` remain scoped only to the old branch. This is Vercel branch/environment configuration, not a product-code defect.
- The exact staging worker URL is now established as `https://vantage-platform-staging-staging.up.railway.app`. The matching tenant value must be copied secret-safely from the authorized old branch/runtime configuration; do not expose it in proof.
- Vercel branch-scoped variables should be copied to `repair/prysm-mvp-client-readiness-2026-09-21` for Preview only, then the authoritative `prysm` Preview must be rebuilt and proven READY at exact SHA `bd12a1c...`.
- Duplicate Vercel project `vantage-platform` is non-authoritative; do not repair product code for that context. Determine whether its GitHub status can be ignored/removed from the MVP release contract or should be disabled separately without touching production.
- Real authenticated browser acceptance and fresh browser-generated PDF for `bd12a1c...` remain outstanding.
- Final independent post-run challenge remains outstanding pending Vercel/browser/PDF evidence.
- PRODUCTION PATH EQUIVALENCE: not yet PASS.
- PRODUCTION IDENTITY CONTINUITY: exact Git/deployment identity is substantially improved; final closure still requires Vercel/browser/report retrieval continuity.
- Production remained untouched: no merge to main, production deploy/promotion/alias/configuration change, production audit, production AWS/Cognito/PostgreSQL/S3 mutation, or paid/live Writer/Judge/provider execution.

## Governance and proof

- Decision: `DECISION_PRYSM_MVP_CLIENT_READINESS_CLOSURE_2026-09-21.md`.
- Tranche specification: `PRYSM_MVP_CLIENT_READINESS_CLOSURE_PLAN_2026-09-21.md`.
- Frozen Encyclopedia and seven-page narrative contracts remain authoritative.
- Existing local proof folder: `C:\Users\kulba\Downloads\PRYSM-MVP-CLOSURE-2026-09-21\`.
- Production activation requires separate explicit authorization after all staging/browser/PDF/identity gates pass.

## Important constraints

- No TBK-specific product behavior; TBK remains an acceptance fixture only.
- Preserve Encyclopedia challenge/materiality rules and UNKNOWN/PARTIAL/UNAVAILABLE semantics.
- Do not reset or rewrite repair history; do not merge to main.
- Do not store or expose secrets in proof or project memory.
- Production remains frozen: no production deploy/promotion/configuration, data/provider mutation, live audit, or paid/live Writer/Judge/provider execution.
- Do not reopen report logic unless real browser/runtime evidence proves a product defect.

## Exact next action

On the clean MVP closure worktree, use the Vercel CLI to secret-safely copy only `VANTAGE_WORKER_API_URL` and `VANTAGE_TENANT_ID` from the old branch-specific Preview mapping to `repair/prysm-mvp-client-readiness-2026-09-21`, without printing their values. Redeploy the authoritative `prysm` Preview at exact SHA `bd12a1c...`, prove it targets the exact Railway staging worker, then run the real authenticated seven-page browser/PDF acceptance and final independent challenge.

Last verified: 2026-09-21 America/Toronto
