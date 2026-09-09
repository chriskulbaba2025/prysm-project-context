# PRYSM Writer Narrative Remediation Authority Leak — Diagnosis Checkpoint

Date: 2026-09-09
Status: READY_FOR_IMPLEMENTATION
Application starting SHA: `c37913acfd82580724c74feb26175e2f0c36232c`
Branch: `review/prysm-solution-directive-authority-betty`

## Betty defect

Betty returned:

`RESULT: REAL PROGRESS — NO`

`REASON: renderWriterNarrativeLayer still renders WriterOutput.actionPlan as a client-facing Action Plan, so canonical solutions are not the sole remediation authority.`

`CONFIDENCE: HIGH`

The defect is confirmed.

## Root cause

`renderGovernedNarrativeReportV2()` renders the deterministic report through `renderReportV2(model)`, then serializes the Writer-derived narrative layer into the client HTML before `</main>` and injects `NARRATIVE_CSS` before `</style>`.

The Writer layer includes hidden diagnostic HTML, but hidden / aria-hidden / CSS `display:none !important` does not remove those bytes from the final client report artifact.

The persisted `report-v2/pages/index.html` therefore still contains non-canonical Writer remediation semantics.

## Exact verified runtime dependency

At exact application SHA `c37913acfd82580724c74feb26175e2f0c36232c`, `hasRequiredNarrativeV2ReportStructure(html)` in `services/worker/src/narrative-v2/production-path.js` requires:
- `<!doctype html>`;
- the deterministic report text `Where are the problems?`;
- `id="narrative-layer"`.

Removing the Writer layer therefore requires a bounded structural-guard update in the production path so finalization validates the deterministic report-v2 structure rather than requiring the Writer HTML marker.

This is a render-structure compatibility guard only. It does not authorize lifecycle, persistence, Writer, Judge, scoring, evidence, or artifact-contract changes.

## Complete Writer-derived leak surface

Diagnosis identified the following as competing or unconstrained remediation/diagnostic content that must not be serialized into the client HTML artifact:
- `WriterOutput.actionPlan` / `actionPlanNarrativeSection()`;
- `executiveDecision.change`;
- `executiveDecision.doNext`;
- `executiveDecision.preserve` because the current contract does not guarantee non-prescriptive semantics;
- `conversion.priority`;
- `seoSerp.priority`;
- `aiSearch.opportunity`;
- funnel `nextAction`;
- unconstrained Writer gap/proof/technical prose that may become prescriptive;
- Writer executive conclusion/strength/root-cause/limitation/deeper-narrative fields because current Writer contracts do not provide a field-level non-prescriptive serialization guarantee;
- hard-coded advisory sentences inside the Writer narrative disclosure;
- Writer/Judge diagnostic HTML metadata and legacy narrative viewer assignments.

## Selected repair architecture

Use whole-layer removal at the client rendering boundary.

Writer/Judge may continue producing and validating internal outputs under their existing contracts. The client renderer must stop inserting Writer-derived narrative HTML into the report artifact.

Canonical remediation remains entirely owned by the deterministic report-v2 renderer using `canonicalSolutions`:
- Priority Fixes owns complete remedy detail;
- other client pages may use existing canonical summaries/references;
- no second Writer-authored remedy surface is introduced.

Do not selectively retain mixed Writer HTML. That would require a new semantic allowlist and would leave a recurring authority-leak surface.

## Exact expected production repair boundary

1. `services/worker/src/report/render-narrative-v2.js`
   - keep input validation / WriterOutput revalidation;
   - stop composing/inserting `renderWriterNarrativeLayer()` into client HTML;
   - stop injecting Writer-specific narrative CSS into client HTML;
   - remove or internalize now-unused client-layer serialization helpers/exports only as required by tests/callers;
   - return the deterministic canonical report-v2 HTML after successful governed input validation.

2. `services/worker/src/narrative-v2/production-path.js`
   - change only `hasRequiredNarrativeV2ReportStructure()` (and directly necessary adjacent guard assertions if proven) so the required structure is the deterministic report-v2 structure, not `id="narrative-layer"`;
   - no lifecycle, persistence, orchestration, provider, or audit behavior changes.

## Expected directly affected tests

- `services/worker/src/report/render-narrative-v2.test.js`
- `services/worker/src/application/narrative-v2-production-path.test.js`
- `services/worker/src/report/karen-style-regression.test.js` only if directly required because it imports `renderWriterNarrativeLayer()` or asserts the old layer.
- nearest directly affected render/finalization tests only if the implementation proves they are necessary.

## Required proving behavior

Implementation must prove:
- final client HTML contains canonical Priority Fix solution IDs/details;
- final client HTML contains no `narrative-action-plan`;
- no `narrative-decision`;
- no `narrative-diagnostic-layer`;
- no Writer `actionPlan`, Change, Do next, priority, opportunity, funnel nextAction, hard-coded advisory text, or old narrative viewer assignments;
- mutating Writer remedy fields while canonical solutions remain fixed cannot change client remediation HTML;
- WriterOutput/orchestration artifacts remain available under existing internal contracts;
- Writer/Judge validation and execution behavior remain unchanged;
- six primary pages plus Supporting Detail remain unchanged;
- non-v2 delegation remains unchanged;
- canonical authority/provider/generator/scoring/evidence/lifecycle/persistence/report-content/production configuration remain unchanged.

## Governance

No merge to `main`.
No deployment or production promotion.
No provider/model calls.
No audit rerun.
No production mutation.

After Builder PASS / published review-branch candidate, STOP for combined Betty re-review before any release advancement or new report tranche.
