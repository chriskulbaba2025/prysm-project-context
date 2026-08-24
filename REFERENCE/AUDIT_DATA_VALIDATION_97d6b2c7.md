# PRYSM Audit Data Validation Ledger

Audit ID: `97d6b2c7-03b9-4530-8ea7-16557502c638`
Target: `https://rebootbusinesscoaching.com/`
Date opened: 2026-08-23
Status: Active investigation

## Purpose

Durable evidence and impact ledger for the selected audit-data investigation. It records verified defects, diagnostics, code-boundary findings, downstream impact, and the exact verification state. It is not a transcript and does not itself authorize application deployment or production mutation.

## Investigation rules

- Existing persisted artifacts for this audit remain immutable evidence.
- Do not create or rerun a full paid production audit merely to diagnose this audit.
- Prefer persisted-artifact inspection and no-cost diagnostics before paid provider requests.
- Any paid/provider diagnostic must be isolated to the smallest request needed to prove or disprove one hypothesis.
- Before an application-code change, record the proven root cause, source file(s), upstream inputs, downstream consumers, artifact/contracts affected, regression risks, and required tests.
- Application source changes use the governed manual VS Code workflow unless the user explicitly changes it.
- Simple surgical edits are acceptable when reference points and replacement boundaries are unambiguous; otherwise provide the coherent complete file directly in chat, split into ordered chunks if needed.
- After editing: syntax check → targeted/relevant regression tests → correct failures → only then update/commit the application.
- Do not broaden a repair into unrelated scoring, lifecycle, storage, Writer/Judge, authentication, report-design, n8n, or architecture changes.
- After three unsuccessful attempts on the same observable failure, stop repair attempts and perform the project-wide diagnostic reset before any fourth attempt.

## Verified artifact baseline

The production S3 bundle for this audit was exported read-only and inspected. It contains 35 files spanning raw, normalized, canonical, findings/scores, Narrative v2, report HTML, lifecycle, and manifests.

Persisted source status baseline:
- DataForSEO On-Page: `PARTIAL`.
- PageSpeed: lab evidence `AVAILABLE`; CrUX field calls failed with 403.
- Backlinks: `AVAILABLE`.
- DataForSEO SERP/competitors: `FAILED` after timeout/retries; no raw SERP artifact persisted.
- GA4/GSC: not connected/not requested for this audit.

## DQV-001 — SERP / competitor source loses usable evidence at the outer timeout boundary

Classification: PROVEN HISTORICAL FAILURE + PROVEN TIMEOUT/CANCELLATION DESIGN DEFECT. ACTIVE REPAIR TARGET.

Persisted evidence:
- `normalized/dataforseo-serp.json` records `FAILED`, retryCount `2`, returnedRecords `0`, limitation `Source execution failed: Source execution timed out`, errorCategory `timeout`.
- `source-checkpoint-dataforseo-serp.json` has `rawArtifact: null`.
- Audit request contains three supplied competitor URLs and four services.

Code-path evidence at application commit `33ec9b63083f62141141ea6363828c9e8152f188`:
- Production runtime gives the whole `dataforseo-serp` source a 60,000 ms timeout and up to three attempts.
- Adapter direct-crawls supplied competitors, then performs service-keyword DataForSEO SERP requests serially.
- Individual SERP requests can wait up to 45,000 ms.
- Outer retry boundary is a `Promise.race`; when the timeout wins it rejects the attempt and can ultimately synthesize `FAILED` with `rawBytes: null`.
- Raw/normalized persistence occurs only after the adapter returns, so valid partial evidence accumulated inside a timed-out attempt can be lost.
- The orchestration AbortSignal is not propagated into the DataForSEO SERP HTTP request and shared `withTimeout()` does not abort the underlying fetch, creating a proven overlap/duplicate-cost risk when retries begin.

### Direct competitor diagnostic — 2026-08-23

- `https://ginakeeping.ca/` — `AVAILABLE`, 8 pages, ~1.9s.
- `https://traceyjazmin.com/` — `AVAILABLE`, 8 pages, ~3.0s.
- `https://clarityofgoalsandvision.com/` — `AVAILABLE`, 8 pages, ~3.7s.
- Total ~8.6s.

Conclusion: the supplied competitors are currently crawlable; direct crawling is not a systemic 60-second bottleneck.

### One-keyword DataForSEO diagnostic — 2026-08-23

- Keyword: `Group Coaching`.
- Elapsed: 5.25s.
- Success: true.
- Task ID: `08232042-1281-0139-0000-2eda65f9fe51`.
- Result count: 18.

Conclusion: a generally broken DataForSEO credential/client/provider path is ruled out.

### Full composite adapter diagnostic — 2026-08-23

Exact three competitors + four audit services, production environment, isolated 60-second outer diagnostic race, no persistence:
- elapsed: 43.51s
- status: `PARTIAL`
- expected 7 / returned 6
- coverage requested 7 / completed 6 / failed 1
- 3/3 supplied competitors preserved, 8 pages each
- 58 combined SERP results
- one keyword failed cleanly: `4-Week Reboot Series` with status 40101 `Internal SE Server Error`

Conclusion:
- Graceful partial semantics work if the adapter is allowed to return.
- 43.51s uses ~72.5% of the current 60s source budget, leaving ~16.5s margin.
- If the outer timeout wins, valid supplied-competitor and completed-keyword evidence can be erased.
- Historical exact in-adapter operation at timeout is unrecoverable because no partial/raw payload survived.

Current downstream effect:
- Selected audit lost usable competitor evidence.
- Competitor opportunity/report sections were deprived of evidence that should have survived a later delay/failure.
- Retry overlap can create duplicate paid provider calls and nondeterministic results.

Current inspection boundary:
- `services/worker/src/adapters/dataforseo-serp/dataforseo-serp-client.js`
- `services/worker/src/adapters/dataforseo-serp/serp-adapter.js`
- `services/worker/src/application/production-runtime.js`
- review generic retry-policy/orchestrator only if source-bounded repair cannot safely close the defect.

Required repair properties:
- preserve partial evidence already acquired before a later delay/failure;
- propagate true HTTP cancellation to the DataForSEO request;
- prevent overlapping paid retries;
- keep bounded wall-clock and cost;
- preserve correct source-status semantics;
- do not broaden into unrelated report/scoring/storage changes.

## DQV-002 — On-Page content parsing succeeds, then usable body content is lost in normalization

Classification: PROVEN DATA-LOSS DEFECT. RAW DATA QUALITY PASS. REPAIR VERIFIED AND COMMITTED LOCALLY; NOT YET VERIFIED PUSHED/DEPLOYED.

### Persisted raw evidence

On-Page `contentParsing`:
- requested 5
- completed 5
- failed 0
- retryCount 0
- provider finalCode 20000 / `Ok.`
- each result includes real `content_parsing_element.page_content`

Production response shape:
- useful item: `res.result.items[0]`
- useful content: `res.result.items[0].page_content`
- `page_content.main_topic[*]` and `page_content.secondary_topic[*]`
- topic text lives in `primary_content` and `secondary_content`
- provider-classified `header` and `footer` are separate fields and need not be folded into body evidence

Validated usable content from the stored production raw payload:
- `/`: ~473 words / 2996 chars
- `/about`: ~765 words / 4526 chars
- `/services`: ~685 words / 4435 chars
- `/home`: ~473 words / 2996 chars
- `/insights`: ~310 words / 1913 chars

Examples include real business content such as individual/group coaching, the 4-Week Reboot Series, pricing/investment language, testimonials, credentials/experience, and registration calls to action.

Conclusion: DataForSEO acquired good/useful body content; PRYSM lost it after acquisition.

### Proven root cause

Primary application file:
`services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`

The executing normalizer selected `res.result` as the item, stopping one level too shallow. The production content is under `res.result.items[0].page_content`. The old function then attempted to read legacy `item.main_content` / `item.secondary_content`, which are absent from the production shape. This deterministically produced empty normalized text.

Downstream hydration already existed in `summarizeSite()` and required no rewrite.

### Verified repair — 2026-08-23

Application files:
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.test.js`

Implemented:
- adapter version `1.2.1`;
- unwrap `result.items[0]`;
- read production `page_content.main_topic` and `secondary_topic`;
- collect `primary_content` and `secondary_content` text;
- retain bounded normalized text;
- exact-text deduplication;
- exclude provider-classified header/footer from body evidence;
- preserve older fixture shape.

Verification:
- production-shaped no-network diagnostic PASS;
- normalized content text non-empty;
- page `_contentAvailable: true`;
- site `_contentEvidenceAvailable: true`;
- testimonials, credentials, pricing detected;
- duplicate fragment count 1;
- header/footer excluded;
- syntax checks PASS;
- final targeted adapter suite PASS 68/68;
- final diff checks PASS.

Local commit:
`82a9f84f8c96bcd44a3b307abe024442d1903336` — `fix(onpage): retain DataForSEO parsed page content`.

Downstream items still to verify after the acquisition defects are resolved through the governed workflow:
- canonical site evidence;
- decision evidence;
- `content.body` capability consistency;
- offer/trust capability eligibility;
- content/funnel scoring inputs;
- evidence coverage;
- Narrative v2 writer input/report conclusions.

## DQV-003 — Microdata request omits required page URL

Classification: PROVEN PROVIDER-CONTRACT DEFECT. REPAIR VERIFIED AND COMMITTED LOCALLY; NOT YET VERIFIED PUSHED/DEPLOYED.

### Persisted production defect

- task created with `validate_micromarkup: true`;
- previous request payload contained only task ID;
- DataForSEO returned 40501 `Invalid Field: 'url'.`;
- acquisition requested 1, completed 0, failed 1;
- `schema.structured_data` was unavailable.

### Proven root cause

- previous `getMicrodata(taskId)` constructed `[{ id: taskId }]`;
- provider requires task ID plus resource URL;
- PRYSM already builds deterministic `keyPageUrls`, so no new URL-selection policy was needed.

### Verified repair — 2026-08-23

Application files:
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-client.js`
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.test.js`

Implemented:
- client `getMicrodata(taskId, url, options)` requires URL and posts `[{ id: taskId, url }]`;
- adapter version advanced to `1.2.2`;
- microdata acquisition moved after deterministic key-page selection;
- request uses `keyPageUrls[0]` and existing sub-endpoint poll options;
- no new selection logic and no unrelated behavior change;
- added regression test `DQV-003: live microdata client posts required task ID and page URL` proving exact endpoint payload and request metadata.

Verification:
- client syntax PASS;
- adapter syntax PASS;
- test-file syntax PASS;
- targeted adapter suite PASS: 69/69;
- `git diff --check` PASS after cleanup;
- no paid provider call or production audit rerun used.

Local commit:
`10bf22cb7f9ad74183fa626fcc696fd86e6a34e1` — `fix(onpage): send page URL with microdata request`.

## DQV-004 — Seven-page crawl is not currently proven defective

Classification: VERIFIED PROVIDER RESULT; completeness remains subject to site-structure validation.

Evidence:
- max crawl pages 500
- pages_crawled 7
- crawl_stop_reason `empty_queue`
- pages_in_queue 0
- extended_crawl_status `no_errors`

Interpretation: provider did not stop because of the page ceiling or an explicit crawl error. Do not classify this as an adapter failure without contrary sitemap/site evidence.

## DQV-005 — Report source-status propagation is inconsistent

Classification: PROVEN REPORT-DATA MAPPING DEFECT; repair deferred.

Evidence:
- canonical competitor source: `FAILED`
- report-layer artifacts: `NOT_APPLICABLE` / `NOT_CONNECTED`

Implication: `FAILED`, `NOT_CONNECTED`, and `NOT_APPLICABLE` are materially different states and must not be substituted.

## Current exact next action

DQV-001: from `C:\Users\kulba\Desktop\vantage-platform\services\worker`, inspect the exact executing DataForSEO SERP client/adapter call path plus the production-runtime source timeout/retry boundary. Verify where the orchestration AbortSignal is created, whether it reaches the SERP HTTP fetch, where the 60-second outer timeout is enforced, and where partial evidence exists before adapter return. Do not edit code, make paid provider calls, push, deploy, rerun the production audit, or mutate persisted artifacts during this inspection.

After DQV-001 is verified through the governed workflow, return to DQV-005 unless new evidence changes priority.
