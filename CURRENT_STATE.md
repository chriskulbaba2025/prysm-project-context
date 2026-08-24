# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Complete DQV-001 Track A source-policy wiring, then implement the locked Track B representative-evidence acquisition design. After acquisition semantics pass, return to DQV-005/report review.

## Authoritative repositories

- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Last verified remote application `main` before current local data-quality work: `33ec9b63083f62141141ea6363828c9e8152f188` — `feat(report-v2): add read-only UAT rerender route`.
- Current verified local application HEAD: `6465890daa6beeff96d7ba265c1f804065e603d6`.
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

Status: **PRE-EDIT GATE PASS; TRACK A IMPLEMENTATION ACTIVE.**

Verified historical defect:

- persisted competitor/SERP source `FAILED` after retryCount 2 with no raw SERP artifact;
- full current isolated adapter completed in 43.51s as `PARTIAL`, preserving 3/3 supplied competitors and 58 SERP results while one keyword returned DataForSEO 40101;
- 60-second whole-source timeout can erase already-valid in-memory evidence;
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
- generic `retry-policy.js` is not expected to change.

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
- focused combined contract at this step PASS 31/31;
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

A temporary false hang (~114 seconds) was diagnosed without code churn: the updated adapter had been saved in a duplicate Downloads repo while the governed Desktop repo still had v1.1.0. The verified v1.2.0 file was copied into the Desktop repo; the adapter test then passed 3/3 in ~0.4 seconds. Future file creation/editing must confirm the Desktop governed path before testing.

### Track A remaining source-file unit

`services/worker/src/application/production-runtime.js`

Required change only:

- set whole `dataforseo-serp` source timeout to **30 minutes**;
- set whole-source attempts to **1**;
- add/adjust focused source-policy regression proving those exact values;
- do not modify generic retry policy unless new evidence proves necessary.

Track A is not complete until this source-policy unit passes.

## Track B — locked large-site representative-evidence design

After Track A PASS:

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
- Before testing or copying a manually edited file, verify it is under `C:\Users\kulba\Desktop\vantage-platform\services\worker`; a duplicate Downloads repository exists and must not be treated as authoritative.
- Project-wide three-attempt diagnostic reset remains active.
- Source code is delivered directly in conversation, never as generated/downloadable code files.
- No application remote write/push, merge, deployment, production audit rerun, provider/model rerun, or persisted-artifact mutation without explicit approval.
- Existing selected-audit artifacts remain immutable.
- Do not broaden acquisition implementation into unrelated lifecycle, storage, authentication, n8n, Writer/Judge, Viewer, or uncalibrated scoring changes.

## Exact next action

Start DQV-001 Track A source-file unit 3.

From `C:\Users\kulba\Desktop\vantage-platform\services\worker`:

1. verify `git rev-parse HEAD` is `6465890daa6beeff96d7ba265c1f804065e603d6`;
2. open and paste the complete exact Desktop-repo `src\application\production-runtime.js`;
3. change only the `dataforseo-serp` whole-source policy to a **30-minute timeout / one attempt** and add/adjust the focused no-network policy regression;
4. syntax check, run focused policy + SERP regressions, inspect diff, then commit only if clean.

Do not make a paid provider call during this step.

Last verified:
2026-08-23
