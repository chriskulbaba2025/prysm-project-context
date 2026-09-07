# S02 Source Boundary Proof — Priority Fixes

Section: `S02 — Priority Fixes`
Date: 2026-09-07
Status: **PASS — VERIFIED**
Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md` v1.2.0
Contract: `S02_CONTRACT.md` — APPROVED / FROZEN
Repair plan: `S02_REPAIR_PLAN.md`
GCU: `governed-coding-upgrade` v2.1.0

## Evidence source

Chris returned the read-only local diagnostic:

`C:\Users\kulba\Downloads\PRYSM-S02-SOURCE-BOUNDARY.txt`

The diagnostic inspected the exact current local application worktree and made zero application edits.

## Exact candidate identity

- Repository root: `C:\Users\kulba\Desktop\vantage-platform`
- Worker: `C:\Users\kulba\Desktop\vantage-platform\services\worker`
- Branch: `p1/bounded-build-cross-report-integrity`
- Historical committed HEAD: `a9523ac3de98de76335a05304b60bec246242b65`
- HEAD does not identify the complete governed candidate; the intentional dirty P1/S01 worktree remains part of the candidate and must be preserved.
- Current local Viewer version: `2.3.0`.

## Verified current S02 composition

Current `REPORT_V2_VIEWER_PAGES` presents exactly six peer client destinations plus one subordinate `Supporting Detail` destination.

`Priority Fixes` currently owns:

- `blockers`
- `foundations`
- `action-plan`

`Supporting Detail` currently owns:

- `pillars`
- `performance`
- `accessibility-mobile`
- `cms`
- `technical`
- `headings`
- `schema`
- `machine-readiness`
- `internal-links`
- `evidence`
- `phase2`

The viewer activates only section IDs assigned to the selected page. Therefore `foundations` and `action-plan` can be moved from S02 to Supporting Detail as a presentation/page-assignment change without deleting their governed renderers or changing evidence/scoring semantics.

## Verified source ownership

### `src/report/render-report-v2.js`

Owns:

- Viewer 2.3.0 page composition;
- `blockersSection(model, plan)`;
- the current dense seven-column Priority Findings table;
- rule-ID/action-class/confidence/rank-reason/raw-location exposure on the primary S02 page;
- construction and attachment of the shared governed `plan`.

This file is already dirty from valid P1/S01 work. Its existing dirty changes must be preserved in place.

### `src/report/report-detail-sections.js`

Owns:

- `foundationSection(checklist)`;
- full Foundational Readiness matrix;
- `actionPlanSection(plan, checklist)`;
- Do Now / Do Next / Later / Measure deterministic action-plan presentation.

This file is already dirty from P1 compatibility work, but the S02 repair does **not** require changing it. The governed sections can remain intact and be reassigned to Supporting Detail.

### `src/report/render-narrative-v2.js`

Owns viewer-page assignment for:

- Narrative Root Cause;
- Narrative Conversion;
- Narrative Action Plan.

All three currently target `priority-fixes`. This file is clean and is the exact presentation seam for moving those narrative cards to Supporting Detail without changing WriterOutput, JudgeResponse, validation, statement classes, evidence references, or generated prose.

### `src/report/action-priority.js`

Owns governed deterministic priority ordering through `buildActionPlan(model, checklist)`.

It is clean and must remain untouched. S02 must consume `plan.actions` in its existing order without resorting or recomputing rank.

### `src/scoring/score-components.js`

Owns governed finding production and detailed recommendation wording. It is already dirty from P1 work and is outside the S02 presentation boundary. No S02 repair requires changing it.

## Verified smallest BUILD source boundary

Exactly two source files:

1. `services/worker/src/report/render-report-v2.js`
   - preserve all existing P1/S01 dirty changes;
   - change S02 page assignment so `foundations` and `action-plan` move to Supporting Detail;
   - replace only the primary `blockersSection` presentation with one authoritative ranked client sequence;
   - consume existing `plan.actions` order unchanged;
   - translate client-facing wording without changing finding/scoring truth.

2. `services/worker/src/report/render-narrative-v2.js`
   - change only the viewer-page assignments for Narrative Root Cause, Narrative Conversion, and Narrative Action Plan from `priority-fixes` to `supporting-detail`;
   - preserve Writer/Judge contracts, validation, evidence lineage, statement classes, and narrative content.

## Verified smallest BUILD test boundary

Exactly four test files are authorized for focused S02 migration/proof:

1. `services/worker/src/report/render-report-v2.test.js`
2. `services/worker/src/report/render-report-v2-section-viewer.test.js`
3. `services/worker/src/report/render-report-v2-conversion.test.js`
4. `services/worker/src/report/render-narrative-v2.test.js`

Verify-only regressions unless a direct stale assertion caused by the authorized repair proves otherwise:

- `services/worker/src/report/render-report-v2-sections.test.js`
- `services/worker/src/report/karen-style-regression.test.js`

Any expansion beyond the exact two-source/four-test BUILD boundary requires new proof and repair-plan reopening before editing.

## Required S02 BUILD outcome

The primary Priority Fixes page must render one authoritative ranked client action sequence only.

Every supported priority must show:

1. What needs attention
2. Why it matters
3. What to change
4. Where it applies
5. How to confirm it improved
6. Material uncertainty only when required

The primary S02 page must not expose ordinary client-facing:

- rule IDs;
- `HIGH_CONVERSION` / `OPTIMIZATION` / foundation-blocker class labels;
- deterministic evidence-confidence wording;
- raw effort codes;
- long raw URL inventories;
- raw rank-reason mechanics;
- unnecessary `LCP`, `render-blocking`, or repeated `re-crawl` implementation jargon;
- a competing `First Things First` hierarchy;
- duplicate Do Now / Do Next action ranking;
- a second narrative Action Plan.

## Verified boundary determinations

- Foundation matrix can move to Supporting Detail without scoring/evidence changes: **YES**.
- Deterministic duplicate action-plan presentation can leave S02 without changing priority logic: **YES**.
- Narrative Root Cause / Conversion / Action Plan placement can change without changing Writer/Judge contracts: **YES**.
- `action-priority.js` can remain untouched: **YES**.
- `score-components.js` can remain untouched: **YES**.
- BUILD can be bounded without changing scoring/evidence/Client Truth/Writer/Judge semantics: **YES**, using the exact two-source/four-test boundary above.

## Prohibited files/boundaries

Do not modify for S02 BUILD:

- `src/report/action-priority.js`;
- `src/scoring/score-components.js`;
- `src/scoring/report-model.js`;
- `src/scoring/vantage-score.js`;
- `src/report/report-detail-sections.js` unless new proof first reopens the plan;
- evidence contracts/adapters/collection;
- Client Truth producers/validators;
- Writer/Judge generation, schemas, validators, or orchestration;
- lifecycle/storage/auth;
- canonical audit artifacts;
- provider/model execution;
- production state;
- unrelated dirty P1/S01 files.

No reset, clean, checkout-overwrite, restore, destructive revert, stash, discard, push, merge, or deploy.

## Tests-first BUILD sequence

When BUILD is explicitly authorized:

1. update/extend only the four authorized S02 tests;
2. run them against the current implementation and preserve expected pre-change FAIL proof;
3. edit only the two authorized source files;
4. rerun focused tests to PASS;
5. verify no unexpected file changed and `git diff --check` passes;
6. stop before broad deterministic audit and return the focused proof.

## Source-boundary conclusion

**SOURCE BOUNDARY: PASS**

The exact current local candidate supports a presentation-only S02 repair within the two-source/four-test boundary above.

No application edit is authorized by this proof itself.
