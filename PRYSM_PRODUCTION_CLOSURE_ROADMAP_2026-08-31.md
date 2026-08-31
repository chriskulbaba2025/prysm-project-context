# PRYSM Production Closure Roadmap

Date: 2026-08-31
Status: ACTIVE / GOVERNING CLOSURE PACKAGE
Goal: eliminate the stale-state, contract-propagation, false-PASS, replay, and release-control failures that caused repeated one-more-test repair loops, then leave the repository-controlled system at a verified fresh-audit readiness boundary.

## Authority

Application repository:
`chriskulbaba2025/vantage-platform`

Durable governance/project memory:
`chriskulbaba2025/prysm-project-context`

Current remote application `main` at roadmap creation:
`e7e8477819f8bff0a7e3f0c5969637df9fb787a3`

The local application working tree is known to contain governed uncommitted repair work. Its exact current SHA/diff is UNKNOWN until the autonomous Builder inspects it locally. Preserve it. Never reset, clean, checkout-overwrite, or discard it.

## Governing objective

This is not another targeted PF/NV2 repair sequence.

The closure target is one governed production spine:

`AuditRequest -> SourceResults -> DecisionEvidence -> CapabilityEvidence -> deterministic scoring -> persisted ScoreSet/FindingSet -> persisted Conversion-First decision hierarchy -> WriterInput -> Writer -> Judge -> finalization -> Viewer v2 -> persistence/reload/recovery`

The same governed semantic state must survive every material boundary without independent reconstruction, stale compatibility guessing, or semantic defaults.

## Terminal definition

The autonomous closure roadmap is exhausted only when all repository-controlled conditions below are true at one exact application SHA:

- every tranche T0-T7 has a durable PASS;
- the independent Auditor has PASSed the final exact SHA;
- the deterministic PRYSM Whole-App Tranche Gate passes;
- the composite local machine gate passes;
- all intended worker test families are included in the composite gate;
- current Narrative v2 production-path application tests are included;
- current-release replay is separate from historical compatibility replay;
- persisted current contracts are versioned and validated at write and read boundaries;
- no known material false-PASS mechanism remains open;
- no known duplicate source of truth remains for the governed Conversion-First hierarchy/report model;
- application repair branch is pushed and local/remote SHA equality plus 0/0 divergence are proven;
- governance memory is pushed, re-read, and synchronized;
- `CURRENT_STATE.md` names one truthful next action.

`COMPLETE` means repository-controlled closure is complete. It does NOT silently authorize merge to `main`, deployment, production configuration changes, paid provider calls, paid Writer/Judge calls, or a fresh production audit. If those external actions have not been separately authorized, the exact next action is the human production-promotion/new-audit authorization boundary.

## Global repair rules

1. Diagnose before editing.
2. Maximum three evidence-based repair attempts against the same root defect.
3. A third failed attempt is a mandatory root-cause/process reset; do not keep retrying the same mechanism.
4. Every escaped production defect receives a permanent executable regression when feasible.
5. Every false-PASS escape receives a proof-system repair, not only a product-code repair.
6. Never weaken an existing gate or expected outcome merely to obtain PASS.
7. Never replace UNKNOWN / UNAVAILABLE / PARTIAL / not-deeply-parsed with absence, false, zero, empty, complete, or available unless the governed evidence establishes that state.
8. Required governed state missing at a current-contract boundary fails closed.
9. Historical compatibility is not current release proof.
10. A tranche PASS is invalidated when application HEAD changes after its exact-SHA gates.
11. No tranche closes on targeted tests alone.
12. Do not use a fresh paid audit to prove repository-controlled behavior that can be proven deterministically.

## T0 - Recovery, exact baseline, and closure contract freeze

Objective:
Recover the actual local state and freeze the end-to-end dependency map before further product edits.

Required work:
- inspect local application branch, HEAD, upstream, working tree, and current uncommitted repairs;
- preserve every intended local change;
- create/recover `repair/prysm-production-closure` without discarding dirty work;
- inspect governance local/remote state;
- reconcile current local repairs with the systemic audit findings;
- build one durable Producer -> Contract/Persistence -> Loader -> Consumer -> Gate -> Renderer -> Replay map for all release-critical fields;
- identify every duplicated report/scoring-model reconstruction;
- identify every current test family omitted by `npm test` and by CI;
- identify every stale current/historical artifact/version collision;
- identify every semantic default that can manufacture governed meaning;
- record the exact closure inventory in governance.

Gate T0:
- zero lost local work;
- exact repair branch established or safely recoverable;
- dependency map complete enough to explain all known failures without guessing;
- no unresolved contradiction about which artifacts/contracts are current versus historical;
- no product code change made before the map is frozen, except changes strictly necessary to preserve/recover the dirty worktree safely.

## T1 - Persisted Conversion-First decision contract and ScoreSet closure

Objective:
Make the governed Conversion-First decision hierarchy a versioned persisted source of truth instead of a render-time recomputation that consumers rediscover independently.

Required work:
- define the current governed persisted decision hierarchy contract;
- preserve at minimum ordered governed findings, rule identity, rank, influence domain/class, governed effort, root-cause binding, and hierarchy version/provenance required downstream;
- make scoring derive the hierarchy once from governed evidence/findings;
- persist it in the current ScoreSet or a single explicitly governed adjacent canonical artifact;
- make `rootCauseRuleId` an explicit current governed field;
- align current ScoreSet schema with every release-critical persisted field actually consumed downstream;
- version the contract truthfully when semantics are incompatible with historical `1.0.0` artifacts;
- validate current ScoreSet on write and on every current production/recovery read boundary;
- define an explicit current-versus-legacy compatibility policy rather than accepting ambiguous old shapes.

Gate T1:
- producer, persisted bytes, validated reload, and consumer see the same hierarchy/root-cause identity;
- missing release-critical hierarchy identity fails closed;
- no downstream layer must derive a different root cause from array order or first score-bearing finding;
- escaped `rootCauseRuleId` regression permanently covered;
- exact-SHA Whole-App Tranche Gate PASS.

## T2 - One canonical report-model hydration boundary

Objective:
Eliminate the multiple independently maintained ScoreSet -> report model projections that caused fixes to fail one hop later.

Required work:
- create one canonical fail-closed current model hydrator/adapter from validated persisted artifacts;
- base report rendering, Narrative v2 rendering, UAT rerender, and current-release replay consume that same governed adapter or exact shared object contract;
- remove/reduce independent field-by-field model reconstructions;
- remove semantic defaults for required current governed values;
- retain optional defaults only when the contract proves they are semantically neutral;
- ensure model comments accurately describe implementation.

Gate T2:
- one changed governed field cannot be silently dropped by base/V2/replay independently;
- static/proof test demonstrates the three paths consume the same current semantic source;
- exact-SHA Whole-App Tranche Gate PASS.

## T3 - WriterInput / Writer / Judge current-contract migration

Objective:
Complete the Conversion-First contract migration through the Narrative v2 boundary.

Required work:
- current production WriterInput receives every required governed input, including DecisionEvidence/current hierarchy context;
- bump/version WriterInput semantics truthfully when incompatible with historical WriterInput `1.0.0`;
- add a governed WriterInput persisted-artifact validation boundary;
- production-shaped Writer fixtures must be generated from the real current builder or a single canonical fixture builder;
- remove synthetic richer-than-production `sourceDependencies` or other fields unless production truly persists them;
- action priority/order/effort validation must exercise at least two governed findings and non-empty Conversion-First hierarchy;
- Judge conversionInterpretation must cite the current governed hierarchy reference when required;
- Writer/Judge prompt/contract versions must be coherent with current persisted artifacts;
- current production application test family must be part of the intended release verification surface.

Gate T3:
- the previously escaped decisionEvidence, effort/rank, Judge hierarchy-reference, and invalid-terminal-artifact cases are permanent regressions;
- no hard-coded finding ID or effort is required for PASS;
- current production-path deterministic Narrative run reaches its governed terminal result;
- exact-SHA Whole-App Tranche Gate PASS.

## T4 - Replay, ReportContent, and semantic-coherence closure

Objective:
Stop historical fixtures and permissive downstream packages from masquerading as current release proof.

Required work:
- split current-release replay from legacy/historical compatibility replay;
- current replay accepts only current compatible artifact versions and current governed hierarchy;
- legacy replay is explicitly labeled compatibility-only and can never satisfy current release readiness;
- ReportContentPackage must not turn missing/unknown evidence into `0`, `false`, `Complete`, `NOT_CONNECTED`, deterministic confidence, score-bearing truth, or other fabricated semantics;
- source status must remain coherent across DecisionEvidence, ReportContentPackage, manifests, WriterInput, and rendered report;
- stale artifacts are rejected or explicitly migrated under a versioned compatibility boundary;
- current replay uses the same canonical current model hydration boundary from T2.

Gate T4:
- a current artifact set cannot contain contradictory source states and still pass the current release gate;
- historical 2.0 Writer/Judge artifacts cannot be mistaken for current 2.1 release proof;
- current replay is reproducible from current validated artifacts;
- exact-SHA Whole-App Tranche Gate PASS.

## T5 - False-PASS elimination and composite machine gate

Objective:
Replace misleading partial test labels with one executable local closure gate.

Required work:
- inventory every worker `*.test.js` family and make exclusions explicit;
- add `src/application` and every release-relevant omitted family to the composite verification surface;
- preserve targeted tests but never call them full regression;
- add false-PASS/static checks for synthetic WriterInput shapes, empty hierarchy fixtures where hierarchy parity is required, hardcoded PASS validators, pre-seeded terminal state pretending to be tip-to-tail acceptance, and production paths not exercised by acceptance;
- create one local command (recommended responsibility: `verify:prysm-closure`) that fails non-zero on any required gate failure;
- include schema/contract checks, targeted escaped-defect regressions, all intended worker tests, whole-app acceptance, diff hygiene/static checks, build/syntax checks that are material to the worker path;
- update CI so the exact same closure-critical test families are not omitted;
- record exact-head CI status honestly; queued/unavailable is not PASS.

Gate T5:
- one command is the authoritative repository-controlled machine gate;
- all required test families are enumerated rather than implied by directory globs that omit production areas;
- CI and local gate cannot both be green while `src/application/narrative-v2-production-path.test.js` is broken;
- exact-SHA Whole-App Tranche Gate PASS.

## T6 - Deterministic full PRYSM V2 production spine

Objective:
Prove the assembled current production composition from request to reloadable Viewer v2 without paid/live providers or models.

Minimum golden scenarios:
1. current V2 audit with sufficiently complete controlled evidence reaches `DRAFT_RENDERED` through `createProductionRuntime` and the real Narrative v2 wrapper;
2. a PARTIAL/unknown-evidence scenario proves uncertainty survives into current persisted/report/Narrative surfaces without becoming absence/zero/false;
3. a current Conversion-First multi-finding scenario proves root cause, ordered actions, rank, and effort stay identical from scoring through final render;
4. persisted release-candidate reload/recovery renders without another Writer/Judge execution set;
5. invalid/stale current terminal artifact fails closed without another model spend;
6. current report/replay reconstructs from persisted validated artifacts without a separate semantic derivation.

Rules:
- controlled/frozen external transports are allowed;
- internal production composition may not be mocked away;
- live paid provider calls: 0;
- live paid Writer/Judge calls: 0;
- no AWS/Vercel/Railway mutation;
- same exact SHA for the gate and closure claim.

Gate T6:
- all golden scenarios PASS;
- measured controlled Writer/Judge call counts match expectations;
- output contains governed Viewer v2 and valid release/finalization state;
- full composite machine gate PASS on exact unchanged SHA.

## T7 - Independent final audit, release controls, and fresh-audit readiness

Objective:
Independently challenge the complete candidate and leave one truthful terminal state.

Required work:
- independent Auditor reviews the exact candidate SHA with no application-write authority;
- audit contract propagation, duplicate sources of truth, semantic defaults, historical/current versioning, false-PASS risk, persistence/recovery, cost/live-call boundaries, and final machine-gate evidence;
- repair every material audit FAIL through Builder -> gate -> Auditor loop;
- verify application branch remote equality and 0/0 divergence;
- verify governance remote equality and read-back;
- evaluate `main` release controls/branch protection and record any external GitHub control that still requires owner action;
- update `CURRENT_STATE.md`, closure state, and final handoff with one exact next action.

Gate T7:
- final Auditor verdict PASS;
- zero open material defects;
- exact candidate SHA unchanged since final whole-app/machine gates;
- application and governance GitHub state synchronized;
- terminal state is either:
  - `READY_FOR_FRESH_AUDIT` when all required production promotion/deployment permissions have already been explicitly granted and completed outside this repository-controlled closure; or
  - `READY_FOR_AUTHORIZED_PRODUCTION_PROMOTION` when merge/deploy/new paid audit remains a human authorization boundary.

## Independent-audit rule at each application-changing tranche

Every application-changing tranche T1-T6 must pass this sequence before the next tranche begins:

`Builder candidate -> exact-SHA Whole-App Gate -> composite applicable checks -> push/sync -> independent Auditor -> PASS -> next tranche`

If Auditor returns FAIL, the controller hands the exact bounded defects back to Builder. The tranche stays open. No later tranche starts.

## No tail-chasing rule

The autonomous loop must not respond to a new failure by immediately editing the nearest file.

For every new failure:
1. classify whether it is product defect, contract migration defect, fixture drift, false-PASS proof defect, historical/current compatibility defect, or external/infrastructure failure;
2. trace the full affected Producer -> Contract -> Persistence -> Loader -> Consumer chain;
3. repair the root contract/path plus the escaped-proof mechanism;
4. rerun only the tranche proof and mandatory whole-app/machine gates;
5. never add another ad hoc test merely to move the failure one hop downstream.

## External authorization boundary

This roadmap authorizes autonomous local diagnosis, source edits, deterministic tests, local commits, normal fast-forward pushes to the dedicated repair branch, governance-memory updates, and GitHub synchronization needed to complete repository-controlled closure.

It does NOT by itself authorize:
- merging the repair branch to `main`;
- force push;
- deployment or production configuration mutation;
- AWS/Vercel/Railway mutation;
- live/paid provider recollection;
- live/paid Writer/Judge execution;
- starting a fresh production audit.

Those remain explicit user authorization boundaries unless a later durable instruction changes them.
