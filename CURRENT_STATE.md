# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Implement the locked DQV-001 Track B representative-evidence acquisition design. After acquisition semantics pass, return to DQV-005/report review.

## Authoritative repositories

- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Last verified remote application `main` before current local data-quality work: `33ec9b63083f62141141ea6363828c9e8152f188` — `feat(report-v2): add read-only UAT rerender route`.
- Current verified local application HEAD: `b8d3ae404cbea75207d7a75bd2011ea62b122dd5`.
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

Status: **PRE-EDIT GATE PASS; TRACK A COMPLETE LOCALLY; TRACK B NEXT.**

Verified historical defect:

- persisted competitor/SERP source `FAILED` after retryCount 2 with no raw SERP artifact;
- full isolated adapter completed in 43.51s as `PARTIAL`, preserving 3/3 supplied competitors and 58 SERP results while one keyword returned DataForSEO 40101;
- 60-second whole-source timeout could erase already-valid in-memory evidence;
- orchestration AbortSignal did not reach the SERP HTTP fetch;
- shared 45-second `withTimeout()` did not cancel the underlying fetch;
- whole-source retries could overlap abandoned paid requests and repeat completed work.

### Track A locked reliability contract

- live SERP fetch gets caller AbortSignal;
- per-request hard ceiling 120 seconds;
- at most one sequential retry for transient transport/timeout/HTTP-5xx failure;
- no PRYSM retry for task-level 40101;
- `dataforseo-serp`: 30-minute safety ceiling, one whole-source attempt;
- preserve supplied competitors and completed keyword evidence across later individual failures;
- generic `retry-policy.js` remains unchanged.

### Track A completed source-file units

#### 1. `dataforseo-serp-client.js` — COMPLETE

Implemented:

- caller AbortSignal reaches the actual live fetch;
- request-local AbortController enforces 120-second default ceiling;
- timeout aborts the underlying fetch rather than abandoning it with Promise.race;
- one sequential transient retry maximum;
- caller cancellation prevents any later request;
- HTTP 5xx may retry once;
- DataForSEO task-level failures including 40101 are terminal for that keyword.

Verification:

- client syntax PASS;
- existing SERP regressions PASS 26/26;
- new client cancellation/retry contract PASS 5/5;
- focused combined contract PASS 31/31;
- `git diff --check` PASS apart from informational Windows LF→CRLF warning.

Local commit:
`3841fa729c6a232ba45b9a794ae9504c86505f0f` — `fix(serp): make request cancellation cooperative`.

#### 2. `serp-adapter.js` — COMPLETE

Implemented:

- orchestration signal is passed into every `querySerp()` call;
- no new keyword request begins after caller cancellation;
- completed keyword evidence survives a later task failure or cancellation;
- supplied competitor evidence remains preserved;
- graceful PARTIAL/FAILED outcomes retain raw artifact evidence;
- adapter version advanced to `1.2.0`.

Verification:

- adapter syntax PASS;
- new adapter cancellation/preservation contract PASS 3/3;
- full focused SERP suite PASS 34/34;
- `git diff --check` PASS apart from informational Windows LF→CRLF warning.

Local commit:
`6465890daa6beeff96d7ba265c1f804065e603d6` — `fix(serp): preserve partial evidence on cancellation`.

A temporary false hang (~114 seconds) was traced to a duplicate Downloads repo while the governed Desktop repo still had v1.1.0. The governed Desktop file was corrected and the adapter test passed 3/3 in ~0.4 seconds.

#### 3. `production-runtime.js` source policy — COMPLETE

Implemented:

- `dataforseo-serp` default whole-source timeout changed from 60 seconds to **1,800,000 ms / 30 minutes**;
- `dataforseo-serp` whole-source attempts changed from 3 to **1**;
- generic retry behavior for other sources remains unchanged;
- new no-network `production-runtime-source-policy.test.js` proves the exact policy;
- stale supplied-competitor regression contract was updated from adapter v1.1.0 to the already-governed v1.2.0.

Verification:

- runtime syntax PASS;
- focused source-policy test PASS 1/1;
- full SERP + source-policy regression boundary PASS **102/102**;
- `git diff --check` PASS;
- staged diff contained only the governed policy/test changes;
- no paid provider call was used.

Local commit:
`b8d3ae404cbea75207d7a75bd2011ea62b122dd5` — `fix(serp): govern composite source policy`.

During this unit, an initial edit was made from the wrong VS Code repository (`vantage-platform-main`). The contaminated governed-file replacement was detected from the diff, restored to HEAD, and then reapplied from the exact Desktop-repo file. Final commit is clean. Future file editing must confirm the governed Desktop repository before copying/testing.

### Track A result

**PASS.** All eight locked reliability requirements are proven by local no-network/focused regressions. Track A is committed locally but not verified pushed or deployed.

## Track B — locked large-site representative-evidence design

Next implementation phase:

- recursively discover public sitemap footprint, bounded to 200 sitemap documents / 100,000 retained URLs;
- deterministic structural URL-family clustering;
- up to 20 representative `priority_urls`;
- use DataForSEO `respect_sitemap: true` and `return_despite_timeout: true` where applicable;
- retain default general On-Page crawl cap at 500 but make the sample structurally representative;
- `dataforseo-onpage`: 60-minute safety ceiling, one whole-source attempt, 30-minute poll budget;
- merge business-critical important pages with material cluster representatives for up to 20 deep content-parsing pages;
- add explicit `siteFootprint` and `programmaticSeo` normalized/decision evidence;
- assess thin/near-duplicate content, offer/conversion signals available from collected evidence, trust/E-E-A-T, schema/entity evidence, and geographic trust alignment without fabricating unknowns.

Scoring v4.1.1 must not change silently. Any capability/scoring/report reaction follows only after acquisition evidence is proven and requires deliberate versioned/calibrated work.

Expected Track B source-file set remains governed by `SPECS/ENTERPRISE_EVIDENCE_ACQUISITION_v1.0.0.md`, beginning with new `services/worker/src/evidence/sitemap-footprint.js`.

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
- `git diff --check` PASS.
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
- Application changes proceed through the governed manual VS Code workflow, one verified source-file unit at a time.
- For each file, apply every already-approved change belonging to that file in one coherent replacement whenever safely possible.
- Do not make the user repeatedly edit the same file for requirements already known.
- Before testing or copying a manually edited file, verify it is under `C:\Users\kulba\Desktop\vantage-platform\services\worker`; duplicate repositories must not be treated as authoritative.
- Project-wide three-attempt diagnostic reset remains active.
- Source code is delivered directly in conversation, never as generated/downloadable code files.
- No application remote write/push, merge, deployment, production audit rerun, provider/model rerun, or persisted-artifact mutation without explicit approval.
- Existing selected-audit artifacts remain immutable.
- Do not broaden acquisition implementation into unrelated lifecycle, storage, authentication, n8n, Writer/Judge, Viewer, or uncalibrated scoring changes.

## Exact next action

Start DQV-001 Track B source-file unit 1 from local application HEAD `b8d3ae404cbea75207d7a75bd2011ea62b122dd5`.

From `C:\Users\kulba\Desktop\vantage-platform\services\worker`:

1. verify `git rev-parse HEAD` is `b8d3ae404cbea75207d7a75bd2011ea62b122dd5`;
2. begin the new `src\evidence\sitemap-footprint.js` unit under the already-approved Track B contract;
3. implement recursive sitemap/sitemap-index discovery, same-origin filtering, deterministic deduplication, 200-document / 100,000-URL caps, deterministic structural clustering inputs, explicit capped/incomplete coverage, and deterministic representative selection bounded to 20 priority URLs;
4. add the focused no-network unit regression for this new source-file unit and verify syntax/tests/diff before moving to `programmatic-seo-analysis.js`.

Do not make a paid provider call, push, deploy, rerun the production audit, or mutate persisted artifacts during this step.

Last verified:
2026-08-23
