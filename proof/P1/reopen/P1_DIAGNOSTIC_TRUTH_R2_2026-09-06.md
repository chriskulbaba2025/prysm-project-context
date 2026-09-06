# P1 Reopened Diagnostic Truth R2

Date: 2026-09-06  
Stage: `DIAGNOSTIC_TRUTH`  
Actor: `BUILDER/Codex`  
Application branch: `p1/bounded-build-cross-report-integrity`  
Application SHA: `8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c`  
Governance baseline observed: `bbc58141a5339d5533c64307550c189bedf10469`

## Protected outcome

A client must receive one coherent assessment across the report. When related
conclusions legitimately differ, the distinction must be understandable at the
point of reading. The client must not reconstruct internal evidence semantics
by comparing distant sections.

## Diagnostic conclusion

Classification: `VERIFIED_DESIGN_GAP`  
Stable root-defect identity: `P1-CROSS-REPORT-PROJECTION-RECONCILIATION`

The prior repair added and persisted a cross-report interpretation object, and
the current consumers require that object at several boundaries. That is a
real engineering improvement, but it does not yet make the projection the
single source of every client-visible conclusion. Three material consumer
families still independently derive or present related conclusions:

1. CTA invitation/mechanism and conversion-path completion are separately
   correct inputs but are not reconciled at the point where `PASS` mechanism
   wording and an obstructed/weak path are shown together.
2. The trust question `What reduces my risk?` uses `policies` as its primary
   flag while its evidence label groups policies, pricing, guarantees, and
   other reassurance. The resulting `PASS` can therefore be read as pricing
   evidence even when pricing is false.
3. The performance detail and pillar consumers treat a numeric performance
   score as sufficient for an assessed performance result, while capability
   and readiness-map consumers can simultaneously represent performance field
   evidence as unavailable/not assessed. The assembled report has no universal
   point-of-reading reconciliation of lab measurements, incomplete coverage,
   and readiness state.

The defect is in interpretation/projection and presentation composition. No
new evidence acquisition, scoring, provider, model, page-selection, storage,
or deployment defect was required to establish it.

## Observed facts and evidence

### CTA/path coherence

- `services/worker/src/report-model/cross-report-interpretation.js:14-21`
  intentionally defines CTA clarity from `site.ctas[].text,url` and path
  clarity from `conversionPaths[].status`; the two lineages are independent.
- `services/worker/src/report/foundation-readiness.js:326-409` emits
  `Conversion mechanism: PASS` when a CTA or form is present.
- `services/worker/src/report-model/cross-report-interpretation.js:5-13`
  emits `Weak`, `Partial`, or `Not Assessed` from conversion-path records.
- `services/worker/src/report/render-report-v2.js:699-729` contains a second
  local conversion-path derivation (`governedConversionState`) and then uses
  the persisted projection separately. The local state is not the rendered
  reconciliation contract.
- Frozen rendered proof at application SHA `8fa9ea9...` shows the material
  client-visible combination in `proof/P1/reopen/render-v2-f053f63/path-validated-blocker.html`:
  the report contains Conversion Path `57`, while the foundational mechanism
  row remains a PASS. The existing rendered scenario does not explain at that
  point that mechanism presence is distinct from path completion.
- The current focused suite passes `CR-03` and `P1-CROSS-01`; those tests prove
  ranking and independent data lineage, not the client-visible reconciliation
  of the two conclusions in the affected assembled report.

### Trust evidence overstatement

- `services/worker/src/report/report-detail-sections.js:227-257` defines the
  risk question with flag `policies` but evidence label
  `Policies, pricing, guarantees, or other reassurance`.
- `services/worker/src/report/report-detail-sections.js:272-295` sets the
  question present when either the selected flag or `trust.pricing` is true,
  then renders the grouped evidence label as observed.
- The exact rendered product at
  `proof/P1/reopen/render-v2-f053f63/assessed.html` and
  `proof/P1/reopen/render-v2-f053f63/competitor-present.html` contains the
  client-visible contradiction recorded by Brad: pricing/investment context
  is absent elsewhere, while the risk question can state that policies,
  pricing, guarantees, or other reassurance was observed.
- Existing `CR-07` proves E-E-A-T dimensions and unavailable behavior, but it
  does not assert one-to-one attribution of each positive buyer question to the
  exact observed signal.

### Fail-closed projection/performance reconciliation

- `services/worker/src/report/v2-pillars.js:60-95` computes the
  `performance_experience` pillar from eligible numeric module scores and
  separately reports `performance.lab` and `performance.field` capability
  statuses.
- `services/worker/src/report/report-detail-sections.js:522-528` reads source
  status, but `:660-677` marks the Performance detail row assessed whenever
  `typeof model.scores.performance === "number"`; it does not require the
  governed performance capability/readiness state to agree.
- `services/worker/src/report/render-report-v2.js:285-380` renders a numeric
  pillar whenever a score exists and renders `Not Assessed` only when the
  pillar score is null. No shared client-facing reconciliation is emitted
  when measured lab performance coexists with unavailable field or other
  incomplete evidence.
- The frozen failure scenarios `crawl-blocked.html` and `provider-failed.html`
  demonstrate the fail-closed side (scores withheld), while the rendered
  `path-validated-blocker.html` / `assessed.html` demonstrate the opposite
  mixed state: `Performance & Experience` is `77/100` while the same report's
  capability summary lists `performance.field UNAVAILABLE`. The report does
  not explain the scope difference at the performance conclusion itself.
- Existing `CR-12`, `CR-13`, `CR-28` through `CR-44` prove many individual
  unavailable and source-failure rules. They do not prove branch-complete
  reconciliation between numeric lab output, field availability, and every
  client-facing readiness projection.

## Authoritative lineage map

The relevant governed path is:

`provider/adapters -> canonical evidence -> capability evidence -> scoreAudit -> buildScoreSet/persist scores.json -> hydrateCurrentReportModel or replay hydration -> report consumers -> v2 renderer -> HTML artifact`

| Handoff | Authoritative implementation | Diagnostic seam |
|---|---|---|
| Producer / normalization | `services/worker/src/evidence/*`, adapter outputs, canonical DecisionEvidence | Evidence is input to this defect, not changed by this stage. |
| Capability validation | `services/worker/src/evidence/capability-evidence.js` and capability contract | Statuses can be narrower than raw arrays or numeric scores. |
| Scoring / interpretation production | `services/worker/src/scoring/report-model.js` and `services/worker/src/scoring/scoring-service.js` | `conversionPaths`, `scores`, `bands`, and persisted `crossReportInterpretation` are produced here. |
| Canonical persistence | `services/worker/src/scoring/scoring-service.js:285-411, 472-498` | `scores.json` is read back and schema-validated before success. |
| Current hydration | `services/worker/src/report-model/current-model.js:7-46` | Requires persisted hierarchy and cross-report interpretation, then exposes evidence and projection together. |
| Replay / reopen | `services/worker/scripts/replay-report.js:405-475` plus current hydration import | Current replay rejects non-current score contracts and missing hierarchy; legacy compatibility is a separate explicit path. |
| Interpretation consumer | `services/worker/src/report-model/cross-report-interpretation.js`, `sections-conversion.js`, `render-report-v2.js` | Required projection is consumed, but local derivations and grouped labels remain. |
| Foundation consumer | `services/worker/src/report/foundation-readiness.js:238-477` | Mechanism status is evidence-scoped but not path-reconciled. |
| Trust consumer | `services/worker/src/report/report-detail-sections.js:173-463` | Grouped evidence label overstates the selected signal. |
| Performance/pillar consumers | `services/worker/src/report/report-detail-sections.js:522-678`, `v2-pillars.js:55-98` | Numeric score and capability/readiness state are not one fail-closed projection. |
| Renderer | `services/worker/src/report/render-report-v2.js:2458-2481` | Builds pillars/checklist/action plan and emits all affected sections into one HTML document. |
| Artifact proof | `proof/P1/reopen/render-v2-f053f63/manifest.json` and frozen HTML files | Artifact is bound to the reviewed application candidate; it records the remaining client-visible seams. |

## Material consumer/render inventory

| Consumer / section | P1 conclusion(s) | Material risk |
|---|---|---|
| Executive scorecard | overall/readiness, strengths, evidence limitations | Can summarize a score while detail sections carry narrower unknowns. |
| Conversion Readiness Map / pillar | Conversion Path and Performance & Experience states | Can show weak/not-assessed state beside positive mechanism or lab result. |
| Foundation Readiness | Conversion mechanism PASS/ACTION/NOT ASSESSED | Presence is not completion; no immediate path distinction. |
| Conversion Path section | path steps, blockers, status | Correct path result is distant from foundational mechanism wording. |
| Trust / E-E-A-T | dimension cards and buyer trust questions | Grouped positive evidence can imply an unobserved signal. |
| Technical detail | performance row and source/capability limitation | Numeric performance assessment is not reconciled with incomplete field coverage. |
| Competitor benchmark | own-site CTA/path/trust projection | Uses projection for some values but remains a separate consumer requiring coherent labels. |
| Evidence appendix / deferred analysis | source and capability statuses | Internal statuses are exposed without always translating the practical business conclusion. |
| Replay/current model boundary | exact current ScoreSet and persisted projection | Correctly fail-closed for missing projection, but does not guarantee semantic agreement among downstream consumers. |

## Branch and scenario inventory

| Implemented branch | Required scenario | Current evidence / outcome | Later proof obligation |
|---|---|---|---|
| CTA/form present; path weak/obstructed | `path-validated-blocker` | Mechanism PASS and path weak appear without immediate distinction | Explain invitation visibility versus usable completion in every affected view. |
| CTA/form absent with complete interactive evidence | `no-conversion-mechanism` | Limited/action state is rendered | Preserve absence semantics and reconcile with path state. |
| CTA present and path clear | aligned positive scenario | Covered by assessed conversion fixtures/tests | Prove no unnecessary downgrade or invented contradiction. |
| Interactive evidence unavailable | `unassessed` | Path is Not Assessed | Keep mechanism/path fail-closed and client-readable. |
| Trust policy present, pricing absent | `assessed`, `competitor-present` | Grouped risk evidence can imply pricing | Attribute each positive statement to the exact observed signal. |
| Trust partial | partial capability branch | Partial wording exists | Do not turn one observed signal into complete reassurance. |
| Robots retrieved but directives unparsed | `robots-retrieved` | Not Assessed; improved and not decisive for P1 | Preserve retrieval-versus-evaluation distinction. |
| Crawl blocked by audit access | `crawl-blocked` | Scores and pillars withheld | Preserve fail-closed state and business-language explanation. |
| Provider failure | `provider-failed` | Scores and pillars withheld | Preserve evidence limitation; no site conclusion. |
| Lab performance available, field unavailable | `path-validated-blocker`, `assessed` | Numeric lab result and field UNAVAILABLE coexist | Reconcile measured lab scope with broader readiness/unknown state. |
| Performance unavailable/failed | `no-performance`, `provider-failed` | Performance is withheld | Preserve no numeric score and no positive performance conclusion. |
| Malformed/missing persisted projection | `P1-CROSS-04` and current hydration tests | Current consumer fails closed | Retain rejection and prove all material consumers use one valid projection. |
| Current replay | replay fixture/tests | Current contract and identity are checked | Bind later render proof to exact persisted lineage, not a synthetic object. |
| Legacy replay compatibility | explicit `--legacy-compat` path | Separate compatibility behavior exists | Do not let legacy artifacts serve as current P1 proof. |

## Unresolved questions

None material for diagnosis. The remaining uncertainty is correction design,
which is outside the current read-only authorization. Robots/indexability has
not yielded new decisive P1 evidence in this run.

## Ownership and boundary

Correction ownership is the Builder, but implementation is not authorized in
the current `DIAGNOSTIC_TRUTH` stage. A later governed Chris repair
authorization is required before editing application code. The eventual
bounded seam is the report interpretation projection plus the named report
consumers/render tests, with evidence acquisition, scoring policy, providers,
Writer/Judge, storage lifecycle, deployment, and application `main` protected.

## Read-only verification performed

Command: `node --test src/report-model/cross-report-interpretation.test.js src/report/render-report-v2-conversion.test.js src/report/render-report-v2.test.js src/report/render-report-v2-sections.test.js` from `services/worker`.

Result: `77` tests passed, `0` failed. This is diagnostic evidence of the
current implementation and existing contract coverage; it is not a claim that
the client-visible P1 outcome passes. No application files were edited.

