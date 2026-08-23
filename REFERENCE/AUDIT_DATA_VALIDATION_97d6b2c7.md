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

## DQV-001 — SERP / competitor source loses usable evidence at the outer timeout boundary

Classification: PROVEN HISTORICAL FAILURE + PROVEN TIMEOUT/CANCELLATION DESIGN DEFECT. Exact historical in-adapter operation at timeout is unrecoverable from persisted artifacts.

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
- Production runtime gives the whole `dataforseo-serp` source a 60,000 ms timeout and up to three attempts.
- The SERP adapter first direct-crawls up to three supplied competitors, then runs up to five DataForSEO live SERP requests serially. This audit has three supplied competitors and four service keywords.
- Each individual DataForSEO SERP client request is independently allowed up to 45,000 ms.
- The outer retry boundary uses `Promise.race`. When it wins, it aborts the orchestration signal, rejects the attempt, and after retries are exhausted creates a synthetic `FAILED` result with `rawBytes: null` and no partial evidence.
- Normalized/raw persistence happens only after `executeSource()` returns. Therefore evidence accumulated inside an adapter attempt is not persisted if the outer timeout wins.
- `querySerp()` does not receive the orchestration `AbortSignal`. Its `withTimeout()` helper only races the fetch promise against a timer; it does not abort the underlying HTTP fetch. Therefore an outer timeout does not reliably cancel an in-flight DataForSEO request before the orchestration layer starts a retry. This creates a proven overlap/duplicate-cost risk under timeout conditions.

### Isolated direct-crawl diagnostic — 2026-08-23

Exact supplied competitors, current application commit, no persistence:
- `https://ginakeeping.ca/` — `AVAILABLE`, 8 pages, 1.9 seconds, no limitations.
- `https://traceyjazmin.com/` — `AVAILABLE`, 8 pages, 3.0 seconds, no limitations.
- `https://clarityofgoalsandvision.com/` — `AVAILABLE`, 8 pages, 3.7 seconds, no limitations.
- Total direct-crawl wall time: approximately 8.6 seconds.

Conclusion:
The three supplied competitor sites are currently reachable and direct crawling is not a systemic 60-second bottleneck.

### Isolated one-keyword DataForSEO diagnostic — 2026-08-23

Using the production Railway `vantage-platform` environment and current production SERP client:
- Keyword: `Group Coaching`.
- Elapsed: 5.25 seconds.
- Result: success.
- Task ID: `08232042-1281-0139-0000-2eda65f9fe51`.
- PRYSM client result count: 18.
- No provider/client error.

Conclusion:
A generally broken DataForSEO credential/client/provider path is ruled out as the explanation for the selected audit.

### Full composite adapter diagnostic — 2026-08-23

Executed the existing `dataforseo-serp` adapter once in isolation using the exact three supplied competitors and four service keywords, production Railway credentials/environment, and a 60-second outer diagnostic race. No audit/S3/Postgres/lifecycle/report persistence was invoked.

Observed result:
- outcome: `COMPLETED`
- elapsed: `43.51` seconds
- source status: `PARTIAL`
- provider: `DataForSEO + Prysm direct crawl`
- expected records: `7`
- returned records: `6`
- coverage: requested `7`, completed `6`, failed `1`
- SERP status: `PARTIAL`
- keyword count: `4`
- combined result count: `58`
- supplied competitor coverage: requested `3`, completed `3`, failed `0`
- all three supplied competitors produced 8-page direct-crawl evidence
- one service query failed cleanly: `4-Week Reboot Series: SERP task 0 failed: status_code=40101, message="Internal SE Server Error."`

Interpretation:
- The adapter's intended graceful-degradation behavior works when the adapter is allowed to finish: a provider task failure for one keyword produced `PARTIAL`, while preserving three supplied competitor crawls plus successful SERP evidence.
- The full attempt used 43.51 seconds, or about 72.5% of the 60-second outer budget, leaving only about 16.5 seconds of margin under current conditions.
- The historical production timeout was not reproduced, but it is technically credible from normal network/provider variance because the internal work budget is much larger than the outer source budget.
- Most importantly, the selected audit's all-or-nothing loss is now explained by the boundary design: if the outer 60-second timer fires before this same adapter returns, the orchestrator discards already-collected supplied-competitor and completed-keyword evidence and persists a synthetic total failure instead.
- The historical artifact cannot reveal which specific competitor crawl or SERP keyword was active at the timeout because no partial/raw payload survives that boundary.

Current downstream effect:
- The selected audit has no usable persisted competitor evidence even though the same supplied competitors are demonstrably crawlable and the adapter can produce meaningful partial evidence.
- Competitor opportunity generation and competitor report sections were deprived of evidence that should have survived a later SERP delay/failure.
- A timeout can also trigger a retry while a prior DataForSEO HTTP request remains in flight, creating duplicate-call/cost and nondeterministic-result risk.
- Report status propagation remains separately defective: canonical `FAILED` is later represented as `NOT_APPLICABLE` / `NOT_CONNECTED` in report-layer artifacts.

Potential change boundary — NOT YET AUTHORIZED:
- `services/worker/src/adapters/dataforseo-serp/dataforseo-serp-client.js` — accept/propagate a cooperative abort signal so provider requests actually stop when the source attempt is cancelled.
- `services/worker/src/adapters/dataforseo-serp/serp-adapter.js` — align internal sequencing/deadline behavior with the governed source budget and preserve partial evidence before the hard outer boundary.
- `services/worker/src/application/production-runtime.js` — source-specific SERP timeout may need adjustment only after the internal deadline/cost model is chosen.
- `services/worker/src/orchestration/retry-policy.js` — review all-or-nothing timeout/retry semantics, but avoid broad generic-orchestrator changes if the defect can be fixed safely inside the SERP source boundary.

Required impact review before change:
- provider request cancellation and in-flight overlap;
- retry/idempotency behavior;
- duplicate DataForSEO cost risk;
- maximum audit wall-clock duration;
- supplied competitor crawl behavior;
- preservation of partial direct-crawl evidence;
- serial vs bounded-parallel SERP request behavior and API-rate implications;
- source checkpoint/raw artifact semantics;
- canonical competitor source status (`AVAILABLE` / `PARTIAL` / `FAILED`);
- competitor opportunity derivation;
- report source-status propagation;
- deterministic regression tests for outer-timeout, one-keyword provider failure, and mixed partial evidence.

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

Complete the DQV-001 dependency-impact design before editing code: choose the smallest source-bounded fix that (1) propagates real cancellation into DataForSEO HTTP requests, (2) prevents a 60-second outer timeout from erasing already-valid supplied-competitor/SERP partial evidence, (3) avoids duplicate paid calls on retry, and (4) keeps bounded audit wall-clock/cost behavior. Define the exact files and regression tests, then obtain user approval before any application source edit.