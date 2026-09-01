# PRYSM Whole-App Branch Matrix

Matrix ID: PRYSM-BRANCH-MATRIX-01
Status: ACTIVE / PDV4 DIAGNOSIS OPEN
Effective: 2026-08-31

## Rule

This matrix is governed by `PRYSM_WHOLE_APP_BRANCH_COVERAGE_PROTOCOL.md`.

`MAPPED` means a deterministic whole-app scenario has been identified. `VERIFIED` means that scenario executed and passed on the exact candidate SHA. Historical test/scenario counts do not become `VERIFIED` here until they are explicitly mapped to the branch ID and rerun under the current gate.

A future application-changing PASS is forbidden while any required implemented branch remains `UNMAPPED`, `UNEXECUTED`, or materially `UNKNOWN`.

## Materially distinct branch inventory

| Branch ID | Production branch / condition | Material boundary at risk | Required now | Scenario mapping status | Exact-SHA verification | Notes |
|---|---|---|---|---|---|---|
| P-B01 | Crawl/evidence viable: site `AVAILABLE` or `PARTIAL` and normal governed scoring path | DecisionEvidence -> `scoreAudit` -> current ScoreSet | YES | `acceptance-prysm.js` assembled lifecycle | VERIFIED at PDV3 SHA | Existing golden-path evidence is exercised by the assembled lifecycle. |
| P-B02 | PARTIAL/UNKNOWN evidence survives downstream without absence/zero/false/Complete coercion | evidence -> scoring -> Writer/Judge -> render | YES | `acceptance-prysm.js` negative/status assertions | INSUFFICIENT FOR P-B15 | Generic status-honesty coverage passed at PDV3 but did not cover the exact PARTIAL heading wording branch exposed by PDV4. |
| P-B03 | Crawl/evidence non-viable path enters Not-Assessed scoring model | `buildNotAssessedModel` -> current ScoreSet persistence | YES | `acceptance-prysm.js` P-B03 | VERIFIED at PDV3 SHA | Production escape `PDV3`; deterministic persistence/reload regression added. |
| P-B04 | Zero findings / empty governed decision hierarchy | scoring -> ScoreSet -> WriterInput/report model | YES | `acceptance-prysm.js` P-B03 empty hierarchy | VERIFIED at PDV3 SHA | Empty hierarchy is asserted as present governed state. |
| P-B05 | Non-empty single-finding hierarchy/root-cause | scoring -> persistence -> reload -> consumers | YES | `src/scoring/current-score-set.test.js` | VERIFIED at PDV3 SHA | Current contract identity assertions. |
| P-B06 | Multiple findings with ordered Conversion-First hierarchy | scoring -> persistence -> reload -> Writer action plan -> render | YES | `narrative-v2-production-path.test.js` | VERIFIED at PDV3 SHA | Production path asserts ordered action parity. |
| P-B07 | Narrative first automatic Writer/Judge round reaches PASS | WriterInput -> Writer -> Judge -> release candidate | YES | `narrative-v2-production-path.test.js` | VERIFIED at PDV3 SHA | Controlled first-round path. |
| P-B08 | Judge 1 `REVISE` -> Writer 2 -> Judge 2 | governed revision directive and field locking | YES | `narrative-v2-production-path.test.js` | VERIFIED at PDV3 SHA | Controlled revision path. |
| P-B09 | Judge 2 still not releasable -> HUMAN_REVIEW / explicitly authorized final pass | terminal persistence -> authorization -> Writer 3/Judge 3 | YES where current final-pass feature is enabled | `narrative-v2-production-path.test.js` | VERIFIED at PDV3 SHA | Final-pass authorization and no Pass 4 assertions. |
| P-B10 | Valid persisted release-candidate recovery | persistence -> reload -> render without new model spend | YES | `replay-report.test.js` | VERIFIED at PDV3 SHA | Current replay hydration. |
| P-B11 | Invalid/stale/incompatible terminal Narrative artifact | recovery validation -> fail closed, zero extra Writer/Judge calls | YES | `replay-report.test.js`, `narrative-v2-production-path.test.js` | VERIFIED at PDV3 SHA | Fail-closed recovery assertions. |
| P-B12 | Current publication/retrieval/render path | approved artifact -> publication -> API retrieval -> Viewer v2 | YES | `acceptance-prysm.js` publication/retrieval | VERIFIED at PDV3 SHA FOR COVERED FIXTURE | Live PDV4 failed before publication because the production-shaped finalization branch differed from the covered fixture. |
| P-B13 | Current replay/recovery identity | persisted current semantic model -> replay -> Viewer v2 | YES | `prysm-whole-app-gate.js` replay CLI | VERIFIED at PDV3 SHA | Current replay only; historical compatibility separated. |
| P-B14 | PARTIAL On-Page evidence has positive provider image-issue numerator, unavailable image-array denominator serialized as `0`, while deep body-content evidence is available | DataForSEO adapter availability metadata -> DecisionEvidence integer coercion -> finalization numerator/denominator consistency | YES | UNMAPPED | UNEXECUTED | Production escape `PDV4`. Adapter can retain `imagesMissingAlt` from `page_metrics.checks.no_image_alt` while `imageCount` is unavailable; deep content parsing can make `_contentEvidenceAvailable=true`, so the finalization fallback does not recognize the missing image denominator without an explicit image availability marker. |
| P-B15 | PARTIAL heading finding uses explicit assessed-scope wording (`assessed pages ... unassessed pages remain unknown`) through the finalization absence-claim guard | deterministic finding text -> finalization PARTIAL semantic validator | YES | UNMAPPED | UNEXECUTED | Production escape `PDV4`. Current finalization bounded-partial recognition does not match this producer wording even though the claim is scope-qualified. Full live reason must be captured before repair scope is frozen. |

## Known branch coverage escapes to retain permanently

| Escape ID | Live/UAT symptom | Missing/weak branch proof | Required permanent regression |
|---|---|---|---|
| PDV1 | Writer pass 1 rejected prompt-compliant bounded AI-search negation | Writer prompt/semantic-validator equivalence branch | bounded neutral AI-search wording accepted while unsupported negative wording remains rejected |
| PDV2 | Judge pass 2 emitted provider-valid `defects[].section` later rejected by deterministic Judge validator | provider structured-output schema vs deterministic Judge contract handoff | Judge structured schema must constrain `section` to `WRITER_SECTION_FIELDS` |
| PDV3 | Audit remained `evidence_locked`; scoring log: `Current ScoreSet requires decisionHierarchy` | non-viable/Not-Assessed scoring branch was not exercised against current ScoreSet contract | Not-Assessed model must produce a valid governed empty hierarchy and persist/reload through the real scoring boundary |
| PDV4 | Fresh production audit reached `narrative_ready` then `render_failed`; visible reason includes impossible image numerator/denominator and begins a `VAN-TECH-002` PARTIAL-evidence rejection | production-shaped finalization branches P-B14/P-B15 were not represented by the PDV3 branch gate | permanent P-B14 and P-B15 assembled finalization regressions; add any additional branch row revealed by the full lifecycle reason before PDV4 PASS |

## Next matrix action

Obtain the complete `render_failed` lifecycle reason for audit `688e0cd2-7e09-4b2c-8e20-d05e507f5b7d` once. Classify every finalization error before any edit. Then map and implement permanent deterministic assembled-system coverage for P-B14, P-B15, and any additional materially distinct branch revealed by that complete reason. A new application PASS is prohibited until all required rows are mapped, executed, and green on one exact candidate SHA.
