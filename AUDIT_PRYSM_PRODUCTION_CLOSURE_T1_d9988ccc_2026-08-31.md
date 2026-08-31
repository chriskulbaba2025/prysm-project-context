# Independent Audit — PRYSM Production Closure T1

Date: 2026-08-31  
Application branch: `repair/prysm-production-closure`  
Application SHA: `d9988ccc6085311a6cf144aa2cd4f822190e9f00`  
Whole-App Gate: PASS (`82` acceptance checks + `10/10` Narrative v2 production-path tests)

## Verdict

**FAIL** — one material defect remains in the T1 boundary.

## AUD-T1-001 — duplicate Conversion-First hierarchy source

- Category: `DUPLICATE_SOURCE_OF_TRUTH`
- Severity: `MAJOR`
- Evidence: `services/worker/src/narrative-v2/writer-input.js:15` imports `buildActionPlan` and `buildFoundationChecklist`; `buildWriterConversionInfluence` at approximately lines 482–560 calls both and reconstructs `orderedFindingIds`, rank, effort, and influence from `model`. The persisted canonical hierarchy is instead created in `services/worker/src/scoring/vantage-score.js:1269-1289` and persisted through `services/worker/src/scoring/scoring-service.js:336-337` as `scoreSet.decisionHierarchy`.
- Why proof missed it: the Whole-App acceptance proves that a controlled run has non-empty findings and that the first Writer action exists, but it does not assert at least two governed findings or compare every Writer action's finding ID, rank, effort, action class, and influence against the persisted `decisionHierarchy`. The production-path tests likewise only require a governed first action. A changed action-priority implementation or input projection can therefore make WriterInput disagree while the gate remains green.
- Required bounded correction: make current WriterInput consume the validated persisted `ScoreSet.decisionHierarchy` as its sole Conversion-First action authority; retain only a projection/lookup over that hierarchy and validated FindingSet. Add a deterministic multi-finding regression that persists/reloads a hierarchy with at least two distinct findings and asserts exact ordered IDs and governed metadata at WriterInput and final consumer boundaries. Do not weaken the existing gate.
- Owning tranche: `T1`.

## Verified evidence

- Local application branch and HEAD matched the durable candidate; working tree was clean; `HEAD...origin/repair/prysm-production-closure` was `0 0`.
- `npm run verify:prysm-whole-app` passed at the exact unchanged SHA with zero live/paid calls reported by the acceptance harness.
- Current ScoreSet contract is version `2.0.0` and requires `decisionHierarchy`, including ordered IDs, root-cause identity, and action metadata.

## Disposition

Builder must repair AUD-T1-001, rerun the exact T1 proof and Whole-App Gate on a new pushed exact SHA, then return to independent Auditor review. No later tranche may begin.
