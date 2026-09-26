# Current State

Project: PRYSM

Current objective:
Lock a defensible, useful V1 report foundation by strengthening evidence acquisition, evidence classification, scoring verification, and reconciliation before redesigning or automating the report. Automation and recurring remediation workflows are V2.

Verified checkpoint:
- Authoritative durable context repository: `chriskulbaba2025/prysm-project-context`.
- Active isolated staging repository for this tranche: `chriskulbaba2025/prysm-staging-isolated`.
- Isolated staging default branch: `main`.
- Exact isolated staging remote HEAD independently verified on 2026-09-25: `96d948f956181f09c005bae6289d93ee176a0972`.
- The isolated staging repository was initialized from production snapshot `26fb91d29559cb189064c301cdf89ff69f330492`.
- `STAGING_ISOLATION.md` marks this repository staging-only and freezes production.
- The `PRYSM_DFS_RAW_EVIDENCE_GATE` returned FAIL.
- The generalized owning boundary is the universal DataForSEO adapter raw-evidence return contract before `AuditOrchestrator.processOneSource()`.
- Independent source inspection confirmed `processOneSource()` could persist only adapter-supplied `rawBytes`, while DataForSEO OnPage, SERP, and Backlinks paths did not guarantee materially sufficient pre-normalization raw evidence plus sanitized request context across failure/partial/not-connected outcomes.
- Chris explicitly authorized one narrow isolated-staging exception for the generalized DataForSEO raw-evidence contract repair and deterministic tests only. The exception is recorded in `CONSTRAINTS.md`.
- The governed repair returned `PRYSM_DFS_RAW_EVIDENCE_REPAIR_PASS`.
- Identity reconciliation returned `PRYSM_DFS_RAW_EVIDENCE_IDENTITY_PASS`.
- Exact accepted repair SHA `96d948f956181f09c005bae6289d93ee176a0972` is published on `chriskulbaba2025/prysm-staging-isolated` `main`, and GitHub readback confirms the same SHA.
- The report-foundation decisions remain active: V1 report before V2 automation; deliberate evidence classification; independent second verification after scoring; real-DFS tuning before classifier implementation; and the 2 TOFU / 2 MOFU / 2 BOFU / 2 Leading Edge content contract.
- The service-sector no-pricing recommendation rule remains an active hard constraint.
- Fresh Bulldog isolated-staging audit `560f5640-9ff3-4a68-881c-56f4284867e4` completed evidence collection, evidence lock, scoring, and narrative-ready state on accepted SHA `96d948f956181f09c005bae6289d93ee176a0972`.
- That Bulldog audit then failed only at v1 page rendering. Railway logs show one shared compatibility-projection defect: the current ScoreSet/decision-evidence path is passed to the legacy v1 renderer without the legacy `model.evidence.site` shape required by pages such as content ideas, trust, CMS, technical SEO, headings, schema, performance, and appendix.

Current environment / branch / version:
- Working directory: `C:\Users\kulba\Desktop\prysm-staging-isolated`
- Repository: `chriskulbaba2025/prysm-staging-isolated`
- Branch: `main`
- Remote SHA: `96d948f956181f09c005bae6289d93ee176a0972`
- Production source snapshot: `26fb91d29559cb189064c301cdf89ff69f330492`

Completed:
- Selected Bulldog Home Maintenance as the relatively strong validation fixture and Reboot Business Coaching as the more complex/weak validation fixture; neither may become an implementation target.
- Defined the report-foundation sequence: evidence acquisition -> normalization -> classification -> scoring -> independent verification -> reconciliation -> client-facing report.
- Defined the principle that the second measurement must be meaningfully independent and disagreements must reconcile or fail closed rather than be averaged.
- Defined the content opportunity target of up to eight primary ideas across TOFU/MOFU/BOFU/Leading Edge.
- Ran the bounded DataForSEO raw-evidence preservation diagnosis and identified the generalized raw-evidence contract defect.
- Implemented and proved the generalized DataForSEO raw-evidence repair with deterministic tests only.
- Published and verified the exact accepted repair candidate at `96d948f956181f09c005bae6289d93ee176a0972`.

In progress:
- No implementation repair is currently in progress.
- The fresh Bulldog audit is complete through evidence/scoring and is now the validation source for external evidence classification and a meaningfully independent second verification.
- The v1 renderer compatibility defect is recorded but intentionally deferred until after evidence classification/verification.

Blocked:
- No evidence-validation blocker is proven. The Bulldog data path completed before the renderer failed.
- v1 client-report rendering for this audit is blocked by the current-to-legacy report evidence projection defect.
- Evidence classification remains blocked only until the governed staging readback chain is proven. The exact Bulldog package is persisted in isolated-staging object storage; this is not presently an evidence-collection failure.
- Preflight on 2026-09-25 initially returned `PRYSM_BULLDOG_PREFLIGHT_FAIL` because the local Railway CLI session could not access the isolated staging project. Chris successfully re-linked the local Railway CLI to the isolated staging project/environment and selected `prysm-worker`; that blocker is cleared.
- The second preflight failure (`postgres.railway.internal` ENOTFOUND from local Windows) was an invalid preflight requirement, not a broken staging dependency. Railway connector verification shows Postgres is healthy and the worker is already connected to PostgreSQL; Railway documents `railway connect postgres --tunnel-only` for genuine local DB access, but this tranche does not require direct DB access.
- The preferred readback chain is now frozen: Railway-linked local process -> existing worker `GET /api/v1/audits/:auditId` using `x-vantage-secret` for governed audit/client identity -> Railway-injected tenant/S3 configuration -> exact object-store artifact readback and verification.
- The full Bulldog evidence readback/classification run completed and returned `PRYSM_BULLDOG_EVIDENCE_PACKAGE_FAIL`. Readback itself PASSed: 21 artifacts recovered; identity, hashes, manifests, and schema checks passed; external classification and independent reconciliation completed.
- The actual remaining generalized blocker is live evidence-provider configuration: DataForSEO OnPage FAILED because `DATAFORSEO_LOGIN` / `DATAFORSEO_PASSWORD` are absent; DataForSEO SERP and Backlinks are `NOT_CONNECTED`; PageSpeed is `NOT_CONNECTED` because no PageSpeed API key is configured. The same DataForSEO credential pair serves OnPage, SERP, and Backlinks. `GOOGLE_PAGESPEED_API_KEY` is the primary PageSpeed key; `GOOGLE_CRUX_API_KEY` is optional because the worker falls back to the PageSpeed key for CrUX.
- Conversion-path validation is `NOT_ASSESSED` downstream of the failed OnPage crawl because no crawled page set existed for deterministic key-page selection. Do not treat conversion validation as an independent blocker until provider-backed OnPage collection succeeds; then explicitly smoke the Playwright runtime before any paid rerun.
- GA4 and GSC remain optional first-party integrations and are not required to close the current generalized evidence-package baseline when absent is represented truthfully.

Important constraints:
- Production remains frozen. No production mutation is authorized.
- Work only in the isolated staging repository for this tranche.
- Preserve provider failure/partial/unavailable/not-connected states; UNKNOWN must never become ABSENT or a negative finding.
- Preserve secrets/data minimization: raw evidence storage must exclude credentials, authorization headers, tokens, cookies/session secrets, and unnecessary personal information.
- Data acquisition is driven by defined evidence questions. Use DataForSEO where it closes the evidence question; use first-party sources for facts only first-party systems can establish.
- Service-sector content recommendations must never recommend publishing specific pricing or a pricing page.
- Named sites are regression/validation fixtures only.
- Do not implement the classifier or change report code before the Bulldog evidence has been externally classified and independently second-verified.
- Do not rerun Bulldog merely to repair presentation; reuse the already-persisted governed evidence from audit `560f5640-9ff3-4a68-881c-56f4284867e4`.

Exact next action:
Authorization is now granted for the full isolated-staging provider-readiness closure: configure the required DataForSEO/PageSpeed variables, redeploy the isolated worker, run no-cost/low-cost readiness checks, prove Playwright/Chromium, then run exactly one fresh Bulldog isolated-staging audit with bounded paid provider execution and continue automatically through evidence readback, classification, independent verification, reconciliation, and Evidence Package readiness. Production remains frozen. If preflight passes, establish a safe isolated-staging readback path for Bulldog audit `560f5640-9ff3-4a68-881c-56f4284867e4` without rerunning providers, then continue in the same tranche through exact artifact identity/readback, external classification, meaningfully independent second verification, reconciliation, and Evidence Package readiness. Prefer a no-deploy local readback using Railway-injected staging environment and the existing governed artifact-store code. Stop immediately if any required access is missing or if continuation would require a new authorization boundary.

Last verified:
2026-09-25
