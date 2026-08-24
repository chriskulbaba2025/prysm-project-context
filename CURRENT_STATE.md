# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Implement the verified DQV-001 acquisition repair and enterprise representative-evidence upgrade, then verify downstream evidence semantics before returning to DQV-005/report review.

## Authoritative repositories

- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Last verified remote application `main` before current local data-quality work: `33ec9b63083f62141141ea6363828c9e8152f188` — `feat(report-v2): add read-only UAT rerender route`.
- Current verified local application `main`: `10bf22cb7f9ad74183fa626fcc696fd86e6a34e1` — `fix(onpage): send page URL with microdata request`.
- DQV-002 and DQV-003 local commits have not yet been verified as pushed or deployed.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Viewer contract remains Viewer v2.2.0 / 16 governed pages.

## Selected validation audit

- Website: `https://rebootbusinesscoaching.com/`
- Audit ID: `97d6b2c7-03b9-4530-8ea7-16557502c638`
- Existing persisted artifacts remain immutable evidence.
- Durable investigation ledger: `REFERENCE/AUDIT_DATA_VALIDATION_97d6b2c7.md`.
- Governing DQV-001 implementation design: `SPECS/ENTERPRISE_EVIDENCE_ACQUISITION_v1.0.0.md`.

## DQV-001 — SERP reliability + enterprise evidence depth

Status: **PRE-EDIT GATE PASS; IMPLEMENTATION ACTIVE.**

Verified historical defect:

- persisted competitor/SERP source `FAILED` after retryCount 2 with no raw SERP artifact;
- full current isolated adapter completed in 43.51s as `PARTIAL`, preserving 3/3 supplied competitors and 58 SERP results while one keyword returned DataForSEO 40101;
- 60-second whole-source timeout can erase already-valid in-memory evidence;
- orchestration AbortSignal does not reach the SERP HTTP fetch;
- shared 45-second `withTimeout()` does not cancel the underlying fetch;
- whole-source retries can overlap abandoned paid requests and repeat completed work.

Locked Track A reliability design:

- live SERP fetch gets caller AbortSignal;
- per-request hard ceiling 120 seconds;
- at most one sequential retry for transient transport/timeout/HTTP-5xx failure;
- no PRYSM retry for task-level 40101;
- `dataforseo-serp`: 30-minute safety ceiling, one whole-source attempt;
- preserve supplied competitors and completed keyword evidence across later individual failures;
- generic `retry-policy.js` is not expected to change.

Locked Track B large-site design:

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

Expected file/test set and complete regression contract are recorded in `SPECS/ENTERPRISE_EVIDENCE_ACQUISITION_v1.0.0.md` and the audit-data ledger.

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
- Application changes now proceed through the governed manual VS Code workflow, one verified source-file unit at a time.
- For each file, apply every already-approved change belonging to that file in one coherent replacement whenever safely possible.
- Do not make the user repeatedly edit the same file for requirements already known now.
- Project-wide three-attempt diagnostic reset remains active.
- Open exact files from the active PowerShell working path when local/duplicate-file ambiguity exists.
- Source code is delivered directly in conversation, never as generated/downloadable code files.
- No application remote write/push, merge, deployment, production audit rerun, provider/model rerun, or persisted-artifact mutation without explicit approval.
- Existing selected-audit artifacts remain immutable.
- Do not broaden acquisition implementation into unrelated lifecycle, storage, authentication, n8n, Writer/Judge, Viewer, or uncalibrated scoring changes.

## Exact next action

Begin DQV-001 Track A, source-file unit 1. From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, verify application HEAD remains `10bf22cb7f9ad74183fa626fcc696fd86e6a34e1` and obtain the complete exact local current `src\adapters\dataforseo-serp\dataforseo-serp-client.js`. Apply the complete client-level AbortSignal + 120-second request-timeout + bounded transient-retry behavior in that one file, then run syntax and focused no-network regression verification before moving to `serp-adapter.js`.

Do not make a paid provider call during this step.

Last verified:
2026-08-23
