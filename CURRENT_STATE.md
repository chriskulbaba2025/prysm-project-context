# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Design and implement bounded representative acquisition so PRYSM can audit very large sites without attempting exhaustive crawling or allowing repetitive/programmatic URL families to consume the provider crawl budget.

Verified checkpoint:
- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Governed application branch: `main`.
- Verified application HEAD remains `edd034b62529a4d7317c1416cdb37c71b7cfb517` — `fix(serp): keep request timeout active in CI`.
- Draft-report `← Back to Dashboard` control remains implemented and deployed.
- SERP CI cancellation defect remains closed; Vantage Worker CI run `32905857982` / `#367` completed successfully.
- Viewer remains v2.2.0 / 16 governed pages.
- Scoring remains v4.1.1 unchanged.
- Controlled production Narrative v2 audit `5d22dcef-7d98-422f-8415-933e7b02003e` remains recovered to `draft_rendered`; no fourth Writer/Judge pass is permitted.
- Stripe audit `75992ac9-e2f1-4efe-b315-7ee8d6bda13b` reached `draft_rendered` but had approximately 10% evidence coverage, 1 of 13 evidence capabilities, 0 assessed modules, and crawl-dependent evidence unavailable.
- Direct S3 evidence proved `dataforseo-onpage` failed with `errorCategory: timeout`, returned zero records, produced no evidence, and persisted no raw OnPage artifact.
- The persisted normalized OnPage result records limitation `Source execution failed: Source execution timed out`.
- Direct runtime config verification proved the loaded production values are `onpagePollTimeoutMs: 600000`, `onpageMaxPages: 500`, and `onpagePollIntervalMs: 10000`.
- Application code proves `VANTAGE_ONPAGE_POLL_TIMEOUT_MS` defaults to 600000 ms, `VANTAGE_ONPAGE_MAX_PAGES` defaults to 500, and the orchestration retry boundary returns `Source execution timed out` when its hard timeout fires.
- The prior speculative environment-variable names were wrong and are not evidence. Do not repeat that diagnostic path.
- Current product decision: do not solve large-site failures by simply increasing timeout or crawl volume.
- Current large-site strategy: PRYSM should understand a broad footprint, classify material page families, select important/representative pages, and cap provider acquisition at approximately 250 pages.
- Current code already contains broad sitemap-footprint discovery, clustering of repeated/variable URL families, representative URLs, business-role priority scoring, DataForSEO `priority_urls`, and representative evidence integration.
- Current DataForSEO client caps `priority_urls` at 20 and currently submits `max_crawl_pages` from the configured `maxPages` value.
- The missing behavior is representative crawl enforcement: use footprint intelligence to govern the bounded acquisition plan before the paid provider crawl rather than merely analyzing representative evidence after the crawl.

Current environment / branch / version:
- Governed manual VS Code workflow on Desktop application repository.
- Application path: `C:\Users\kulba\Desktop\vantage-platform`.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Branch: `main`.
- Verified application HEAD: `edd034b62529a4d7317c1416cdb37c71b7cfb517`.
- Viewer: v2.2.0 / 16 governed pages.
- Scoring: v4.1.1.

Completed:
- Prior Narrative v2 production closure remains complete.
- Draft dashboard-return UI repair remains complete.
- SERP CI cancellation repair remains complete and CI-green.
- Diagnostic governance remains strengthened with evidence-first, no-guess rules.
- Stripe OnPage failure boundary is now directly verified from persisted production evidence and loaded runtime configuration.
- Large-site product direction has been decided: bounded representative acquisition rather than exhaustive crawling or timeout inflation.

In progress:
- New work package: Representative Crawl Enforcement.
- Design target: broad footprint discovery → page-family classification → deterministic priority/representative plan → approximately 20 must-have priority URLs → hard 250-page DataForSEO acquisition ceiling → explicit reporting of discovered footprint versus assessed sample.

Blocked:
- No implementation should begin until the current application baseline is reverified in the fresh chat and the exact current source-file contents for the first governed source-file unit are inspected.

Important constraints:
- GitHub context is authoritative durable memory.
- `DIAGNOSTIC_EVIDENCE_PROTOCOL.md` remains mandatory: no guessing; do not present inferred architecture/provider/storage/failure behavior as fact; verify the executing boundary and direct evidence first.
- Every technical/diagnostic response must include a concrete executable action when further work is required.
- Prefer action over explanation. Keep rationale concise unless deeper explanation is requested or needed for a diagnostic reset.
- Recommendations must be forward-looking: account for likely downstream failure boundaries, dependencies, cost, and product constraints before implementation.
- Do not increase timeout or crawl volume merely to accommodate giant sites without evidence that doing so improves the product outcome.
- Preserve whole-site footprint evidence separately from bounded assessed-page evidence; never imply that a 250-page assessment is an exhaustive full-site crawl.
- Manual application edits remain user-applied in VS Code unless the user explicitly changes that method.
- Preserve scoring v4.1.1 and Viewer v2.2.0 / 16 pages unless separately approved.
- Do not rerun production audits, recollect provider evidence, rescore, invoke paid Writer/Judge calls, deploy, push, or mutate persisted production artifacts without explicit approval.
- Same-failure repair attempts remain capped at three before a deeper diagnostic reset.

Exact next action:
Start a fresh chat. Read `PROJECT.md`, `GITHUB_PROJECT_MEMORY_PROTOCOL.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`, `CURRENT_STATE.md`, active `CONSTRAINTS.md`, active `DECISIONS.md`, and `EFFICIENCY_METRICS.md` first. Treat GitHub as authoritative. Reverify the current `vantage-platform` `main` HEAD before implementation. Then design the exact Representative Crawl Enforcement contract against the verified current code before editing. The first likely governed source-file unit is `services/worker/src/evidence/sitemap-footprint.js`, but do not assume that boundary until the fresh-chat code verification confirms it.

Last verified:
2026-08-25 America/Toronto
