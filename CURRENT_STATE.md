# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Critically validate and improve the accuracy/completeness of the audit-data acquisition and interpretation path using the selected Rebootbusinesscoaching audit before resuming page-by-page report review.

## Authoritative repositories

- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Last verified committed application `main`: `33ec9b63083f62141141ea6363828c9e8152f188` — `feat(report-v2): add read-only UAT rerender route`.
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
- DQV-001 code repair remains deferred while the current DQV-002 repair is completed and verified.

### DQV-002 — On-Page content parsing normalization

Proven data-loss defect. Raw DataForSEO acquisition quality is good; PRYSM normalization lost the content.

Persisted raw evidence:
- Content parsing requested 5 key pages, completed 5, failed 0.
- Actual provider shape is `res.result.items[0].page_content`.
- Usable text lives under `page_content.main_topic[*].primary_content/secondary_content` and `page_content.secondary_topic[*].primary_content/secondary_content`.
- Approximate extracted content: `/` 473 words, `/about` 765, `/services` 685, `/home` 473, `/insights` 310.
- Raw content includes real offers, pricing, testimonials, credentials, coaching services, and calls to action.

Persisted normalized defect:
- All five normalized contentParsing records had empty `text`, `hasMainContent: false`, null metrics.
- Pages retained empty `bodyText` and `_contentAvailable: false`.
- Site `_contentEvidenceAvailable` was false.

Local repair status — NOT COMMITTED:
- User authorized the smallest coherent DQV-002 adapter repair.
- Current working-copy file: `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`.
- Adapter version is `1.2.1` in the exact executing working-copy file.
- Diagnostic reset proved the current root cause: the old normalizer stopped at `res.result` instead of descending into `res.result.items[0].page_content`, then read legacy `main_content` / `secondary_content` fields that do not exist in the production shape.
- The normalizer was replaced as one coherent bounded repair: unwrap `result.items[0]`, read `page_content.main_topic` and `secondary_topic`, collect primary/secondary topic text, deduplicate exact body fragments, exclude provider-classified header/footer content, preserve the older fixture shape, and retain bounded normalized text.
- No scoring, lifecycle, storage, report, competitor, microdata, authentication, or orchestration behavior is intentionally changed by this repair.
- `node --check src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js` passes after the coherent normalizer repair.
- Production-shaped, fixture-only, no-network DQV-002 diagnostic now PASSES against the exact executing file.
- Verified diagnostic output: adapterVersion `1.2.1`; normalized content text length 261; `hasMainContent: true`; page `_contentAvailable: true`; site `_contentEvidenceAvailable: true`; testimonials true; credentials true; pricing true; duplicate fragment count 1; header excluded true; footer excluded true.
- The targeted adapter suite has NOT yet been rerun after this final repair. Therefore DQV-002 is not yet verified complete and must not be committed/deployed.

### DQV-003 — microdata provider contract

Proven provider-contract defect.

- On-Page task uses `validate_micromarkup: true`.
- Current microdata request sends task ID without required page URL.
- Provider returned 40501 `Invalid Field: 'url'.`
- `schema.structured_data` is therefore unavailable.
- Repair is deferred until DQV-002 is closed.

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
- Default code flow: verify current source file → inspect complete file → make one coherent bounded repair → provide complete replacement directly in chat or clear surgical reference-point instructions when simple → user applies it → syntax check → targeted/relevant regression tests → correct failures → only after verification update/commit the application.
- Do not make the user repeatedly edit the same file when the coherent change can be grouped safely.
- Project-wide three-attempt diagnostic reset is active: after three unsuccessful attempts on the same failure, stop fixes and perform a deeper diagnostic reset before any fourth attempt.
- Code must not be delivered through generated download links; use conversation code/chunks.
- No application repository write, commit, merge, deployment, production audit rerun, provider/model rerun, or production artifact mutation without the appropriate explicit approval.
- Existing selected-audit artifacts remain immutable.
- Do not broaden DQV repairs into unrelated scoring, lifecycle, storage, Writer/Judge, authentication, report-design, n8n, or architecture work.

## Exact next action

From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, run `node --test src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.test.js` against the current exact executing working copy and require all tests to PASS (previous intentional count was 68). Do not commit, deploy, rerun the production audit, or mutate persisted artifacts until this targeted suite passes.

After DQV-002 is verified and committed through the governed application workflow, return to DQV-003 isolated microdata repair/diagnostic before DQV-001 implementation unless the user explicitly changes priority.

Last verified:
2026-08-23
