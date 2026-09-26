# Current State

Project: PRYSM

Current objective:
Restore `chriskulbaba2025/prysm-staging-isolated` to a file-for-file copy of known-working production source `chriskulbaba2025/vantage-platform` at exact SHA `26fb91d29559cb189064c301cdf89ff69f330492`, then change only isolated staging landing destinations.

Verified checkpoint:
- Authoritative durable context repository: `chriskulbaba2025/prysm-project-context`.
- Working production source repository: `chriskulbaba2025/vantage-platform`.
- Exact approved production source SHA: `26fb91d29559cb189064c301cdf89ff69f330492`.
- Existing staging target repository: `chriskulbaba2025/prysm-staging-isolated`; do not create another staging repository.
- The original staging initialization commit `3e14fb869f590f6bcfc8f63f39194b4ca3d95698` was already essentially a production clone: production had 1,110 file blobs; initialization had 1,109; the only differences were two omitted workflow files and added `STAGING_ISOLATION.md`.
- The uploaded production source ZIP was independently verified against production SHA `26fb91d29559cb189064c301cdf89ff69f330492`; all 1,110 file blobs matched exactly.
- Current repaired staging state is superseded for implementation purposes. The previously used staging HEAD `5b7705717bf4470c55038df60bcdd682268ad65e` and later repair lineage are forensic only and must not be used as the cloning base.
- Production remains frozen.

Current environment / branch / version:
- Target repository: `chriskulbaba2025/prysm-staging-isolated`
- Target branch: `main`
- Production source: `chriskulbaba2025/vantage-platform@26fb91d29559cb189064c301cdf89ff69f330492`
- Railway project: `07f1a0a3-a657-4a24-9ecb-56ba667cfc3f`
- Railway environment: `b67677ba-4ac1-458f-a6d3-412de5ad9ea8`
- Railway worker: `3343e2a8-0472-4780-8536-e8b9667fcc7a`
- Railway Postgres: `23ca9253-9388-45d7-90a5-e441af63083a`
- Worker domain: `prysm-worker-production.up.railway.app`
- Vercel staging project ID: `prj_ys6JNfnwyRow5G3BENFXliU3fIqs`
- Vercel staging URL: `https://prysm-staging-isolated.vercel.app`

Completed:
- Identified the exact known-working production source SHA.
- Verified that the original isolated-staging initialization was already essentially a direct production clone.
- Verified the uploaded source ZIP matches all 1,110 production file blobs at the approved SHA.
- Explicitly superseded the hybrid staging repair path.

In progress:
- No code mutation is currently authorized beyond the exact-clone reset and isolated landing-destination changes described below.

Blocked:
- No blocker is currently proven.
- The clone must fail closed if exact source identity, destination identity, environment/runtime parity, or final tree parity cannot be proven.

Important constraints:
- Do not reconstruct the application piece by piece.
- Do not continue from the repaired staging lineage as an implementation base.
- Preserve application code, worker code, renderer, provider adapters, DataForSEO setup, PageSpeed setup, Playwright/browser runtime, package versions, build method, Railway runtime settings, Vercel build settings, environment variable names, provider credentials, auth logic, feature flags, timeouts, and report behavior exactly.
- Change only isolated landing-area values: PostgreSQL target; S3 bucket/prefix or artifact destination; staging tenant/namespace where required; staging worker URL/domain; Vercel project/domain references; and auth callback/webhook URLs only where required by the staging destination.
- No variable renaming, refactoring, provider rewiring, renderer fixes, cleanup, or architecture changes.
- Preserve Git history; do not force-push or destructively rewrite history. The accepted reset must make the staging file tree match the approved production tree while retaining auditable history.
- Production remains frozen.

Exact next action:
Execute one bounded governed clone-reset tranche: verify both repository identities and exact source SHA; make `prysm-staging-isolated/main` resolve to a new auditable commit whose file tree is exactly identical to production SHA `26fb91d29559cb189064c301cdf89ff69f330492`; then apply only the explicitly required isolated landing-destination values without renaming variables or altering application behavior; deploy the exact accepted staging commit; prove source/tree/runtime parity; run one test audit; and confirm the report renders. Stop on any parity mismatch or requirement to change application logic.

Last verified:
2026-09-25

## Exact clone reset closure — 2026-09-26

- Approved production source: `chriskulbaba2025/vantage-platform@26fb91d29559cb189064c301cdf89ff69f330492`.
- Restored staging commit: `af787bbf8ce6019702d2a76b4e82f5d874fb6ad6`.
- Production and staging tracked trees matched exactly before landing-destination review: tree `c65a41686e3d45f77d7f1d937da2ba6a4068c3b8`, 1,110 tracked files, complete path/blob mapping equal.
- Railway deployment: `f3e520ff-aa41-48cd-8010-c9502c83d257`, SUCCESS, deployed commit exactly `af787bbf8ce6019702d2a76b4e82f5d874fb6ad6`.
- Vercel deployment: `dpl_6EnFNNH3bw6Q6X8gvfCkVGoEMWXp`, READY, project `prj_ys6JNfnwyRow5G3BENFXliU3fIqs`, Git SHA exactly `af787bbf8ce6019702d2a76b4e82f5d874fb6ad6`.
- Exactly one test audit was created: `d0911546-80ea-49d4-94cc-afc5e57892d7`; execution `e047b383-1d0b-4d8c-b12b-09405dc974c4`; terminal lifecycle `draft_rendered`.
- Readback recovered 44 governed objects. OnPage and Backlinks were available; conversion-path evidence was partial with screenshots. SERP failed because the approved source location resolver could not resolve `London, Ontario`. PageSpeed remained `NOT_CONNECTED` because the approved source execution path required `PAGESPEED_API_KEY` and did not consume the configured staging key path.
- Per the fail-closed clone-reset boundary, no application repair and no second audit were authorized after these product/configuration defects were exposed.
- Terminal disposition: `PRYSM_EXACT_CLONE_RESET_BLOCKED`.
- Full proof: `C:\Users\kulba\Downloads\PRYSM-EXACT-CLONE-RESET-2026-09-26\`.
- Last verified: 2026-09-26.

## GACM multi-tranche checkpoint — 2026-09-26

- Application candidate: `0678d77e2633eefda1e44e421b95f30a9b91a48f` on `main`, pushed normally and verified equal to `origin/main`.
- Railway isolated worker deployment: `f46fe286-a2a2-4bc4-a760-9b6dfc8d9c03`, `SUCCESS`; worker health HTTP 200.
- Fresh staging audit: `14da9fc6-8d58-4f9b-85bb-f3bfbda1b758`, tenant `prysm-staging`, client `bulldoghomemaintenance.ca-bulldog-hme-maintenance`, terminal `draft_rendered`.
- Readback: 43 governed objects; required canonical artifacts, raw artifacts, normalized artifacts, source manifests, four conversion screenshots, and 16 report pages recovered with exact hashes.
- Live evidence: OnPage AVAILABLE; SERP AVAILABLE with local Maps, Business Profile, and Labs evidence; Backlinks AVAILABLE with 12 history periods; PageSpeed AVAILABLE via DataForSEO Lighthouse; CrUX/GA4/GSC NOT_CONNECTED; conversion paths PARTIAL with four screenshots.
- Worker regression: 1,044 passed, 0 failed.
- Public staging browser and all 16 served report routes returned HTTP 200 with non-empty content and no observed browser errors.
- Truth limitations: persisted intake has zero services and empty market; no values were fabricated. PageSpeed diagnostic screenshot persistence reported missing `runId` while score evidence remained available.
- GACM disposition: `PRYSM GACM MULTI-TRANCHE ACCEPTANCE: BLOCKED`.
- Blocking gates: required master-checklist seven-page contract is not proven because the current served report has 16 pages; the required eight-site generalization matrix is not complete. Tranche 13 remains dependent on these gates; no whole-system release PASS is claimed.
- Full proof: `C:\Users\kulba\Downloads\PRYSM-GACM-MULTITRANCHE-2026-09-26\`.
- Production remains untouched.

## Stale-recovery closure checkpoint — 2026-09-26

- PR #5 exact source candidate: `d008727baa4dacbea7915f0e3237b4146597c69b`.
- Newer accepted `main` lineage `c0eda73a2c741fdafbb71da4bd893e91b6dc0e06` was preserved; no blind merge or rollback occurred.
- Vercel Preview configuration parity was repaired without changing application code. Exact candidate Preview deployment is READY and returns HTTP 200.
- First Railway proof deployment logged the expected worker startup and a `PRYSM_DATA_VISIBILITY_SNAPSHOT` showing audit `560f5640-9ff3-4a68-881c-56f4284867e4` at `render_failed`.
- Subsequent exact-SHA proof deployments unexpectedly ran the root Next.js web app rather than the Worker runtime; the worker audit readback endpoint returned 404. A bounded local exact-worktree Railway upload failed at the Railway API boundary.
- Terminal disposition: `PRYSM_GACM_STALE_RECOVERY_TRANCHE_BLOCKED`.
- Work Package 2 was not started.
- Proof: `C:\Users\kulba\Downloads\PRYSM-GACM-CLOSURE-2026-09-26\`.
- Production remains untouched.

## Bulk closure tranche checkpoint — 2026-09-26

- Candidate `c0eda73a2c741fdafbb71da4bd893e91b6dc0e06` on `main`, pushed normally and verified equal to `origin/main`.
- Railway deployment `a524a41d-199c-4e36-95f0-387561526084`: SUCCESS, exact candidate SHA; health HTTP 200.
- Vercel staging deployment: READY, exact candidate SHA.
- Generic intake contract now rejects missing market, primaryGoal, and services for new creation while persisted recovery remains verbatim.
- PageSpeed universal execution now carries governed screenshot identity into diagnostic persistence; targeted tests 50/50 and full worker regression 1,045/1,045.
- Bulk proof: `C:\Users\kulba\Downloads\PRYSM-GACM-BULK-CLOSURE-2026-09-26\`.
- Bulk disposition: `PRYSM_GACM_BULK_CLOSURE_HOLD`.
- Blocking gates: v1 seven-page migration is not complete; legacy current-model projection fails in controlled report fixtures; final PDF acceptance is not active; generalization matrix lacks e-commerce, multi-location, and service+booking/product closure evidence.
- Production remains untouched.
