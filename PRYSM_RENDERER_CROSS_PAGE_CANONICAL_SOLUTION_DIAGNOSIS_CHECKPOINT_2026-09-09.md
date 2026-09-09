# PRYSM Renderer / Cross-Page Canonical Solution Diagnosis Checkpoint

Date: 2026-09-09
Status: READY_FOR_IMPLEMENTATION / BETTY DEFERRED FOR INTERMEDIATE DEVELOPMENT

## Application baseline

Repository: `chriskulbaba2025/vantage-platform`

Branch: `review/prysm-solution-directive-authority-betty`

Exact starting SHA: `f0a46f0e23d8b9b0d7a6d4a9a155119344af3e5a`

## Diagnosis result

`RESULT: READY_FOR_IMPLEMENTATION`

Canonical solutions are generated in the current Narrative v2 deterministic preparation path but are discarded before render preparation. The client renderer therefore still rebuilds solution-like content from legacy Finding fields and hard-coded per-rule prose.

## Verified competing remedy sources

- Executive Scorecard priorities: legacy competing authority via `buildActionPlan()`, `finding.businessImpact`, `finding.recommendation`, and hard-coded remedy copy.
- Priority Fixes: legacy competing authority via `priorityClientCopy()`, `businessImpact`, `recommendation`, `affectedUrls`, and hard-coded rule prose.
- Conversion Journey: intended summary/reference role, but current links/copy do not carry canonical solution IDs.
- Content Opportunities: intended summary/reference role only where content opportunities overlap actionable canonical findings.
- Competitor Comparison: evidence/context or canonical reference only; competitor observations do not authorize client fixes.
- Trust & Credibility: legacy competing remedy usage exists where Finding recommendation/businessImpact is rendered as action guidance.
- Supporting Detail action plan: legacy competing authority via Finding recommendation/businessImpact/verificationMethod.
- WriterOutput.actionPlan: diagnostic-only under current hidden narrative diagnostic layer; must never populate canonical solution detail.
- Writer executive decision fields: bounded interpretation only, not remediation authority.

## Selected canonical ownership model

One canonical solution record per actionable underlying issue.

- Priority Fixes owns full canonical client-facing solution detail.
- Executive Scorecard renders top-three canonical summaries referencing the same stable solution IDs.
- Conversion Journey, Content Opportunities, Competitor Comparison, Trust & Credibility, and Supporting Detail may summarize or deep-link to existing canonical solution IDs only.
- Supporting Detail remains evidence/context depth, not a competing solution source.
- Writer/Judge remain interpretation/quality layers and do not own remediation authority.

## Selected canonical data flow

Persisted governed findings + ScoreSet/decision hierarchy + DecisionEvidence + CapabilityEvidence
→ existing versioned Solution Authority Provider
→ repaired `buildSolutionDirectiveInput()`
→ accepted `generateCanonicalSolutions()`
→ in-memory `canonicalSolutions` on the current report model
→ deterministic report renderer
→ Priority Fixes canonical detail + cross-page references to the same solution IDs.

The same provider/generator is deterministically rerun for render/UAT preparation from the same persisted governed inputs. No new persistence artifact is required.

## Contract/persistence decisions

- WriterInput change required: NO
- Writer contract change required: NO
- Judge contract change required: NO
- Report model change required: YES — add `canonicalSolutions` to the in-memory current semantic report model.
- Report content contract change required: NO
- Persistence change required: NO

## Expected implementation boundary

Application files expected to change:

1. `services/worker/src/narrative-v2/production-path.js`
2. `services/worker/src/report-model/current-model.js`
3. `services/worker/src/report/render-report-v2.js`
4. `services/worker/src/report/report-detail-sections.js`

Test files expected to change/create only as directly required:

1. `services/worker/src/application/narrative-v2-production-path.test.js`
2. `services/worker/src/report/render-report-v2-canonical-solutions.test.js` — new focused renderer ownership/reference suite
3. `services/worker/src/report/render-narrative-v2.test.js` — only focused non-authority assertions if required
4. nearest affected existing render-report-v2 fixture tests
5. nearest report-detail test if current inventory lacks direct coverage

`render-narrative-v2.js` is not in the selected implementation boundary unless direct implementation inspection proves a visible non-hidden competing Writer remedy path.

## Fail-closed requirements

- No renderer fallback to `finding.recommendation`, `businessImpact`, `verificationMethod`, `affectedUrls`, hard-coded rule remedy prose, competitor recommendation, or Writer action text when canonical solution detail is required.
- Missing canonical solution for an actionable governed hierarchy finding fails closed in the solution-detail path.
- Priority Fixes and Executive summaries require valid stable canonical solution IDs and governed display eligibility.
- Cross-page references resolve to the same canonical solution IDs; pages do not synthesize new remedies or IDs.
- Site anchor/scope comes only from canonical solution records.
- PARTIAL remains CONDITIONAL; UNKNOWN remains INVESTIGATIVE or NON_REMEDIATION.
- Unsupported/diagnostic findings never gain remedies.
- Current six primary pages plus Supporting Detail remain unchanged.

## Preserved systems

Do not change solution authority provider, repaired authority resolver, solution contract, validator, generator, sequence, scoring/evidence production, DecisionEvidence, CapabilityEvidence, action-priority scoring semantics, WriterInput/Writer/WriterOutput/Judge contracts, lifecycle, persistence/artifact contracts, report-content contract, production configuration, provider/adapters, page count/names, or deployment state.

## Required direct proving tests

- Canonical solution set reaches the deterministic report model/render path.
- Priority Fixes renders canonical solution IDs and canonical detail/anchor/capability/effort/dependencies/implementation check/evidence grade/mode.
- Executive top-three IDs match the first eligible canonical sequence IDs.
- Journey/Content/Competitor/Trust/Supporting Detail references use existing canonical IDs where applicable.
- Mutating/removing legacy recommendation/businessImpact/verificationMethod/affectedUrls/Writer action text does not alter canonical solution detail.
- Missing canonical records fail closed.
- PARTIAL/UNKNOWN modes do not upgrade.
- Identical persisted governed inputs rerender deterministically.
- UAT/recovery uses the same provider/version and does not call Writer/Judge again for canonical authority.
- Non-v2 path remains unchanged.
- Viewer remains exactly six primary pages plus Supporting Detail.

## Governance effect

Renderer/cross-page implementation is now authorized for intermediate development under the existing temporary Betty deferral.

Supporting Detail solution-depth work remains blocked until this canonical renderer/reference tranche is implemented, verified, and published.

Merge to application `main`, deployment, production promotion, provider/model execution, audit rerun, and production mutation remain blocked until deferred Betty review is caught up and release governance passes.

## Exact next action

Starting from exact application SHA `f0a46f0e23d8b9b0d7a6d4a9a155119344af3e5a` on `review/prysm-solution-directive-authority-betty`, implement only the model-carried canonical renderer/cross-page reference architecture within the diagnosed source/test boundary; run focused canonical renderer tests and comparable regressions; produce a Downloads proof; commit/push the bounded non-production candidate; stop before Supporting Detail solution-depth work and before any release action.