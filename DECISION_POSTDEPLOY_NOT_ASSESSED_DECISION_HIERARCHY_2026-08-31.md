# Decision — PDV3 Not-Assessed ScoreSet Decision Hierarchy

Date: 2026-08-31
Status: PASS / GOVERNING REPAIR COMPLETE
Root defect ID: `PDV3.NOT_ASSESSED_DECISION_HIERARCHY`

## Production evidence

Fresh production audit:

- audit ID: `cd63135d-87d9-436f-91cc-6d84f64d7a96`;
- target: `https://www.tbkcreative.com/`;
- production application SHA: `c6cb6f7e2b60f350a4021c052c9f9dff4b83411e`;
- lifecycle reached `evidence_stored` then `evidence_locked` and did not transition to `scored`;
- Railway worker log at the scoring boundary: `Current ScoreSet requires decisionHierarchy`.

The current scoring orchestrator intentionally leaves lifecycle at `EVIDENCE_LOCKED` on governed-scoring failure. This is therefore a scoring-boundary failure, not a Narrative/Writer/Judge failure.

## Proven root cause

Current production source establishes the mismatch:

1. `current-score-set.js` requires every current ScoreSet to contain a valid governed `decisionHierarchy`.
2. `scoring-service.js` builds ScoreSet by copying `model.decisionHierarchy` and then validates it at persistence.
3. the normal `scoreAudit` path constructs the current governed hierarchy.
4. the alternate `buildNotAssessedModel()` path returns a Not-Assessed scoring model with `findings: []` and a bounded root-cause explanation but does not return `rootCauseRuleId` or `decisionHierarchy`.
5. `buildScoreSet()` therefore receives `model.decisionHierarchy === undefined`, and the current ScoreSet assertion correctly fails closed.

The current ScoreSet requirement is not the defect. The alternate producer is stale relative to the current contract.

## Repair rule

Repair only the alternate Not-Assessed producer/contract parity needed for a current valid empty hierarchy.

The repair must:

- preserve the current ScoreSet assertion and schema;
- preserve Not-Assessed semantics and numeric-score suppression;
- preserve `findings: []` when no governed findings are established;
- emit a governed empty decision hierarchy using the same current hierarchy contract/provenance as the normal scoring path, with no invented finding/root-cause identity;
- keep `rootCauseRuleId` null when no governed finding establishes a root-cause rule;
- ensure `orderedFindingIds` and `actions` are empty arrays;
- preserve the explanatory Not-Assessed `rootCause` prose without turning it into a governed finding identity;
- avoid downstream special cases, silent defaults, or validator weakening.

Do not change evidence acquisition, provider behaviour, Narrative Writer/Judge semantics, publication, or rendering as part of this root repair unless deterministic proof exposes a directly coupled contract requirement.

## Required deterministic proof

PDV3 must add a permanent branch regression through the real governed scoring boundary for the non-viable/Not-Assessed path:

1. controlled non-viable crawl evidence enters `scoreAudit`;
2. Not-Assessed model is produced;
3. current ScoreSet contains a valid empty `decisionHierarchy` and `rootCauseRuleId: null`;
4. findings and scores persist and validate;
5. persisted ScoreSet reloads successfully under the current contract;
6. lifecycle can advance from `EVIDENCE_LOCKED` to `SCORED` in assembled production composition;
7. no evidence-status semantics are weakened.

Then run the current PRYSM Whole-App Branch Coverage Gate, not only a targeted scoring test.

## Branch coverage consequence

This production defect is branch coverage escape `P-B03` in `PRYSM_WHOLE_APP_BRANCH_MATRIX.md`.

PDV3 is not complete merely when the source repair passes. The executable Whole-App gate must be extended/reconciled so the non-viable Not-Assessed scoring branch is permanently represented and the current required branch matrix is reported by branch ID.

No new application PASS may rely only on the historical six golden scenarios.

## Authorization boundary

Authorized during PDV3:

- deterministic local source repair on the dedicated repair branch;
- targeted scoring regression;
- branch-matrix/Whole-App verification updates needed to prove the assembled branch;
- full deterministic regression/local gate;
- exact-SHA independent Auditor;
- governance synchronization.

Not authorized without later owner approval:

- merge to application `main`;
- deployment;
- production configuration mutation;
- live/paid provider or Writer/Judge calls;
- another fresh production audit.

## Efficiency boundary

The root cause is proven above the 97% confidence threshold. Do not perform more production-provider diagnostics unless deterministic repair/proof materially contradicts this model.
