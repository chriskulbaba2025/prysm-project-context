# S01 ScoreSet Compatibility Diagnosis

Section: `S01 — Executive Scorecard`
Stage: `REAL_REPORT_RENDER`
Result: **DIAGNOSIS COMPLETE — BOUNDED REPAIR AUTHORIZED**
Date: 2026-09-07
Source proof: uploaded `PRYSM-S01-SCORESET-COMPATIBILITY-DIAGNOSIS.txt`

## Observed mismatch

The persisted TBK `canonical/scores.json` was generated on 2026-09-01 with pre-enrichment `contentIdeas` rows:
- TOFU/MOFU/BOFU rows contain `idea`, `frame`, `type`, `question`, `priority`;
- LEADING rows contain `query`, `rationale`, `priority`.

The current `score-current.schema.json` requires enriched opportunity rows including `stage`, `topic`, `whyItMatters`, `currentEvidence`, `gap`, `recommendedAsset`, `placement`, `objective`, `internalLinks`, `funnelStage`, and `evidenceStatus`.

Historical validation established that the persisted TBK ScoreSet was valid under the contract that existed when it was produced. The current content-opportunity schema/producer enrichment was introduced on 2026-09-02. This is a historical producer/contract evolution boundary, not persisted-artifact corruption.

## Deterministic reconstruction proof

The existing `contentIdeas(site, input)` producer in `src/scoring/report-model.js` was invoked in memory using only the already-persisted `audit-request.json` and `decision-evidence.json`.

Observed result:
- `13/13` enriched rows produced;
- zero missing required fields;
- zero limitations;
- zero mismatches across the previously persisted legacy semantic fields;
- no provider/model call;
- no new evidence;
- `currentEvidence` remains bounded to persisted page/body evidence and preserves PARTIAL/UNAVAILABLE states.

Therefore the missing current fields can be reconstructed deterministically without inventing evidence.

## Existing compatibility boundary

No existing governed `contentIdeas` migration exists for current replay.

`--legacy-compat` is explicitly compatibility-only and copies persisted historical HTML. It cannot produce current Viewer 2.3.0 release proof.

Current replay loads the persisted ScoreSet and validates it against `score-current.schema.json` before hydration, so the legacy-shaped `contentIdeas` row fails before any safe deterministic re-derivation can occur.

## Lowest-risk repair

Authorize a replay-boundary, in-memory deterministic `contentIdeas` normalization/re-derivation before current ScoreSet validation.

The repair must:
- preserve every persisted ScoreSet field except the in-memory `contentIdeas` projection;
- derive replacement `contentIdeas` only from persisted `audit-request.json` + `decision-evidence.json` through the existing deterministic producer;
- never write or mutate canonical `scores.json`;
- leave current already-enriched ScoreSets unchanged;
- fail closed for unsupported/malformed shapes rather than guessing;
- leave `--legacy-compat` semantics unchanged.

This is lower risk than weakening the current schema, mutating canonical evidence, changing the producer, or re-deriving the entire ScoreSet.

## Authorized source boundary

Production/support file:
- `services/worker/scripts/replay-report.js`

Permitted change only:
- add the narrow current-replay historical `contentIdeas` normalization/re-derivation seam between fixture load and current ScoreSet validation;
- reuse the existing exported deterministic `contentIdeas` producer;
- guard it so current enriched rows pass through unchanged and unsupported shapes fail closed.

Test file:
- `services/worker/scripts/replay-report-cli.test.js`

Required regression proof:
1. legacy-shaped current `2.0.0` ScoreSet contentIdeas are deterministically enriched for current replay;
2. already-current enriched ScoreSets are not changed by normalization;
3. legacy semantic fields remain equivalent after deterministic enrichment;
4. malformed/unsupported compatibility shapes fail closed;
5. `--legacy-compat` remains compatibility-only;
6. current artifact validation remains enforced.

No schema change, canonical artifact change, producer change, renderer change, scoring change, evidence recollection, or provider/model call is authorized.

## Required closure and real-render proof

After the bounded repair:
- targeted replay CLI tests must PASS;
- `npm run verify:prysm-closure` must PASS;
- `git diff --check` must exit `0`;
- scope verification must prove only the authorized repair/test files were newly modified by this repair;
- the real TBK report must be rerendered from unchanged canonical artifacts;
- final HTML must prove Viewer `2.3.0`, `Executive Scorecard`, exactly 8 primary destinations, supporting destinations subordinate, no old `A. Conversion Readiness` heading, and no duplicate `What Is Already Good` S01 section;
- final HTML SHA-256 and canonical input hashes must be captured.

## Diagnosis scope

The diagnosis itself introduced zero repository modifications. Final diagnostic scope verification: PASS.

## Decision

`S01_SCORESET_COMPATIBILITY_DIAGNOSIS_COMPLETE`

The bounded replay compatibility repair above is authorized. S01 remains at `REAL_REPORT_RENDER` and is not `PASS_LOCKED` until a successful current TBK render and HUMAN_REVIEW are complete.
