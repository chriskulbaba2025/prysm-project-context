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

## Decision: Measure workflow efficiency persistently

Date: 2026-08-22
Status: Active

Decision:
PRYSM governed work packages will record elapsed time, edit events, failed iterations, and context-recovery turns in `EFFICIENCY_METRICS.md` so workflow-efficiency claims can be measured and revised from durable evidence.

Reason:
The current estimate that project-memory use improves practical development efficiency by roughly 55% is directionally useful but not yet a defensible measured benchmark. Persistent raw measures are required to compare comparable work packages and separate genuine process improvement from impression.

Implication:
At each materially completed governed work package, update `EFFICIENCY_METRICS.md`. Preserve raw measures, label estimates as estimates, never turn unknown values into zero, and calculate a percentage improvement only when comparable baseline/current data exists. Future PRYSM handoffs should preserve this measurement record.

---

## Decision: Manual VS Code file handoff for report implementation

Date: 2026-08-22
Status: Active

Decision:
Implement report changes through a controlled manual file handoff: the user provides the exact current source file, the assistant edits only that governed source-file unit, the user pastes the complete replacement back into the working copy, and the user verifies/tests the result before another source file begins.

Reason:
This creates the smallest and most observable change boundary, avoids autonomous multi-file drift, and keeps the user in direct control of the production application repository while still allowing precise file-level assistance.

Implication:
Do not directly edit `vantage-platform` as part of this workflow unless the user explicitly changes the operating method. Do not infer or reconstruct an unverified application file. If a source file contains multiple approved report pages/functions, those may be updated together as one governed source-file unit. Do not batch changes across separate source files. All source-code replacements must be returned directly in the conversation, never as generated/downloadable code files. When a complete replacement source file is too large for one chat message, share the complete replacement directly in sequential, clearly labeled code blocks that can be copied into VS Code in order. Every chunk must be part of the same complete file, with no omitted middle content, and the final chunk must explicitly state that the file is complete.

---

## Decision: Code files are never delivered as downloads

Date: 2026-08-22
Status: Active

Decision:
Across the entire PRYSM Project, source code, replacement code, patches, scripts, configuration code, and other code files must never be delivered through generated/downloadable file links or sandbox downloads.

Reason:
The governed implementation workflow depends on visible, copyable, reviewable code in the conversation so the user can inspect exactly what is being pasted into VS Code. Download artifacts create an opaque delivery path and break that control boundary.

Implication:
Every code-file replacement must appear directly in the conversation. If the file is too large for one response, provide it in sequential, clearly labeled code blocks in exact copy order with no omitted content. This rule applies to every PRYSM chat and work package unless the user explicitly reverses this decision in the authoritative context repository.

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
Status: Superseded by completed Viewer v2.2.0 migration

Decision:
Preserve the current Viewer v2.1.0 15-page registry and tests during ordinary report-content work. Add the approved 16th Accessibility page only as a deliberate viewer-contract migration.

Reason:
The current production viewer tests explicitly governed 15 pages. Mixing content changes with a page-count contract migration creates unnecessary regression ambiguity.

Implication:
The deliberate migration has now been completed and verified. The current governed target is Viewer v2.2.0 with 16 pages.

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

---

## Decision: Audit-data fixes require a durable dependency-impact ledger

Date: 2026-08-23
Status: Active

Decision:
Any proposed fix to PRYSM evidence acquisition, provider adapters, normalization, capability evidence, or scoring eligibility must be preceded by a durable impact record that identifies the proven defect, exact source-file boundary, upstream inputs, downstream consumers, artifact/contracts affected, cost/retry implications, regression risks, and required verification.

Reason:
Data-layer fixes can change many downstream conclusions at once. The user requires every material reaction to an action to be understood and retained so debugging is not repeated and a local repair does not silently destabilize another part of the governed system.

Implication:
Use `REFERENCE/AUDIT_DATA_VALIDATION_97d6b2c7.md` as the active ledger for the current audit-data investigation. Do not change application code merely because a symptom appears in the report. Prove the acquisition/normalization defect first, record the dependency map, then make the smallest approved source-file change and test both the direct fix and all listed downstream boundaries.

---

## Decision: Preserve narrative quality gate and add governed final revision

Date: 2026-08-25
Status: Active

Decision:
Keep the existing Narrative v2 client-release quality gate unchanged. Do not lower the 92/100 release threshold, the perfect evidence-fidelity requirement, the per-dimension floor, hard-gate protections, or major-defect protections. When an audit reaches `HUMAN_REVIEW_REQUIRED` after the two automatic production Writer/Judge rounds, expose the exact Judge defects and allow one explicitly human-authorized final third Writer/Judge round using the already-persisted evidence and scores.

Reason:
The production validation audit reached scoring successfully and stopped because the narrative did not reach the governed release threshold within the production two-round automatic limit. The quality standard protects the client-facing report; the operational gap is that the system currently has no governed continuation path for the third pass already allowed by the Judge contract.

Implication:
The repair must preserve the original audit, evidence, scores, and prior narrative artifacts; must not recollect providers or rescore; must require explicit human authorization before the final round; must show the Judge defects that caused review; and must stop for genuine manual review if the final governed round still does not pass.

---

## Decision: Upgrade the Narrative v2 Writer while keeping the Judge stable

Date: 2026-08-25
Status: Active

Decision:
For the next controlled production validation, move the Narrative v2 Writer to the approved higher-tier Terra model while keeping the current Judge model unchanged. The exact production provider model identifier and price-table entry must be verified before changing deployment configuration.

Reason:
A stronger Writer is expected to improve synthesis, root-cause interpretation, business clarity, and non-repetition while retaining the same deterministic Judge standard. The user accepted the modest incremental cost in exchange for a lower probability of unnecessary narrative revision.

Implication:
Do not hardcode the Writer model into application logic. Continue using the existing deployment configuration boundary (`PRYSM_NARRATIVE_V2_WRITER_MODEL` and governed price table). Change production configuration only after the continuation repair is verified and explicit deployment approval is obtained. The Judge quality contract and model remain unchanged unless separately approved.

---

## Decision: Large sites use bounded representative acquisition

Date: 2026-08-25
Status: Active

Decision:
PRYSM must support very large sites without attempting full-site crawling. The acquisition model is: discover and understand the broad sitemap/site footprint, classify material page families, prioritize the most important commercial/conversion pages and representative family examples, then enforce a bounded DataForSEO On-Page crawl with a target hard ceiling of 250 pages.

Reason:
PRYSM is a governed conversion-readiness audit product, not an enterprise exhaustive crawler. Large repetitive/programmatic sites can consume crawl time and budget without improving the quality of conversion, UX, trust, SEO, or readiness conclusions. The existing code already supports broad sitemap discovery, URL clustering, representative families, and priority URLs; the missing product behavior is to connect that intelligence to bounded provider acquisition.

Implication:
Do not solve large-site failures by simply increasing timeout or crawl volume. Preserve whole-site footprint evidence separately from assessed-page evidence. A report may truthfully state that a very large footprint was discovered while only a bounded representative sample was assessed. The next work package should design and implement representative crawl enforcement using existing footprint intelligence, with roughly 20 must-have priority URLs and a maximum 250-page provider crawl. Any exact implementation details must be verified against the current DataForSEO adapter/client before code changes.