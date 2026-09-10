# PRYSM Betty NO — Writer Remediation Artifact Leakage

Date: 2026-09-09
Application candidate: `c37913acfd82580724c74feb26175e2f0c36232c`
Review branch: `review/prysm-solution-directive-authority-betty`

## Betty verdict

RESULT: REAL PROGRESS — NO

REASON: `renderWriterNarrativeLayer` still renders `WriterOutput.actionPlan` as a client-facing Action Plan, so canonical solutions are not the sole remediation authority.

CONFIDENCE: HIGH

## Review of the defect

Exact-SHA source confirms `actionPlanNarrativeSection(writerOutput)` is serialized into the final report HTML as part of `deeperNarrative`. It is nested inside `#narrative-diagnostic-layer`, which is browser-hidden with `hidden`, `aria-hidden="true"`, and CSS `display:none !important`.

The earlier project interpretation treated browser-hidden diagnostic HTML as non-client-facing. Betty's NO establishes that this interpretation is too permissive for the canonical-authority gate: non-canonical remediation content must not be serialized into the client report artifact at all merely because CSS hides it.

This is therefore accepted as a real governance defect.

## Direction change

Do not ask Betty for more detail before diagnosis. Her defect is concrete enough to trace.

Before implementation, inspect all Writer-derived or hard-coded remedy-like content serialized by `renderWriterNarrativeLayer`, not only `WriterOutput.actionPlan`, so the project does not repair one authority leak and expose another on the next Betty pass.

At minimum inspect:
- `WriterOutput.actionPlan`;
- `executiveDecision.change`;
- `executiveDecision.doNext`;
- visible narrative fields labelled `priority`, `opportunity`, or `nextAction`;
- hard-coded narrative summary text that instructs the client to refine/check/add/do something;
- hidden/deep narrative content that is still serialized into the client HTML artifact.

Classify every such surface as one of:
- interpretation/context only and safe to serialize;
- canonical solution summary/reference only;
- competing remediation authority and must be removed/replaced from the client artifact;
- diagnostic-only data that must remain outside the client artifact entirely.

## Preservation boundary

Do not change WriterInput, WriterOutput contract, Writer generation, Judge contract, scoring, evidence, lifecycle, persistence, canonical solution authority/provider/generator, or page architecture merely to close this rendering leak.

Preferred architecture: Writer may continue producing internal interpretation/action structures if required by its contract, but the client report renderer must not serialize independent remedy instructions. Client-facing remediation must come only from canonical solutions or bounded summaries/references to those canonical solution IDs.

## Exact next action

Starting from application SHA `c37913acfd82580724c74feb26175e2f0c36232c`, run a read-only Writer Narrative Remediation Authority Leakage Diagnosis focused on `services/worker/src/report/render-narrative-v2.js` and directly connected rendering tests. Determine the complete serialized remedy-like surface and the smallest repair boundary. Do not implement during diagnosis. Produce `C:\Users\kulba\Downloads\PRYSM-WRITER-NARRATIVE-REMEDIATION-AUTHORITY-LEAK-DIAGNOSIS.txt`.
