# S01 Repair Plan — Executive Scorecard

Section: S01 — Executive Scorecard
Status: COMPLETE — BOUNDED BUILD AUTHORIZED
Date opened: 2026-09-07
Date completed: 2026-09-07
Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md`
Contract: `S01_CONTRACT.md`
Report-wide IA contract: `PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md`
Baseline: `S01_BASELINE_AUDIT.md`
Source-boundary proof: `S01_SOURCE_BOUNDARY_PROOF.md`
Baseline result: `63/100 — FAIL — 2 hard-gate failures`

## Repair objective

Rebuild S01 as a client decision page while preserving the already-correct P1 evidence uncertainty and governed priority order, and migrate the viewer shell to the approved 8-item primary client navigation with supporting technical/evidence detail demoted to a subordinate navigation surface.

This is a presentation/decision-layer repair. It does not authorize new scoring, evidence collection, lifecycle changes, provider/model calls, production mutation, merge, push, or deployment.

## Dominant root cause

The Executive Scorecard exposes internal assessment constructs as peer client outcomes, splits each priority across duplicate problem/action lists, and composes the viewer page from both `executive` and a separate technical `strengths` section. At the report-shell level, all 16 conceptual pages are rendered as peer primary navigation even though half are supporting technical/evidence detail.

## Verified source ownership

Read-only local diagnostic `PRYSM-S01-SOURCE-BOUNDARY.txt` established the exact current intentional dirty P1 seam. Full proof is recorded in `S01_SOURCE_BOUNDARY_PROOF.md`.

Key verified facts:

- `src/report/render-report-v2.js` owns `executiveScorecard(...)`, `REPORT_V2_VIEWER_PAGES`, sidebar generation, viewer config, hash/page activation, and current-page print behavior.
- Executive top-three ordering comes from `buildActionPlan(...).actions.slice(0, 3)`.
- Problem / Why / Action source fields are `finding.title` / `finding.businessImpact` / `finding.recommendation`.
- `VAN-PERF-001` `render-blocking` wording originates in the governed finding recommendation in `score-components.js`; S01 must translate it at executive presentation level rather than mutate the underlying scoring/finding contract.
- the separate `strengthsSection(...)` is produced in `report-detail-sections.js`, imported/rendered by `render-report-v2.js`, and mapped to S01 through `sectionIds: ["executive", "strengths"]`.
- the lowest-risk viewer migration is to preserve 16 addressable conceptual destinations while classifying them into 8 PRIMARY and 8 SUPPORTING destinations and rendering only the PRIMARY set as peer client navigation.

## Approved exact application BUILD boundary

Application code allowed:

1. `src/report/render-report-v2.js`

Application tests allowed as required to encode/verify the approved migration:

2. `src/report/render-report-v2-section-viewer.test.js`
3. `src/report/render-report-v2-conversion.test.js`
4. `src/report/render-report-v2.test.js`
5. `src/report/render-report-v2-sections.test.js`
6. `src/report/karen-style-regression.test.js`
7. `src/report/render-narrative-v2.test.js`

No other application file is authorized in this build. In particular, do not edit `score-components.js`, `action-priority.js`, `report-detail-sections.js`, evidence/scoring contracts, lifecycle/storage, Writer/Judge, or unrelated dirty P1 files unless a new deterministic failure proves an additional seam is required and this plan is reopened first.

## Required implementation

### R1 — Rebuild S01 hierarchy

Render this exact conceptual order:

1. **How ready is your website to convert visitors?**
2. **What should you improve first?**
3. **What is already working well?**
4. **What could we not determine?**
5. **How confident is this assessment?**
6. **Where to find supporting detail**

### R2 — One primary score

- Conversion Readiness is the sole visually primary score.
- Evidence Confidence becomes secondary supporting copy late in the page.
- Evidence Coverage becomes a plain-language limitation statement rather than a peer metric.
- remove client-facing Known/Unknown factor counts, capability counts, module counts, intended-weight percentages, and equivalent mechanics from S01.

### R3 — One ranked top-three priority structure

Render up to three actions from the existing deterministic `buildActionPlan` order.

Each priority must contain together:

- Problem;
- Why it matters;
- Action.

Do not create a second priority list. Do not manufacture filler priorities.

### R4 — Executive plain-language translation

Translate technical finding/action wording deterministically for S01 while preserving evidence scope.

Current required translations include:

- `VAN-PERF-001`
  - Problem: **Main content takes too long to appear on mobile.**
  - Why: plain-language equivalent of mobile friction.
  - Action: bounded summary such as **Reduce the time it takes for the main mobile content to appear, then retest the page.**
  - Do not expose `LCP`, `largest contentful paint`, or `render-blocking` on S01.
- `VAN-TECH-001`
  - use **Search-result descriptions** instead of `meta descriptions`.
- `VAN-CONTENT-002`
  - preserve that FAQ content was not found only within available/assessed scope; do not convert to whole-site absence.

Generic executive fallback copy must also pass the prohibited-language contract.

### R5 — Consolidate positives

- exactly one executive positive section: **What is already working well?**
- retain only supported positives in concise business language.
- S01 must no longer render the separate `What Is Already Good` section.
- remove S01 mapping/render ownership of `strengths`; leave `report-detail-sections.js` itself untouched in this build.

### R6 — Plain coverage statement

For the current TBK scenario, render:

**Assessment coverage: Nearly complete.**

A small part of the assessment could not be completed. Affected findings are marked as uncertain rather than treated as website problems.

For materially different governed coverage states, use a truthful plain-language state rather than forcing `Nearly complete`.

### R7 — Supporting detail pointer

Under **Where to find supporting detail**, point clients to:

- Priority Fixes for ranked action/evidence detail;
- Supporting Evidence / Technical Detail for deeper evidence, technical diagnostics, and limitations.

### R8 — Preserve evidence uncertainty

Executive shortening may not strengthen:

- PARTIAL;
- NOT_ASSESSED;
- unavailable;
- failed;
- blocked;
- not-detected;
- assessed-page-only findings.

No whole-site absence claim may be created from partial/not-detected evidence.

### R9 — Client-first viewer information architecture

Retain the 16 conceptual destinations as addressable viewer pages but classify them into two navigation tiers.

PRIMARY — exactly 8 peer client links in this order:

1. Executive Scorecard
2. Priority Fixes
3. Conversion Journey
4. Content Opportunities
5. Competitor Comparison
6. Trust & Credibility
7. Website Speed & Performance
8. Mobile & Accessibility

SUPPORTING — subordinate under **Supporting Evidence / Technical Detail**:

- Conversion Readiness Detail
- CMS & Platform Detail
- Technical SEO Detail
- Heading & Structure Detail
- Schema & Entity Detail
- Internal-Link Detail
- Supporting Evidence
- Assessment Limitations

Stable viewer `pageId` values should remain unchanged where possible so existing hash routing and traceability remain intact.

All supporting pages must remain reachable, switchable, and printable.

### R10 — Viewer presentation version

This is a material viewer information-architecture change with no evidence/scoring/report-data contract change.

Increment viewer presentation version only:

`2.2.0 -> 2.3.0`

Do not change the report design/data contract solely for this migration.

## Tests-first proof requirement

Before changing implementation behavior:

1. update/extend the authorized focused tests to encode the new S01 + navigation contract;
2. run the focused tests against the old implementation;
3. preserve output proving the intended contract assertions fail for the old implementation;
4. only then edit `render-report-v2.js`;
5. rerun the focused tests to PASS.

Expected migration assertions include:

- exact six-part S01 order;
- one primary score;
- confidence/coverage subordinate;
- max three priorities;
- Problem + Why + Action together;
- governed action order preserved;
- no duplicate priority list;
- exactly one positive section;
- no S01 `What Is Already Good`;
- plain coverage statement;
- supporting-detail pointer;
- prohibited S01 technical/internal terms absent;
- business-language equivalents present;
- uncertainty fail-closed cases preserved;
- conceptual viewer page count remains 16 unless a new proof requires otherwise;
- primary peer navigation count = 8;
- supporting navigation count = 8;
- exact approved labels/order;
- no supporting page exposed as a primary peer;
- all supporting destinations addressable;
- hash navigation/back-forward fallback remains deterministic;
- current-page print/save remains present/functioning;
- legacy v1 16-page approval contracts remain untouched.

## Focused BUILD proof gate

After implementation, run at minimum the authorized affected test files and capture exact pass/fail totals in one TXT outside both repositories.

The build does not advance to broad deterministic audit until:

- focused S01/viewer tests = PASS;
- no unexpected file outside the authorized seam changed;
- `git diff --check` = PASS for the current worktree;
- no provider/model call or production mutation occurred.

## Post-build deterministic audit

After focused BUILD PASS, RSIP advances to `DETERMINISTIC_AUDIT`, where broad gates are run:

1. focused S01 + navigation suite;
2. relevant renderer/viewer regressions;
3. focused P1 regressions;
4. CR-43 with governed hash procedure if deterministic output hashes changed;
5. complete worker suite;
6. `npm run verify:prysm-closure`;
7. Whole-App acceptance where required;
8. `git diff --check`;
9. exact real TBK offline render;
10. S01 human 10–20 second scan review;
11. human navigation review;
12. RSIP score >=95/100 with zero hard failures.

## Deferred observation for S02

The diagnostic shows `VAN-PERF-001` detailed recommendation includes `remove render-blocking work` even though the direct finding evidence shown is slow mobile LCP. S01 will summarize this at a bounded executive level. The underlying detailed recommendation should be re-examined when `S02 — Priority Fixes` becomes ACTIVE; do not broaden the present S01 build to repair S02 early.

## Repair-plan decision

`PASS — COMPLETE`.

The exact local source/test boundary is verified and the bounded S01 BUILD is authorized.

Exact next action: execute the tests-first bounded S01 build using only the authorized files above, preserve an expected pre-implementation failing focused proof, then implement the renderer/viewer repair and return a focused PASS proof for review.