# PRYSM Audit Data Validation Ledger

Audit ID: `97d6b2c7-03b9-4530-8ea7-16557502c638`  
Target: `https://rebootbusinesscoaching.com/`  
Date opened: 2026-08-23  
Status: Active investigation — local repair boundary complete; production validation pending approval

## Purpose

Durable evidence and impact ledger for the selected audit-data investigation. It records verified defects, diagnostics, code-boundary findings, downstream impact, and exact verification state. It is not a transcript and does not authorize deployment or production mutation.

## Investigation rules

- Existing persisted artifacts for this audit remain immutable evidence.
- Do not create or rerun a full production audit merely to diagnose this audit.
- Prefer persisted-artifact inspection and no-cost diagnostics before paid provider requests.
- Any provider diagnostic must be isolated to the smallest request needed to prove or disprove one hypothesis.
- Before application-code change, record the proven root cause, source files, upstream inputs, downstream consumers, affected artifacts/contracts, cost/retry implications, regression risks, and required tests.
- Application source changes use the governed manual VS Code workflow.
- After editing: syntax check → targeted/relevant regression tests → correct failures → inspect diff → only then commit/update.
- Do not broaden a repair into unrelated lifecycle, storage, Writer/Judge, authentication, n8n, report-design, or architecture changes.
- After three unsuccessful attempts on the same failure, stop and perform the project-wide diagnostic reset.

## Verified artifact baseline

The production S3 bundle for this audit was exported read-only and inspected. It contains 35 files spanning raw, normalized, canonical, findings/scores, Narrative v2, report HTML, lifecycle, and manifests.

Persisted source status baseline:

- DataForSEO On-Page: `PARTIAL`.
- PageSpeed: lab evidence `AVAILABLE`; CrUX field calls failed with 403.
- Backlinks: `AVAILABLE`.
- DataForSEO SERP/competitors: `FAILED` after timeout/retries; no raw SERP artifact persisted.
- GA4/GSC: not connected/not requested for this audit.

---

## DQV-001 — SERP timeout + enterprise evidence-depth boundary

Classification: **PROVEN HISTORICAL FAILURE + PROVEN TIMEOUT/CANCELLATION DESIGN DEFECT. TRACK A + TRACK B COMPLETE LOCALLY; PRODUCTION VALIDATION PENDING APPROVAL.**

Governing implementation design:
`SPECS/ENTERPRISE_EVIDENCE_ACQUISITION_v1.0.0.md`

### Persisted historical evidence

- `normalized/dataforseo-serp.json` records `FAILED`, retryCount `2`, returnedRecords `0`, limitation `Source execution failed: Source execution timed out`, errorCategory `timeout`.
- `source-checkpoint-dataforseo-serp.json` has `rawArtifact: null`.
- Audit request contains three supplied competitor URLs and four services.

### Verified diagnostics — 2026-08-23

Direct supplied competitor crawls:

- `https://ginakeeping.ca/` — `AVAILABLE`, 8 pages, ~1.9s.
- `https://traceyjazmin.com/` — `AVAILABLE`, 8 pages, ~3.0s.
- `https://clarityofgoalsandvision.com/` — `AVAILABLE`, 8 pages, ~3.7s.
- Total ~8.6s.

One live DataForSEO request:

- Keyword: `Group Coaching`.
- Elapsed: 5.25s.
- Task ID: `08232042-1281-0139-0000-2eda65f9fe51`.
- 18 organic results.

Full composite adapter, exact three competitors + four services:

- elapsed 43.51s;
- source status `PARTIAL`;
- expected 7 / returned 6;
- 3/3 supplied competitors preserved;
- 58 combined SERP results;
- one keyword failed cleanly: `4-Week Reboot Series`, DataForSEO task status 40101 `Internal SE Server Error`.

Conclusion: direct competitors and the provider path are functional. Graceful partial semantics work when the adapter is allowed to return.

### Proven original executing failure boundary

Production execution at the defect baseline:

`production-bootstrap.js` → `production-runtime.js` source policy → `audit-orchestrator.js` → `executeWithRetry()` → `serp-adapter.execute()` → `querySerp()` → live `fetch()`.

Verified at the defect baseline:

- Production gave the whole `dataforseo-serp` source a 60,000 ms timeout and up to three attempts.
- `executeWithRetry()` created an `AbortController`, passed its signal into the adapter, aborted at timeout, then could begin another whole-source attempt.
- The adapter checked the signal between operations but did not pass it into `querySerp()` options.
- `querySerp()` called the DataForSEO HTTP fetch without the orchestration signal.
- Its 45-second shared `withTimeout()` used `Promise.race` and did not abort the underlying HTTP request.
- A timed-out paid request could therefore still be running when a later whole-source retry started.
- Valid partial evidence existed before return in `suppliedItems`, `allItems`, `totalCompleted`, and `errors`.
- Raw and normalized persistence began only after the adapter returned.
- If the outer race won, valid in-memory evidence could be replaced with synthetic `FAILED` and `rawBytes: null`.

### Provider behavior relevant to repair

Current DataForSEO documentation/help was rechecked on 2026-08-23:

- On-Page supports up to 20 `priority_urls` and `respect_sitemap: true`.
- On-Page supports `return_despite_timeout: true` for page-load timeouts.
- DataForSEO 40101 means the search-engine request was submitted and DataForSEO already retried it several times before returning the failure; the task can still be billable.

Implication: PRYSM must not repeat an entire composite SERP source because one keyword returned 40101.

### User outcome being protected

PRYSM must prioritize defensible enterprise conversion intelligence, not arbitrary short timeout or minimum-provider-cost behavior.

For large sites, PRYSM must:

- discover the broad site footprint without exhaustively downloading thousands of URLs;
- detect material repeated/template/programmatic URL families;
- select representative pages from those families;
- deeply assess enough representatives to evaluate content depth, conversion/offer signals, trust/E-E-A-T, schema/entity signals, and geographic trust alignment;
- preserve explicit evidence coverage and limitations;
- avoid claiming absence or failure from uncollected evidence.

Example requirement: a Pennsylvania-targeted landing-page family whose representative expert/support evidence materially points to Texas without Pennsylvania-specific support should surface a bounded geographic trust-alignment concern. Unknown geography remains unknown.

### Upstream inputs

- audit target URL;
- audit services and market/language;
- supplied competitor URLs;
- target site's public sitemap resources;
- DataForSEO SERP credentials/provider responses;
- DataForSEO On-Page task/pages/content-parsing evidence;
- existing deterministic important-page selection.

### Downstream consumers

Direct consumers affected by the repair:

- normalized DataForSEO SERP SourceResult;
- normalized DataForSEO On-Page SourceResult;
- raw source artifacts when returned;
- source checkpoint manifests;
- canonical/decision evidence;
- capability eligibility/coverage;
- later calibrated scoring;
- Narrative/report conclusions after acquisition semantics are proven.

### Artifact / contract impact

Expected new On-Page nested evidence:

- `siteFootprint`;
- `programmaticSeo`.

`source-result.schema.json` allows additional properties inside `evidence`; no SourceResult schema migration is currently expected.

`decision-evidence.schema.json` does not prohibit additional site properties; `decision-evidence.js` must explicitly hydrate the new fields. Contract regression tests must prove this assumption.

No lifecycle, storage, authentication, n8n, Viewer, or Writer/Judge contract change is expected for acquisition implementation.

### Locked reliability design

SERP:

- per-request live HTTP fetch receives caller AbortSignal;
- request-local timeout 120 seconds;
- at most one sequential retry for transient transport/timeout/HTTP-5xx failure;
- no retry for task-level 40101;
- no new request after caller abort;
- whole `dataforseo-serp` source timeout 30 minutes;
- whole-source attempts 1;
- completed keywords and supplied competitor evidence survive later individual failures.

On-Page:

- whole `dataforseo-onpage` source timeout 60 minutes;
- whole-source attempts 1;
- task poll budget 30 minutes;
- use up to 20 representative `priority_urls`;
- use `respect_sitemap: true` when usable footprint evidence exists;
- use `return_despite_timeout: true`;
- keep general provider crawl default at 500 pages, making the sample structurally representative rather than increasing it blindly;
- deep content parsing becomes bounded at up to 20 important + cluster-representative pages.

### Track A verified implementation result — 2026-08-23

Track A status: **PASS, committed locally, not pushed/deployed.**

Unit 1 — SERP client:

- caller AbortSignal reaches the live fetch;
- request-local 120-second AbortController ceiling;
- underlying fetch is aborted on timeout;
- at most one sequential transient retry;
- no later request after caller cancellation;
- HTTP 5xx may retry once;
- task-level 40101 is terminal for that keyword.

Local commit:
`3841fa729c6a232ba45b9a794ae9504c86505f0f` — `fix(serp): make request cancellation cooperative`.

Verification:

- focused client boundary PASS 31/31.

Unit 2 — SERP adapter:

- orchestration signal passed into every `querySerp()` call;
- no new keyword request begins after cancellation;
- completed keyword evidence survives later failure/cancellation;
- supplied competitor evidence remains preserved;
- graceful PARTIAL/FAILED outcomes retain raw evidence;
- adapter version advanced to `1.2.0`.

Local commit:
`6465890daa6beeff96d7ba265c1f804065e603d6` — `fix(serp): preserve partial evidence on cancellation`.

Verification:

- focused adapter boundary PASS 34/34.

Unit 3 — production source policy:

- `dataforseo-serp` whole-source default timeout is now 1,800,000 ms / 30 minutes;
- `dataforseo-serp` whole-source attempts are now 1;
- generic retry policy remains unchanged;
- focused no-network policy test proves the exact values;
- stale supplied-competitor test assertion was intentionally updated from adapter v1.1.0 to the already-governed v1.2.0.

Local commit:
`b8d3ae404cbea75207d7a75bd2011ea62b122dd5` — `fix(serp): govern composite source policy`.

Final Track A verification:

- full SERP + production-policy regression boundary PASS **102/102**;
- `git diff --check` PASS;
- staged diff clean and limited to governed changes;
- no paid provider call, production audit rerun, application push, or deployment used.

Workspace-control note:

- two duplicate-repository incidents were detected during Track A;
- the governed application path is `C:\Users\kulba\Desktop\vantage-platform\services\worker`;
- wrong-repository edits were not retained in the final governed commit;
- future manual file work must verify the Desktop path before editing/testing.

### Large-site Track B design

A new bounded sitemap-footprint layer will:

- recursively process sitemap and sitemap-index documents;
- cap sitemap documents at 200;
- cap retained discovered URLs at 100,000;
- same-origin filter and deduplicate URLs;
- record incomplete/capped discovery explicitly;
- group URLs into deterministic structural families;
- select representative URLs for large families without treating repetition alone as a quality defect.

A deterministic programmatic analysis layer will use the footprint plus representative normalized content to classify evidence as `NOT_DETECTED`, `LIKELY`, or `INSUFFICIENT_EVIDENCE` and record cluster-level content/trust/geographic/conversion evidence and limitations.

### Expected application files

Track A — SERP reliability — COMPLETE:

- `services/worker/src/adapters/dataforseo-serp/dataforseo-serp-client.js`
- `services/worker/src/adapters/dataforseo-serp/serp-adapter.js`
- `services/worker/src/application/production-runtime.js`
- focused SERP cancellation/retry/policy tests plus existing SERP production/failure aggregation regressions.

Generic `services/worker/src/orchestration/retry-policy.js` did not change.

Track B — representative large-site acquisition — COMPLETE LOCALLY:

- new `services/worker/src/evidence/sitemap-footprint.js`
- new `services/worker/src/evidence/programmatic-seo-analysis.js`
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-client.js`
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`
- `services/worker/src/application/production-runtime.js`
- `services/worker/src/evidence/decision-evidence.js`
- corresponding focused tests and existing On-Page/decision-evidence regressions.

Track C — downstream semantics after acquisition PASS:

- `capability-evidence.js` only if capability semantics legitimately change;
- `score-components.js` only through a deliberate calibrated scoring-version change;
- Narrative/report files only after new evidence/scoring semantics are verified.

### Cost / retry implications

- Increasing outer time limits does not itself create DataForSEO task cost; provider requests do.
- Removing whole-source retries reduces duplicate paid work.
- A single sequential transient retry may create one extra keyword request, but never concurrently and never for 40101.
- Representative site sampling avoids paying to deeply process thousands of near-identical programmatic pages.
- Priority is evidence quality and reliable completion, not minimizing pennies.

### Regression risks

Must guard against:

- false programmatic classification on ordinary small sites;
- false thin-content findings from pages without body evidence;
- false geographic mismatch when geography is unknown;
- representative sampling excluding core conversion pages;
- DQV-002 body-content normalization regression;
- DQV-003 microdata request regression;
- new evidence silently changing scoring v4.1.1.

### Required verification

Track A requirements — all PASS locally:

1. AbortSignal reaches actual SERP fetch.
2. Local timeout aborts the fetch.
3. No overlapping provider retry.
4. 40101 is not blindly retried.
5. Transient retry is sequential and capped at one.
6. Completed keyword evidence survives later keyword failure.
7. Supplied competitor evidence survives SERP failure.
8. Production SERP policy is 30 minutes / one whole-source attempt.

Track B requirements — all verified locally:

1. recursive sitemap-index discovery;
2. deterministic same-origin deduplication and caps;
3. deterministic URL-family clustering;
4. priority set bounded to 20;
5. ordinary small site is not falsely classified as programmatic;
6. large location/template family is detected as likely template-scale;
7. thin/near-duplicate samples are surfaced only from collected content;
8. bounded geographic trust concern is supported only by collected evidence;
9. unknown geography remains unknown;
10. On-Page task payload carries `priority_urls`, `respect_sitemap`, `return_despite_timeout`;
11. important pages and cluster representatives both enter the bounded deep set;
12. `siteFootprint` / `programmaticSeo` survive SourceResult → DecisionEvidence;
13. DQV-002 and DQV-003 regressions remain green;
14. scoring v4.1.1 remains unchanged merely because new acquisition fields exist.

### Track B verified implementation result — 2026-08-25

Track B status: **PASS locally; not verified pushed/deployed; no production rerun.**

Verified outcomes:

- representative sitemap footprint discovery and programmatic SEO evidence are integrated into the On-Page acquisition path;
- representative selection stays bounded and business-aware;
- bounded deep parsing merges important business pages with material cluster representatives;
- unavailable sitemap evidence remains explicit rather than becoming a false `NOT_DETECTED` conclusion;
- On-Page whole-source policy is 60 minutes / one attempt; main task polling budget is 30 minutes;
- DecisionEvidence preserves representative site evidence losslessly;
- representative acquisition integration previously PASS **92/92** with no paid provider call;
- DQV-002 On-Page normalization and DQV-003 microdata contract remained green in the final integrated boundary.

### Pre-edit gate

`REPAIR_BOUNDARY_PROTOCOL.md` Mandatory Pre-Edit Gate: **PASS** for the completed Track B repair.

Track B implementation is closed locally. Reopen design only if production validation produces genuinely new evidence that materially changes the boundary.

---

## DQV-002 — On-Page content parsing normalization

Classification: **PROVEN DATA-LOSS DEFECT. REPAIR VERIFIED AND COMMITTED LOCALLY; NOT YET VERIFIED PUSHED/DEPLOYED.**

Persisted raw production content was good: body content existed at `result.items[0].page_content`, with `main_topic` / `secondary_topic` and `primary_content` / `secondary_content`.

Proven root cause: the old normalizer stopped one level too shallow at `res.result` and read legacy fields absent from the production shape.

Verified repair:

- adapter version `1.2.1` at that repair step;
- unwrap `result.items[0]`;
- read production page-content topic fields;
- retain bounded normalized text;
- exact-text deduplication;
- exclude provider-classified header/footer;
- preserve older fixture shape.

Verification:

- production-shaped no-network diagnostic PASS;
- normalized text non-empty;
- page `_contentAvailable: true`;
- site `_contentEvidenceAvailable: true`;
- testimonials/credentials/pricing detected;
- header/footer excluded;
- syntax PASS;
- targeted adapter suite PASS 68/68;
- final diff checks PASS.

Local commit:
`82a9f84f8c96bcd44a3b307abe024442d1903336` — `fix(onpage): retain DataForSEO parsed page content`.

---

## DQV-003 — Microdata provider contract

Classification: **PROVEN PROVIDER-CONTRACT DEFECT. REPAIR VERIFIED AND COMMITTED LOCALLY; NOT YET VERIFIED PUSHED/DEPLOYED.**

Persisted defect:

- On-Page task used `validate_micromarkup: true`;
- request sent task ID only;
- DataForSEO returned 40501 `Invalid Field: 'url'.`;
- `schema.structured_data` was unavailable.

Proven root cause: `getMicrodata(taskId)` omitted the required page URL.

Verified repair:

- `getMicrodata(taskId, url, options)` requires and posts task ID + URL;
- adapter version advanced to `1.2.2`;
- request moved after deterministic key-page selection and uses `keyPageUrls[0]`;
- exact live POST payload regression added.

Verification:

- client syntax PASS;
- adapter syntax PASS;
- test syntax PASS;
- targeted adapter suite PASS 69/69;
- `git diff --check` PASS;
- no paid provider call or production audit rerun used.

Local commit:
`10bf22cb7f9ad74183fa626fcc696fd86e6a34e1` — `fix(onpage): send page URL with microdata request`.

---

## DQV-004 — Seven-page crawl

Classification: **NOT CURRENTLY PROVEN DEFECTIVE.**

Evidence:

- max crawl pages 500;
- pages_crawled 7;
- crawl_stop_reason `empty_queue`;
- pages_in_queue 0;
- extended_crawl_status `no_errors`.

Interpretation: provider did not stop because of the page ceiling or explicit crawl error. Large-site representative-footprint work is a forward product requirement, not retroactive proof that this seven-page result was defective.

---

## DQV-005 — Report source-status propagation

Classification: **PROVEN REPORT-DATA MAPPING DEFECT; REPAIR COMPLETE LOCALLY; INTEGRATED REGRESSION PASS.**

Original evidence:

- canonical competitor source: `FAILED`;
- report layer represented it as `NOT_APPLICABLE` / `NOT_CONNECTED`.

Required semantic rule:

`FAILED`, `NOT_CONNECTED`, and `NOT_APPLICABLE` are materially different states and must not be substituted.

Verified repair — 2026-08-25:

- DecisionEvidence carries root canonical `sourceStatus` independently from hydrated item collections;
- `report-content/build-package.js` consumes canonical `decisionEvidence.sourceStatus.competitors` with bounded legacy fallback for older evidence lacking the root map;
- Viewer v2 no-comparison rendering distinguishes `FAILED`, `NOT_CONNECTED`, and `NOT_APPLICABLE`;
- Narrative v2 model and persisted report manifest consume the canonical competitor source status with bounded legacy fallback;
- end-to-end Narrative v2 regression proves canonical `FAILED` reaches Viewer v2 and manifest without degrading to `NOT_APPLICABLE`;
- report-content focused boundary PASS **25/25**;
- Viewer v2 conversion boundary PASS **46/46**;
- Narrative v2 production-path boundary PASS **7/7**;
- DE-16 real On-Page adapter → DecisionEvidence → production render regression PASS **1/1** after aligning a stale test-only adapter-version literal to current `1.3.0`;
- final integrated DQV/Track B boundary PASS **185/185**, 0 failures, ~18.3s;
- `git diff --check` PASS;
- governed working tree clean except known unrelated `../../lifecycle-failure.txt` and `prysm-v2.2.0-uat.html`.

Known local checkpoints:

- `3776b9e7f39f7fcf396464330f4c889976d4158b` — `fix(report): preserve competitor source status`;
- `86f134b` — `fix(narrative-v2): preserve competitor source status` was the last explicitly pasted local HEAD before the final test-only adapter-version alignment.

The exact resulting local HEAD after the final test-only alignment was not pasted. Do not guess it; re-verify at the start of the next chat.

No paid provider call, push, deploy, production audit rerun, or persisted production-artifact mutation was used to close DQV-005.

---

## Current exact next action

From `C:\Users\kulba\Desktop\vantage-platform\services\worker`:

1. verify the exact current local `HEAD` and confirm the governed working tree remains clean except the two known unrelated untracked artifacts;
2. prepare the controlled production audit/UAT validation plan to prove the real acquisition → DecisionEvidence → report path yields robust, representative evidence for site structure/content, conversion, technical/performance health, competitors, backlinks, and connected GA4/GSC when available;
3. state paid-provider/cost exposure, runtime boundaries, immutable-artifact rules, and objective success/failure criteria before execution;
4. obtain explicit user approval before any paid provider call, production audit rerun, push, deployment, or persisted production-artifact mutation.

Do not begin a production audit rerun merely because the local regression boundary is green.
