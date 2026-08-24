# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Complete the final DQV-001 Track B downstream decision-evidence propagation. After acquisition semantics pass end-to-end, return to DQV-005/report review.

## Authoritative repositories

- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Last verified remote application `main` before current local data-quality work: `33ec9b63083f62141141ea6363828c9e8152f188` — `feat(report-v2): add read-only UAT rerender route`.
- Current verified local application HEAD: `2f15bab` — `feat(onpage): integrate representative site evidence`.
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

Status: **TRACK A COMPLETE LOCALLY; TRACK B ACQUISITION/RUNTIME INTEGRATION COMPLETE LOCALLY; DECISION-EVIDENCE PROPAGATION NEXT.**

### Track A — COMPLETE

Local commits:

- `3841fa729c6a232ba45b9a794ae9504c86505f0f` — `fix(serp): make request cancellation cooperative`.
- `6465890daa6beeff96d7ba265c1f804065e603d6` — `fix(serp): preserve partial evidence on cancellation`.
- `b8d3ae404cbea75207d7a75bd2011ea62b122dd5` — `fix(serp): govern composite source policy`.

Track A full SERP/source-policy regression boundary passed 102/102 with no paid provider call.

## Track B — locked representative-evidence design

Required design:

- recursive sitemap/sitemap-index discovery bounded to 200 documents / 100,000 retained URLs;
- deterministic structural URL-family clustering;
- up to 20 representative `priority_urls`;
- DataForSEO OnPage `respect_sitemap: true` when usable sitemap evidence exists;
- `return_despite_timeout: true`;
- retain general OnPage crawl cap at 500;
- OnPage 30-minute provider poll budget;
- OnPage 60-minute whole-source safety ceiling;
- exactly one whole-source attempt;
- merge business-critical pages with material cluster representatives for up to 20 deep content-parsing pages;
- expose explicit `siteFootprint` and `programmaticSeo` evidence;
- never infer absence from unavailable evidence;
- scoring v4.1.1 remains unchanged unless deliberately versioned/calibrated later.

### Completed local Track B units

#### 1. Sitemap footprint — COMPLETE

Files:
- `src/evidence/sitemap-footprint.js`
- `src/evidence/sitemap-footprint.test.js`

Local commit:
`9257317` — `feat(evidence): add representative sitemap footprint discovery`.

Focused tests: 5/5 PASS.

#### 2. Programmatic SEO analysis — COMPLETE

Files:
- `src/evidence/programmatic-seo-analysis.js`
- `src/evidence/programmatic-seo-analysis.test.js`

Local commit:
`fe408dd` — `feat(evidence): add programmatic SEO analysis`.

Combined evidence tests: 12/12 PASS.

#### 3. DataForSEO OnPage client policy — COMPLETE

Files:
- `src/adapters/dataforseo-onpage/dataforseo-onpage-client.js`
- `src/adapters/dataforseo-onpage/dataforseo-onpage-client-policy.test.js`
- migrated existing paid-task retry regression in `dataforseo-onpage-adapter.test.js` to the governed single-submit contract.

Implemented:
- deduplicated/capped `priority_urls` up to 20;
- `respect_sitemap`;
- `return_despite_timeout: true`;
- 30-minute poll budget;
- paid `task_post` single-submit behavior.

Local amended commit:
`d56217d` — `feat(onpage): add representative crawl task policy`.

Focused OnPage regression: 75/75 PASS.

#### 4. OnPage adapter + production runtime integration — COMPLETE

Files changed:
- `src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`
- `src/adapters/dataforseo-onpage/dataforseo-onpage-representative-evidence.test.js`
- `src/application/production-runtime.js`
- `src/application/production-runtime-source-policy.test.js`
- `src/application/production-runtime-onpage-policy.test.js`

Implemented:
- adapter version advanced to 1.3.0;
- sitemap footprint discovery integrated into OnPage acquisition;
- representative `priority_urls` and sitemap policy forwarded to the client;
- deep content-parsing set merges business-critical pages with material structural-family representatives, bounded to 20;
- `siteFootprint` and `programmaticSeo` preserved in normalized adapter evidence/raw artifact path;
- OnPage default poll budget is 30 minutes;
- production whole-source OnPage safety ceiling is 60 minutes;
- OnPage whole-source attempts = 1;
- SERP whole-source policy remains 30 minutes / 1 attempt;
- non-SERP/non-OnPage retry policy remains unchanged;
- existing paid-task resume/idempotency behavior preserved.

Verification:
- integrated no-network/focused regression boundary PASS **92/92**;
- `git diff --check` PASS;
- no paid provider call used;
- no push/deploy/production audit rerun performed.

Local commit:
`2f15bab` — `feat(onpage): integrate representative site evidence`.

## Track B remaining work

Only the downstream decision-evidence propagation unit remains before DQV-001 Track B can be considered acquisition-semantics complete:

1. update `src/evidence/decision-evidence.js` so `siteFootprint` and `programmaticSeo` survive into canonical decision evidence with correct AVAILABLE/PARTIAL/UNAVAILABLE semantics;
2. add focused no-network regressions proving unavailable sitemap evidence cannot become `NOT_DETECTED` programmatic SEO and that available representative evidence survives normalization;
3. run the integrated Track B regression boundary;
4. do not change scoring v4.1.1 in this unit.

After that, return to DQV-005/report status propagation.

## DQV-002 — On-Page content parsing normalization

Status: **VERIFIED AND COMMITTED LOCALLY; NOT YET VERIFIED PUSHED/DEPLOYED.**

Local commit: `82a9f84f8c96bcd44a3b307abe024442d1903336`.
Targeted adapter suite: 68/68 PASS.

## DQV-003 — Microdata provider contract

Status: **VERIFIED AND COMMITTED LOCALLY; NOT YET VERIFIED PUSHED/DEPLOYED.**

Local commit: `10bf22cb7f9ad74183fa626fcc696fd86e6a34e1`.
Targeted adapter suite: 69/69 PASS.

## DQV-004 — seven-page crawl

Status: **NOT CURRENTLY PROVEN DEFECTIVE.**

- max crawl pages 500;
- pages_crawled 7;
- crawl_stop_reason `empty_queue`;
- pages_in_queue 0;
- extended_crawl_status `no_errors`.

## DQV-005 — report status propagation

Status: **PROVEN; DEFERRED UNTIL DQV-001 ACQUISITION SEMANTICS PASS.**

- canonical competitor source: `FAILED`;
- report layer represented it as `NOT_APPLICABLE` / `NOT_CONNECTED`.

## Active operating rules

- GitHub context is authoritative durable memory.
- At substantive chat start, read `PROJECT.md`, `GITHUB_PROJECT_MEMORY_PROTOCOL.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `CURRENT_STATE.md`, active `CONSTRAINTS.md`, and active `DECISIONS.md`.
- Application changes use the governed Desktop repository at `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Manual editing remains user-applied; do not directly modify the application repo through tools.
- Manual source-edit instructions must provide exact file path, exact start/end line references, start/end anchor text, complete replacement code, and bottom-up ordering when multiple edits in one file could shift later line numbers.
- Use one consolidated syntax/test/diff/commit block after coherent edits rather than conversational micro-steps.
- Do not make the user repeatedly edit the same file for requirements already knowable.
- Project-wide three-attempt diagnostic reset remains active.
- Source code is delivered directly in conversation, never as generated/downloadable code files.
- No application remote write/push, merge, deployment, production audit rerun, provider/model rerun, or persisted-artifact mutation without explicit approval.
- Existing selected-audit artifacts remain immutable.
- Do not broaden acquisition implementation into unrelated lifecycle, storage, authentication, n8n, Writer/Judge, Viewer, or uncalibrated scoring changes.

## Exact next action

Continue DQV-001 Track B from local application HEAD `2f15bab`.

Obtain the complete current local file:

- `src/evidence/decision-evidence.js`

Then implement the final decision-evidence propagation unit in one pass, with exact bottom-up line/anchor instructions and focused no-network regressions. Preserve scoring v4.1.1 unchanged.

Do not make a paid provider call, push, deploy, rerun the production audit, or mutate persisted artifacts.

Last verified:
2026-08-24
