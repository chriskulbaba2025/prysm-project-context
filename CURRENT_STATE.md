# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Critically validate and improve the accuracy/completeness of the audit-data acquisition and interpretation path using the selected Rebootbusinesscoaching audit before resuming page-by-page report review.

## Authoritative repositories

- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Last verified remote application `main` before the current local data-quality work: `33ec9b63083f62141141ea6363828c9e8152f188` — `feat(report-v2): add read-only UAT rerender route`.
- Current verified local application `main`: `82a9f84f8c96bcd44a3b307abe024442d1903336` — `fix(onpage): retain DataForSEO parsed page content`.
- The local DQV-002 commit has not yet been verified as pushed or deployed.
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
- DQV-001 implementation remains deferred until DQV-003 is closed unless the user changes priority.

### DQV-002 — On-Page content parsing normalization

Status: VERIFIED AND COMMITTED LOCALLY; NOT YET VERIFIED PUSHED/DEPLOYED.

- Proven root cause: the old normalizer stopped at `res.result` instead of descending into `res.result.items[0].page_content`, then read legacy `main_content` / `secondary_content` fields that do not exist in the production shape.
- Repair: adapter version `1.2.1`; unwrap `result.items[0]`; read `page_content.main_topic` and `secondary_topic`; collect primary/secondary topic text; retain bounded normalized text; exact-text deduplication; exclude provider-classified header/footer; preserve older fixture shape.
- Production-shaped no-network diagnostic PASS: normalized text non-empty; page `_contentAvailable: true`; site `_contentEvidenceAvailable: true`; testimonials/credentials/pricing detected; duplicate fragment count 1; header/footer excluded.
- Adapter syntax PASS.
- Test-file syntax PASS.
- Final targeted adapter suite PASS: 68/68.
- Final `git diff --check` and cached diff check PASS.
- Local commit: `82a9f84f8c96bcd44a3b307abe024442d1903336` — `fix(onpage): retain DataForSEO parsed page content`.
- Files committed:
  - `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`
  - `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.test.js`
- Unrelated untracked files were intentionally excluded from the commit.

### DQV-003 — microdata provider contract

Proven provider-contract defect; now the active repair target.

- On-Page task uses `validate_micromarkup: true`.
- Current microdata request sends task ID without required page URL.
- Provider returned 40501 `Invalid Field: 'url'.`
- `schema.structured_data` is therefore unavailable.
- Proven client-side boundary: current `getMicrodata(taskId)` constructs `[{ id: taskId }]`; provider requires task ID plus resource URL.
- Before editing, inspect the exact current local `getMicrodata()` implementation and then the exact caller boundary that supplies its arguments.

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

DQV-003: from `C:\Users\kulba\Desktop\vantage-platform\services\worker`, inspect the exact current local `getMicrodata()` implementation in `src/adapters/dataforseo-onpage/dataforseo-onpage-client.js` without editing it. Verify the request payload and method boundary first. After that, inspect the exact caller in `dataforseo-onpage-adapter.js` to determine the smallest coherent two-file contract repair if the caller must supply a URL. Do not make a paid provider call, deploy, rerun the production audit, or mutate persisted artifacts during this inspection.

After DQV-003 is verified through the governed workflow, return to DQV-001 before DQV-005 unless the user explicitly changes priority.

Last verified:
2026-08-23
