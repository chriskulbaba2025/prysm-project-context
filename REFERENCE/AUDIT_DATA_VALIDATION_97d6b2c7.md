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

Classification: VERIFIED HISTORICAL FAILURE; CURRENT DIRECT-CRAWL BOTTLENECK DISPROVED; CURRENT SINGLE SERP PROVIDER FAILURE DISPROVED; exact historical timeout point UNRESOLVED; composite timeout-budget risk remains PROVEN BY CODE STRUCTURE.

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

Isolated direct-crawl diagnostic on 2026-08-23 against exact application commit `33ec9b63083f62141141ea6363828c9e8152f188`:
- `https://ginakeeping.ca/` — `AVAILABLE`, 8 pages, 1.9 seconds, no limitations.
- `https://traceyjazmin.com/` — `AVAILABLE`, 8 pages, 3.0 seconds, no limitations.
- `https://clarityofgoalsandvision.com/` — `AVAILABLE`, 8 pages, 3.7 seconds, no limitations.
- Total current direct-crawl wall time: approximately 8.6 seconds.
- Diagnostic was local/read-only: no DataForSEO call, no audit mutation, no S3/database/lifecycle/report mutation.

Isolated DataForSEO SERP diagnostic on 2026-08-23 using the production Railway `vantage-platform` environment and the current production client path:
- Keyword: `Group Coaching`.
- Elapsed time: 5.25 seconds.
- Result: success.
- DataForSEO task ID: `08232042-1281-0139-0000-2eda65f9fe51`.
- Result count returned by the PRYSM client: 18.
- Top returned domains included `coactive.com`, `coachingfederation.org`, `groupcoachingessentials.ca`, `royalroads.ca`, and `groupcoachinghq.com`.
- No provider/client error was returned.
- This was one isolated provider call only; it did not create an audit or mutate S3, Postgres, lifecycle, or report artifacts.
- The Railway CLI printed an upgrade warning, but the diagnostic itself completed successfully.

Interpretation of diagnostics:
- The supplied competitor sites are currently reachable and their direct-crawl phase is not a systemic 60-second bottleneck.
- A single live DataForSEO SERP request is also currently healthy and returned 18 results in 5.25 seconds, so missing local credentials and a generally broken provider/client path are ruled out as explanations for this audit.
- Using today's measured timings as a representative estimate, direct competitor crawling (8.6s) plus four SERP calls at 5.25s each would be about 29.6 seconds, below the 60-second source envelope.
- This means today's diagnostics do not reproduce the historical production timeout.
- The architecture is nevertheless objectively unsafe under slower provider conditions: the outer source receives only 60 seconds while four serial internal SERP requests may each consume up to 45 seconds, in addition to direct crawl time. One slow request or moderate cumulative latency can cause the orchestration timeout to discard the entire composite source result.
- The historical artifact proves that exactly this outer timeout occurred after three attempts; it does not identify which internal operation was active at timeout because the orchestration failure replaces the partial adapter result with a synthetic failure and persists no raw SERP artifact.
- Therefore DQV-001 is now narrowed from “provider or crawl may be broken” to “historical composite-source timeout with all-or-nothing loss; exact internal historical timing cannot be recovered from persisted artifacts.”

Current downstream effect:
- Competitor canonical evidence is absent/failed.
- Direct-crawl evidence that could have been available is lost when the broader composite source times out.
- Competitor opportunity generation cannot be dependable.
- Report competitor sections are deprived of intended evidence.
- Report status mapping is inconsistent: canonical source failure is later represented as `NOT_APPLICABLE` in the Report v2 manifest.

Next diagnostic:
1. Run the existing `dataforseo-serp` adapter once in isolation with the exact three supplied competitors and four audit service keywords, using the production Railway environment but no orchestration persistence.
2. Record total elapsed time, direct competitor evidence count, SERP result count, source status, and any limitations/errors.
3. This diagnostic will make the same four live SERP requests the adapter normally makes, but will not create an audit or write persisted artifacts.
4. Do not change timeout policy or adapter sequencing until this composite timing result is recorded.

Potential change boundary if confirmed:
- `services/worker/src/adapters/dataforseo-serp/serp-adapter.js`
- and/or the source-specific timeout policy in `services/worker/src/application/production-runtime.js`.
- The current all-or-nothing orchestration failure behavior may also need review so successfully acquired supplied-competitor evidence is not erased by a later SERP timeout, but no orchestration change is authorized yet.

Required impact review before change:
- retry/idempotency behavior;
- audit wall-clock duration;
- duplicate provider cost risk on retries;
- supplied competitor crawl behavior;
- preservation of partial direct-crawl evidence;
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
  - `/about`: ~765
  - `/services`: ~685
  - `/home`: ~473
  - `/insights`: ~310

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

Run the existing `dataforseo-serp` adapter once in isolation with the exact three supplied competitor URLs and four service keywords from audit `97d6b2c7-03b9-4530-8ea7-16557502c638`, using the production Railway environment but no persistence/orchestration wrapper. Record total elapsed time, source status, supplied-competitor evidence count, SERP result count, and limitations/errors. Do not rerun the audit and do not change application code yet.
