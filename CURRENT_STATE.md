# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Critically validate and improve the accuracy/completeness of the audit-data acquisition and interpretation path using the selected Rebootbusinesscoaching audit before resuming page-by-page report review.

## Authoritative repositories

- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Last verified remote application `main` before the current local data-quality work: `33ec9b63083f62141141ea6363828c9e8152f188` — `feat(report-v2): add read-only UAT rerender route`.
- Current verified local application `main` baseline before DQV-003 working-copy edits: `82a9f84f8c96bcd44a3b307abe024442d1903336` — `fix(onpage): retain DataForSEO parsed page content`.
- DQV-002 local commit has not yet been verified as pushed or deployed.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Viewer contract remains Viewer v2.2.0 / 16 governed pages.

## Selected validation audit

- Website: `https://rebootbusinesscoaching.com/`
- Audit ID: `97d6b2c7-03b9-4530-8ea7-16557502c638`
- Production S3 bundle was exported read-only and contains 35 files covering raw, normalized, canonical, scores/findings, Narrative v2, report HTML, lifecycle, and manifests.
- Existing selected-audit artifacts remain immutable evidence.
- Durable evidence ledger: `REFERENCE/AUDIT_DATA_VALIDATION_97d6b2c7.md`.

## Verified defects / findings

### DQV-001 — competitor/SERP timeout boundary

Proven historical failure plus timeout/cancellation design defect.

- Historical competitor source timed out after retries and persisted synthetic `FAILED` with no raw SERP artifact.
- Exact three supplied competitor crawls currently succeed: 3/3, 8 pages each, ~8.6 seconds total.
- One live `Group Coaching` DataForSEO SERP request succeeded in 5.25 seconds with 18 results.
- Full isolated current competitor adapter using the exact three competitors + four audit services completed in 43.51 seconds and returned `PARTIAL`: 6/7 completed, 58 combined SERP results, all three supplied competitors preserved.
- One keyword, `4-Week Reboot Series`, failed cleanly with DataForSEO task status 40101 `Internal SE Server Error`.
- The outer source timeout can erase already-valid partial evidence because persistence occurs only after the adapter returns.
- The orchestration AbortSignal is not propagated into the DataForSEO SERP HTTP request and shared `withTimeout()` does not abort the underlying fetch, so timed-out attempts can overlap later retries and create duplicate paid-call risk.
- DQV-001 implementation remains deferred until DQV-003 is committed through the governed workflow unless the user changes priority.

### DQV-002 — On-Page content parsing normalization

Status: VERIFIED AND COMMITTED LOCALLY; NOT YET VERIFIED PUSHED/DEPLOYED.

- Proven root cause: the old normalizer stopped at `res.result` instead of descending into `res.result.items[0].page_content`, then read legacy `main_content` / `secondary_content` fields absent from the production shape.
- Repair: adapter version `1.2.1`; unwrap `result.items[0]`; read `page_content.main_topic` and `secondary_topic`; collect primary/secondary topic text; retain bounded normalized text; exact-text deduplication; exclude provider-classified header/footer; preserve older fixture shape.
- Production-shaped no-network diagnostic PASS: normalized text non-empty; page `_contentAvailable: true`; site `_contentEvidenceAvailable: true`; testimonials/credentials/pricing detected; duplicate fragment count 1; header/footer excluded.
- Final targeted adapter suite PASS: 68/68.
- Final diff checks PASS.
- Local commit: `82a9f84f8c96bcd44a3b307abe024442d1903336` — `fix(onpage): retain DataForSEO parsed page content`.

### DQV-003 — microdata provider contract

Status: PROVEN DEFECT; LOCAL REPAIR VERIFIED; NOT YET COMMITTED.

Persisted production defect:
- On-Page task uses `validate_micromarkup: true`.
- Existing microdata request sent only task ID.
- DataForSEO returned 40501 `Invalid Field: 'url'.`
- `schema.structured_data` was therefore unavailable.

Proven code root cause:
- `getMicrodata(taskId)` constructed `[{ id: taskId }]`.
- DataForSEO requires task ID plus page URL.
- PRYSM already creates deterministic `keyPageUrls` for URL-scoped deep acquisitions, so no new page-selection logic is needed.

Current local repair:
- `dataforseo-onpage-client.js`: `getMicrodata(taskId, url, options)` now requires a URL and posts `[{ id: taskId, url }]`.
- `dataforseo-onpage-adapter.js`: adapter version advanced to `1.2.2`; microdata acquisition moved to occur after deterministic `keyPageUrls` are built and uses `keyPageUrls[0]` plus existing sub-endpoint poll options.
- Existing deep-acquisition behavior remains bounded; no paid provider call or production audit rerun was used for verification.
- `dataforseo-onpage-adapter.test.js`: added `DQV-003: live microdata client posts required task ID and page URL`, asserting both live POST payload and recorded request metadata contain exact task ID + URL.
- Syntax checks PASS for client, adapter, and adapter test file.
- Targeted adapter regression suite PASS: 69 tests, 69 pass, 0 fail, duration ~30.0s.
- DQV-003 is verified locally but has not yet passed final diff review or been committed.

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
- At the beginning of a new substantive chat, read `PROJECT.md`, `CURRENT_STATE.md`, active `CONSTRAINTS.md`, and active `DECISIONS.md` before doing work.
- Application changes use the governed manual VS Code workflow.
- Default code flow: verify current source file → inspect complete relevant boundary → make one coherent bounded repair → user applies it → syntax check → targeted/relevant tests → correct failures → inspect diff → only after verification commit/update.
- Do not make the user repeatedly edit the same file when the coherent change can be grouped safely.
- Project-wide three-attempt diagnostic reset is active: after three unsuccessful attempts on the same failure, stop fixes and perform a deeper diagnostic reset before any fourth attempt.
- Open exact application files from the active PowerShell working path with `code -r <exact-path>` before manual editing when duplicate workspace/file-copy ambiguity is possible.
- When a command/code block/reference from earlier is needed again, reproduce it in the current reply; do not direct the user to scroll back.
- Code must not be delivered through generated download links; use conversation code/chunks.
- No application repository remote write/push, merge, deployment, production audit rerun, provider/model rerun, or production artifact mutation without the appropriate explicit approval.
- Existing selected-audit artifacts remain immutable.
- Do not broaden DQV repairs into unrelated scoring, lifecycle, storage, Writer/Judge, authentication, report-design, n8n, or architecture work.

## Exact next action

From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, inspect the exact DQV-003 working-copy diff before commit. Confirm only the intended three files changed for DQV-003: `dataforseo-onpage-client.js`, `dataforseo-onpage-adapter.js`, and `dataforseo-onpage-adapter.test.js`, and confirm the diff contains only the URL contract repair, deterministic key-page call-site move, adapter version `1.2.2`, and regression test. Do not push, deploy, rerun the production audit, or mutate persisted artifacts.

After DQV-003 is committed through the governed local workflow, return to DQV-001 before DQV-005 unless the user explicitly changes priority.

Last verified:
2026-08-23
