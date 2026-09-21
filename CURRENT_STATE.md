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

## Runtime closure update — 2026-09-21

- **Closure result: BLOCKED.** `MVP_READY_FOR_PRODUCTION_ACTIVATION` is not established.
- Authoritative Vercel project `prysm` (`prj_o4dQkuESOoTphZkOwVKG49BaLQT9`, team `chriskulbabas-projects`) now has exact-candidate Preview deployment `dpl_7VShafwVk4weTJSL473zaFYVvkNh`, READY at branch `repair/prysm-mvp-client-readiness-2026-09-21`, SHA `bd12a1c7c77ba0e297a8da4c69e331d6456b3748`. Preview URL: `https://prysm-ahc9jew33-chriskulbabas-projects.vercel.app`.
- The Preview branch has `VANTAGE_WORKER_API_URL` pointing to the authoritative GENSEN staging URL and the matching staging `VANTAGE_TENANT_ID`. Values were not written to proof. `COGNITO_REGION`, `COGNITO_CLIENT_ID`, `COGNITO_USER_POOL_ID`, and `VANTAGE_WEBHOOK_SECRET` remain scoped only to the old Preview branch. Source inspection confirms the missing values are required for authenticated session and worker paths. They were not changed because the active instruction authorized copying only the two Vantage variables.
- A real local Chromium/Playwright smoke reached `/login` on the exact Preview (HTTP 200, expected login title/fields, zero page errors). Authenticated reviewer flow, seven report pages, session continuity, and report retrieval are not proven. No fresh PDF was generated.
- Railway exact staging deployment `95ace217-6c0d-4d65-a42a-209077670b71` remains SUCCESS at the exact SHA. Build manifest `sha256:40f926c14c6e85c3a5c234afaab9a57b5dae60bd004189c1d99209d6e90ac0b8`, config digest `sha256:c629ad67e3700711eee02207b0681919bf6d10ff525689ba53420619260a9e2a`; startup proves PostgreSQL initialization, S3 connectivity, and worker listening. GET `/health` returned 200. Railway does not expose a separate running-container digest; no digest equality is claimed. No redeploy was performed.
- GitHub `Vercel – prysm` status is success for the new Preview deployment. `Vercel – vantage-platform` remains a failing status pointing to an older deployment; that distinct project is non-authoritative and was not changed or disconnected. Railway's stale error status points to removed predecessor `79fee361-...`; the direct current deployment `95ace...` is successful.
- **PRODUCTION PATH EQUIVALENCE: BLOCKED. PRODUCTION IDENTITY CONTINUITY: BLOCKED.** The login-to-audit/report/PDF identity path has not traversed authentication and terminal report retrieval.
- Final independent challenge is BLOCKED; zero critical/major is not certified because the authenticated report/PDF path is unavailable.
- Production remained untouched: no production aliases, deployments, variables, Cognito, PostgreSQL, S3, audits, or provider calls were changed or run.

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

Obtain authorization to apply the existing staging-only `COGNITO_REGION`, `COGNITO_CLIENT_ID`, `COGNITO_USER_POOL_ID`, and `VANTAGE_WEBHOOK_SECRET` values to Preview scope for branch `repair/prysm-mvp-client-readiness-2026-09-21`. Then complete authenticated browser/session acceptance, generate and inspect a fresh PDF, run the final independent challenge, and refresh durable state. Production activation requires separate authorization.

Last verified: 2026-09-21 America/Toronto
