# PRYSM Enterprise Evidence Acquisition

**Version:** 1.0.0  
**Date:** 2026-08-23  
**Status:** Approved implementation design  
**Work package:** DQV-001 + enterprise evidence-depth extension

## 1. Product outcome

PRYSM must collect enough representative evidence to make defensible conversion-readiness decisions about the whole site without requiring an exhaustive crawl of every URL.

Timeouts and provider-cost controls are safety boundaries. They must not be used as arbitrary evidence-depth controls.

For large sites, PRYSM must discover the broad site footprint, identify meaningful page/template clusters, deeply inspect representative pages from the commercially relevant clusters, and state the resulting evidence coverage explicitly.

## 2. Verified DQV-001 root cause

The current DataForSEO SERP source combines supplied-competitor crawling and serial service-keyword SERP requests behind a 60-second whole-source timeout with up to three whole-source attempts.

The orchestration AbortSignal reaches the SERP adapter but does not reach the DataForSEO HTTP fetch. The client's 45-second timeout is a passive `Promise.race` and does not cancel the underlying fetch. A timed-out whole-source attempt can therefore continue paid work while a later whole-source retry begins.

Valid supplied-competitor and completed-keyword evidence exists in memory before adapter return, while durable persistence begins only after adapter return. When the outer timeout wins, valid partial evidence can be replaced by a synthetic `FAILED` result with no raw artifact.

## 3. Reliability contract

### 3.1 DataForSEO SERP request

- Every live SERP HTTP request must receive the caller's AbortSignal.
- Every live SERP HTTP request must also have a request-local hard ceiling of **120 seconds**.
- Caller cancellation must dominate local retry behavior: once the source signal is aborted, no new provider request may start.
- Task-level `40101 Internal SE Server Error` is not retried by PRYSM. DataForSEO already performs several internal retries before returning 40101 and the task can still be billable.
- A transient transport/timeout/HTTP-5xx failure may receive **one sequential retry** for that keyword only. The previous request must be cancelled/settled before the retry starts. No overlap is permitted.
- Successful keywords are never repeated merely because a later keyword fails.

### 3.2 Composite SERP source

- Production whole-source timeout: **30 minutes**.
- Production whole-source attempts: **1** for `dataforseo-serp`.
- Whole-source retries are prohibited for this composite source because they repeat already-successful competitor crawls and completed paid keyword calls.
- The adapter must continue through individual keyword failures and return `PARTIAL` when usable evidence exists.
- Any adapter-controlled graceful failure path must include already-completed SERP evidence as well as supplied-competitor evidence.
- The generic retry-policy implementation remains unchanged unless later evidence proves it is strictly required.

## 4. Large-site acquisition contract

### 4.1 Footprint discovery

Before the DataForSEO On-Page task is submitted, PRYSM will perform a bounded, read-only sitemap footprint discovery using the target site's public sitemap resources.

The discovery must:

- support sitemap files and sitemap-index files recursively;
- remain same-origin for discovered page URLs;
- fail soft when no usable sitemap is available;
- cap sitemap documents at **200**;
- cap retained discovered URLs at **100,000**;
- deduplicate normalized URLs;
- record whether the discovery was capped or incomplete;
- never interpret an unavailable sitemap as proof that programmatic SEO is absent.

This stage discovers URL structure; it does not download every discovered page.

### 4.2 URL/template clustering

The footprint analyzer will deterministically group URLs by structural path families using normalized parent/depth patterns and variable sibling segments.

Clusters must record:

- stable cluster identifier;
- structural pattern;
- discovered URL count;
- representative URLs;
- whether the family is large enough to require representative assessment;
- evidence/reason codes for a likely templated or programmatic pattern.

A large repeated URL family is evidence of a templated footprint, not by itself proof of low-quality content.

### 4.3 Representative selection

PRYSM will build a deterministic representative set from:

1. homepage/root;
2. obvious conversion/contact/pricing/about/proof/service URL roles discoverable from URL structure and intake services;
3. representative URLs from large structural clusters;
4. deterministic outliers where useful.

The DataForSEO task will receive up to **20 `priority_urls`**, matching the provider's documented limit, and will use `respect_sitemap: true` where sitemap discovery is usable.

The general provider crawl remains bounded at the existing default **500 pages**. The objective is to make the first 500 structurally representative, not to increase the crawl blindly to thousands of pages.

The task will set `return_despite_timeout: true` so provider page evidence can survive individual 120-second page-load timeouts where DataForSEO can return it.

## 5. On-Page wall-clock contract

Large-site crawling and deep acquisitions must be allowed to complete.

- Production whole-source timeout for `dataforseo-onpage`: **60 minutes**.
- Whole-source attempts for `dataforseo-onpage`: **1**. A provider task must not be reposted automatically because a broad orchestration retry began.
- On-Page task poll budget: **30 minutes**.
- Existing provider task/recovery identity remains the mechanism for later governed recovery; do not create duplicate provider tasks merely to satisfy a short local timeout.

## 6. Deep representative evidence

The existing important-page selector remains the conversion/business-role selector. Its semantics must not be replaced by programmatic clustering.

The On-Page adapter will merge:

- existing decision-bearing key pages; and
- representative pages from material structural clusters.

The merged set is deterministic and bounded. Deep content parsing budget becomes **up to 20 pages** so business-critical pages and cluster representatives can both receive body-content evidence.

Cluster representatives must receive enough normalized evidence to assess, where available:

- body-content depth;
- repeated/near-duplicate template content;
- page title/H1/description alignment;
- offer/service clarity;
- pricing/reassurance language;
- testimonials, credentials, case-study and policy signals;
- schema/entity signals already returned by the On-Page task;
- internal-link context;
- location/service claim consistency;
- local trust support;
- conversion language and available CTA/form evidence without fabricating interactive behavior that was not actually extracted.

## 7. Programmatic SEO / E-E-A-T analysis contract

PRYSM will add deterministic, non-score-bearing acquisition evidence for likely programmatic/template-scale sections.

The analysis must distinguish:

- `NOT_DETECTED` — enough footprint evidence exists and no material repeated family is found;
- `LIKELY` — structural/template evidence supports a likely programmatic pattern;
- `INSUFFICIENT_EVIDENCE` — footprint or representative content is too incomplete to judge.

For each material cluster, record:

- structural pattern and estimated/discovered size;
- sampled URLs and sample coverage;
- content-depth distribution;
- template/content-similarity signals;
- thin-content signals;
- trust-proof coverage;
- schema/entity signals;
- conversion/offer signals available from collected evidence;
- geographic claim/support status;
- limitations.

### Geographic/entity consistency

A geographic landing page must not receive a negative finding merely because it targets a location.

A concern becomes supportable only when collected evidence shows a material mismatch or weak support, for example:

- the URL/title/H1/body makes a clear Pennsylvania service claim;
- representative content provides little Pennsylvania-specific proof; and/or
- named expert/address/credential evidence materially points to another geography such as Texas without explaining the relationship.

The output should describe this as weak or conflicting **geographic trust alignment**, not fabricate legal or search-engine compliance claims.

Unknown geography remains unknown.

## 8. Normalized evidence additions

The DataForSEO On-Page SourceResult may add these nested evidence objects without changing the current SourceResult top-level contract:

### `siteFootprint`

Expected fields:

- `status`;
- `discoveredUrlCount`;
- `retainedUrlCount`;
- `sitemapDocumentCount`;
- `capped`;
- `clusters`;
- `priorityUrls`;
- `coverage`;
- `limitations`.

### `programmaticSeo`

Expected fields:

- `status`;
- `clusterCount`;
- `assessedClusterCount`;
- `clusters`;
- `limitations`.

`source-result.schema.json` currently allows additional properties inside `evidence`, so no SourceResult schema migration is expected for these nested fields.

`decision-evidence.js` must explicitly hydrate the two new site fields. The current decision-evidence site object does not prohibit additional properties, so no decision-evidence schema migration is expected unless executable contract tests prove otherwise.

## 9. Scoring and report boundary

The new footprint/programmatic/geographic evidence is **not allowed to silently change scoring v4.1.1**.

Current trust/content scoring is site-level and does not model cluster quality or geographic trust alignment. Once the acquisition evidence is proven through deterministic fixtures, scoring impact must be handled as a separate deliberate versioned/calibrated migration.

Likewise, report/Narrative presentation changes occur only after the evidence and any scoring semantics are verified. The acquisition work must first prove that the facts reach persisted normalized and decision evidence correctly.

This separation prevents an uncalibrated score change from masking an acquisition defect.

## 10. Expected application file set

### Track A — SERP reliability

Expected source files:

- `services/worker/src/adapters/dataforseo-serp/dataforseo-serp-client.js`
- `services/worker/src/adapters/dataforseo-serp/serp-adapter.js`
- `services/worker/src/application/production-runtime.js`

Expected verification files:

- existing `services/worker/src/adapters/dataforseo-serp/serp-production-path.test.js` as relevant;
- existing `services/worker/src/adapters/dataforseo-serp/serp-query-failure-aggregation.test.js` as relevant;
- a focused cancellation/retry regression test if the existing files do not cleanly express the contract;
- a focused production source-policy regression proving the governed timeout/attempt values.

Not expected to change: `services/worker/src/orchestration/retry-policy.js`.

### Track B — site-footprint and representative acquisition

Expected new source files:

- `services/worker/src/evidence/sitemap-footprint.js`
- `services/worker/src/evidence/programmatic-seo-analysis.js`

Expected existing source files:

- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-client.js`
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`
- `services/worker/src/application/production-runtime.js`
- `services/worker/src/evidence/decision-evidence.js`

Expected verification files:

- new unit test for `sitemap-footprint.js`;
- new unit test for `programmatic-seo-analysis.js`;
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.test.js`;
- `services/worker/src/evidence/decision-evidence.test.js` and/or the permanent production regression where appropriate;
- source-policy regression for the On-Page 60-minute/one-attempt boundary.

### Track C — downstream decision semantics after acquisition PASS

Reasonably expected later files, but deliberately not edited until the new evidence is proven:

- `services/worker/src/evidence/capability-evidence.js` and tests if cluster evidence changes capability semantics;
- `services/worker/src/scoring/score-components.js` and scoring tests if calibrated score impact is approved;
- Narrative/report files that surface the new evidence after scoring semantics are known.

No scoring version, lifecycle, storage, authentication, n8n, or Viewer contract change is authorized by this specification alone.

## 11. Required tests

Before Track A is complete, tests must prove:

1. caller AbortSignal reaches the actual SERP fetch;
2. local request timeout aborts the fetch rather than merely abandoning its Promise;
3. an aborted attempt cannot overlap a later provider request;
4. 40101 is retained as a task failure and is not blindly retried;
5. transient request retry, when exercised, is sequential and bounded to one retry;
6. completed keyword evidence survives a later keyword failure;
7. supplied competitor evidence survives SERP failure;
8. production SERP policy is one whole-source attempt with the 30-minute safety ceiling.

Before Track B is complete, tests must prove:

1. recursive sitemap-index discovery;
2. same-origin filtering and deterministic deduplication;
3. hard discovery caps are reported rather than hidden;
4. repeat URL families are clustered deterministically;
5. representative selection is deterministic and bounded to 20 priority URLs;
6. small ordinary sites do not get falsely classified as programmatic;
7. a large location/template family is detected as likely template-scale;
8. thin/near-duplicate representative content is surfaced without inferring beyond evidence;
9. geographic support mismatch fixtures such as Pennsylvania target + Texas-only expert/support evidence produce a bounded trust-alignment concern;
10. missing geography stays unknown rather than negative;
11. DataForSEO task payload carries `priority_urls`, `respect_sitemap`, and `return_despite_timeout` correctly;
12. deep content parsing includes both important pages and cluster representatives within the 20-page bound;
13. `siteFootprint` and `programmaticSeo` survive SourceResult → DecisionEvidence hydration;
14. existing DQV-002 and DQV-003 regressions remain green;
15. no scoring change occurs merely because the new acquisition fields exist.

## 12. Implementation order

1. SERP client cancellation and bounded per-keyword request behavior.
2. SERP adapter partial-preservation/non-overlap behavior.
3. Production source policies for SERP and On-Page.
4. Sitemap footprint discovery + deterministic cluster selection.
5. On-Page provider options and representative deep acquisition.
6. Programmatic SEO / trust / geographic analysis.
7. Decision-evidence hydration and integrated acquisition regression.
8. Only after acquisition PASS: evaluate/version capability, scoring, and report reactions.
9. Production provider/audit validation only with explicit user approval.

Each source-file unit follows the governed manual VS Code workflow and is verified before the next source file begins.

## 13. Explicitly out of scope during acquisition implementation

- lifecycle redesign;
- storage redesign;
- authentication;
- n8n;
- Writer/Judge reruns;
- Viewer/page-count changes;
- silent scoring-weight changes;
- exhaustive crawling of thousands of near-duplicate programmatic URLs;
- production audit rerun without explicit approval.

## 14. Pre-edit gate

`REPAIR_BOUNDARY_PROTOCOL.md` Mandatory Pre-Edit Gate: **PASS**.

The user outcome, verified defect boundary, expected source/test set, downstream reactions, timeout/cost implications, implementation order, and out-of-scope systems are now mapped before application-file editing begins.
