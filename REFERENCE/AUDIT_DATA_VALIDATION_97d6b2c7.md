# PRYSM Audit Data Validation Ledger

Audit ID: `97d6b2c7-03b9-4530-8ea7-16557502c638`
Target: `https://rebootbusinesscoaching.com/`
Date opened: 2026-08-23
Status: Active investigation

## Purpose

Durable evidence and impact ledger for the read-only audit-data investigation. This file records verified defects, unresolved questions, proposed diagnostics, and the expected downstream reaction of any later code change. It is not a transcript and does not authorize application changes by itself.

## Investigation rules

- Existing audit artifacts are evidence and remain immutable.
- Do not create another paid audit merely to diagnose this audit.
- Prefer persisted-artifact inspection and no-cost provider reads before paid live calls.
- A paid/provider diagnostic call must be isolated to the smallest request needed to prove or disprove one hypothesis.
- Before an application-code change, record: proven root cause, exact source file(s), upstream inputs, downstream consumers, artifact/contracts affected, regression risks, and required tests.
- Application source changes still follow the governed manual VS Code file-handoff method unless the user explicitly changes it.
- Do not alter scoring, lifecycle, storage, Writer/Judge, report design, or unrelated provider behavior as collateral work.

## Verified artifact baseline

The user exported the production S3 bundle for this audit. The bundle contains 35 files spanning raw, normalized, canonical, findings/scores, Narrative v2, final report, lifecycle, and manifests.

Persisted source status evidence:
- DataForSEO On-Page: `PARTIAL`.
- PageSpeed: `AVAILABLE` for lab evidence; CrUX field calls failed with 403.
- Backlinks: `AVAILABLE`.
- DataForSEO SERP/competitors: `FAILED` after timeout and retries; no raw SERP artifact persisted.
- GA4: not connected/not requested for this audit.
- GSC: not connected/not requested for this audit.

## DQV-001 — SERP / competitor source times out before dependable acquisition

Classification: VERIFIED FAILURE; ROOT-CAUSE BUDGET MISMATCH HIGH CONFIDENCE; exact in-adapter timeout point UNRESOLVED.

Persisted evidence:
- `normalized/dataforseo-serp.json`:
  - provider: `mock`
  - adapterVersion: `1.1.0`
  - status: `FAILED`
  - retryCount: `2`
  - expectedRecords: `0`
  - returnedRecords: `0`
  - limitation: `Source execution failed: Source execution timed out`
  - errorCategory: `timeout`
- `source-checkpoint-dataforseo-serp.json` has `rawArtifact: null`.
- Audit request explicitly contains three supplied competitor URLs and four services.

Code-path evidence at application commit `33ec9b63083f62141141ea6363828c9e8152f188`:
- Production runtime wraps the whole `dataforseo-serp` adapter in a 60,000 ms source timeout.
- The SERP adapter first direct-crawls up to three supplied competitors serially, up to eight pages each.
- The direct crawler allows up to 20,000 ms for a page fetch/read, plus robots/sitemap discovery.
- Only after direct supplied-competitor crawling does the adapter run DataForSEO live SERP queries serially for service-derived keywords.
- Each DataForSEO SERP request has its own 45,000 ms timeout.

Implication:
The 60-second orchestration envelope is structurally capable of expiring before the intended composite work completes. This can erase both supplied-competitor evidence and SERP evidence even when the provider itself is healthy.

Current downstream effect:
- Competitor canonical evidence is absent/failed.
- Competitor opportunity generation cannot be dependable.
- Report competitor sections are deprived of intended evidence.
- Report status mapping is inconsistent: canonical source failure is later represented as `NOT_APPLICABLE` in the Report v2 manifest.

Next diagnostic:
1. Measure the three supplied competitor direct-crawl boundaries independently, with no audit mutation.
2. Run one isolated DataForSEO SERP live request for one service keyword and record response time/status/cost.
3. Do not rerun the full audit.

Potential change boundary if confirmed:
- `services/worker/src/adapters/dataforseo-serp/serp-adapter.js`
- and/or the source-specific timeout policy in `services/worker/src/application/production-runtime.js`.

Required impact review before change:
- retry/idempotency behavior;
- audit wall-clock duration;
- duplicate provider cost risk on retries;
- supplied competitor crawl behavior;
- SERP request count/cost;
- source checkpoint and raw artifact semantics;
- competitor opportunity derivation;
- report source-status propagation.

## DQV-002 — On-Page content parsing succeeds, then usable body content is lost in normalization

Classification: PROVEN DATA-LOSS DEFECT.

Persisted raw evidence:
- On-Page `contentParsing` acquisition requested 5 key pages, completed 5, failed 0.
- Each of the five responses contains one `content_parsing_element` with `page_content`.
- Extractable text is materially present in the raw provider payload:
  - `/`: ~473 words
  - `/about`: ~765 words
  - `/services`: ~685 words
  - `/home`: ~473 words
  - `/insights`: ~310 words

Persisted normalized evidence:
- All five normalized `contentParsing` records contain `text: ""`, `hasMainContent: false`, and null content metrics.
- All normalized site pages retain `_contentAvailable: false` and empty `bodyText`.
- Site-level `_contentEvidenceAvailable` is false.

Code-path evidence:
- `normalizeContentParsing()` chooses `res.result` before `res.items[0]`.
- The provider response wrapper stored at `res.result` contains an `items` array; the actual `page_content` lives on the first element of that array.
- The normalizer therefore evaluates the wrapper object instead of the `content_parsing_element`, producing empty normalized content despite a successful provider response.

Current downstream effect:
- `content.body` capability is marked `AVAILABLE` solely because acquisition says 5/5 completed, even though normalized required content fields are empty. This is an internal consistency defect.
- `offer.clarity` is `UNAVAILABLE` because `_contentEvidenceAvailable` is false.
- `trust.proof` is `UNAVAILABLE` for the same reason.
- `conversion.cta`, `conversion.form`, and browser-validated `conversion.path` remain separate capabilities and must not be fabricated from parsed body text.
- Content/trust/offer report sections understate the evidence actually collected.
- Readiness coverage and any dependent scoring/module eligibility may change once the normalization defect is corrected and regenerated from valid evidence.

Potential change boundary if approved:
- Primary: `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`.
- Defensive hardening may also be needed in `services/worker/src/evidence/capability-evidence.js` so endpoint completion alone cannot mark `content.body` required fields present when usable normalized content is empty.

Required impact review before change:
- canonical site evidence shape;
- decision evidence;
- capability evidence;
- offer-clarity and trust module eligibility;
- content/funnel scoring;
- evidence coverage percentage;
- Narrative v2 writer input;
- report claims and strengths/limitations;
- deterministic tests for real DataForSEO response nesting.

## DQV-003 — Microdata request omits required page URL

Classification: PROVEN PROVIDER-CONTRACT DEFECT.

Persisted evidence:
- On-Page task was created with `validate_micromarkup: true`.
- `microdataMeta.requestPayload` contains only `{ id: <taskId> }`.
- DataForSEO returned code `40501` with `Invalid Field: 'url'.`
- Acquisition records microdata requested 1, completed 0, failed 1.

Code-path evidence:
- `getMicrodata(taskId)` constructs `[{ id: taskId }]`.
- Current official DataForSEO On-Page Microdata documentation requires both `id` and the resource `url`.

Current downstream effect:
- `schema.structured_data` is `UNAVAILABLE`.
- Schema/entity and AI-search modules are not eligible.
- Report cannot make a dependable structured-data assessment from this acquisition path.

Potential change boundary if approved:
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-client.js` to request microdata for selected page URLs using both task ID and URL.
- Calling code in `dataforseo-onpage-adapter.js` may need to pass the deterministic key-page set rather than one task-only request.

Required impact review before change:
- number of microdata calls;
- provider cost (DataForSEO documents task-result microdata retrieval as free for the retained task window);
- acquisition coverage semantics;
- schema type normalization;
- capability eligibility;
- schema/entity scoring and report sections;
- API-rate and timeout behavior.

## DQV-004 — Seven-page crawl is not currently proven defective

Classification: VERIFIED PROVIDER RESULT; completeness still subject to site-structure validation.

Evidence:
- DataForSEO task max crawl pages: 500.
- `pages_crawled: 7`.
- `crawl_stop_reason: empty_queue`.
- `extended_crawl_status: no_errors`.
- `pages_in_queue: 0`.

Interpretation:
The provider did not stop because it hit the 500-page limit or an explicit crawl error. The seven-page result may accurately reflect the site's discoverable internal crawl graph at collection time. This should be checked against sitemap/current site structure, but it is not presently a proven adapter failure.

## DQV-005 — Report source-status propagation is inconsistent

Classification: PROVEN REPORT-DATA MAPPING DEFECT; repair deferred until acquisition defects are understood.

Evidence:
- Canonical competitor source: `FAILED`.
- Report v2 manifest competitors: `NOT_APPLICABLE`.
- Other report content has also represented competitor evidence as unavailable/not connected.

Implication:
`FAILED`, `NOT_CONNECTED`, and `NOT_APPLICABLE` are materially different states and must not be collapsed or substituted.

Potential downstream scope:
Report manifest/status mapping only after the authoritative source semantics are fixed and tested.

## Current exact next action

Run isolated, non-mutating diagnostics for DQV-001: direct-crawl timing for the three supplied competitor sites, then one minimal DataForSEO SERP live request. Record timing, response status, and cost. Do not rerun this audit and do not change application code yet.
