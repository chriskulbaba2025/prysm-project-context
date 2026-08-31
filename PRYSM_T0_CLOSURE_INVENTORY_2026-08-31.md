# PRYSM T0 Closure Inventory

Date: 2026-08-31  
Status: FROZEN RECOVERY / DEPENDENCY MAP  
Application baseline: `e7e8477819f8bff0a7e3f0c5969637df9fb787a3`  
Recovered repair branch: `repair/prysm-production-closure`

## Recovered local repair package

The dirty worktree was preserved while creating the repair branch. The four
tracked local changes are the previously recorded governed repairs:

1. `scoring-service.js`: ScoreSet carries `rootCauseRuleId`.
2. `audit-orchestrator.js`: base score projection carries `rootCauseRuleId`.
3. `narrative-v2/production-path.js`: both production WriterInput calls carry
   DecisionEvidence and V2 projection carries `rootCauseRuleId`.
4. `application/narrative-v2-production-path.test.js`: controlled Writer and
   Judge fixtures derive action rank, effort, and hierarchy evidence from the
   current WriterInput instead of stale constants.

Untracked `TBK-*`, `NV2-*`, diagnostic text, and replay fixture directories
are preserved local diagnostic output. They are not source-of-truth contracts,
are excluded from candidate commits, and must not be used as current release
proof.

## Current production dependency map

| Semantic state | Producer | Persisted contract / loader | Current consumers | Required closure |
| --- | --- | --- | --- | --- |
| Source status and normalized evidence | source execution -> `buildDecisionEvidence` | SourceResults -> DecisionEvidence -> CapabilityEvidence; governed loaders | scoring, ReportContent, WriterInput, report surfaces | T4 coherence and unknown honesty |
| Findings and Conversion-First hierarchy | `scoreAudit` / `action-priority` | FindingSet plus current ScoreSet decision contract | root-cause selection, WriterInput, finalization, render | T1 derive once, version, persist, validate |
| Root-cause identity | `scoreAudit` | ScoreSet `rootCauseRuleId` (currently permissive schema) | base model, V2 model, finalization | T1 explicit schema/read-write validation |
| Current report model | validated current persisted artifacts | no single canonical hydrator today | orchestrator base projection, V2 `buildV2Model`, replay `buildV2Model` | T2 single fail-closed hydrator |
| WriterInput and Narrative versions | Narrative V2 production wrapper | WriterInput/release artifacts; `1.0.0` is historically ambiguous | Writer, Judge, recovery/finalization | T3 truthful current version and validation |
| ReportContent/source presentation | `buildReportContentPackage` | ReportContentPackage and manifests | Viewer v2, rerender/replay | T4 remove semantic imputation and enforce coherence |
| Current replay/recovery | persisted release artifacts | direct JSON parse in parts of Narrative V2/replay | Viewer v2 and finalization | T2/T4 validated current lane; legacy separate |

The required production spine remains:

`AuditRequest -> controlled source execution -> SourceResults -> DecisionEvidence -> CapabilityEvidence -> scoreAudit -> FindingSet/ScoreSet -> validated reload -> current hierarchy -> WriterInput -> Writer -> Judge -> finalization -> Viewer v2 -> persistence -> recovery/current replay`.

## Verified duplicate and false-PASS inventory

- Duplicate current ScoreSet/report projections: `src/orchestration/audit-orchestrator.js`, `src/narrative-v2/production-path.js`, and `scripts/replay-report.js` (SYS-12). T2 owns replacement.
- Current ScoreSet schema omits release-critical fields and permits semantic omissions; byte/SHA integrity is not semantic validation (SYS-09/10). T1 owns replacement.
- Narrative V2 direct-parses persisted `scores.json` and `findings.json` on a current read boundary (SYS-11). T1/T2 own validation.
- `npm test` omits `src/application`; CI also omits that production-path family (SYS-01/02). T5 owns explicit enumeration, composite command, and CI.
- WriterInput `1.0.0` and historical Writer/Judge versions collide with current Conversion-First semantics (SYS-16/17). T3/T4 own versioned separation.
- ReportContent and model fallbacks can fabricate zero/false/Complete/empty meaning; historical artifacts have contradictory source statuses (SYS-13/18/19). T2/T4 own fail-closed/current coherence.

## Tranche proof map

| Tranche | Boundary proof that must be added or strengthened |
| --- | --- |
| T1 | persisted current hierarchy/root cause schema, write/read validation, missing identity fail-closed |
| T2 | one shared current hydrator consumed by base, V2, and current replay |
| T3 | versioned persisted WriterInput and production-shaped multi-finding Writer/Judge tests |
| T4 | explicit current versus legacy replay, source-status/ReportContent semantic coherence |
| T5 | `verify:prysm-closure`, explicit all-family inventory, static false-PASS checks, CI parity |
| T6 | deterministic `createProductionRuntime` golden scenarios G1-G6 with controlled transports/models |
| T7 | exact-SHA independent audit, synchronization, and owner-only promotion boundary |

## T0 verdict

T0 is complete: no local repair was lost, the dedicated application branch is
established, the local repair package is reconciled with SYS-04/07/08, and the
remaining release-critical contract/proof boundaries are assigned without
claiming a current release PASS.
