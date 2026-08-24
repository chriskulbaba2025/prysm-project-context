# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Critically validate and improve the accuracy/completeness of the audit-data acquisition and interpretation path using the selected Rebootbusinesscoaching audit before resuming page-by-page report review.

## Authoritative repositories

- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Last verified remote application `main` before the current local data-quality work: `33ec9b63083f62141141ea6363828c9e8152f188` — `feat(report-v2): add read-only UAT rerender route`.
- Current verified local application `main`: `10bf22cb7f9ad74183fa626fcc696fd86e6a34e1` — `fix(onpage): send page URL with microdata request`.
- DQV-002 and DQV-003 local commits have not yet been verified as pushed or deployed.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Viewer contract remains Viewer v2.2.0 / 16 governed pages.

## Selected validation audit

- Website: `https://rebootbusinesscoaching.com/`
- Audit ID: `97d6b2c7-03b9-4530-8ea7-16557502c638`
- Production S3 bundle was exported read-only and contains 35 files covering raw, normalized, canonical, scores/findings, Narrative v2, report HTML, lifecycle, and manifests.
- Existing selected-audit artifacts remain immutable evidence.
- Durable evidence ledger: `REFERENCE/AUDIT_DATA_VALIDATION_97d6b2c7.md`.

## Verified defects / findings

### DQV-001 — competitor/SERP timeout and enterprise evidence-depth boundary

Status: PROVEN HISTORICAL FAILURE + PROVEN TIMEOUT/CANCELLATION DESIGN DEFECT; FAILURE BOUNDARY FULLY MAPPED; REPAIR-DESIGN GATE ACTIVE.

- Historical competitor source timed out after retries and persisted synthetic `FAILED` with no raw SERP artifact.
- Exact three supplied competitor crawls currently succeed: 3/3, 8 pages each, ~8.6 seconds total.
- One live `Group Coaching` DataForSEO SERP request succeeded in 5.25 seconds with 18 results.
- Full isolated current competitor adapter using the exact three competitors + four audit services completed in 43.51 seconds and returned `PARTIAL`: 6/7 completed, 58 combined SERP results, all three supplied competitors preserved.
- One keyword, `4-Week Reboot Series`, failed cleanly with DataForSEO task status 40101 `Internal SE Server Error`.
- Production registers `serp-adapter.js` as the executing `dataforseo-serp` adapter.
- Production runtime currently gives the whole source a 60,000 ms outer timeout and up to three attempts.
- `executeWithRetry()` creates an `AbortController`, passes its signal into the adapter, and aborts it when the outer timeout wins.
- The adapter checks the signal between operations but does not pass it into `querySerp()`; `querySerp()` therefore calls the DataForSEO HTTP fetch without the orchestration signal.
- Each SERP request is separately wrapped in a 45,000 ms shared `withTimeout()` implemented as `Promise.race`; it does not abort the underlying fetch.
- Therefore a timed-out attempt can leave a paid HTTP request running while orchestration begins a later retry, creating duplicate-call overlap risk.
- Valid partial evidence exists in memory before adapter return: supplied competitor evidence in `suppliedItems`, completed SERP evidence in `allItems`, completion count in `totalCompleted`, and per-keyword errors in `errors`.
- Raw/normalized persistence occurs only after the adapter returns, so the 60-second outer timeout can erase already-valid in-memory evidence and synthesize `FAILED` with `rawBytes: null`.
- No application code has been edited for DQV-001.
- Product direction is now explicit: PRYSM must optimize evidence acquisition for enterprise-grade conversion decision quality, not arbitrary short timeouts or minimal provider spend. Large sites must be handled through broad footprint discovery plus representative structure-aware sampling rather than exhaustive crawling or arbitrary fixed-page truncation.
- Programmatic SEO must be detectable as a site pattern, with representative cluster sampling deep enough to assess thin/duplicated content, conversion quality, trust/E-E-A-T, geographic/entity consistency, local proof, schema/entity signals, and material downstream recommendations.

### DQV-002 — On-Page content parsing normalization

Status: VERIFIED AND COMMITTED LOCALLY; NOT YET VERIFIED PUSHED/DEPLOYED.

- Proven root cause: the old normalizer stopped at `res.result` instead of descending into `res.result.items[0].page_content`, then read legacy `main_content` / `secondary_content` fields absent from the production shape.
- Repair: adapter version `1.2.1`; unwrap `result.items[0]`; read `page_content.main_topic` and `secondary_topic`; collect primary/secondary topic text; retain bounded normalized text; exact-text deduplication; exclude provider-classified header/footer; preserve older fixture shape.
- Production-shaped no-network diagnostic PASS: normalized text non-empty; page `_contentAvailable: true`; site `_contentEvidenceAvailable: true`; testimonials/credentials/pricing detected; duplicate fragment count 1; header/footer excluded.
- Final targeted adapter suite PASS: 68/68.
- Final diff checks PASS.
- Local commit: `82a9f84f8c96bcd44a3b307abe024442d1903336` — `fix(onpage): retain DataForSEO parsed page content`.

### DQV-003 — microdata provider contract

Status: VERIFIED AND COMMITTED LOCALLY; NOT YET VERIFIED PUSHED/DEPLOYED.

Persisted production defect:
- On-Page task uses `validate_micromarkup: true`.
- Existing microdata request sent only task ID.
- DataForSEO returned 40501 `Invalid Field: 'url'.`
- `schema.structured_data` was therefore unavailable.

Proven code root cause:
- `getMicrodata(taskId)` constructed `[{ id: taskId }]`.
- DataForSEO requires task ID plus page URL.
- PRYSM already creates deterministic `keyPageUrls` for URL-scoped deep acquisitions, so no new page-selection logic was needed.

Verified repair:
- `dataforseo-onpage-client.js`: `getMicrodata(taskId, url, options)` requires a URL and posts `[{ id: taskId, url }]`.
- `dataforseo-onpage-adapter.js`: adapter version `1.2.2`; microdata acquisition occurs after deterministic `keyPageUrls` are built and uses `keyPageUrls[0]` plus existing sub-endpoint poll options.
- `dataforseo-onpage-adapter.test.js`: added `DQV-003: live microdata client posts required task ID and page URL`, asserting exact live POST payload and recorded request metadata.
- Syntax checks PASS for client, adapter, and test file.
- Targeted adapter regression suite PASS: 69/69.
- Final `git diff --check` PASS.
- Local commit: `10bf22cb7f9ad74183fa626fcc696fd86e6a34e1` — `fix(onpage): send page URL with microdata request`.
- No paid provider call or production audit rerun was used to verify the repair.

### DQV-004 — seven-page crawl

Not currently proven defective.

- Provider max crawl pages 500.
- `pages_crawled: 7`.
- `crawl_stop_reason: empty_queue`.
- `pages_in_queue: 0`.
- `extended_crawl_status: no_errors`.

### DQV-005 — report status propagation

Proven report-data mapping defect.

- Canonical competitor source: `FAILED`.
- Report-layer artifacts have represented it as `NOT_APPLICABLE` / `NOT_CONNECTED`.
- Repair remains deferred until authoritative acquisition semantics are fixed and tested.

## Active operating rules

- GitHub context is authoritative durable memory; do not reconstruct project state from chat history when starting a new chat.
- At the beginning of a new substantive chat, read `PROJECT.md`, `GITHUB_PROJECT_MEMORY_PROTOCOL.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `CURRENT_STATE.md`, active `CONSTRAINTS.md`, and active `DECISIONS.md` before doing work.
- The Mandatory Pre-Edit Gate in `REPAIR_BOUNDARY_PROTOCOL.md` must pass before asking the user to open/paste an application file or before proposing an application edit.
- Complete the whole repair design, expected application file set, required tests, material downstream reactions, cost/performance implications, and implementation sequence before beginning the one-source-file-at-a-time manual workflow.
- Application changes use the governed manual VS Code workflow only after the pre-edit gate passes.
- Default code flow after the gate passes: verify current source file → inspect complete current file → apply every already-approved change belonging to that source-file unit in one coherent replacement → user applies it → syntax check → targeted/relevant tests → correct failures → inspect diff → only after verification commit/update.
- Do not make the user repeatedly edit the same file when the coherent change can be grouped safely.
- Project-wide three-attempt diagnostic reset is active: after three unsuccessful attempts on the same failure, stop fixes and perform a deeper diagnostic reset before any fourth attempt.
- Open exact application files from the active PowerShell working path with `code -r <exact-path>` before manual editing when duplicate workspace/file-copy ambiguity is possible.
- When a command/code block/reference from earlier is needed again, reproduce it in the current reply; do not direct the user to scroll back.
- Code must not be delivered through generated download links; use conversation code/chunks.
- No application repository remote write/push, merge, deployment, production audit rerun, provider/model rerun, or production artifact mutation without the appropriate explicit approval.
- Existing selected-audit artifacts remain immutable.
- Do not broaden DQV repairs into unrelated scoring, lifecycle, storage, Writer/Judge, authentication, report-design, n8n, or architecture work.

## Exact next action

DQV-001: complete the Mandatory Pre-Edit Gate before requesting any application source file. Define the smallest coherent enterprise-grade production repair and expected file/test set that jointly covers reliable source completion, true HTTP cancellation, non-overlapping retries, a generous safety timeout rather than an evidence-depth control, preservation of already-acquired evidence, broad site-footprint discovery, representative structure-aware sampling for large sites, programmatic-SEO/template-cluster detection, and deep conversion/trust/E-E-A-T/geographic-entity consistency assessment. Map material downstream reactions and explicitly identify what remains out of scope. Only after this design is complete and coherent may the governed one-source-file-at-a-time implementation workflow begin. Do not make paid provider calls, push, deploy, rerun the production audit, or mutate persisted artifacts during this design step.

After DQV-001 is verified through the governed workflow, return to DQV-005 unless new evidence changes priority.

Last verified:
2026-08-23
