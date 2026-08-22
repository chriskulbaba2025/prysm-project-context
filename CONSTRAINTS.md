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
- Do not modify authentication as part of report-page implementation.
- Do not broaden a report change into an architectural redesign.
- Work one report source file at a time.
- If multiple approved report pages/functions live in the same supplied source file, they may be updated together as one governed source-file unit.
- Do not batch changes across separate report source files.
- Required sequence for every governed source-file unit:
  verify stable application branch/head → identify exact source file → user provides current file from VS Code/current working copy → inspect → apply the smallest approved report-layer change → return complete replacement file → user pastes into working copy → syntax/test/verify → only then move to another source file.
- Do not directly edit the `vantage-platform` application repository as part of this manual report workflow unless the user explicitly changes that operating method.
- Do not reconstruct, guess, or edit an application source file that the user has not supplied or whose exact current contents have not been verified.
- If a supplied file proves that a second file is strictly required, identify that dependency before modifying the second file.
- Do not move to another source file until the current source-file unit passes its relevant verification.
- Preserve the current left-hand navigation concept unless an approved viewer-contract change requires a minimal section update.
- The final approved scaffold contains a standalone Accessibility & Mobile Usability Readiness page.
- The currently implemented viewer contract remains 15 pages / Viewer v2.1.0 until the deliberate 16-page migration is performed with its governed test-contract update.
- Do not update tests merely to silence a regression; test changes require an intentional approved contract migration.
- Do not edit `services/worker/src/report/sections-conversion.js` for Report v2. It belongs to the frozen v1 path protected by V2R-07.
- Do not run a paid production audit merely to verify report-presentation changes.
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
