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

Classification: PROVEN HISTORICAL FAILURE + PROVEN TIMEOUT/CANCELLATION DESIGN DEFECT.

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

Potential future repair boundary — DEFERRED:
- `services/worker/src/adapters/dataforseo-serp/dataforseo-serp-client.js`
- `services/worker/src/adapters/dataforseo-serp/serp-adapter.js`
- possibly `services/worker/src/application/production-runtime.js`
- review generic retry-policy/orchestrator only if source-bounded repair cannot safely close the defect.

Any later DQV-001 repair must preserve partial evidence, propagate true HTTP cancellation, prevent overlapping paid retries, keep bounded wall-clock/cost, and preserve correct source-status semantics.

## DQV-002 — On-Page content parsing succeeds, then usable body content is lost in normalization

Classification: PROVEN DATA-LOSS DEFECT. RAW DATA QUALITY PASS. LOCAL REPAIR VERIFIED; NOT COMMITTED.

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

### Persisted normalized defect

- Every normalized contentParsing record had `text: ""`, `hasMainContent: false`, and null content metrics.
- All site pages retained empty `bodyText` and `_contentAvailable: false`.
- Site `_contentEvidenceAvailable` was false.

### Proven root cause

Primary application file:
`services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`

The executing normalizer selected `res.result` as the item, stopping one level too shallow. The production content is under `res.result.items[0].page_content`. The old function then attempted to read legacy `item.main_content` / `item.secondary_content`, which are absent from the production shape. This deterministically produced empty normalized text.

Downstream hydration already exists in `summarizeSite()`:
- normalized content is matched back to pages by normalized URL;
- when `hasMainContent && text`, the page receives `bodyText`, `_contentAvailable: true`, and trust-signal detection;
- site `_contentEvidenceAvailable` becomes true when at least one content page has actual content.

Therefore the smallest coherent repair remains in the On-Page adapter normalizer; no report/storage/scoring rewrite is required merely to retain the already-collected text.

### Local repair status — 2026-08-23

User explicitly authorized moving ahead with the targeted DQV-002 repair.

Application files involved:
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.test.js`

Implemented local change boundary:
- adapter version `1.2.1`;
- unwrap `result.items[0]`;
- read production `page_content.main_topic` and `secondary_topic`;
- collect `primary_content` and `secondary_content` text;
- retain bounded normalized text;
- exact-text deduplication;
- exclude provider-classified header/footer from body evidence;
- preserve the older fixture shape;
- do not infer CTA/form/path evidence from body text.

Verification history:
1. After an initial complete-file replacement, `node --check` passed and the existing targeted adapter test suite passed 68/68.
2. A separate production-shaped no-network diagnostic then returned empty content and correctly blocked a premature commit.
3. Duplicate `normalizeContentParsing()` definitions were found in the working copy and the duplicate was removed.
4. A path/version mismatch was proven: VS Code initially displayed a different file copy while PowerShell/Node executed the actual working-copy file with adapter version `1.2.0`.
5. The exact executing file was reopened from PowerShell, versioned `1.2.1`, saved, and syntax-checked.
6. The production-shaped no-network diagnostic still failed with `contentParsing.text is empty`, proving path/version was no longer the cause.
7. Under the project-wide three-attempt diagnostic-reset rule, the exact executing `normalizeContentParsing()` function was inspected before any further repair.
8. That inspection proved the one-level-too-shallow unwrapping plus legacy-field read described above.
9. The entire `normalizeContentParsing()` function was replaced as one coherent bounded repair implementing the production shape plus legacy compatibility, exact-fragment deduplication, header/footer exclusion, and bounded text retention.
10. `node --check src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js` PASS after the final coherent repair.
11. The production-shaped, fixture-only, no-network diagnostic PASS after the final repair with:
   - adapterVersion `1.2.1`
   - normalized content text length 261
   - `hasMainContent: true`
   - page `_contentAvailable: true`
   - site `_contentEvidenceAvailable: true`
   - testimonials: true
   - credentials: true
   - pricing: true
   - duplicate fragment count: 1
   - header excluded: true
   - footer excluded: true
12. The first post-repair targeted suite run produced 67/68 PASS. The only failure was `WP-B-10`, caused solely by a stale hard-coded assertion requiring artifact adapter version `1.2.0` while the adjacent assertion already required `payload.adapterVersion === ADAPTER_VERSION`.
13. The redundant hard-coded `1.2.0` assertion was removed from the exact executing test file. No production behavior changed.
14. `node --check src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.test.js` PASS.
15. Final targeted adapter suite PASS: 68 tests, 68 pass, 0 fail, duration ~29.9s.

Current verification state:
- Production-shaped normalization diagnostic: PASS.
- Adapter syntax: PASS.
- Test-file syntax: PASS.
- Targeted adapter regression suite: 68/68 PASS.
- DQV-002 local repair is verified complete at the application working-copy level.
- Application changes remain uncommitted and undeployed.

Required proof before commit:
1. Production-shaped nested fixture produces non-empty normalized `contentParsing.text`. — PASS.
2. Matching page gets `_contentAvailable: true` and populated `bodyText`. — PASS.
3. Site gets `_contentEvidenceAvailable: true`. — PASS.
4. Expected content-dependent trust/pricing signal can be detected from that text. — PASS.
5. Header/footer sentinel text is not included when separately supplied as provider-classified header/footer. — PASS.
6. Exact duplicate body fragments are not duplicated. — PASS.
7. Existing targeted adapter regression suite passes after the final code state. — PASS, 68/68.

Downstream items to verify only after the adapter repair is committed:
- canonical site evidence;
- decision evidence;
- `content.body` capability consistency;
- offer/trust capability eligibility;
- content/funnel scoring inputs;
- evidence coverage;
- Narrative v2 writer input/report conclusions.

Defensive follow-up candidate, NOT YET AUTHORIZED/REQUIRED:
`services/worker/src/evidence/capability-evidence.js` may need hardening so endpoint completion alone cannot mark `content.body` available when normalized usable content is empty. Do not change this until the primary normalization repair is committed and dependency impact is checked.

## DQV-003 — Microdata request omits required page URL

Classification: PROVEN PROVIDER-CONTRACT DEFECT.

Evidence:
- task created with `validate_micromarkup: true`;
- current request payload contains only task ID;
- DataForSEO returned 40501 `Invalid Field: 'url'.`;
- acquisition requested 1, completed 0, failed 1.

Code-path evidence:
- current `getMicrodata(taskId)` constructs `[{ id: taskId }]`;
- provider requires task ID plus resource URL.

Current downstream effect:
- `schema.structured_data` unavailable;
- schema/entity and AI-search dependent modules are not eligible.

Potential future repair boundary:
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-client.js`
- calling code in `dataforseo-onpage-adapter.js` may need to pass deterministic selected URLs.

DQV-003 remains deferred until DQV-002 closes.

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

From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, inspect the exact local application diff before any commit by running `git status --short` and `git diff -- src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.test.js`. Confirm that only the intended DQV-002 adapter normalizer/version change and redundant stale test-version assertion removal are present. Do not commit, deploy, rerun the production audit, or mutate persisted artifacts without explicit user approval.

After DQV-002 is reviewed and committed through the governed application workflow, return to DQV-003 before implementing DQV-001 unless the user explicitly changes priority.
