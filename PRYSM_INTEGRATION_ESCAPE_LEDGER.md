# PRYSM Integration Escape Ledger

Status: ACTIVE / APPEND-ONLY
Effective: 2026-08-31

## Purpose

Track material defects that escaped the deterministic/model-bearing verification surface and were discovered later in UAT/live/production so PRYSM can measure whether assembled-system and stochastic Narrative verification are improving.

This ledger measures the development process. It does not weaken product acceptance criteria.

## Definitions

**Integration escape** — a material defect missed by targeted/component proof but caught by deterministic Whole-App verification or independent audit before production promotion.

**Post-freeze / production escape** — a material repository-controlled defect discovered after a governed candidate had already been reported PASS/frozen/promoted and that should reasonably have been caught by the applicable assembled-system or model-bearing verification surface.

**Branch coverage escape** — a post-freeze/production escape whose defect class existed because a materially distinct production branch was not represented or not asserted at the required handoff in the Whole-App Branch Matrix.

**Semantic-distribution/model-bearing escape** — a post-freeze/production escape where the deterministic branch existed or nominally executed, but the real production-shaped semantic input/model-output condition was not represented strongly enough to expose the defect before promotion.

## Targets

- branch coverage escapes: downward trend toward **0**;
- semantic-distribution/model-bearing escapes: downward trend toward **0**;
- post-freeze material escapes attributable to known deterministic/model-bearing verification gaps: **0**;
- every branch coverage escape receives a permanent matrix row/regression before the next dependent release;
- every model-bearing escape receives real production-artifact replay, adversarial semantic coverage, and the applicable `PRYSM_MODEL_BEARING_RELEASE_GATE.md` proof before the next dependent release.

Never convert unknown counts to zero.

## Current escape record

| Escape ID | Date | Discovery boundary | Root defect | Class | Verification gap | Permanent correction |
|---|---|---|---|---|---|---|
| PDV1 | 2026-08-31 | live production Narrative | Writer semantic validator rejected prompt-compliant bounded AI-search negation | post-freeze / branch coverage escape | prompt-authorized bounded-negation wording was not paired against the deterministic semantic validator in assembled production-shaped proof | permanent Writer bounded-negation regression + P-B matrix retention |
| PDV2 | 2026-08-31 | live production Judge pass 2 | strict provider Judge schema allowed `defects[].section` values later rejected by deterministic Judge validator | post-freeze / branch coverage escape | provider structured-output contract and deterministic Judge contract were not asserted as one handoff branch | permanent strict `WRITER_SECTION_FIELDS` regression + P-B matrix retention |
| PDV3 | 2026-08-31 | live production governed scoring | Not-Assessed model omitted current required `decisionHierarchy` | post-freeze / branch coverage escape | non-viable/Not-Assessed scoring producer was not exercised against current ScoreSet persistence/reload contract | P-B03 + permanent Not-Assessed assembled-system scoring regression |
| PDV4 | 2026-08-31 | live production finalization after `narrative_ready`; completed deterministic replay of persisted live artifacts | exactly two materially distinct roots: `PDV4.IMAGE_DENOMINATOR_AVAILABILITY` (positive image issue numerator with unavailable image denominator serialized `0`) and `PDV4.PARTIAL_HEADING_SCOPE_VALIDATION` (`VAN-TECH-002` assessed-scope PARTIAL wording rejected by finalization guard) | post-freeze / branch coverage escape | PDV3 Whole-App fixtures did not represent P-B14 or P-B15 at the finalization handoff | P-B14/P-B15 permanent assembled finalization regressions. Completed replay returned exactly two errors; no additional PDV4 branch row is required from this escape. |
| PDV5 | 2026-09-01 | fresh live production Writer pass 1 after deterministic PDV4 closure | `PDV5.WRITER_PRODUCTION_SHAPING_UNCLASSIFIED` pending exact persisted-artifact replay; visible error begins at `writerOutput.aiSearch.citationReadiness.text ...` | post-freeze / semantic-distribution/model-bearing escape | deterministic Whole-App/branch proof was treated as stronger evidence of stochastic Writer reliability than it actually was; real production Writer outputs were not a mandatory repeated corpus/sample gate, semantic citation relevance was not independently re-scored, and exact Railway worker runtime identity was not a hard pre-validation proof | permanent `PRYSM_MODEL_BEARING_RELEASE_GATE.md`; PDV5 real production corpus + exact incident replay + narrative-only real Writer/Judge harness + repeated model-bearing sample + five-area semantic thresholds + independent Auditor re-score + deployment identity gate. Root-specific application regressions remain pending diagnosis. |

## Recording rule

Append one row for every future material escape. Record:

- exact discovery boundary;
- root defect ID;
- whether targeted, Whole-App, audit, UAT, staging, or production found it;
- whether the escape was branch-coverage, semantic-distribution/model-bearing, deployment-identity, or another verified class;
- which materially distinct branch/handoff/input distribution/proof plane was missing or weak;
- permanent regression/matrix/corpus/gate correction;
- whether the defect was discovered before or after production promotion.

Do not delete historical escapes after repair. The objective is a falling escape rate, not a rewritten history.
