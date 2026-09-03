# P6 Diagnostic Evidence — Make Unavailable / Partial Evidence Useful

Date: 2026-09-02  
Status: Verified diagnostic; design gap confirmed  
Application candidate: `89b1957b98ac5064527bc55cf7eb20caf2889051`  
Production SHA: `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`

## Requirement preserved

Preserve truthful `UNAVAILABLE` and `PARTIAL` states while making them actionable. Where an enabling path is known, client output must state: what could not be determined; why; what source or information is required; how to enable or collect it; and what additional insight PRYSM could then provide. This applies especially to Accessibility & Mobile Usability, Evidence Appendix, Deferred & Unavailable Analysis, and field/real-user performance evidence.

Non-goals: no conversion of unavailable evidence into a negative finding, no scoring change, no provider/model call, no prompt change, no n8n change, no production mutation, and no consultant override control.

## Trace

| Surface | Producer / contract | Current consumer / output | Finding |
|---|---|---|---|
| Source status and limitations | `services/worker/src/orchestration/audit-orchestrator.js` aggregates adapter status and limitations; canonical evidence contracts preserve status | `reportPackage.sourceStatus`, `model.evidence`, capability evidence | Truthful status lineage exists; no defect shown |
| Capability status | `services/worker/src/evidence/capability-evidence.js` derives `AVAILABLE`, `PARTIAL`, `UNAVAILABLE`, provenance, coverage, and limitations | v2 model and Writer input | Status/provenance are available for machine consumers, but no standardized enablement/next-insight projection exists |
| Accessibility & Mobile Usability | `services/worker/src/report/report-detail-sections.js::accessibilityMobileSection` creates unavailable/partial area rows with `detail` and `impact` | Rendered section `#accessibility-mobile` | Explains the limitation and impact, but does not tell the client what to collect/enable or what new insight would follow |
| Lab / field performance | `services/worker/src/report/sections-performance.js` and `report-detail-sections.js::performanceDetailSection` inspect `fieldData` and show unavailable text | Performance page and detail table | Correctly distinguishes lab from field data, but unavailable field data ends at “not available” with no collection path or future insight |
| Deferred analysis | `services/worker/src/report/render-approved-report.js::deferredAnalysis` emits `area`, `reason`, `impact`, and `phase` | Deferred & Unavailable Analysis page | The table is a dead end: no required source/information, enablement step, or additional insight field |
| Evidence appendix | `services/worker/src/report/sections-performance.js::appendix` renders source gates and technical detail | Evidence Appendix page | Source state is visible, but no reusable roadmap contract is projected for unavailable/partial entries |

## Controlled read-only observations

1. The existing report model has explicit source statuses and limitations; unknown evidence is not converted to `FALSE`, `0`, or a confirmed absence on the traced P6 paths.
2. Accessibility rows for viewport, responsive layout, font legibility, and tap-target sizing are explicitly `UNAVAILABLE`; the renderer correctly withholds a usability conclusion.
3. `fieldData` is independently represented from lab profiles. When absent, the renderer correctly says field performance is unavailable and retains lab-vs-field distinction.
4. The approved deferred page currently exposes only `Reason`, `Impact`, and `Available In`. It has no structured fields for `Required source/information`, `How to enable/collect`, or `Additional insight enabled`.
5. Therefore the gap is not evidence semantics or status propagation. It is a presentation-contract/design gap: known roadmap metadata is not represented as a governed additive contract and is not rendered consistently.

## Classification

`VERIFIED_DESIGN_GAP` — `P6_UNAVAILABLE_ACTIONABILITY_CONTRACT`: unavailable/partial evidence remains honest, but the current client contract does not carry a bounded, source-aware enablement roadmap through all applicable report surfaces.

No historical production claim is made. No provider failure or missed evidence acquisition is inferred from the current output.

## Acceptance artifact / proof target

For each applicable unavailable or partial item, exact candidate output must preserve the status and include:

`Area | status | what could not be determined | why | required source/information | how to enable/collect | additional insight enabled`

The proof must cover at minimum: one unavailable accessibility area, one partial accessibility/crawl case, unavailable CrUX field data with lab data present, unavailable GA4/backlinks, and a fully available control showing no fabricated roadmap item. Existing evidence status, scores, and lab-vs-field semantics must remain unchanged.

## Next governed action

Freeze the P6 Surgical Change Contract for an additive deterministic roadmap metadata/projection and rendering update. Keep the change in report presentation/contract scope; do not alter acquisition, scoring, canonical evidence, prompts, n8n, or production configuration.
