# PRYSM Whole-App Branch Matrix

Matrix ID: PRYSM-BRANCH-MATRIX-01
Status: ACTIVE / PDV3 CANDIDATE COVERAGE RECONCILED
Effective: 2026-08-31

## Rule

This matrix is governed by `PRYSM_WHOLE_APP_BRANCH_COVERAGE_PROTOCOL.md`.

`MAPPED` means a deterministic whole-app scenario has been identified. `VERIFIED` means that scenario executed and passed on the exact candidate SHA. Historical test/scenario counts do not become `VERIFIED` here until they are explicitly mapped to the branch ID and rerun under the current gate.

A future application-changing PASS is forbidden while any required implemented branch remains `UNMAPPED`, `UNEXECUTED`, or materially `UNKNOWN`.

## Initial materially distinct branch inventory

| Branch ID | Production branch / condition | Material boundary at risk | Required now | Scenario mapping status | Exact-SHA verification | Notes |
|---|---|---|---|---|---|---|
| P-B01 | Crawl/evidence viable: site `AVAILABLE` or `PARTIAL` and normal governed scoring path | DecisionEvidence -> `scoreAudit` -> current ScoreSet | YES | `acceptance-prysm.js` assembled lifecycle | CANDIDATE GATE | Existing golden-path evidence is exercised by the assembled lifecycle. |
| P-B02 | PARTIAL/UNKNOWN evidence survives downstream without absence/zero/false/Complete coercion | evidence -> scoring -> Writer/Judge -> render | YES | `acceptance-prysm.js` negative/status assertions | CANDIDATE GATE | Existing status-honesty assertions. |
| P-B03 | Crawl/evidence non-viable path enters Not-Assessed scoring model | `buildNotAssessedModel` -> current ScoreSet persistence | YES | `acceptance-prysm.js` P-B03 | CANDIDATE GATE | Production escape `PDV3`; deterministic persistence/reload regression added. |
| P-B04 | Zero findings / empty governed decision hierarchy | scoring -> ScoreSet -> WriterInput/report model | YES | `acceptance-prysm.js` P-B03 empty hierarchy | CANDIDATE GATE | Empty hierarchy is asserted as present governed state. |
| P-B05 | Non-empty single-finding hierarchy/root-cause | scoring -> persistence -> reload -> consumers | YES | `src/scoring/current-score-set.test.js` | CANDIDATE GATE | Current contract identity assertions. |
| P-B06 | Multiple findings with ordered Conversion-First hierarchy | scoring -> persistence -> reload -> Writer action plan -> render | YES | `narrative-v2-production-path.test.js` | CANDIDATE GATE | Production path asserts ordered action parity. |
| P-B07 | Narrative first automatic Writer/Judge round reaches PASS | WriterInput -> Writer -> Judge -> release candidate | YES | `narrative-v2-production-path.test.js` | CANDIDATE GATE | Controlled first-round path. |
| P-B08 | Judge 1 `REVISE` -> Writer 2 -> Judge 2 | governed revision directive and field locking | YES | `narrative-v2-production-path.test.js` | CANDIDATE GATE | Controlled revision path. |
| P-B09 | Judge 2 still not releasable -> HUMAN_REVIEW / explicitly authorized final pass | terminal persistence -> authorization -> Writer 3/Judge 3 | YES where current final-pass feature is enabled | `narrative-v2-production-path.test.js` | CANDIDATE GATE | Final-pass authorization and no Pass 4 assertions. |
| P-B10 | Valid persisted release-candidate recovery | persistence -> reload -> render without new model spend | YES | `replay-report.test.js` | CANDIDATE GATE | Current replay hydration. |
| P-B11 | Invalid/stale/incompatible terminal Narrative artifact | recovery validation -> fail closed, zero extra Writer/Judge calls | YES | `replay-report.test.js`, `narrative-v2-production-path.test.js` | CANDIDATE GATE | Fail-closed recovery assertions. |
| P-B12 | Current publication/retrieval/render path | approved artifact -> publication -> API retrieval -> Viewer v2 | YES | `acceptance-prysm.js` publication/retrieval | CANDIDATE GATE | Exact approved-byte retrieval assertions. |
| P-B13 | Current replay/recovery identity | persisted current semantic model -> replay -> Viewer v2 | YES | `prysm-whole-app-gate.js` replay CLI | CANDIDATE GATE | Current replay only; historical compatibility separated. |

## Known branch coverage escapes to retain permanently

| Escape ID | Live/UAT symptom | Missing/weak branch proof | Required permanent regression |
|---|---|---|---|
| PDV1 | Writer pass 1 rejected prompt-compliant bounded AI-search negation | Writer prompt/semantic-validator equivalence branch | bounded neutral AI-search wording accepted while unsupported negative wording remains rejected |
| PDV2 | Judge pass 2 emitted provider-valid `defects[].section` later rejected by deterministic Judge validator | provider structured-output schema vs deterministic Judge contract handoff | Judge structured schema must constrain `section` to `WRITER_SECTION_FIELDS` |
| PDV3 | Audit remained `evidence_locked`; scoring log: `Current ScoreSet requires decisionHierarchy` | non-viable/Not-Assessed scoring branch was not exercised against current ScoreSet contract | Not-Assessed model must produce a valid governed empty hierarchy and persist/reload through the real scoring boundary |

## Next matrix action

During PDV3, extend the executable Whole-App gate so it emits covered branch IDs and proves P-B03 plus the current required matrix. Do not claim a new application PASS from a scenario count alone.
