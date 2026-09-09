# PRYSM Canonical Remediation Authority Closure Gate

Date: 2026-09-09
Status: MANDATORY CURRENT SOLUTION-DEPTH GATE — ACTIVE

## Governing invariant

**Canonical solutions are the sole source of client remediation anywhere in the final client artifact.**

This applies to visible HTML, hidden HTML, collapsed content, print/PDF/export/searchable DOM, supporting detail, hard-coded renderer copy, deterministic helpers, Writer-derived prose, legacy Finding prose, and any other serialized client surface.

## Why this gate exists

The project made real progress but external review was finding authority leaks one at a time:
- WriterOutput.actionPlan remained serialized even when hidden;
- after closing that leak, deterministic report detail still contains independent action-like copy.

The correct response is not another one-line repair. The whole remediation-authority surface must be audited and closed as one defect class.

## Current application baseline

Repository: `chriskulbaba2025/vantage-platform`
Branch: `review/prysm-solution-directive-authority-betty`
Current candidate: `ed671bbd50ef836b10c77917e3a78b95963188fc`
Production baseline remains unchanged.

## Already closed

At `ed671bbd...`:
- Writer narrative HTML is no longer serialized into client report HTML;
- WriterOutput.actionPlan is absent from client HTML;
- executiveDecision Change / Do next are absent;
- hidden diagnostic Writer narrative is absent;
- Writer/Judge HTML metadata is absent;
- internal Writer/Judge artifacts remain preserved;
- canonical Priority Fix authority remains intact;
- full test suite reported 1007 PASS / 0 FAIL.

Do not reopen that repair unless direct evidence proves regression.

## Confirmed remaining authority leak

`services/worker/src/report/report-detail-sections.js` currently contains independent Trust client action copy that is not derived from canonical solution records, including an action list equivalent to:
- keep existing proof assets;
- check that testimonials/case studies/credentials/pricing/reassurance appear near decision points;
- add or reposition proof where review shows a gap.

This is a concrete current example, not the full scope. The next diagnosis must search for all equivalent deterministic renderer leaks before implementation.

## Required audit scope

Use Terra High.

Run read-only whole-system diagnosis across every production code path that can contribute client-facing report HTML or action wording, including at minimum:
- `services/worker/src/report/render-report-v2.js`
- `services/worker/src/report/report-detail-sections.js`
- directly imported report helpers used by those renderers;
- client-facing deterministic content helpers;
- current model-to-render mapping for canonicalSolutions;
- any renderer function that emits imperative/advisory/action lists.

Follow imports as necessary. Do not limit diagnosis to files containing obvious words such as `fix` or `action`.

## Surface classification

Every client-facing recommendation-like surface must be classified:

### A — CANONICAL_FULL_DETAIL
Allowed only where full remedy ownership is authorized (Priority Fixes).
Must derive from canonical solution record and preserve stable `solutionId`, governed order, evidence grade, prescription mode, disposition, and site anchor.

### B — CANONICAL_SUMMARY_REFERENCE
Allowed on non-owning pages only when tied to the same canonical solution ID and bounded to the page's role.
Must not author a second independent remedy.

### C — SAFE_CONTEXT
Evidence, observation, business meaning, limitation, strength, or neutral explanation that does not instruct the client what to change/do/add/check/publish/reposition/improve.

### D — COMPETING_REMEDIATION
Any independent instruction, recommendation, checklist, advisory action, verification instruction, or implied fix that can change while canonicalSolutions remain fixed.
Must be removed or replaced with a canonical summary/reference.

## Mutation-invariance standard

The final repair must prove that with canonicalSolutions fixed, mutating any non-canonical remedy source cannot change client remediation.

At minimum test mutation of:
- legacy Finding `recommendation`;
- `businessImpact`;
- `verificationMethod`;
- `affectedUrls`;
- hard-coded deterministic action text selected by non-canonical conditions;
- WriterOutput remedy fields (already covered; retain coverage);
- other discovered non-canonical action objects/arrays.

## Hard-coded action rule

Hard-coded text is not automatically forbidden. Hard-coded neutral explanatory UI text is allowed.

Hard-coded client remediation is forbidden unless it is merely rendering a canonical solution field/reference.

Do not solve this with a keyword blacklist alone. Semantic classification is required.

## Consolidated repair rule

After the exhaustive inventory, implement one bounded consolidated repair for the entire confirmed defect class.

Do not perform a separate micro-tranche for every sentence unless file boundaries genuinely require separate governed contracts.

The repair should normally:
- remove independent deterministic remedies;
- replace appropriate non-owning-page actions with canonical references/summaries;
- preserve evidence/context sections;
- preserve Priority Fix full-detail ownership;
- add permanent invariant tests.

## Required preflight before external Betty

After the consolidated candidate is published:
1. Run full focused/regression verification.
2. Run a separate adversarial authority-closure review using Sol High when available; otherwise use Terra High in a fresh context with no Builder assumptions.
3. Review the complete diff from the last externally accepted solution milestone and the final serialized HTML authority surface.
4. Return `REAL PROGRESS — YES|NO` internally.
5. Only if internal preflight is YES should the candidate be sent to external Betty.

## Blind spots explicitly queued

### 1. Static authority evidence mode
The current static authority registry defaults its entries to `evidenceGrade: PARTIAL`, `prescriptionMode: CONDITIONAL`, and `disposition: FIX_LATER` before building finding-specific records. This is conservative and may be intentional, but it is a likely later specificity/priority-quality issue. Do not change it inside the renderer authority-closure repair. Diagnose it as a separate governed authority-quality tranche after closure.

### 2. Exact scope specificity
Current authority records use `DecisionEvidence.site.targetUrl` as siteAnchor scope and do not carry exact per-finding affected URL lists/counts. Do not invent specificity or restore legacy `affectedUrls` as remedy authority. Handle exact scope as a separate governed-data improvement if still needed after closure.

### 3. Human-render review
Automated authority tests do not prove the report remains coherent after independent actions are removed. After the consolidated repair, render a production-shaped persisted report without new model/provider calls and run a browser human review before release.

### 4. Model change is not a substitute for governance
Terra High should reduce missed cross-file semantics, but model selection alone does not prove closure. Exact-SHA code inspection, invariant tests, serialized artifact inspection, and independent preflight remain mandatory.

## Preservation boundary

Do not change during this gate unless diagnosis proves unavoidable and governance is explicitly reopened:
- solution contract;
- solution validator;
- solution generator;
- solution sequence;
- authority evidence-trust resolver;
- static provider semantics;
- scoring;
- evidence collection;
- DecisionEvidence;
- CapabilityEvidence;
- WriterInput / WriterOutput / Judge contracts;
- lifecycle;
- persistence/artifact contracts;
- report-content contract;
- production configuration;
- six primary pages plus Supporting Detail.

## Exit criteria

This gate closes only when:
- exhaustive surface inventory is complete;
- every client remediation surface is canonical full detail, canonical summary/reference, or safe context;
- no competing remediation remains in serialized HTML;
- permanent mutation-invariance tests pass;
- full regression suite passes;
- exact changed-file boundary is verified;
- adversarial internal preflight returns REAL PROGRESS — YES;
- human browser review finds no material loss of decision usefulness.
