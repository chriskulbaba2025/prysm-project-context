# S01 Cross-Report Interpretation Compatibility Diagnosis

Section: `S01 — Executive Scorecard`
Stage: `REAL_REPORT_RENDER`
Result: **DIAGNOSIS COMPLETE — BOUNDED REPAIR PROVEN**
Date: 2026-09-07
Source proof: uploaded `PRYSM-S01-CROSS-REPORT-INTERPRETATION-DIAGNOSIS.txt`

## Observed blocker

After the previously authorized `contentIdeas` current-replay compatibility repair passed its targeted and closure gates, the real TBK offline replay advanced to the next boundary and failed with:

`Current report model requires persisted cross-report interpretation`

The persisted TBK `canonical/scores.json`:
- `contractVersion`: `2.0.0`
- `scoringVersion`: `4.1.1`
- `generatedAt`: `2026-09-01T20:40:35.444Z`
- `rootCauseRuleId`: `VAN-PERF-001`
- does not contain top-level `crossReportInterpretation`.

## Historical validity

The diagnosis validated the persisted TBK ScoreSet against the production-era `score-current.schema.json` immediately before the later persisted-cross-report requirement. AJV2020 validation passed with zero errors. The production-era current-model hydration boundary also did not require persisted `crossReportInterpretation`.

Therefore the TBK ScoreSet was valid when produced. The current replay failure is a historical producer/current-hydration compatibility boundary, not evidence of canonical corruption.

## Chronology established from source history

The diagnosis established:
- commit `32884562276daacce83a46d5f75bb417925ac54c` introduced/unified cross-report interpretation production on 2026-09-02 17:30:19 -0400;
- commit `9a1612c7e2388297120d5196b0be099762c97e2b` required persisted cross-report interpretation on 2026-09-02 17:44:11 -0400;
- the TBK ScoreSet was generated on 2026-09-01 and therefore predates both changes.

## Current deterministic producer

Current production derives `crossReportInterpretation` inside `scoreAudit` in `src/scoring/vantage-score.js` using the deterministic Client Truth path:
- decision-scoped persisted site evidence;
- persisted performance evidence;
- deterministic score values/bands;
- deterministic conversion paths;
- persisted capability evidence;
- deterministic action hierarchy.

The producer builds `crossReportInterpretation` through `buildCrossReportInterpretation(...)`, then attaches governed action projections through `attachClientTruthActions(...)`.

The current object is Client Truth Contract `2.0.0` and includes:
- `version`;
- `contract`;
- `constructs`;
- `truth`;
- `actions`;
- `lineage`.

No provider/model call is involved.

## Persisted inputs are sufficient

The canonical TBK export contains the required persisted inputs:
- `canonical/audit-request.json`;
- `canonical/decision-evidence.json`;
- `canonical/capability-evidence.json`;
- `canonical/scores.json`;
- `canonical/findings.json`.

No provider call, evidence recollection, new audit, or invented evidence is required.

## Read-only reconstruction proof

An in-memory current `scoreAudit(...)` reconstruction from persisted audit request + decision evidence + capability evidence, pinned to the persisted scoring timestamp, completed successfully.

Verified invariants:
- reconstructed legacy scores equal persisted scores;
- reconstructed root cause remains `VAN-PERF-001`;
- reconstructed decision hierarchy equals the persisted decision hierarchy;
- finding count remains `5`;
- all five finding IDs match persisted IDs;
- deterministic cross-report projection is produced as Client Truth Contract `2.0.0`.

The read-only probe did identify current-source prose differences in some re-derived finding text. Those differences do not alter scores, finding IDs, priorities, severities, evidence status, decision hierarchy, or root-cause identity. They establish an important compatibility constraint: **the replay repair must extract only the missing `crossReportInterpretation`; it must not replace or persist the re-derived whole model or findings.**

Because current cross-report action projections may contain current deterministic action text, focused tests must explicitly cover the compatibility boundary and prove all persisted ScoreSet fields other than the missing projection remain unchanged.

## Existing compatibility seam

No existing governed `crossReportInterpretation` replay migration was found.

`scoreFromCanonicalEvidence(...)` is deterministic/offline but re-runs and persists the whole scoring boundary, so it is too broad for this historical replay compatibility case.

Current replay validates/loads the persisted ScoreSet and then calls `hydrateCurrentReportModel`, which fails if `crossReportInterpretation` is absent.

## Lowest-risk supported repair

Authorize a narrow current-replay compatibility seam in `scripts/replay-report.js` only:

1. Apply only to current replay for `contractVersion: 2.0.0` when `crossReportInterpretation` is demonstrably absent from the historical persisted ScoreSet.
2. Use already-persisted canonical inputs and the existing deterministic current producer to derive the missing projection in memory.
3. Before accepting the derived projection, verify compatibility invariants against the persisted artifacts, including at minimum score equality, root-cause identity, decision-hierarchy equality, finding count/IDs, and required source identity.
4. Attach **only** the derived `crossReportInterpretation` to an in-memory ScoreSet view.
5. Preserve every other persisted ScoreSet field byte/semantic-equivalent in the replay input view.
6. Do not replace persisted findings or ScoreSet fields with current re-derived prose or values.
7. Already-current ScoreSets with persisted `crossReportInterpretation` pass through unchanged.
8. Unsupported, malformed, ambiguous, missing-input, producer-failure, or invariant-mismatch cases fail closed.
9. Do not weaken current hydration/finalization validation.
10. Keep `--legacy-compat` unchanged and compatibility-only.
11. Never write the derived projection back to canonical `scores.json`.

## Exact authorized repair boundary

Only these application/test files are justified for the next repair:

- `services/worker/scripts/replay-report.js`
- `services/worker/scripts/replay-report-cli.test.js`

No schema, producer, scoring, renderer, lifecycle, evidence, canonical artifact, or additional application file is authorized by this diagnosis.

## Required proof after repair

Focused tests must prove:
- historical current-2.0.0 ScoreSet missing only `crossReportInterpretation` receives a deterministic in-memory projection;
- every other persisted ScoreSet field remains unchanged;
- persisted finding IDs, score map, root cause, and decision hierarchy remain authoritative;
- already-current projections pass through unchanged;
- malformed/unsupported/missing-input/invariant-mismatch cases fail closed;
- current validation remains enforced;
- `--legacy-compat` remains compatibility-only.

Then run:
- targeted replay CLI tests;
- `npm run verify:prysm-closure`;
- `git diff --check`;
- normalized scope verification.

Only if every deterministic gate passes may the unchanged real TBK canonical export be replayed again to produce the current Viewer `2.3.0` HTML for HUMAN_REVIEW.

## Scope / safety

The diagnosis made zero repository edits and zero canonical edits. No provider/model call, evidence recollection, new production audit, production mutation, push, merge, deploy, reset, clean, checkout-overwrite, or discard occurred.

## Decision

`S01_CROSS_REPORT_INTERPRETATION_DIAGNOSIS_COMPLETE`

The bounded replay repair above is authorized. S01 remains in `REAL_REPORT_RENDER` until the real TBK HTML is successfully regenerated and hashed. HUMAN_REVIEW remains blocked until then.