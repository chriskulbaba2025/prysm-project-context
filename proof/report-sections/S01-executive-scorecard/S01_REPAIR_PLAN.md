# S01 Repair Plan — Executive Scorecard

Section: S01 — Executive Scorecard
Status: IN PROGRESS — SOURCE BOUNDARY VERIFICATION REQUIRED
Date opened: 2026-09-07
Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md`
Contract: `S01_CONTRACT.md`
Report-wide IA contract: `PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md`
Baseline: `S01_BASELINE_AUDIT.md`
Baseline result: `63/100 — FAIL — 2 hard-gate failures`

## Repair objective

Rebuild S01 as a client decision page while preserving the already-correct P1 evidence uncertainty and governed priority order, and migrate the viewer shell to the approved 8-item primary client navigation with supporting technical/evidence detail demoted to a subordinate navigation surface.

This is a presentation/decision-layer repair. It does not authorize new scoring, evidence collection, lifecycle changes, provider/model calls, production mutation, merge, or deployment.

## Dominant root cause

The Executive Scorecard still exposes multiple internal assessment constructs as peer client outcomes and composes the viewer page from both the `executive` and separate `strengths` sections. Priority meaning is also split across two separate lists instead of presenting one ranked client action object with Problem -> Why it matters -> Action.

At the report-shell level, the 16-page navigation also mixes client decisions with audit mechanics, causing technical/evidence pages to compete with conversion-oriented destinations.

## Baseline defect -> required repair -> proof map

### D1 — Wrong executive hierarchy

Observed problem:
- Executive verdict -> three peer score blocks -> root-cause list -> action list -> positives -> partial-weight note -> navigation -> separate strengths section.

Required repair:
- Render the approved six-part hierarchy exactly:
  1. How ready is your website to convert visitors?
  2. What should you improve first?
  3. What is already working well?
  4. What could we not determine?
  5. How confident is this assessment?
  6. Where to find supporting detail

Proof:
- deterministic heading/order assertions;
- actual TBK render review.

### D2 — Conversion Readiness / Evidence Confidence / Evidence Coverage are peer scores

Observed problem:
- `74/100`, `95/100`, and `93%` use the same three-column score treatment.

Required repair:
- Conversion Readiness remains the sole primary score.
- Evidence confidence becomes short subordinate supporting information late in the page.
- Evidence coverage becomes the approved limitation statement, not a peer score.

Proof:
- one primary score assertion;
- prohibited peer-metric/internal-mechanics assertions;
- visual review.

### D3 — Three priorities are split across duplicate lists

Observed problem:
- `What is really holding the site back?` supplies problem/reason.
- `What should you do first?` supplies problem/action.

Required repair:
- render up to three ranked priority cards/rows from the governed action hierarchy;
- each contains Problem, Why it matters, Action together;
- preserve governed rank order;
- render fewer than three if fewer than three supported actions exist.

Proof:
- exact max-three assertion;
- required three fields per rendered priority;
- order parity against governed action hierarchy;
- no second executive priority list.

### D4 — Technical/machine language on executive page

Observed problem includes:
- largest contentful paint / LCP;
- render-blocking;
- partial assessment;
- meta descriptions;
- evidence capabilities;
- modules assessed;
- intended dimension weight;
- browser conversion validation;
- certificate-validation detail;
- json_ld;
- supporting capability.

Required repair:
- deterministic client-facing translation for S01 only;
- preserve technical evidence in later report sections;
- examples required by contract:
  - LCP finding -> `Main content takes too long to appear on mobile.`
  - meta-description finding -> `Search-result descriptions.`
- FAQ wording must remain bounded and must not become whole-site absence.

Proof:
- prohibited-term assertions scoped to S01;
- required business-language assertions;
- uncertainty counterexamples.

### D5 — Duplicate positive sections

Observed problem:
- `What Is Already Working` inside `executive` plus separate `What Is Already Good` section on the same viewer page.

Required repair:
- one section only: `What is already working well?`
- consolidate supported positive findings into concise client language;
- remove S01 exposure of the separate `strengths` section or otherwise prevent duplicate positive rendering on the Executive Scorecard;
- do not delete supporting evidence needed elsewhere unless the exact current source boundary proves it is safe.

Proof:
- exactly one positive-section assertion on S01;
- old `What Is Already Good` heading absent from S01;
- supported positives retained without audit mechanics.

### D6 — Limitation wording exposes weighting mechanics

Observed problem:
- `PARTIAL: 93% of intended dimension weight was assessed.`

Required repair:
- replace with the approved client statement when applicable:

  **Assessment coverage: Nearly complete.**
  A small part of the assessment could not be completed. Affected findings are marked as uncertain rather than treated as website problems.

- preserve Client Truth uncertainty; do not imply complete assessment.

Proof:
- required statement assertion for the current TBK scenario;
- partial/unavailable counterexample tests;
- prohibited weighting-mechanics assertion.

### D7 — Supporting-detail pointer is directionally correct but outside approved hierarchy

Observed problem:
- current `Where to go next` pointer is useful but not contract-labelled.

Required repair:
- retain useful direction to Priority Fixes and deeper evidence under `Where to find supporting detail`;
- technical/evidence destinations must route through the subordinate Supporting Evidence / Technical Detail surface where appropriate.

Proof:
- required heading and destination/pointer assertion;
- supporting-detail navigation resolution test.

### D8 — Preserve current evidence-integrity strengths

Observed good behaviour:
- FAQ not-detected statement remains bounded to available partial assessment.
- search-description absence remains bounded to assessed pages.
- unassessed pages remain unknown.

Required repair:
- executive simplification must not strengthen these claims.
- if the client-facing translation shortens wording, uncertainty must remain explicit wherever it materially changes meaning.

Proof:
- PARTIAL / NOT_ASSESSED / not-detected adversarial cases;
- no unsupported whole-site absence;
- Client Truth parity tests.

### D9 — LCP implementation action requires evidence trace

Observed concern:
- S01 says `remove render-blocking work`, while the executive page itself does not establish that specific root cause.

Required repair:
- during exact local source verification, trace the action to its governed evidence/action object.
- if that root cause is not directly supported, replace it with a bounded client action that follows the governed action hierarchy without inventing implementation diagnosis.

Proof:
- evidence/action lineage identified before build;
- client action remains supported by governed evidence.

### D10 — 16-page primary navigation mixes client decisions with audit mechanics

Observed problem:
- current viewer primary navigation exposes all 16 conceptual pages as peers.
- technical/evidence pages compete directly with conversion-oriented client pages.

Required repair:
- primary navigation must contain exactly 8 destinations in this order:
  1. Executive Scorecard
  2. Priority Fixes
  3. Conversion Journey
  4. Content Opportunities
  5. Competitor Comparison
  6. Trust & Credibility
  7. Website Speed & Performance
  8. Mobile & Accessibility
- keep stable source S## IDs for governance; do not renumber historical IDs.
- remove S04/S08/S09/S10/S11/S14/S15/S16 from equal-weight primary navigation.
- retain those sections behind a subordinate Supporting Evidence / Technical Detail navigation surface.
- moving navigation placement must not delete governed evidence or alter scoring/Client Truth.

Proof:
- primary count = 8;
- exact label/order tests;
- zero supporting-detail peers in primary nav;
- all 8 supporting-detail destinations remain reachable;
- viewer page switching and print/save regression PASS.

## Expected source/test seam — not yet authorized as exact

Remote/current committed repository evidence indicates the likely seam includes:

- `services/worker/src/report/render-report-v2.js`
  - executive renderer;
  - viewer-page composition currently maps Executive Scorecard to `executive` + `strengths`;
  - `REPORT_V2_VIEWER_PAGES` currently defines all 16 peer viewer pages and therefore likely owns the navigation migration.
- `services/worker/src/report/report-detail-sections.js`
  - separate `strengthsSection` producer, if consolidation requires changing its use/ownership.
- `services/worker/src/report/render-report-v2-conversion.test.js`
- `services/worker/src/report/karen-style-regression.test.js`
- exact viewer/navigation tests that assert page count/order/current labels or all 16 peer pages.

The repaired P1 candidate is an intentional dirty local worktree. Therefore this list is only an expected seam. **No BUILD is authorized until the exact current local versions, current git status, relevant functions, viewer mapping, and test assertions are captured without modifying the worktree.**

## Required pre-build source-boundary proof

From the exact local application worktree, capture read-only evidence for:

1. `git status --short`;
2. current branch and HEAD;
3. full current `REPORT_V2_VIEWER_PAGES` mapping for all pages;
4. current viewer/sidebar navigation generation logic and print/page-switch logic;
5. full current `executiveScorecard(...)` function boundary;
6. current `strengthsSection(...)` boundary;
7. current tests asserting viewer page count/order/labels, `What Is Already Good`, Evidence Confidence/Coverage, executive priority structure, and viewer-page composition;
8. exact source of each of the three executive priority problem/reason/action fields;
9. exact evidence lineage for the LCP action wording;
10. any code that assumes 16 primary peer pages and would break when support pages become subordinate.

Diagnostics must remain outside governed repositories.

## Planned deterministic acceptance suite

Before implementation, create/modify tests so the current baseline fails for the intended reasons and the repaired page/viewer must prove at minimum:

- exact six-part S01 conceptual order;
- one primary score only;
- confidence/coverage subordinate;
- max three priorities;
- Problem + Why + Action together for every priority;
- governed priority order preserved;
- no duplicate priority list;
- exactly one positive section;
- no `What Is Already Good` on S01;
- required assessment-coverage statement;
- supporting-detail pointer present;
- prohibited S01 technical/internal terms absent;
- business-language equivalents present where applicable;
- PARTIAL/NOT_ASSESSED/not-detected states never become confirmed site-wide defects;
- no unsupported action/root-cause upgrade;
- primary navigation count exactly 8;
- primary navigation exact approved labels/order;
- supporting-detail pages absent from primary peer list;
- all supporting-detail destinations reachable;
- viewer page switching/print behaviour intact;
- existing P1 cross-report integrity remains green.

## Post-build gates

1. focused S01 + navigation deterministic suite — PASS;
2. relevant renderer/viewer regressions — PASS;
3. focused P1 regressions — PASS;
4. CR-43 if governed output hashes are affected — PASS with governed hash procedure;
5. complete worker suite — PASS;
6. `npm run verify:prysm-closure` — PASS;
7. Whole-App acceptance — PASS where required by current governance;
8. `git diff --check` — PASS;
9. regenerate real TBK HTML from already-downloaded canonical artifacts — no live provider/model calls;
10. S01 human 10–20 second scan review — PASS;
11. human navigation review confirms the 8 client destinations are immediately understandable and technical/evidence detail is subordinate;
12. final RSIP score >=95/100 and hard-gate failures = 0.

## Current decision

`REPAIR_PLAN` is open but not complete.

Exact next action: capture the exact current local S01 + viewer/navigation source/test boundary read-only. Do not edit application code yet.
