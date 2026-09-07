# S01 Replay Repair and Real Rerender Proof

Section: `S01 — Executive Scorecard`
Stage: `REAL_REPORT_RENDER`
Result: **BOUNDED REPLAY REPAIR PASS / REAL RERENDER BLOCKED**
Date: 2026-09-07
Source proof: uploaded `PRYSM-S01-REPLAY-REPAIR-AND-RERENDER-PROOF.txt`

## Authorized repair result

Authorized files only:
- `services/worker/scripts/replay-report.js`
- `services/worker/scripts/replay-report-cli.test.js`

Implemented the bounded in-memory historical `contentIdeas` compatibility seam. No schema, canonical artifact, producer, renderer, scoring, evidence, or lifecycle change was made.

## Deterministic gates

Targeted replay CLI:
- `7/7 PASS`
- exit code `0`
- historical current-2.0.0 contentIdeas enrichment PASS
- already-current passthrough PASS
- malformed/mixed fail-closed PASS
- current artifact validation PASS
- invalid current ScoreSet fail-closed PASS
- `--legacy-compat` remains compatibility-only

Closure:
- `npm run verify:prysm-closure`: PASS, exit `0`
- lifecycle: `57/57 PASS`
- Full-System Acceptance: `87/87 PASS`
- replay CLI: `7/7 PASS`
- Whole-App tranche: PASS
- closure machine gate: PASS

Other gates:
- `git diff --check`: exit `0`, line-ending warnings only
- normalized scope verification: PASS
- newly introduced repair path relative to initial checkpoint: `scripts/replay-report.js`
- existing authorized replay test path remained within scope
- no unexpected new path

## Real TBK replay

Canonical artifacts were staged unchanged and SHA-256 inventory was captured.

Replay command used the existing governed path:
`node scripts/replay-report.js <staged-root>`

Result:
- exit code `1`
- replay `0/1 PASS`
- no current review HTML produced

Exact next blocker:
`Current report model requires persisted cross-report interpretation`

The persisted TBK `canonical/scores.json` top-level keys do not include `crossReportInterpretation`.

## Boundary decision

The `contentIdeas` compatibility repair is proven and remains accepted.

The new `crossReportInterpretation` blocker is outside that repair authorization. No additional application change was made.

Do not infer that the missing field is safe to reconstruct, mutate canonical artifacts, weaken hydration, or broaden the replay seam until a read-only compatibility diagnosis proves the originating contract/producer boundary and the lowest-risk supported repair.

## Current decision

S01 remains `REAL_REPORT_RENDER` and is not `PASS_LOCKED`.

Exact next action: read-only diagnosis of the persisted/current `crossReportInterpretation` boundary, including production-era ScoreSet contract, current producer, persistence, current hydration requirement, replay behavior, deterministic derivation inputs, existing compatibility seams, and exact repair files/tests. Stop before any further edit or rerender.
