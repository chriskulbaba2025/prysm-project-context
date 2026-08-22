# Constraints

Record hard project boundaries here.

## Active PRYSM report-rebuild constraints

- Report structure/presentation only for this rebuild.
- Do not modify evidence collection.
- Do not modify provider/adaptor behavior.
- Do not modify scoring logic or scoring versions.
- Do not modify audit lifecycle or state transitions.
- Do not modify storage behavior.
- Do not modify canonical evidence plumbing.
- Do not modify Writer/Judge governance.
- Do not modify audit orchestration.
- Do not modify n8n flows as part of report-page implementation.
- Do not broaden a page change into an architectural redesign.
- Do not batch multiple report pages into one implementation change.
- Work one report page at a time.
- Required sequence for every page:
  verify stable application branch/head → identify exact page source file → user provides current file from VS Code → inspect → propose smallest report-layer change → user approval → edit only supplied file → return complete replacement file → user pastes into VS Code → test/verify → user approval to proceed.
- Do not directly edit the `vantage-platform` application repository as part of this manual report-page workflow.
- Do not reconstruct, guess, or edit an application source file that the user has not supplied from the current stable repository.
- If the supplied file proves that a second file is strictly required, stop and identify that dependency before editing anything else.
- Do not move to the next page without explicit user approval after verification.
- Do not begin report code work until the exact stable `vantage-platform` branch/head is confirmed.
- Preserve the current left-hand navigation concept unless a page-specific approved change requires a minimal label/section update.
- The final approved scaffold contains a standalone Accessibility & Mobile Usability Readiness page.
- Every report page must begin with a plain-language client question and answer it before technical evidence.
- Client-facing status labels are:
  PASS / FINDING / PARTIAL / UNAVAILABLE / NOT APPLICABLE.
- Every status must include a plain-language explanation.
- No missing, unavailable, partial, blocked, or not-connected evidence may be left unexplained.
- Missing evidence must never be presented as a business failure.
- Important commercial/conversion pages must drive client-facing conclusions.
- Low-value utility-page issues may remain observations but must not dominate site-level conclusions.
- Raw H1/H2 counts are supporting evidence, not the client-facing semantic conclusion.
- Technical observations do not automatically become findings.
- Recommendations require material relevance to search visibility, conversion, trust, accessibility, usability, crawl/indexation, or a defined business objective.
- Passing/healthy areas should be made visible where useful.
- Technical metrics are evidence, not conclusions.
- Competitor behavior alone does not create a recommendation.
- Search demand alone does not create a content recommendation.
- Link quantity alone does not create an internal-link finding.
- Missing schema types alone do not create a schema recommendation.
- Performance lab data must not be represented as field performance.
- Accessibility Readiness must not be represented as legal AODA/WCAG compliance certification.
- Structured report visuals should use deterministic inline SVG by default.
- AI image generation must not be used for deterministic report charts/diagrams such as radar charts, pathway diagrams, or entity maps.
- The Conversion Readiness radar/spider chart must use existing scores only and must not alter scoring.
- Any limited-evidence dimension shown visually must be clearly identified as limited evidence.
- Do not modify `PROJECT_CONTEXT_PROTOCOL.md` for ordinary project-state changes.
- Do not rewrite the production PRD or Adam recommendation source merely to record implementation state; those remain governing/reference documents.
