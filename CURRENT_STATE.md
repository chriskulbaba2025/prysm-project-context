# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Complete DQV-001 Track B representative-evidence acquisition. After acquisition semantics pass, return to DQV-005/report review.

## Authoritative repositories

- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Last verified remote application `main` before current local data-quality work: `33ec9b63083f62141141ea6363828c9e8152f188` — `feat(report-v2): add read-only UAT rerender route`.
- Current verified local application HEAD: `d56217d` — `feat(onpage): add representative crawl task policy`.
- Current local DQV work is not yet verified pushed or deployed.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Viewer contract remains Viewer v2.2.0 / 16 governed pages.
- Unrelated untracked local artifacts remain outside DQV scope: `../../lifecycle-failure.txt` and `prysm-v2.2.0-uat.html`.

## Selected validation audit

- Website: `https://rebootbusinesscoaching.com/`
- Audit ID: `97d6b2c7-03b9-4530-8ea7-16557502c638`
- Existing persisted artifacts remain immutable evidence.
- Durable investigation ledger: `REFERENCE/AUDIT_DATA_VALIDATION_97d6b2c7.md`.
- Governing DQV-001 implementation design: `SPECS/ENTERPRISE_EVIDENCE_ACQUISITION_v1.0.0.md`.

## DQV-001 — SERP reliability + enterprise evidence depth

Status: **TRACK A COMPLETE LOCALLY; TRACK B IN PROGRESS LOCALLY.**

### Track A — COMPLETE

Locked reliability contract is implemented and proven locally:

- live SERP fetch gets caller AbortSignal;
- per-request hard ceiling 120 seconds;
- at most one sequential retry for transient transport/timeout/HTTP-5xx failure;
- no PRYSM retry for task-level 40101;
- `dataforseo-serp`: 30-minute safety ceiling, one whole-source attempt;
- supplied competitors and completed keyword evidence survive later individual failures;
- generic retry behavior for other sources remains unchanged.

Local commits:

- `3841fa729c6a232ba45b9a794ae9504c86505f0f` — `fix(serp): make request cancellation cooperative`.
- `6465890daa6beeff96d7ba265c1f804065e603d6` — `fix(serp): preserve partial evidence on cancellation`.
- `b8d3ae404cbea75207d7a75bd2011ea62b122dd5` — `fix(serp): govern composite source policy`.

Track A full SERP/source-policy regression boundary passed 102/102 with no paid provider call.

## Track B — locked large-site representative-evidence design

Required design remains:

- recursively discover public sitemap footprint, bounded to 200 sitemap documents / 100,000 retained URLs;
- deterministic structural URL-family clustering;
- up to 20 representative `priority_urls`;
- DataForSEO OnPage `respect_sitemap: true` where usable sitemap evidence exists;
- DataForSEO OnPage `return_despite_timeout: true`;
- retain default general OnPage crawl cap at 500 while making the sample structurally representative;
- `dataforseo-onpage`: 60-minute whole-source safety ceiling, one whole-source attempt, 30-minute client poll budget;
- merge business-critical important pages with material-cluster representatives for up to 20 deep content-parsing pages;
- add explicit `siteFootprint` and `programmaticSeo` normalized/decision evidence;
- assess thin/near-duplicate content, conversion/offer, trust/E-E-A-T, schema/entity and geographic trust without fabricating unknowns.

Scoring v4.1.1 must not change silently. Capability/scoring/report reactions follow only after acquisition evidence is proven and require deliberate versioned/calibrated work.

### Track B completed local units

#### 1. Sitemap footprint — COMPLETE

Files:

- `src/evidence/sitemap-footprint.js`
- `src/evidence/sitemap-footprint.test.js`

Implemented:

- recursive sitemap/sitemap-index discovery;
- robots.txt sitemap directives plus standard sitemap fallbacks;
- same-origin filtering;
- deterministic canonicalization/deduplication;
- explicit 200-document / 100,000-retained-URL caps and incomplete coverage;
- deterministic structural URL-family clustering;
- deterministic representative selection bounded to 20 URLs;
- fail-soft unavailable semantics that never treat missing sitemap evidence as proof of no programmatic SEO.

Verification:

- syntax PASS;
- focused no-network tests PASS 5/5;
- staged diff check PASS.

Local commit:
`9257317` — `feat(evidence): add representative sitemap footprint discovery`.

#### 2. Programmatic SEO analysis — COMPLETE

Files:

- `src/evidence/programmatic-seo-analysis.js`
- `src/evidence/programmatic-seo-analysis.test.js`

Implemented:

- `NOT_DETECTED` / `LIKELY` / `INSUFFICIENT_EVIDENCE` semantics;
- large repeated/template-family assessment without equating scale with poor quality;
- thin-content and near-duplicate representative evidence;
- trust/proof, schema/entity and conversion/offer evidence;
- bounded geographic trust alignment;
- unknown geography remains unknown;
- deterministic output.

Verification:

- Track B evidence regressions PASS 12/12;
- staged diff check PASS.

Local commit:
`fe408dd` — `feat(evidence): add programmatic SEO analysis`.

#### 3. DataForSEO OnPage client policy — COMPLETE

Files:

- `src/adapters/dataforseo-onpage/dataforseo-onpage-client.js`
- `src/adapters/dataforseo-onpage/dataforseo-onpage-client-policy.test.js`
- existing `src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.test.js` migrated from the obsolete paid-task retry expectation to the governed single-submit contract.

Implemented:

- deterministic deduplicated `priority_urls`, capped at 20;
- `respect_sitemap` task option;
- `return_despite_timeout: true` default;
- 30-minute main OnPage client poll policy;
- paid `task_post` is single-submit so transport uncertainty cannot automatically create a duplicate paid provider task.

A first regression run produced 74/75 PASS because one legacy adapter test still required automatic retries of `task_post`. That test contradicted the governed paid-task idempotency contract and was migrated. Final focused OnPage regression boundary passed **75/75**.

Local amended commit:
`d56217d` — `feat(onpage): add representative crawl task policy`.

No paid provider call was used.

### Track B remaining integration

Still required:

1. DataForSEO OnPage adapter integration:
   - accept/forward representative `priorityUrls` and sitemap policy to the client;
   - preserve existing paid-task resume/idempotency behavior;
   - deep content-parsing set must merge business-critical important pages with material sitemap-cluster representatives, bounded to 20;
   - expose/preserve site-footprint/programmatic-analysis acquisition evidence for runtime normalization.
2. Production runtime integration:
   - discover sitemap footprint before OnPage acquisition where the locked source boundary requires it;
   - feed deterministic representative acquisition inputs to OnPage;
   - `dataforseo-onpage` whole-source safety ceiling 60 minutes / one whole-source attempt;
   - preserve source independence and existing non-OnPage retry policies.
3. Decision-evidence integration:
   - expose explicit `siteFootprint` and `programmaticSeo` evidence with correct unavailable/partial semantics;
   - do not change scoring v4.1.1 silently.
4. Full no-network/focused regression boundary for Track B.
5. Only after Track B acquisition semantics pass, return to DQV-005/report status propagation.

## DQV-002 — On-Page content parsing normalization

Status: **VERIFIED AND COMMITTED LOCALLY; NOT YET VERIFIED PUSHED/DEPLOYED.**

- Root cause: normalizer stopped at `res.result` instead of `res.result.items[0].page_content` and read obsolete fields.
- Repair retained provider body content, excluded header/footer, preserved older fixtures.
- Production-shaped no-network diagnostic PASS.
- Targeted adapter suite PASS 68/68.
- Local commit: `82a9f84f8c96bcd44a3b307abe024442d1903336`.

## DQV-003 — Microdata provider contract

Status: **VERIFIED AND COMMITTED LOCALLY; NOT YET VERIFIED PUSHED/DEPLOYED.**

- Root cause: microdata request omitted required page URL.
- Repair posts task ID + deterministic key-page URL.
- Targeted adapter suite PASS 69/69.
- Local commit: `10bf22cb7f9ad74183fa626fcc696fd86e6a34e1`.
- No paid provider call or production audit rerun used.

## DQV-004 — seven-page crawl

Status: **NOT CURRENTLY PROVEN DEFECTIVE.**

- max crawl pages 500;
- pages_crawled 7;
- crawl_stop_reason `empty_queue`;
- pages_in_queue 0;
- extended_crawl_status `no_errors`.

Large-site representative acquisition is a forward enterprise requirement, not retroactive proof that this specific crawl was defective.

## DQV-005 — report status propagation

Status: **PROVEN; DEFERRED UNTIL DQV-001 ACQUISITION SEMANTICS PASS.**

- canonical competitor source: `FAILED`;
- report layer represented it as `NOT_APPLICABLE` / `NOT_CONNECTED`.

## Active operating rules

- GitHub context is authoritative durable memory.
- At substantive chat start, read `PROJECT.md`, `GITHUB_PROJECT_MEMORY_PROTOCOL.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `CURRENT_STATE.md`, active `CONSTRAINTS.md`, and active `DECISIONS.md`.
- DQV-001 Mandatory Pre-Edit Gate has passed; do not reopen design unless genuinely new evidence materially changes the boundary.
- Application changes use the governed Desktop repository at `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Manual editing remains user-applied; do not directly modify the application repo through tools.
- Accelerated workflow: collect the complete current local files for the next coherent integration boundary, design all already-approved changes across that boundary, return complete coherent file changes, then use one combined syntax/test/diff/commit verification block rather than conversational micro-steps.
- Do not make the user repeatedly edit the same file for requirements already known.
- Project-wide three-attempt diagnostic reset remains active.
- Source code is delivered directly in conversation, never as generated/downloadable code files.
- No application remote write/push, merge, deployment, production audit rerun, provider/model rerun, or persisted-artifact mutation without explicit approval.
- Existing selected-audit artifacts remain immutable.
- Do not broaden acquisition implementation into unrelated lifecycle, storage, authentication, n8n, Writer/Judge, Viewer, or uncalibrated scoring changes.

## Exact next action

Continue DQV-001 Track B from local application HEAD `d56217d`.

To avoid piecemeal edits, collect the complete current local versions of both:

- `src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`
- `src/application/production-runtime.js`

Then design the remaining approved OnPage adapter/runtime representative-acquisition integration as one coherent boundary, while still applying each file once. Include focused no-network regressions and one consolidated verification block. Preserve existing paid-task resume/idempotency behavior. Do not make a paid provider call, push, deploy, rerun the production audit, or mutate persisted artifacts.

Last verified:
2026-08-24
