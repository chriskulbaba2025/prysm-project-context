# PRYSM Whole-App Branch Matrix

Matrix ID: PRYSM-BRANCH-MATRIX-01
Status: ACTIVE / INVENTORY RECONCILIATION REQUIRED BEFORE NEXT APPLICATION PASS
Effective: 2026-08-31

## Rule

This matrix is governed by `PRYSM_WHOLE_APP_BRANCH_COVERAGE_PROTOCOL.md`.

`MAPPED` means a deterministic whole-app scenario has been identified. `VERIFIED` means that scenario executed and passed on the exact candidate SHA. Historical test/scenario counts do not become `VERIFIED` here until they are explicitly mapped to the branch ID and rerun under the current gate.

A future application-changing PASS is forbidden while any required implemented branch remains `UNMAPPED`, `UNEXECUTED`, or materially `UNKNOWN`.

## Initial materially distinct branch inventory

| Branch ID | Production branch / condition | Material boundary at risk | Required now | Scenario mapping status | Exact-SHA verification | Notes |
|---|---|---|---|---|---|---|
| P-B01 | Crawl/evidence viable: site `AVAILABLE` or `PARTIAL` and normal governed scoring path | DecisionEvidence -> `scoreAudit` -> current ScoreSet | YES | TO RECONCILE | UNEXECUTED UNDER MATRIX | Existing golden-path evidence may cover this but must be explicitly mapped. |
| P-B02 | PARTIAL/UNKNOWN evidence survives downstream without absence/zero/false/Complete coercion | evidence -> scoring -> Writer/Judge -> render | YES | TO RECONCILE | UNEXECUTED UNDER MATRIX | Existing G2 is a likely mapping; exact mapping must be proven. |
| P-B03 | Crawl/evidence non-viable path enters Not-Assessed scoring model | `buildNotAssessedModel` -> current ScoreSet persistence | YES | UNMAPPED | UNEXECUTED | Production escape `PDV3`: current ScoreSet rejected missing `decisionHierarchy`. Permanent regression required. |
| P-B04 | Zero findings / empty governed decision hierarchy | scoring -> ScoreSet -> WriterInput/report model | YES | TO RECONCILE | UNEXECUTED UNDER MATRIX | Must prove an empty hierarchy remains a valid governed hierarchy rather than a missing field. |
| P-B05 | Non-empty single-finding hierarchy/root-cause | scoring -> persistence -> reload -> consumers | YES | TO RECONCILE | UNEXECUTED UNDER MATRIX | Must preserve exact root-cause identity. |
| P-B06 | Multiple findings with ordered Conversion-First hierarchy | scoring -> persistence -> reload -> Writer action plan -> render | YES | TO RECONCILE | UNEXECUTED UNDER MATRIX | Existing G3 is a likely mapping; must assert rank/influence/effort parity. |
| P-B07 | Narrative first automatic Writer/Judge round reaches PASS | WriterInput -> Writer -> Judge -> release candidate | YES | TO RECONCILE | UNEXECUTED UNDER MATRIX | Current production architecture supports this terminal path. |
| P-B08 | Judge 1 `REVISE` -> Writer 2 -> Judge 2 | governed revision directive and field locking | YES | TO RECONCILE | UNEXECUTED UNDER MATRIX | Production runs have traversed this path; deterministic whole-app mapping required. |
| P-B09 | Judge 2 still not releasable -> HUMAN_REVIEW / explicitly authorized final pass | terminal persistence -> authorization -> Writer 3/Judge 3 | YES where current final-pass feature is enabled | TO RECONCILE | UNEXECUTED UNDER MATRIX | Must prove no automatic third pass and no unauthorized spend. |
| P-B10 | Valid persisted release-candidate recovery | persistence -> reload -> render without new model spend | YES | TO RECONCILE | UNEXECUTED UNDER MATRIX | Existing G4 is a likely mapping. |
| P-B11 | Invalid/stale/incompatible terminal Narrative artifact | recovery validation -> fail closed, zero extra Writer/Judge calls | YES | TO RECONCILE | UNEXECUTED UNDER MATRIX | Existing G5 is a likely mapping. |
| P-B12 | Current publication/retrieval/render path | approved artifact -> publication -> API retrieval -> Viewer v2 | YES | TO RECONCILE | UNEXECUTED UNDER MATRIX | Must verify client-facing retrieval uses exact governed release artifact. |
| P-B13 | Current replay/recovery identity | persisted current semantic model -> replay -> Viewer v2 | YES | TO RECONCILE | UNEXECUTED UNDER MATRIX | Existing G6 is a likely mapping. Historical compatibility replay cannot satisfy it. |

## Known branch coverage escapes to retain permanently

| Escape ID | Live/UAT symptom | Missing/weak branch proof | Required permanent regression |
|---|---|---|---|
| PDV1 | Writer pass 1 rejected prompt-compliant bounded AI-search negation | Writer prompt/semantic-validator equivalence branch | bounded neutral AI-search wording accepted while unsupported negative wording remains rejected |
| PDV2 | Judge pass 2 emitted provider-valid `defects[].section` later rejected by deterministic Judge validator | provider structured-output schema vs deterministic Judge contract handoff | Judge structured schema must constrain `section` to `WRITER_SECTION_FIELDS` |
| PDV3 | Audit remained `evidence_locked`; scoring log: `Current ScoreSet requires decisionHierarchy` | non-viable/Not-Assessed scoring branch was not exercised against current ScoreSet contract | Not-Assessed model must produce a valid governed empty hierarchy and persist/reload through the real scoring boundary |

## Next matrix action

During PDV3, extend the executable Whole-App gate so it emits covered branch IDs and proves P-B03 plus the current required matrix. Do not claim a new application PASS from a scenario count alone.
