# S02 Repair Plan — Priority Fixes

Section: `S02 — Priority Fixes`
Status: **IN PROGRESS — SOURCE BOUNDARY VERIFICATION REQUIRED**
Date opened: 2026-09-07
Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md` v1.2.0
Contract: `S02_CONTRACT.md` — APPROVED / FROZEN
Baseline: `S02_BASELINE_AUDIT.md` — 67/100 FAIL, 2 hard-gate failures
Report-wide IA contract: `PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md` v1.1.0
GCU: `governed-coding-upgrade` v2.1.0

## Repair objective

Convert S02 from several competing audit/action structures into one authoritative ranked client action sequence, while preserving the governed action order, Client Truth, evidence uncertainty, technical traceability, approved six-item navigation, and the intentional dirty P1/S01 worktree.

This is a presentation/decision-layer repair. No scoring, evidence acquisition, lifecycle, Writer/Judge semantics, provider/model behavior, production data, push, merge, or deployment is authorized.

## Dominant root cause

The current Priority Fixes viewer page exposes both audit machinery and client action guidance as peer content. The same governed priorities are rendered repeatedly through:

1. Priority Findings;
2. `First Things First — Foundational Readiness`;
3. deterministic Client Action Plan / Do Now / Do Next;
4. Narrative Root Cause / Conversion interpretation;
5. Narrative Action Plan.

This produces four rendered pages of crowded tables and repeated explanations instead of one client decision sequence.

## Verified committed-code ownership — NOT YET SUFFICIENT FOR BUILD

Read-only inspection of the application branch confirms the underlying ownership model, but the committed branch is older than the exact governed dirty candidate and therefore cannot alone authorize edits.

Known ownership from committed branch inspection:

- `src/report/render-report-v2.js`
  - owns `REPORT_V2_VIEWER_PAGES`;
  - maps `priority-fixes` to deterministic section IDs including `blockers`, `foundations`, and `action-plan` in the committed implementation;
  - owns `blockersSection(model, plan)`, including the dense seven-column table, rule IDs, action classes, raw URL lists, confidence/rank language, and verification detail;
  - renders deterministic foundation and action-plan sections through imported helpers.
- `src/report/report-detail-sections.js`
  - owns `foundationSection(checklist)` and its full Foundational Readiness matrix;
  - owns `actionPlanSection(plan, checklist)` and the Do Now / Do Next / Later / Measure presentation.
- `src/report/render-narrative-v2.js`
  - assigns `narrative-root-cause`, `narrative-conversion`, and `narrative-action-plan` to viewer page `priority-fixes`;
  - the narrative action plan is another dense seven-column table.
- `src/report/action-priority.js`
  - owns governed deterministic action ordering and must not be modified merely to simplify presentation.
- `src/scoring/score-components.js`
  - owns detailed finding wording such as the `VAN-PERF-001` recommendation and is already part of the dirty governed P1 worktree; S02 should translate presentation wording rather than mutate finding/scoring semantics unless a later proof explicitly reopens that boundary.

## Required exact-local source-boundary diagnostic

Because S01/P1 is an intentional dirty local candidate and current GitHub committed source does not contain the final Viewer 2.3.0/S01 changes, BUILD remains blocked until a read-only diagnostic captures the exact current local source.

The diagnostic must prove:

1. exact repository root, branch, HEAD, and full `git status --short`;
2. current Viewer version and current `REPORT_V2_VIEWER_PAGES` / Supporting Detail composition;
3. current `priority-fixes` deterministic section ownership;
4. current rendering path for `blockersSection`, `foundationSection`, and `actionPlanSection`;
5. current narrative page assignments for root cause, conversion, and narrative action plan;
6. current test files/assertions that govern S02 page composition, narrative assignments, viewer navigation, evidence uncertainty, priority order, and regression behavior;
7. whether Foundation Readiness and detailed audit material can be moved to the existing Supporting Detail surface without editing evidence/scoring logic;
8. the smallest exact source/test file set required to satisfy the frozen S02 contract;
9. any already-dirty target file and its current local diff, so valid P1/S01 work is preserved in place;
10. zero application edits during the diagnostic.

The diagnostic output must be written outside both repositories and returned as a TXT proof for review.

## Intended repair shape — frozen outcome, source seam pending verification

Once the exact local seam is verified, the repair must implement this single client outcome:

### R1 — One authoritative sequence

S02 renders only one ranked client action sequence derived from the existing governed `buildActionPlan` order.

No visible second answer to “what should I fix first?” may remain.

### R2 — Client-facing priority fields

Each supported priority presents together:

- What needs attention
- Why it matters
- What to change
- Where it applies
- How to confirm it improved
- Material uncertainty, only when required

### R3 — Remove client-facing audit mechanics from S02 primary layer

Primary S02 must not expose as normal client fields:

- rule IDs;
- action classes;
- deterministic confidence wording;
- raw effort codes;
- long raw URL inventories;
- raw rank-reason mechanics;
- `render-blocking` / `LCP` when plain wording is sufficient;
- repeated `re-crawl` implementation phrasing.

### R4 — Replace dense table presentation

The current seven-column action tables must not remain the primary S02 presentation. Use a scan-friendly stacked/card/row layout that preserves deterministic rank and complete client action meaning.

### R5 — Demote Foundation Readiness to Supporting Detail

The full foundation matrix remains governed and reachable, but must not render as an equal-weight S02 priority block.

If a foundation materially affects a ranked action, S02 may show one short contextual note without creating another ranking.

### R6 — Remove deterministic duplicate action framework

The current deterministic Client Action Plan / Do Now / Do Next / Later / Measure structure must not duplicate the same five ranked actions on the primary S02 page.

Its underlying governed information may be reused by the single authoritative sequence or retained in Supporting Detail as appropriate.

### R7 — Remove narrative duplicate action frameworks from S02

Narrative Root Cause / Conversion interpretation may remain elsewhere only if they do not compete with the single S02 decision sequence. Narrative Action Plan must not render as a second ranked table on S02.

Any remapping must preserve Writer/Judge output and evidence lineage; this repair changes presentation placement, not narrative truth.

### R8 — Plain-language translation

At minimum for locked TBK:

- `Mobile largest contentful paint is slow` -> `Main content takes too long to appear on mobile.`
- buyer-question non-detection remains bounded to pages that could be assessed;
- `Meta descriptions` -> `search-result descriptions`;
- `Heading structure is inconsistent` -> `Page headings are inconsistent.`
- security-header wording must be understandable without implying more certainty than the assessed response proves.

### R9 — Preserve S01 consistency

Locked S01 top-three order remains:

1. mobile main-content loading;
2. buyer-question content with assessed-scope uncertainty;
3. search-result descriptions.

S02 may add useful action detail but cannot reorder or reinterpret these conclusions.

### R10 — Preserve Supporting Detail and navigation

The approved six peer destinations plus one subordinate `Supporting Detail` destination remain unchanged.

No S02 repair may reopen the navigation contract.

## Tests-first requirement

After exact local source-boundary verification and before implementation behavior changes:

1. update/extend only the authorized S02-focused tests to encode the frozen contract;
2. run them against the current implementation and preserve expected FAIL proof;
3. then modify only the approved source seam;
4. rerun focused tests to PASS;
5. stop before broad deterministic closure and return proof.

Focused tests must directly prove, where applicable:

- one authoritative S02 ranked sequence;
- exact governed rank preserved;
- top-three consistency with S01;
- required client fields present;
- no competing First Things First / Do Now / Do Next / second Action Plan on S02;
- no primary rule IDs/action classes/raw confidence/raw effort/raw URL inventory;
- uncertainty preserved for PARTIAL/not-detected evidence;
- Foundation Readiness remains reachable in Supporting Detail;
- narrative Writer/Judge content remains governed even if its page assignment changes;
- approved navigation remains unchanged;
- no undefined/null required client fields;
- no canonical evidence/scoring/lifecycle mutation.

## Prohibited boundaries

Unless a new diagnostic proves otherwise and the repair plan is explicitly reopened before editing, do not modify:

- `src/report/action-priority.js` ordering logic;
- scoring weights or score computation;
- evidence contracts/adapters/collection;
- Client Truth semantics;
- lifecycle/storage/auth;
- Writer/Judge generation or validation contracts;
- canonical artifacts;
- provider/model execution;
- production state;
- unrelated dirty P1/S01 files.

No reset, clean, checkout-overwrite, destructive revert, discard, push, merge, or deploy.

## GCU release intent

`CHANGE_ONLY`

The goal is to prove the bounded S02 presentation repair only. This work does not claim staging or production readiness and does not authorize deployment.

## Repair-plan gate

Current status: **BLOCKED ONLY ON EXACT LOCAL SOURCE-BOUNDARY PROOF**.

The contract is approved/frozen, the target client outcome is fixed, and committed-code ownership is understood. BUILD is not yet authorized because the exact current dirty local seam must be captured first.

Exact next action: run the read-only S02 source-boundary diagnostic against `C:\Users\kulba\Desktop\vantage-platform\services\worker`, preserve the intentional dirty P1/S01 worktree, write `PRYSM-S02-SOURCE-BOUNDARY.txt` to Downloads, and return that proof for repair-plan completion.