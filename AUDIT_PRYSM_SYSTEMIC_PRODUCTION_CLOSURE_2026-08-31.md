# PRYSM Systemic Production Closure Audit

Date: 2026-08-31
Status: VERIFIED SYSTEMIC FINDINGS / INPUT TO AUTONOMOUS CLOSURE
Application remote baseline reviewed: `e7e8477819f8bff0a7e3f0c5969637df9fb787a3`
Application repo: `chriskulbaba2025/vantage-platform`
Governance repo: `chriskulbaba2025/prysm-project-context`

## Purpose

This audit explains why PRYSM repeatedly reached a supposed final test and then exposed another failure one boundary later.

Conclusion:
The incident is not a collection of unrelated local bugs. It is a contract-migration and proof-coverage design failure. Conversion-First v4.2 changed release-critical semantics without one complete Producer -> Contract/Persistence -> Loader -> Consumer -> Gate -> Renderer -> Replay/Recovery migration.

This audit replaces the prior assumption that PF-01 through PF-18 and CONTRACT-CLOSURE could remain treated as globally closed without qualification. Reopen only dependent closure claims contradicted by the evidence below.

## Confirmed systemic findings

### SYS-01 - `npm test` is not a full worker regression

`services/worker/package.json` selects specific source directories. Release-relevant worker areas including `src/application` are outside that command.

Impact:
The previously reported 959/959 PASS result is valid for that command but cannot be called full-worker proof.

Required closure:
Inventory all worker test families and create one explicit composite gate that includes every release-relevant family.

### SYS-02 - CI omits critical application production-path tests

`.github/workflows/worker-ci.yml` runs more than `npm test`, including Narrative v2 suites, but does not include the application test family containing `src/application/narrative-v2-production-path.test.js`.

Impact:
The production Narrative v2 wrapper can be broken while intended CI coverage remains incomplete.

Required closure:
Make the exact production-path application tests part of the release-critical gate and CI.

### SYS-03 - current remote main is not a verified release authority

At audit time:
- `main` = `e7e8477819f8bff0a7e3f0c5969637df9fb787a3`;
- branch protection is disabled;
- required status checks are off;
- the Worker CI run associated with that commit was observed queued rather than concluded PASS.

Impact:
`main` currently means latest pushed code, not necessarily exact-head governed PASS.

Required closure:
Do not use `main` alone as proof. Final candidate requires exact-SHA local/composite proof and honest CI/release-control state.

### SYS-04 - WriterInput semantic migration omitted its production caller

Current WriterInput derives Conversion-First action state from DecisionEvidence, but committed Narrative v2 production `runNarrativeV2FromScored()` did not pass `decisionEvidence` into `buildWriterInput()`.

Observed production-path failure:
`decisionEvidence is required for governed Writer action-plan parity`

Local repair already made before autonomous closure:
Both applicable production `buildWriterInput()` calls pass `decisionEvidence: inputs.decisionEvidence`.

Required closure:
Preserve the local repair, migrate every WriterInput caller/test to the current contract, version/validate WriterInput truthfully, and add permanent production-boundary regression.

### SYS-05 - Writer output fixtures bypassed the governed hierarchy

`src/narrative-v2/writer-output.test.js` manually constructs WriterInput. The main fixture does not carry a production-shaped non-empty `deterministicAnalysis.conversionInfluence`.

Impact:
The Writer action order/rank/effort validation branch can remain inactive while tests pass.

This explains why a stale hard-coded effort such as `"M"` survived until the application production-path test exercised real governed findings.

Required closure:
Generate Writer fixtures from the real builder/canonical fixture builder and prove at least two governed findings with non-empty hierarchy.

### SYS-06 - contract-closure fixture was too weak for action parity

`src/narrative-v2/contract-closure.test.js` uses the production WriterInput builder but its ScoreSet/finding setup can produce an empty governed action hierarchy.

Impact:
A contract-closure PASS did not prove action order/rank/effort parity.

Required closure:
Make the contract closure scenario production-shaped and non-empty where action parity is the requirement.

### SYS-07 - Judge fixture/version drift escaped

Current Judge contract/prompt semantics moved to contract `1.1.0` / prompt `2.1.0` and added Conversion-First hierarchy grounding requirements.

The application test fixture was stale until locally repaired to:
- `judgePromptVersion: "2.1.0"`;
- include `analysis:conversionInfluence` in conversionInterpretation evidenceRefs.

Required closure:
Centralize current Judge fixture/version identity and prevent synthetic old prompt versions from passing current release proof.

### SYS-08 - `rootCauseRuleId` producer/persistence/consumer migration was incomplete

Commit `e7e847...` added `rootCauseRuleId` to `scoreAudit()` and added a finalization consumer that checks root-cause/action hierarchy agreement.

The same commit did not add `rootCauseRuleId` to `buildScoreSet()` persistence.

Observed failure:
Finalization fell back to the first score-bearing finding (`VAN-CONTENT-001`) while the governed Conversion-First hierarchy ranked another finding (`VAN-TRUST-002`) first.

Local repair already made before autonomous closure:
- `scoring/scoring-service.js` now carries `rootCauseRuleId` into ScoreSet;
- base orchestration projection preserves it;
- Narrative v2 `buildV2Model()` preserves it.

Focused `NV2-PROD-02` then PASSed.

Required closure:
Do not stop at property propagation. Make root-cause/hierarchy identity a persisted versioned governed contract and consume it from one canonical current model boundary.

### SYS-09 - ScoreSet schema is incomplete/permissive relative to actual persistence

`src/contracts/score.schema.json` does not define `rootCauseRuleId` and omits multiple properties current `buildScoreSet()` writes/consumers use. Top-level extra properties are allowed.

Impact:
Schema PASS can prove structural compatibility while release-critical semantic fields are absent or silently outside the schema.

Required closure:
Current contract must explicitly govern release-critical persisted fields and validate them on write and read.

### SYS-10 - artifact integrity is stronger than semantic completeness

`persistScores()` performs validation, exact byte-length/SHA verification, read-back, and store verification.

That proves stored bytes are exact.

It does not prove the bytes contain every field a downstream current consumer requires when the schema itself is incomplete.

Required closure:
Treat byte/SHA integrity and semantic completeness as separate gates.

### SYS-11 - Narrative v2 current read boundary does not fully revalidate scores/findings

`loadScoredInputs()` loads DecisionEvidence and CapabilityEvidence through governed validation but directly parses persisted `findings.json` and `scores.json` bytes.

Impact:
Old/incompatible current-critical ScoreSet/FindingSet shape can enter newer Narrative code unless explicitly rejected/migrated.

Required closure:
Validate current compatible artifacts at every current production/recovery read boundary.

### SYS-12 - multiple independent ScoreSet/report model reconstructions exist

At least these paths reconstruct selected fields independently:
1. base report/orchestrator model projection;
2. `src/narrative-v2/production-path.js` `buildV2Model()`;
3. `scripts/replay-report.js` `buildV2Model()`.

Impact:
A new governed field can be fixed in one path and lost in the next, producing the exact tail-chasing pattern observed.

Required closure:
One canonical current validated artifact -> report model hydration boundary, reused by all current consumers.

### SYS-13 - reconstruction paths contain semantic defaults

Current report/model builders contain fallbacks such as:
- `assessedWeight ?? 0`;
- evidence confidence `?? 0`;
- empty arrays/objects;
- empty strings;
- fallback versions/statuses.

Impact:
Missing governed state can become plausible client/report state rather than failing closed.

Required closure:
Remove semantic defaults for required current governed values. Retain only contract-proven neutral defaults.

### SYS-14 - Conversion-First hierarchy is described as render-time but now drives canonical root cause

`src/report/action-priority.js` describes the Conversion-First hierarchy as a render-time derived decision view.

`scoreAudit()` now uses the same hierarchy to choose canonical root cause.

Impact:
The architecture changed from presentation ordering to release-critical canonical decision semantics without a persisted/versioned decision contract.

Required closure:
Derive once, version, persist, and consume everywhere.

### SYS-15 - historical replay can change meaning under current algorithms

Replay loads historical artifacts and recomputes current finalization/action hierarchy using current code.

Impact:
An old ScoreSet/root cause can be judged against a newer Conversion-First algorithm and fail or change meaning even if it was coherent when originally produced.

Required closure:
Separate current-release replay from legacy compatibility replay. Historical business decisions must not be silently recomputed under current semantics.

### SYS-16 - WriterInput version identity is not trustworthy across semantic eras

Historical replay WriterInput declares `writerInputVersion: "1.0.0"` and predates Conversion-First hierarchy state.

Current code also declares WriterInput `1.0.0` while requiring materially different semantics.

Impact:
The same version label represents incompatible contracts.

Required closure:
Truthful current WriterInput version bump/compatibility boundary plus persisted current WriterInput validation.

### SYS-17 - replay historical Writer/Judge compatibility is a known future failure chain

Historical replay artifacts contain Writer prompt `2.0.0` and Judge contract/prompt `1.0.0` / `2.0.0`.

Current validators require newer current versions. Replay contains a bounded historical Judge compatibility exception, but current rendering revalidates WriterOutput against current Writer rules.

Impact:
Fixing one historical replay mismatch can simply expose the next version mismatch.

Required closure:
Legacy compatibility lane must be explicit and excluded from current release readiness.

### SYS-18 - ReportContentPackage can erase evidence uncertainty

`src/report-content/build-package.js` contains transformations/defaults including:
- missing site metrics -> zero;
- missing trust observations -> false;
- source-status fallbacks;
- missing readiness -> `"Complete"`;
- permissive finding fallback values.

DecisionEvidence v1 intentionally uses some numeric placeholders plus availability metadata to preserve unknown-counter honesty.

Impact:
A stricter upstream evidence state can become an apparently measured downstream state.

Required closure:
ReportContent must preserve source/capability certainty semantics and current status coherence rather than impute client-facing truth.

### SYS-19 - same historical run can contain contradictory source statuses

The supplied historical audit package showed report-content statuses such as `NOT_CONNECTED` while a V2 manifest represented the same sources as `NOT_APPLICABLE`.

Impact:
Shape-valid artifacts can disagree semantically within one audit.

Required closure:
Add cross-artifact semantic-coherence rules for current releases.

### SYS-20 - original Narrative v2 production checklist became stale after Conversion-First changes

`.governance/changes/PRYSM-NARRATIVE-V2_PRODUCTION_PATH_CHECKLIST.md` froze a production WriterInput composition based on AuditRequest + ScoreSet + FindingSet + CapabilityEvidence and did not include DecisionEvidence/current hierarchy.

Impact:
Later semantics changed beneath a frozen proof model without a replacement production-spine migration.

Required closure:
The new Production Closure roadmap supersedes that limited proof model for current Conversion-First release readiness.

### SYS-21 - project durable memory became contradicted

Prior `CURRENT_STATE.md` still recorded:
- old application SHA `90916e...`;
- obsolete next action around `score-components.js`;
- global PF-01 through PF-18 closure;
- CONTRACT-CLOSURE 5/5 PASS;
- instruction not to reopen architecture.

New production evidence directly contradicted those dependent closure claims.

Required closure:
Replace current state with present truth and mark dependent closure claims reopened without rewriting historical work.

### SYS-22 - manual workflow is no longer sufficient for this closure package

The older decision to deliver one source-file edit at a time through chat reduced local edit risk, but the current failure spans persistence contracts, loaders, multiple consumers, tests, CI, replay, and release controls.

User explicitly requested a long autonomous Codex VS Code run with measured gates at each tranche.

Required closure:
For this Production Closure package only, use the governed autonomous Builder/Auditor loop while preserving all evidence, authorization, and no-destructive-change constraints.

## Confirmed local repair checkpoint before autonomous run

The prior interactive session already made local governed repairs that must be preserved:
- Narrative production WriterInput gets DecisionEvidence;
- production application Writer fixture derives governed action rank/effort/reference instead of hardcoding;
- Judge fixture uses current prompt/version and hierarchy evidence reference;
- ScoreSet locally carries `rootCauseRuleId`;
- base orchestration projection locally carries `rootCauseRuleId`;
- Narrative v2 model projection locally carries `rootCauseRuleId`.

Focused proofs:
- `NV2-PROD-02` PASS after full rootCauseRuleId production propagation repair;
- `NV2-PROD-06` PASS for invalid persisted terminal Narrative state fail-closed/no-extra-spend behavior;
- broad `npm test` command PASS 959/959, but this is explicitly not considered full-worker closure because of SYS-01.

The exact local dirty diff remains to be recovered by T0. Do not reconstruct it from this file if local source differs; inspect the working tree directly.

## Governing closure response

Do not run another ad hoc replay/test sequence from this audit.

Use:
`PRYSM_PRODUCTION_CLOSURE_ROADMAP_2026-08-31.md`

Automated execution:
`tools/autorun/PRYSM-AUTORUN.ps1`

Independent gate:
`PRYSM_WHOLE_APP_TRANCHE_GATE.md`

Independent review:
`PRYSM_POSTRUN_AUDIT_PROTOCOL.md`

Terminal objective:
repository-controlled closure at one exact audited SHA, followed by explicit production promotion/new-audit authorization if still required.
