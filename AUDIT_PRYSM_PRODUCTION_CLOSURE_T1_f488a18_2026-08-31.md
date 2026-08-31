# Independent Audit — PRYSM Production Closure T1

Date: 2026-08-31  
Application branch: `repair/prysm-production-closure`  
Application SHA: `f488a18ccbbfff86a33a72236b18b4e708664698`  
Whole-App Gate: executed locally on this exact unchanged SHA — **FAIL (proof insufficiency)**

## Verdict

**FAIL** — one material false-PASS proof defect remains in the T1 boundary.

## AUD-T1-002 — multi-finding persisted hierarchy parity is not proved at final consumers

- Category: `FALSE_PASS_PROOF_DEFECT`
- Severity: `MAJOR`
- Evidence:
  - The repaired `services/worker/src/narrative-v2/writer-input.js:435-505` correctly projects `ScoreSet.decisionHierarchy` rather than importing the action-plan derivers, and its new `T1-WRITER-01` unit fixture covers two actions.
  - The exact gate, `services/worker/scripts/prysm-whole-app-gate.js:10-14`, runs that unit suite separately from the assembled production scenario.
  - In the assembled acceptance scenario, `services/worker/scripts/acceptance-prysm.js:431-447` checks schema validity and only that Findings are non-empty; it does not compare persisted `decisionHierarchy` against the reloaded WriterInput or any later consumer.
  - The current production-path controlled Writer reads only `orderedFindingIds[0]` (`services/worker/src/application/narrative-v2-production-path.test.js:204-221`) and emits exactly one `actionPlan` item (`:308-318`). `NV2-PROD-02` then asserts only WriterInput identity, release-candidate status, and generic rendered markers (`:883-893`).
  - The current gate passed locally: 82/82 acceptance checks, 10/10 WriterInput tests, and 10/10 Narrative-v2 production-path tests; it reported controlled/zero live calls. Those results demonstrate the omitted comparison is a genuine false-PASS gap, not an unexecuted test.
- Why current proof misses it: a defect that preserves a valid hierarchy shape and its first action but loses, reorders, or changes metadata on a later action after persistence/reload would pass all three gate components. The standalone unit does not traverse real ScoreSet persistence/reload, Writer/Judge validation, release-candidate finalization, and rendering. The production-composed path does traverse those boundaries but its controlled Writer/Judge and assertions reduce the hierarchy to the first action.
- Required bounded correction: add one deterministic current production-composed multi-finding scenario to the Whole-App Gate. It must begin with scoring-produced/persisted hierarchy data, reload the exact artifacts, and assert equality of ordered finding IDs, root-cause identity, rank, effort, action class, and conversion influence at WriterInput and the controlled Writer/Judge/finalization/render consumer boundaries. Ensure the controlled Writer exercises at least two actions so a later-order loss/reordering is detectable. Keep it zero-cost and do not weaken existing tests.
- Owning tranche: `T1`.

## Identity and bounded review

- Local application HEAD and `origin/repair/prysm-production-closure` both resolved to `f488a18ccbbfff86a33a72236b18b4e708664698`; ahead/behind was `0/0` after fetch.
- The candidate commit is limited to WriterInput hierarchy projection and its tests/gate wiring. The application HEAD remained unchanged after the auditor gate run and `git diff --check` passed.
- The application status command reports a pre-existing Windows filename-length warning while scanning a fixture path; it did not report staged or tracked modifications. This is recorded as an environmental visibility limitation, not a separate T1 finding because exact HEAD/remote equality was established and no audit operation wrote application files.
- The repaired source has removed the previously audited duplicate hierarchy derivation. This audit finding is limited to the required proof-system correction for its persistence-to-final-consumer boundary.

## Required Builder disposition

Repair `AUD-T1-002` in T1, freeze a new candidate SHA, run the exact-SHA Whole-App Tranche Gate, push and prove synchronization, then return that new candidate for independent audit. No later tranche may begin.
