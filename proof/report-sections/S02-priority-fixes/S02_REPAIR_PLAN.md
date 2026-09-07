# S02 Repair Plan — Priority Fixes

Section: `S02 — Priority Fixes`
Status: **COMPLETE — BOUNDED BUILD AUTHORIZED**
Date opened: 2026-09-07
Date completed: 2026-09-07
Build authorized by: Chris
Build authorization date: 2026-09-07
Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md` v1.2.0
Contract: `S02_CONTRACT.md` — APPROVED / FROZEN
Baseline: `S02_BASELINE_AUDIT.md` — 67/100 FAIL, 2 hard-gate failures
Source-boundary proof: `S02_SOURCE_BOUNDARY_PROOF.md` — PASS
Report-wide IA contract: `PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md` v1.1.0
GCU: `governed-coding-upgrade` v2.1.0

## Repair objective

Convert S02 from several competing audit/action structures into one authoritative ranked client action sequence, while preserving the governed action order, Client Truth, evidence uncertainty, technical traceability, approved six-item navigation, and the intentional dirty P1/S01 worktree.

This is a presentation/decision-layer repair. No scoring, evidence acquisition, lifecycle, Writer/Judge semantics, provider/model behavior, production data, push, merge, or deployment is authorized.

## Dominant root cause

The current Priority Fixes viewer page exposes both audit machinery and client action guidance as peer content. The same governed priorities are repeated through:

1. Priority Findings;
2. `First Things First — Foundational Readiness`;
3. deterministic Client Action Plan / Do Now / Do Next;
4. Narrative Root Cause / Conversion interpretation;
5. Narrative Action Plan.

This creates a four-page crowded surface instead of one client decision sequence.

## Exact local source-boundary result

Read-only local proof returned:

`C:\Users\kulba\Downloads\PRYSM-S02-SOURCE-BOUNDARY.txt`

Governed proof:

`proof/report-sections/S02-priority-fixes/S02_SOURCE_BOUNDARY_PROOF.md`

Result: **SOURCE BOUNDARY: PASS**.

Verified candidate:

- repository: `C:\Users\kulba\Desktop\vantage-platform`;
- worker: `C:\Users\kulba\Desktop\vantage-platform\services\worker`;
- branch: `p1/bounded-build-cross-report-integrity`;
- historical committed HEAD: `a9523ac3de98de76335a05304b60bec246242b65`;
- Viewer: `2.3.0`;
- HEAD alone does not identify the governed candidate; the intentional dirty P1/S01 worktree is part of it and must be preserved.

## Verified source ownership

### `src/report/render-report-v2.js`

Owns Viewer page composition and `blockersSection(model, plan)`. The current S02 deterministic page still owns `blockers`, `foundations`, and `action-plan`, and `blockersSection` exposes the dense seven-column table, rule IDs, action classes, raw location details, confidence/rank mechanics, and technical verification detail.

This file is already dirty from valid P1/S01 work. Existing changes must be preserved in place.

### `src/report/report-detail-sections.js`

Owns `foundationSection(checklist)` and `actionPlanSection(plan, checklist)`. The full foundation matrix and deterministic Do Now / Do Next / Later / Measure plan can remain intact and be moved to Supporting Detail through viewer page assignment. No S02 edit to this file is required.

### `src/report/render-narrative-v2.js`

Owns viewer-page assignment for Narrative Root Cause, Narrative Conversion, and Narrative Action Plan. These currently target `priority-fixes`. Placement can move to `supporting-detail` without changing WriterOutput, JudgeResponse, validation, statement classes, evidence references, or generated narrative content.

### `src/report/action-priority.js`

Owns governed deterministic ordering through `buildActionPlan(model, checklist)`. It is clean and outside the presentation seam. S02 must consume `plan.actions` in the existing order with no second sort or ranking.

### `src/scoring/score-components.js`

Owns governed finding production and detailed recommendation wording. It is already dirty from P1 work and is outside the S02 presentation seam.

## Authorized BUILD source boundary

Chris explicitly authorized BUILD on 2026-09-07.

Only these two source files may be edited:

1. `services/worker/src/report/render-report-v2.js`
   - preserve all existing P1/S01 dirty changes;
   - remove `foundations` and `action-plan` from the S02 page assignment and add them to existing Supporting Detail;
   - preserve all approved six-peer navigation labels/order and current Supporting Detail IDs;
   - replace only `blockersSection` primary presentation with one scan-friendly authoritative ranked client sequence;
   - consume existing `plan.actions` order unchanged;
   - translate client-facing wording without changing finding/scoring truth.

2. `services/worker/src/report/render-narrative-v2.js`
   - change only viewer-page assignment for Narrative Root Cause, Narrative Conversion, and Narrative Action Plan from `priority-fixes` to `supporting-detail`;
   - preserve Writer/Judge objects, validation, evidence lineage, statement classes, and prose.

## Authorized BUILD test boundary

Only these four test files may be edited for focused S02 contract migration/proof:

1. `services/worker/src/report/render-report-v2.test.js`
2. `services/worker/src/report/render-report-v2-section-viewer.test.js`
3. `services/worker/src/report/render-report-v2-conversion.test.js`
4. `services/worker/src/report/render-narrative-v2.test.js`

Verify-only unless a direct stale assertion caused by the authorized S02 repair proves otherwise:

- `services/worker/src/report/render-report-v2-sections.test.js`
- `services/worker/src/report/karen-style-regression.test.js`

Any additional edit requires new proof and repair-plan reopening before the file is changed.

## Required implementation

### R1 — One authoritative sequence

S02 renders one ranked client action sequence only, derived from existing governed `plan.actions`.

### R2 — Required fields per priority

Every supported priority presents together:

- What needs attention
- Why it matters
- What to change
- Where it applies
- How to confirm it improved
- Material uncertainty only when required

### R3 — Remove primary audit mechanics

The primary S02 sequence must not expose as ordinary client fields:

- rule IDs;
- action classes;
- deterministic confidence wording;
- raw effort codes;
- long raw URL inventories;
- raw rank-reason mechanics;
- unnecessary `LCP`, `render-blocking`, or repeated `re-crawl` wording.

### R4 — Replace dense table presentation

The primary S02 client action sequence must not depend on the current seven-column table. Use a scan-friendly stacked/card/row treatment that preserves rank and complete action meaning.

### R5 — Foundation Readiness to Supporting Detail

The full Foundation Readiness matrix remains governed and reachable but must not remain an equal-weight S02 priority block.

### R6 — Deterministic duplicate action plan to Supporting Detail

The deterministic Client Action Plan / Do Now / Do Next / Later / Measure presentation remains governed but must not duplicate the same action ranking on S02.

### R7 — Narrative duplicate structures to Supporting Detail

Narrative Root Cause, Conversion interpretation, and Narrative Action Plan must no longer compete with the single primary S02 decision sequence. Placement changes only; Writer/Judge truth remains unchanged.

### R8 — Plain-language translation

For the locked TBK report, preserve at minimum:

- `Mobile largest contentful paint is slow` -> `Main content takes too long to appear on mobile.`
- buyer-question non-detection remains bounded to pages that could be assessed;
- `Meta descriptions` -> `search-result descriptions`;
- `Heading structure is inconsistent` -> `Page headings are inconsistent.`
- security-header wording must remain understandable and bounded to assessed response evidence.

### R9 — Preserve locked S01 order

Top three remain:

1. mobile main-content loading;
2. buyer-question content with assessed-scope uncertainty;
3. search-result descriptions.

### R10 — Preserve navigation

Exactly six peer client destinations plus one subordinate `Supporting Detail` destination remain unchanged. S02 does not reopen the IA contract.

## Tests-first BUILD requirement

BUILD must execute in this order:

1. update/extend only the four authorized S02 tests to encode the frozen contract;
2. run against the current implementation and preserve expected pre-change FAIL proof;
3. edit only the two authorized source files;
4. rerun focused tests to PASS;
5. verify no unexpected file outside the boundary changed;
6. run `git diff --check`;
7. stop before broad deterministic audit and return focused proof.

Focused proof must establish:

- one authoritative S02 ranked sequence;
- exact governed rank preserved;
- top-three consistency with S01;
- required client fields present;
- no competing First Things First / Do Now / Do Next / second Action Plan on S02;
- no primary rule IDs/action classes/raw confidence/raw effort/raw URL inventory;
- uncertainty preserved for PARTIAL/not-detected evidence;
- Foundation Readiness and deterministic/narrative implementation detail remain reachable in Supporting Detail;
- Writer/Judge content and evidence lineage remain governed;
- approved navigation remains unchanged;
- no undefined/null required client fields;
- no canonical evidence/scoring/lifecycle mutation.

## Prohibited boundaries

Do not modify:

- `src/report/action-priority.js`;
- `src/scoring/score-components.js`;
- `src/scoring/report-model.js`;
- `src/scoring/vantage-score.js`;
- `src/report/report-detail-sections.js` unless new proof first reopens this plan;
- evidence contracts/adapters/collection;
- Client Truth producers/validators;
- Writer/Judge generation/schema/validation/orchestration;
- lifecycle/storage/auth;
- canonical artifacts;
- provider/model execution;
- production state;
- unrelated dirty P1/S01 files.

No reset, clean, checkout-overwrite, restore, destructive revert, stash, discard, push, merge, or deploy.

## GCU release intent

`CHANGE_ONLY`

The bounded S02 build proves the presentation repair only. It does not claim production readiness and does not authorize deployment.

## Repair-plan decision

**PASS — COMPLETE — BUILD AUTHORIZED.**

The exact local source/test seam is verified. The smallest safe BUILD boundary is exactly two source files and four test files.

Exact next action: execute the tests-first bounded S02 BUILD, preserve expected pre-change FAIL proof, implement only the authorized presentation/page-assignment repair, rerun focused tests to PASS, verify exact scope plus `git diff --check`, then stop and return the focused BUILD proof. Do not advance to broad deterministic audit until that proof is reviewed.