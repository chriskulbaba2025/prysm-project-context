# Decisions

Use this file only for decisions that future work must respect.

## Decision: GitHub context repository is authoritative project memory

Date: 2026-08-22
Status: Active

Decision:
`chriskulbaba2025/prysm-project-context` is the authoritative durable context repository for PRYSM.

Reason:
Project continuity must survive chat boundaries and model changes without depending on stale conversational summaries or duplicated Project Sources.

Implication:
Before substantive PRYSM work, read the governing files in the context repository. At handoff, reconcile verified work, update materially changed context files, commit them to GitHub, verify the write, and only then issue the handoff. Duplicated ChatGPT Project Sources must not override the current GitHub state.

---

## Decision: Manual VS Code file handoff for report implementation

Date: 2026-08-22
Status: Active

Decision:
Implement report changes through a controlled manual file handoff: the user provides the exact current source file, the assistant edits only that governed source-file unit, the user pastes the complete replacement back into the working copy, and the user verifies/tests the result before another source file begins.

Reason:
This creates the smallest and most observable change boundary, avoids autonomous multi-file drift, and keeps the user in direct control of the production application repository while still allowing precise file-level assistance.

Implication:
Do not directly edit `vantage-platform` as part of this workflow unless the user explicitly changes the operating method. Do not infer or reconstruct an unverified application file. If a source file contains multiple approved report pages/functions, those may be updated together as one governed source-file unit. Do not batch changes across separate source files. When a complete replacement source file is too large to return reliably as one chat message, do not rely on a generated download link as the delivery mechanism. Share the complete replacement directly in the conversation context in sequential, clearly labeled chunks that can be copied into VS Code in order. Every chunk must be part of the same complete file, with no omitted middle content, and the final chunk must explicitly state that the file is complete.

---

## Decision: Report rebuild is presentation-layer only

Date: 2026-08-22
Status: Active

Decision:
The current PRYSM report rebuild changes report structure, presentation, hierarchy, and interpretation only.

Reason:
The objective is to improve how existing audit evidence is communicated without destabilizing working evidence collection, scoring, lifecycle, storage, or audit orchestration.

Implication:
Do not change evidence collection, adapters/providers, scoring logic, lifecycle/state transitions, storage, canonical evidence plumbing, Writer/Judge governance, n8n flows, authentication, or audit orchestration as part of this report rebuild.

---

## Decision: Governed source-file-unit implementation

Date: 2026-08-22
Status: Active

Decision:
The implementation boundary is one exact report source file at a time, not necessarily one conceptual report page at a time.

Reason:
The current Report v2 architecture groups several approved report pages/functions in the same source files. Editing the same file repeatedly page-by-page increases copy/paste risk and test churn without creating a stronger governance boundary.

Implication:
When several approved pages/functions live in one verified source file, update them together as the smallest coherent source-file unit, then run syntax and relevant targeted tests. Do not move into a second source file until the current source-file unit is green.

---

## Decision: Client-facing questions lead report pages

Date: 2026-08-22
Status: Active

Decision:
Every report page begins with a plain-language client question, followed by the formal report category.

Reason:
Clients should understand the purpose of a page before encountering technical terminology or evidence.

Implication:
Each page must answer its question before presenting technical detail.

---

## Decision: Evidence status must always be explained

Date: 2026-08-22
Status: Active

Decision:
Client-facing report states are PASS, FINDING, PARTIAL, UNAVAILABLE, and NOT APPLICABLE, and every state requires an explanation.

Reason:
A status or blank result without context leaves the client unable to distinguish success, failure, partial evidence, or absence of evidence.

Implication:
No unavailable, partial, blocked, not-connected, not-applicable, or passing state may appear without explaining what was assessed and what the state means. Missing evidence is not a negative finding.

---

## Decision: Important pages drive the narrative

Date: 2026-08-22
Status: Active

Decision:
Client-facing conclusions should emphasize commercially important and conversion-relevant pages rather than allowing low-value utility pages to dominate the report narrative.

Reason:
A crawl may find technically valid issues on utility pages that do not materially reflect homepage, service, trust, content, or conversion readiness.

Implication:
Raw page-level observations may remain visible as supporting evidence, but site-level conclusions should emphasize the pages that matter to search discovery, buyer understanding, trust, and conversion.

---

## Decision: Observations and findings are distinct

Date: 2026-08-22
Status: Active

Decision:
A technically true observation does not automatically become a client-facing finding or recommendation.

Reason:
PRYSM must preserve its judgment layer and avoid becoming a generic checklist crawler.

Implication:
Recommendations require material relevance to search visibility, conversion, trust, accessibility, usability, crawl/indexation, or a defined business objective.

---

## Decision: Show strengths, not only defects

Date: 2026-08-22
Status: Active

Decision:
Every relevant report page should explicitly show what is already working.

Reason:
A report that only displays defects misrepresents the assessed condition and weakens client comprehension.

Implication:
Passing evidence should be summarized in plain language where useful, not silently omitted.

---

## Decision: Technical SEO is organized by client purpose

Date: 2026-08-22
Status: Active

Decision:
Technical SEO Hygiene is organized around Reach → Index → Understand → Deliver, supported by an SEO Coverage Matrix.

Reason:
This better reflects Adam’s intent than presenting a flat crawler checklist.

Implication:
Technical checks should be framed by whether search engines can reach, index, understand, and reliably receive important pages. Adam’s additional checks should appear in the relevant purpose group when evidence exists.

---

## Decision: Accessibility is readiness, not certification

Date: 2026-08-22
Status: Active

Decision:
The report includes a standalone Accessibility & Mobile Usability Readiness section.

Reason:
Accessibility and deeper mobile usability were identified as major genuine gaps in Adam’s recommendations.

Implication:
The report may identify observable barriers and risks but must not claim legal AODA/WCAG compliance certification.

---

## Decision: Deterministic report visuals use inline SVG

Date: 2026-08-22
Status: Active

Decision:
Structured report visuals should default to lightweight inline SVG driven by existing report values.

Reason:
These visuals need accuracy, repeatability, print stability, and no additional image-generation workflow.

Implication:
Do not use AI image generation for radar charts, internal-link pathways, entity relationships, or similar deterministic report graphics.

---

## Decision: Conversion Readiness Map uses a radar visual

Date: 2026-08-22
Status: Active

Decision:
The Conversion Readiness Map includes a five-axis radar/spider visual using the five existing PRYSM readiness dimensions.

Reason:
The visual makes imbalance across readiness dimensions immediately understandable.

Implication:
The chart is explanatory only, uses existing dimension scores, and must visibly identify limited evidence rather than implying full confidence.

---

## Decision: Existing left navigation concept remains

Date: 2026-08-22
Status: Active

Decision:
Keep the current dark left-hand numbered report navigation and one-page-at-a-time viewer concept.

Reason:
The approved redesign is primarily about report content hierarchy and interpretation; the current navigation concept already supports the desired report experience.

Implication:
Do not redesign the navigation architecture as part of page-content implementation. Section names may be refined, and the approved standalone Accessibility & Mobile Usability page adds one report section to the final scaffold.

---

## Decision: Current viewer contract remains 15 pages until deliberate migration

Date: 2026-08-22
Status: Active

Decision:
Preserve the current Viewer v2.1.0 15-page registry and tests during ordinary report-content work. Add the approved 16th Accessibility page only as a deliberate viewer-contract migration.

Reason:
The current production viewer tests explicitly govern 15 pages. Mixing content changes with a page-count contract migration creates unnecessary regression ambiguity.

Implication:
Do not casually add the Accessibility page to `REPORT_V2_VIEWER_PAGES`. When ready, update the viewer registry and corresponding governed viewer test contract together, then run the full targeted report regression suite.

---

## Decision: Stable Git baseline before report code changes

Date: 2026-08-22
Status: Active

Decision:
Do not begin report code changes while the repository is actively being updated elsewhere.

Reason:
A moving baseline creates branch drift and makes source-file verification unreliable.

Implication:
Verify the exact stable `vantage-platform` branch/head before beginning a new governed implementation sequence when the baseline may have changed.
