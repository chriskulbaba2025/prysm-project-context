# S02 Repair Plan — Priority Fixes

Section: `S02 — Priority Fixes`
Status: **BUILD EXECUTED — FOCUSED PASS / VERIFY-ONLY BLOCKED**
Date opened: 2026-09-07
Date completed: 2026-09-07
Build authorized by: Chris
Build authorization date: 2026-09-07
Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md` v1.2.0
Contract: `S02_CONTRACT.md` — APPROVED / FROZEN
Baseline: `S02_BASELINE_AUDIT.md` — 67/100 FAIL, 2 hard-gate failures
Source-boundary proof: `S02_SOURCE_BOUNDARY_PROOF.md` — PASS
Bounded build proof: `S02_BOUNDED_BUILD_PROOF.md`
Report-wide IA contract: `PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md` v1.1.0
GCU: `governed-coding-upgrade` v2.1.0

## Repair objective

Convert S02 from several competing audit/action structures into one authoritative ranked client action sequence while preserving governed action order, Client Truth, evidence uncertainty, technical traceability, approved navigation, and the intentional dirty P1/S01 worktree.

## Dominant root cause

Priority Fixes exposed audit machinery and client action guidance as peer content, repeating the governed actions through several equal-weight structures instead of one client decision sequence.

## Authorized and executed BUILD seam

Only these source files were changed for S02:

1. `services/worker/src/report/render-report-v2.js`
2. `services/worker/src/report/render-narrative-v2.js`

Only these focused tests were changed:

1. `services/worker/src/report/render-report-v2.test.js`
2. `services/worker/src/report/render-report-v2-section-viewer.test.js`
3. `services/worker/src/report/render-report-v2-conversion.test.js`
4. `services/worker/src/report/render-narrative-v2.test.js`

Verify-only files remained unedited:

- `services/worker/src/report/render-report-v2-sections.test.js`
- `services/worker/src/report/karen-style-regression.test.js`

## Implemented behavior

- Priority Fixes now owns one authoritative ranked client sequence derived from existing `plan.actions`.
- `foundations` and deterministic `action-plan` moved from Priority Fixes to existing Supporting Detail by viewer assignment only.
- Narrative Root Cause, Narrative Conversion, and Narrative Action Plan moved from `priority-fixes` to `supporting-detail` by renderer assignment only.
- Primary S02 no longer exposes the old dense seven-column mechanics table as the client decision surface.
- Primary wording removes rule IDs, internal action classes, raw confidence/effort/rank mechanics and raw URL inventory.
- Governed action order, scoring, evidence, Client Truth, Writer/Judge objects and evidence lineage remain unchanged.
- Six peer client destinations plus one subordinate Supporting Detail destination remain unchanged.

## Tests-first proof

Pre-implementation focused gate:

- `83` tests
- `76` pass
- `7` fail
- exit `1`

This provided the required expected-fail proof against old behavior.

Final focused BUILD gate:

- `83` tests
- `83` pass
- `0` fail
- exit `0`

Focused implementation result: **PASS**.

## Verify-only gate

Required verify-only run:

`node --test src/report/render-report-v2-sections.test.js src/report/karen-style-regression.test.js`

Result:

- `18` tests
- `13` pass
- `5` fail
- exit `1`

The verify-only files were outside the authorized edit boundary, so no attempt was made to update or repair them.

`git diff --check`: **PASS**, exit `0`.

S02-attributable changes remained exactly inside the authorized 2-source / 4-test boundary.

## Current decision

The BUILD cannot advance to deterministic audit yet.

The focused implementation is green and scope-clean, but the required verify-only gate is red. The next boundary must diagnose whether each verify-only failure is a stale contract assertion or a genuine S02 regression.

## Prohibited boundaries remain unchanged

Do not modify scoring, evidence, `action-priority.js`, Client Truth, Writer/Judge contracts, lifecycle, storage, provider/model behavior, canonical artifacts, production state, or unrelated P1/S01 work.

Do not reset, clean, restore, checkout-overwrite, revert, stash, discard, commit, push, merge, or deploy.

## Exact next action

Run a read-only diagnosis of the five verify-only failures in:

- `services/worker/src/report/render-report-v2-sections.test.js`
- `services/worker/src/report/karen-style-regression.test.js`

For each failure, classify it as:

1. a stale assertion directly superseded by the frozen S02 contract; or
2. a genuine regression caused by the S02 BUILD.

Do not edit either file during diagnosis. Return an exact proposed boundary before any further application edit. Do not run deterministic audit or rerender the actual TBK report yet.
