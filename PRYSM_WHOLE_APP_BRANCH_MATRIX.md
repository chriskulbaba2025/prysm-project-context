# PRYSM Whole-App Branch Matrix

Matrix ID: PRYSM-BRANCH-MATRIX-01
Status: ACTIVE / PDV5 AUDIT RESUBMISSION
Effective: 2026-09-01

## Rule

This matrix is governed by `PRYSM_WHOLE_APP_BRANCH_COVERAGE_PROTOCOL.md`.

`MAPPED` means a deterministic whole-app scenario has been identified. `VERIFIED` means that scenario executed and passed on the exact candidate SHA. Historical test/scenario counts do not become `VERIFIED` here until they are explicitly mapped to the branch ID and rerun under the current gate.

A future application-changing PASS is forbidden while any required implemented branch remains `UNMAPPED`, `UNEXECUTED`, or materially `UNKNOWN`.

## Materially distinct branch inventory

| Branch ID | Production branch / condition | Material boundary at risk | Required now | Scenario mapping status | Exact-SHA verification | Notes |
|---|---|---|---|---|---|---|
| P-B01 | Crawl/evidence viable: site `AVAILABLE` or `PARTIAL` and normal governed scoring path | DecisionEvidence -> `scoreAudit` -> current ScoreSet | YES | `acceptance-prysm.js` assembled lifecycle | VERIFIED at exact candidate SHA `acfc5c1393261bb7733837289bc3adc1062e64d5` | P0 exact-candidate gate PASS; assembled lifecycle. |
| P-B02 | PARTIAL/UNKNOWN evidence survives downstream without absence/zero/false/Complete coercion | evidence -> scoring -> Writer/Judge -> render | YES | `acceptance-prysm.js` negative/status assertions | VERIFIED at exact candidate SHA `acfc5c1393261bb7733837289bc3adc1062e64d5` | P0 exact-candidate gate PASS; PDV4-specific sibling is P-B15. |
| P-B03 | Crawl/evidence non-viable path enters Not-Assessed scoring model | `buildNotAssessedModel` -> current ScoreSet persistence | YES | `acceptance-prysm.js` P-B03 | VERIFIED at exact candidate SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e` | Exact-SHA gate PASS; production escape `PDV3` regression retained. |
| P-B04 | Zero findings / empty governed decision hierarchy | scoring -> ScoreSet -> WriterInput/report model | YES | `acceptance-prysm.js` P-B03 empty hierarchy | VERIFIED at exact candidate SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e` | Exact-SHA gate PASS. |
| P-B05 | Non-empty single-finding hierarchy/root-cause | scoring -> persistence -> reload -> consumers | YES | `src/scoring/current-score-set.test.js` | VERIFIED at exact candidate SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e` | Exact-SHA gate PASS. |
| P-B06 | Multiple findings with ordered Conversion-First hierarchy | scoring -> persistence -> reload -> Writer action plan -> render | YES | `narrative-v2-production-path.test.js` | VERIFIED at exact candidate SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e` | Exact-SHA gate PASS. |
| P-B07 | Narrative first automatic Writer/Judge round reaches PASS | WriterInput -> Writer -> Judge -> release candidate | YES | `narrative-v2-production-path.test.js` | VERIFIED at exact candidate SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e` | Exact-SHA gate PASS. |
| P-B08 | Judge 1 `REVISE` -> Writer 2 -> Judge 2 | governed revision directive and field locking | YES | `narrative-v2-production-path.test.js` | VERIFIED at exact candidate SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e` | Exact-SHA gate PASS. |
| P-B09 | Judge 2 still not releasable -> HUMAN_REVIEW / explicitly authorized final pass | terminal persistence -> authorization -> Writer 3/Judge 3 | YES where current final-pass feature is enabled | `narrative-v2-production-path.test.js` | VERIFIED at exact candidate SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e` | Exact-SHA gate PASS; no Pass 4 assertions. |
| P-B10 | Valid persisted release-candidate recovery | persistence -> reload -> render without new model spend | YES | `replay-report.test.js` | VERIFIED at exact candidate SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e` | Exact-SHA gate PASS. |
| P-B11 | Invalid/stale/incompatible terminal Narrative artifact | recovery validation -> fail closed, zero extra Writer/Judge calls | YES | `replay-report.test.js`, `narrative-v2-production-path.test.js` | VERIFIED at exact candidate SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e` | Exact-SHA gate PASS; fail-closed recovery. |
| P-B12 | Current publication/retrieval/render path | approved artifact -> publication -> API retrieval -> Viewer v2 | YES | `acceptance-prysm.js` publication/retrieval | VERIFIED at exact candidate SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e` | Exact-SHA gate PASS. |
| P-B13 | Current replay/recovery identity | persisted current semantic model -> replay -> Viewer v2 | YES | `prysm-whole-app-gate.js` replay CLI | VERIFIED at exact candidate SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e` | Exact-SHA gate PASS; historical compatibility separated. |
| P-B14 | PARTIAL On-Page evidence has positive provider image-issue numerator, unavailable image-array denominator serialized as `0`, while deep body-content evidence is available | DataForSEO adapter -> DecisionEvidence persistence/read-back -> finalization numerator/denominator consistency | YES | `prysm-whole-app-gate.js` -> `pdv4-assembled-finalization-gate.js` P-B14 | VERIFIED at exact candidate SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e` | Exact-SHA gate PASS; persisted adapter output and negative sibling regression. |
| P-B15 | PARTIAL heading finding uses explicit assessed-scope wording (`assessed pages ... unassessed pages remain unknown`) through the finalization absence-claim guard | deterministic score producer -> FindingSet persistence/read-back -> finalization PARTIAL semantic validator | YES | `prysm-whole-app-gate.js` -> `pdv4-assembled-finalization-gate.js` P-B15 | VERIFIED at exact candidate SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e` | Exact-SHA gate PASS; persisted producer wording and unqualified negative sibling regression. |
| P-B16 | SERP candidate has query-derived topic/locale and inferred page type, versus explicit competitor-observed service, geography, audience, and commercial evidence | DataForSEO SERP producer -> common qualification contract -> approved-gap consumer | YES | `prysm-whole-app-gate.js` -> `p4-serp-qualification-gate.js` | VERIFIED at exact candidate SHA `28b25f64e3140968842cfdec265b9583e1c995d9` | P4-MAJOR-02/03 permanent regression: accounting title under a physiotherapy query fails service relevance; query locale/page type also fail closed; complete observed evidence remains positive-path compatible. |

## Known branch coverage escapes to retain permanently

| Escape ID | Live/UAT symptom | Missing/weak branch proof | Required permanent regression |
|---|---|---|---|
| PDV1 | Writer pass 1 rejected prompt-compliant bounded AI-search negation | Writer prompt/semantic-validator equivalence branch | bounded neutral AI-search wording accepted while unsupported negative wording remains rejected |
| PDV2 | Judge pass 2 emitted provider-valid `defects[].section` later rejected by deterministic Judge validator | provider structured-output schema vs deterministic Judge contract handoff | Judge structured schema must constrain `section` to `WRITER_SECTION_FIELDS` |
| PDV3 | Audit remained `evidence_locked`; scoring log: `Current ScoreSet requires decisionHierarchy` | non-viable/Not-Assessed scoring branch was not exercised against current ScoreSet contract | Not-Assessed model must produce a valid governed empty hierarchy and persist/reload through the real scoring boundary |
| PDV4 | Fresh production audit reached `narrative_ready` then `render_failed`; deterministic replay against its persisted artifacts returned exactly two finalization errors: image numerator/unavailable denominator and `VAN-TECH-002` PARTIAL assessed-scope rejection | production-shaped finalization branches P-B14/P-B15 were not represented by the PDV3 branch gate | permanent P-B14 and P-B15 assembled finalization regressions; no additional PDV4 branch row is required by the completed two-error diagnostic |

## PDV4 diagnostic classification

The complete deterministic replay for audit `688e0cd2-7e09-4b2c-8e20-d05e507f5b7d` returned `errorCount: 2` and only these two branch families:

- P-B14 -> `site.imagesMissingAlt` / `technical-health`;
- P-B15 -> `findings[].evidence` / `priority-fixes` for `VAN-TECH-002`.

No P-B16 is opened from this diagnostic.

## Next matrix action

P4 repair-3 extends P-B16 across observed service/business provenance. The exact-candidate Whole-App Branch Coverage Gate PASSed with P-B01 through P-B16 covered at `28b25f64e3140968842cfdec265b9583e1c995d9`. Independent Auditor review is required for that exact candidate.

