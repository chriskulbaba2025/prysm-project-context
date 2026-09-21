# PRYSM MVP Client Readiness Resume Audit — 2026-09-21

## Target

- Application: `chriskulbaba2025/vantage-platform`
- Exact branch/SHA: `repair/prysm-mvp-client-readiness-2026-09-21` / `bd12a1c7c77ba0e297a8da4c69e331d6456b3748`
- Local and remote branch heads match; application tree clean.
- `origin/main=0e4a97e68f19b974e7ef3dfdd1480cbc390d090b` is an ancestor; T6 lineage satisfied without a merge.
- Audit identity: `6dca53ed-ae00-484c-bf77-b59c059eef51`; the complete canonical persisted dataset, not rendered report prose, is the source.

## Tranche and test evidence

The 27 post-`af958...` commits were preserved and reviewed. The new exact candidate repairs current acceptance validators/fixtures/hydration at their owning boundaries; no TBK-specific product behavior was added.

- Local `npm test`: PASS, 1,026/1,026, 0 skipped, 18.272 seconds.
- Local `npm run verify:prysm-closure`: PASS, assembled closure checks and Whole-App P-B01–P-B16.
- Hosted Vantage Worker CI `35572418788`: PASS, full regression, hosted PostgreSQL, WP2–WP12, provisioning and closure.
- Hosted PRYSM MVP Hosted Verification `35572418812`: PASS, full regression, narrative v2, hosted PostgreSQL, Whole-App, WP2–WP12, provisioning and closure.
- Local PostgreSQL suite failed only because the developer machine rejects the configured postgres role credential; it is not represented as PASS.
- T0–T6 deterministic/source gates are complete. T7 non-production runtime deployment is incomplete. T8 browser/PDF is incomplete. T9 independent final challenge is blocked.

## External gate findings

### Vercel

The authoritative project is `prysm`, project ID `prj_o4dQkuESOoTphZkOwVKG49BaLQT9`. Its exact-candidate Preview build clones the right branch/SHA but stops in Next config validation because explicit `VANTAGE_WORKER_API_URL` and `VANTAGE_TENANT_ID` are absent for this branch. Existing sensitive variables are scoped to the predecessor repair branch; values were not read or copied and no settings changed.

The duplicate `vantage-platform` project has a fresh build at the same candidate and the same missing-variable failure. Its GitHub context URL still points at an older deployment. It remains non-authoritative. Classification: Preview branch/environment configuration issue, not an app code defect.

### Railway

Read-only Railway configuration identifies GENSEN process staging (project `9dfaead1-79d7-4582-9c58-0999a1d07b84`, environment `9d541fe0-5103-4134-98dc-332dae65de7b`, worker service `d8504781-cb85-4b09-8999-19852f39be2b`) as the only observed PostgreSQL/S3 worker path; prior sanitized proof documents worker startup, PostgreSQL/S3 initialization and an exact audit artifact read.

The distinct PRYSM-stage2 service (project `3c94733e-478b-48e8-b66c-8946a6d46064`, staging environment `4dd88e96-0c01-4da5-957b-4068a6d46064`) is configured for local persistence/dev memory and a local mounted volume, without PostgreSQL/S3 wiring. It is not equivalent to the required production-shaped staging path.

No Railway deploy or variable mutation occurred. The prior GENSEN deployment digest mismatch remains unresolved: metadata `sha256:1ffbfc72b59accd94cdde192239ade1d79d48bc933da0ffacc66630b63e28d12`; build export `sha256:006b1fd0ed138b4650ba3ca01e0978a89d747237a58173476c39406993070b43`.

### Browser, PDF, and identity

No managed Chromium browser is available and no authenticated staging reviewer session is present. The exact-candidate login-to-dashboard-to-audit-to-seven-pages-to-navigation-to-print/PDF-to-refresh/session-to-dashboard flow was not executed. No fresh candidate browser PDF was generated or visually checked. PRODUCTION PATH EQUIVALENCE and PRODUCTION IDENTITY CONTINUITY remain BLOCKED across auth/session, routing, runtime image, persistence/reload, artifact/report and terminal browser/PDF handoffs.

## Independent challenge disposition

Verdict: BLOCKED. The exact source candidate and automated tests are available, but independent terminal challenge cannot establish the required runtime/browser/PDF continuity. Zero CRITICAL / zero MAJOR is not claimed. Production remains untouched.

## Result

`MVP_READY_FOR_PRODUCTION_ACTIVATION` is not established. Continue from this exact candidate after the missing Vercel branch binding, Railway digest identity, authorized reviewer browser session, and exact-candidate staging/browser/PDF proofs become available. Production activation remains a separate authorization boundary.

Proof package: `C:\Users\kulba\Downloads\PRYSM-MVP-CLOSURE-2026-09-21\`.

## Runtime continuation — 2026-09-21

This section supersedes the earlier Vercel/Railway/browser observations above for the exact candidate; source and regression evidence remain unchanged.

- Authoritative Vercel `prysm` Preview is READY: deployment `dpl_7VShafwVk4weTJSL473zaFYVvkNh`, exact branch and SHA `bd12a1c7c77ba0e297a8da4c69e331d6456b3748`. Branch Preview metadata confirms the two authorized Vantage variables are present. The staging worker URL is correct; tenant was bound from the authoritative Railway staging service without disclosure.
- Existing old-branch values for `COGNITO_REGION`, `COGNITO_CLIENT_ID`, `COGNITO_USER_POOL_ID`, and `VANTAGE_WEBHOOK_SECRET` were not copied because the explicit instruction allowed only two variables. Source inspection proves those four are required to execute authenticated browser and worker paths. This is a configuration authorization hold, not a product-code defect.
- Local Chromium/Playwright reached the exact deployment's `/login` page (200; expected login controls; zero page errors). Authenticated acceptance was not attempted, and no Cognito password reset was performed while Preview auth configuration was incomplete.
- Exact Railway candidate deployment `95ace217-6c0d-4d65-a42a-209077670b71` is SUCCESS at the exact SHA. Startup shows Postgres initialization, S3 connectivity, worker startup; GET `/health` returned 200. Build manifest `sha256:40f926c14c6e85c3a5c234afaab9a57b5dae60bd004189c1d99209d6e90ac0b8`; image config `sha256:c629ad67e3700711eee02207b0681919bf6d10ff525689ba53420619260a9e2a`. Railway does not expose a separate runtime digest, so no image digest equality is claimed. No Railway redeploy was needed.
- `Vercel – prysm` GitHub status is successful for the new Preview deployment. The separate `vantage-platform` project remains non-authoritative; its failing status targets an older deployment and was not disconnected. Railway's stale error check references removed predecessor `79fee361-...`; current exact deployment `95ace...` is successful.
- Seven-page authenticated browser acceptance and fresh PDF are blocked. `PRODUCTION PATH EQUIVALENCE: BLOCKED`; `PRODUCTION IDENTITY CONTINUITY: BLOCKED`; final independent challenge blocked and zero critical/major not certified.
- Production remained untouched.

Next action: authorize branch-scoped Preview binding of the four existing staging-only Cognito/webhook settings, then continue authenticated browser/PDF acceptance and final challenge.
