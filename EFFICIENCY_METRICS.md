# PRYSM Efficiency Metrics

Purpose: maintain a persistent, editable record of development-workflow efficiency so improvements from project memory and governed handoffs can be measured rather than estimated.

## Measurement rule

Record one row when a governed work package closes or reaches a verified checkpoint.

Track these four primary measures:

1. **Elapsed time** — wall-clock time from the first substantive action on the work package to the verified completion checkpoint. If the session contains a long unrelated pause, record both total elapsed time and known active elapsed time when available. Never invent missing timing data.
2. **Number of edits** — count each completed source-file replacement/change applied by the user or assistant as one edit event. If the same file is changed again after testing, that is another edit event.
3. **Failed iterations** — count each test/run cycle that fails and requires another code/test-contract change before the package becomes green. Re-running the same unchanged failing state for diagnosis may be noted separately but is not counted as a new edit iteration.
4. **Context-recovery turns** — count turns spent reconstructing already-known project state, re-establishing scope, locating the authoritative file/version, or repeating prior decisions because context was not carried forward. Normal clarification of a genuinely new requirement does not count.

## Secondary measures

Where practical also record:
- files touched
- verification tests and final pass counts
- regressions introduced outside scope
- repeated edits to the same file
- whether a new chat/handoff occurred
- whether authoritative memory was read successfully at start

## Efficiency comparison

Do not claim a measured percentage until at least one comparable pre-memory baseline and one memory-governed work package have sufficient data.

For comparable work packages, calculate normalized burden using:

`Burden = elapsed_minutes + (10 × edit_events) + (15 × failed_iterations) + (10 × context_recovery_turns)`

Then:

`Efficiency improvement % = ((baseline_burden - current_burden) / baseline_burden) × 100`

This weighted burden score is a project-management heuristic, not a software-performance benchmark. Keep the raw measures alongside it so the weighting can be changed later without losing source data.

## Current baseline statement

As of 2026-08-22, the previously stated **~55% improvement in practical development efficiency** is an informed estimate based on observed reductions in context reconstruction, scope drift, repeated governance explanation, wrong-file work, and rework. It is **not yet a measured benchmark** and must remain labelled as an estimate.

Prospective measurement starts now.

## Work-package log

| ID | Date | Work package | Elapsed | Active elapsed | Edit events | Failed iterations | Context-recovery turns | Files touched | Verification | Memory used at start | Burden | Notes |
|---|---|---|---:|---:|---:|---:|---:|---|---|---|---:|---|
| BASELINE-ESTIMATE-2026-08-22 | 2026-08-22 | Pre-measurement comparison | Not reliably measured | Not reliably measured | Not reliably measured | Not reliably measured | Not reliably measured | — | — | Mixed / pre-protocol | — | ~55% improvement is estimate only; not valid as measured benchmark. |
| PRYSM-V2-SECTION-VIEWER-02 | 2026-08-22 | 15→16 page Viewer v2.2.0 migration and regression freeze | Not reliably measured retrospectively | Not reliably measured retrospectively | 3 verified file units | Not reliably counted retrospectively | 0 observed during final governed handoff sequence | `render-report-v2.js`; `render-report-v2-section-viewer.test.js`; `render-report-v2-conversion.test.js` | Viewer 9/9; conversion 46/46; core Report v2 10/10 | Yes | — | First recorded package. Timing/failure counts intentionally left unmeasured rather than reconstructed inaccurately. |

## Update discipline

- Update this file at every materially completed governed work package.
- Preserve prior rows; correct a prior row only when better evidence exists.
- Label estimates as estimates.
- Never convert missing data into zero.
- At meaningful milestones, compare the latest comparable packages and report both raw metrics and the calculated efficiency improvement.
