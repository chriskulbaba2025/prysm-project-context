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
Do not directly edit `vantage-platform` as part of this workflow unless the user explicitly changes the operating method. Do not infer or reconstruct an unverified application file. If a source file contains multiple approved report pages/functions, those may be updated together as one governed source-file unit. Do not batch changes across separate source files. All source-code replacements must be returned directly in the conversation, never as generated/downloadable code files. `WORKFLOW_INSTRUCTIONS.md` now governs the exact delivery form, including surgical-vs-whole-file choice, exact lines/anchors, and mandatory bottom-up ordering for multiple edits.

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
PRYSM must support very large sites without attempting full-site crawling. The acquisition model is: discover and understand the broad sitemap/site footprint, classify material page families, prioritize the most important commercial/conversion pages and representative family examples, then enforce a bounded DataForSEO On-Page crawl with a hard ceiling of 250 pages.

Reason:
PRYSM is a governed conversion-readiness audit product, not an enterprise exhaustive crawler. Large repetitive/programmatic sites can consume crawl time and budget without improving the quality of conversion, UX, trust, SEO, or readiness conclusions.

Implication:
Do not solve large-site failures by increasing timeout or crawl volume. Preserve whole-site footprint evidence separately from assessed-page evidence. A report may truthfully state that a very large footprint was discovered while only a bounded representative sample was assessed. The provider crawl ceiling is 250 pages and the provider priority-URL cap is 20.

---

## Decision: Representative acquisition does not override site robots policy

Date: 2026-08-25
Status: Active

Decision:
Do not use a custom robots override as the core mechanism for representative acquisition. Do not rely on undocumented provider URL-filter behavior as a crawl-selection guarantee.

Reason:
The product needs deterministic cost and coverage governance without replacing a client site’s own robots policy or depending on provider behavior that has not been directly verified. Priority URLs and hard crawl ceilings are documented and safely enforceable; robots override would create an unnecessary governance risk.

Implication:
The current representative-acquisition guarantee is: broad footprint intelligence, deterministic priority selection, maximum 20 provider priority URLs, hard 250-page provider crawl, and explicit representation/limitation truth. Any future stronger family-suppression mechanism requires separate evidence, design, tests, and approval before adoption.

---

## Decision: Manual edit delivery is exact and bottom-up

Date: 2026-08-25
Status: Active

Decision:
`WORKFLOW_INSTRUCTIONS.md` governs all manual application-code edit delivery. Multiple edits in one file must always be presented highest-line-number first. Exact current line numbers/ranges, anchor text, complete replacement blocks, and a single consolidated verification block are mandatory.

Reason:
Repeated deviations from this ordering created avoidable copy/paste and formatting risk during otherwise correct code work. The rule must be durable and model-independent rather than dependent on chat memory.

Implication:
For files roughly under 750–900 lines, whole-file replacement is acceptable/preferred when safer; larger files use surgical edits. The assistant must not move to the next source-file unit until the user confirms verification. The assistant must not ask the user to recover code or instructions from earlier messages.

---

## Decision: Offline report styling and Netlify packaging use derived artifacts only

Date: 2026-08-26
Status: Superseded by fresh TBK showcase-audit decision

Decision:
The next PRYSM work package will style and package a static client-facing report from the saved/offline audit replay artifacts for audit `97d6b2c7`. The target deliverable is a polished Netlify-ready static ZIP. This is presentation and packaging work only.

Reason:
The Audit Integrity repair checkpoint is now verified and committed locally. Styling and deployment packaging should be isolated from evidence acquisition, scoring, interpretation, orchestration, Writer/Judge, production persistence, and the immutable saved audit evidence so visual iteration cannot reopen or contaminate verified audit logic.

Implication:
Use the stored audit/replay artifacts as read-only inputs. Create or work from a derived static-report output for styling. Do not edit the canonical/raw/normalized/governed source evidence merely to change appearance. Do not call providers or models, rerun production, rescore persisted data, mutate production artifacts, or change scoring/evidence/crawl/Writer/Judge logic as part of styling. The final ZIP may be created as a user-facing deployment artifact because it is a packaged static report, not a source-code handoff. Before styling begins, identify and verify the safest derived static-report source/output path.

---

## Decision: Fresh TBK audit is the preferred showcase report source

Date: 2026-08-26
Status: Active

Decision:
Use a fresh production audit of `https://www.tbkcreative.com/`, started only after application commit `dfa5650fa1486b07b34ecc0f61d7747db44c1cc9` was pushed and successfully deployed, as the preferred data source for the next PRYSM showcase/report-review work. The fresh audit ID is `ca8a1171-0d57-4eda-910e-3efe54967af8`.

Reason:
The older Reboot replay has too little assessed coverage for strong data representation, and the older TBK audit `f8eb3d18-ee2f-46ed-9a48-30ec89f56646` has materially incomplete persisted DataForSEO On-Page evidence. A new TBK audit under the current Brad + Chris integrity and representative-acquisition rules provides the cleanest way to evaluate the current product and report model without retrofitting an incomplete historical run.

Implication:
Do not build the final showcase report from the fresh TBK audit until its persisted production evidence is inspected. First verify lifecycle completion, then inspect DataForSEO On-Page raw/normalized artifacts, site-footprint evidence, assessed-page count, representative coverage, findings, and scores. Treat the 20-URL value as the priority-URL ceiling, not the total crawl ceiling; the governed provider crawl ceiling remains 250 pages. If the fresh audit still lacks adequate evidence, diagnose that evidence boundary before doing report styling rather than forcing a report from incomplete data.

---

## Decision: Reopen Same P1 after Brad outcome-review FAIL

Date: 2026-09-05
Status: Active

Decision:
Chris selected `REOPEN SAME P#` for P1 after the formal Brad outcome review found the frozen candidate materially not ready to pass. P1 is reopened to Builder/Codex `DIAGNOSTIC_TRUTH` for one bounded consolidated repair tranche.

Reason:
The independent review proved linked client-visible failures that escaped prior deterministic and rendered gates.

Implication:
The frozen FAIL review stays immutable. Diagnosis must map the shared repair boundary before implementation; the resulting candidate requires new technical, rendered, and independent Brad proof.

---

## Decision: Reopen Same P1 after reopened-candidate outcome-review FAIL

Date: 2026-09-05
Status: Active

Decision:
Chris accepted Brad's reopened P1 OUTCOME_REVIEW FAIL at governance commit `d73c57be0a15291855fc771326d6b181ff281c54` for application candidate `8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c` and selected `REOPEN SAME P#`. P1 returns to Builder/Codex `DIAGNOSTIC_TRUTH`.

Reason:
Material client-visible defects remain in CTA/path coherence, trust evidence overstatement, and fail-closed projection/performance-state reconciliation. Robots/indexability is not a decisive P1 blocker unless new evidence establishes one.

Implication:
The failed review, candidate, and frozen evidence remain immutable. Read-only diagnosis is the sole authorized application activity; repair requires a later governed authorization. P2, Betty Final Audit, deployment, application-main merge, and paid/live provider or model calls remain prohibited.

---

## Decision: Client action ranking follows business-impact domains

Date: 2026-08-27
Status: Active

Decision:
Client-facing action ranking is governed by business-impact domain before raw numeric finding priority: proven foundation blockers first, then Conversion, Trust, Performance / UX, Acquisition / SEO, Technical hygiene, then Other. Numeric `finalPriority` ranks work within the same client-impact domain rather than allowing a technical-hygiene issue to outrank a more material conversion-facing category merely because its score is numerically higher.

Reason:
The prior renderer could label and rank technically severe findings such as missing meta descriptions ahead of more material conversion/friction issues. That order was technically deterministic but commercially misleading for a conversion-readiness report.

Implication:
Future Report v2 prioritization must preserve the domain hierarchy and the evidence-confidence gate. Low-confidence findings cannot be promoted merely by belonging to a high-impact domain. This is a render-time interpretation/order rule only and must not alter governed evidence or scoring values.

---

## Decision: Infrastructure URLs remain evidence but are not client-facing pages

Date: 2026-08-27
Status: Active

Decision:
Infrastructure, proxy, CDN, asset, tracking, storage, and comparable holder URLs may remain in governed collected evidence but must be suppressed from client-facing finding-page examples when they are not meaningful commercial/site pages. The current renderer specifically excludes third-party hosts, `/cdn-cgi/` infrastructure paths, and obvious static asset files from client-facing finding `affectedUrls`.

Reason:
Raw acquisition can legitimately encounter infrastructure endpoints such as Cloudflare email-protection routes, but presenting those endpoints to a client as meaningful affected website pages distorts the report narrative and makes utility/infrastructure noise appear commercially significant.

Implication:
Apply this as presentation-layer sanitization only. Do not mutate canonical/raw/normalized evidence to clean the report. Keep regression coverage proving client-facing suppression and non-mutation of the underlying URL evidence.


---

## Decision: Executive Scorecard v6 design frozen

Date: 2026-09-18
Status: Active

Decision:
Freeze the approved Executive Scorecard presentation represented by `prysm-executive-scorecard-final-language-v6.html`. Preserve the existing PRYSM report shell, sidebar, header, colours, typography, borders, spacing style, navigation, seven-section report structure, and current Executive Scorecard information architecture. The approved executive call remains: “Keep the current site. Fix speed and buyer questions first.”

Reason:
The approved mockup reached the required client-facing quality threshold after readability polish. Further structural redesign would create unnecessary drift without a demonstrated client-value gain.

Implication:
Do not add content or redesign the Executive Scorecard. Any later implementation must reproduce the frozen design generically from audit data, without TBK-specific hard-coding. “Rebuild the whole site” must not be triggered casually by a score alone. Production remains frozen. The next presentation-design target is the second report page, Priority Fixes.


---

## Decision: Priority Fixes v2 design frozen

Date: 2026-09-18
Status: Active

Decision:
Freeze the approved Priority Fixes presentation represented by `prysm-priority-fixes-v2.html`. Preserve the existing PRYSM shell and the approved page hierarchy: primary instruction, three main priorities, each using What we know → Check these first → How to know it worked, with an explicit evidence guardrail, followed by two lower-priority cleanup items and the final work-order sequence.

Reason:
The page reached the required client-facing quality threshold while improving diagnostic usefulness without turning likely causes into asserted diagnoses.

Implication:
Do not redesign or add content to Priority Fixes unless explicitly reopened. Future implementation must source the three diagnostic checks deterministically and preserve the distinction between proven finding, common checks, and verified remedy. Production remains frozen. The next presentation-design target is Conversion Journey.


---

## Decision: Conversion Journey middle-road v4 design frozen

Date: 2026-09-18
Status: Active

Decision:
Freeze the approved middle-road Conversion Journey presentation represented by `prysm-conversion-journey-middle-road-v4.html`. Preserve the existing PRYSM shell and the approved page hierarchy: executive journey call; three journey stages with explicit evidence seen and status; three equal-weight friction cards with plain-language conversion impact; keep guidance; measurement boundary; and next-step sequence.

Reason:
The page reached the required client-facing quality threshold while clearly distinguishing observed journey evidence, likely conversion friction, business impact, and action. The design communicates a fixable middle-state journey without implying either that the site is healthy or that it requires a rebuild.

Implication:
Do not redesign or add content to this middle-road Conversion Journey state unless explicitly reopened. Future implementation must preserve evidence-safe language and deterministic state selection across strong, middle, and materially weak journey outcomes. Production remains frozen. The next presentation-design target is Content Opportunities.


---

## Decision: Content Opportunities v2 design frozen

Date: 2026-09-18
Status: Active

Decision:
Freeze the approved Content Opportunities presentation represented by `prysm-content-opportunities-v2.html`. Preserve the existing PRYSM shell and the approved page hierarchy: audit-derived content strengths; ranked opportunities with buyer question, rationale, creation guidance, funnel stage, and evidence confidence; hub-and-spoke planning; funnel architecture; plan → create → adapt → distribute → measure system; content-planning principles; evidence guardrail; and a restrained optional-support note naming Omnipressence.

Reason:
The page reached the strongest client-facing quality level in the current redesign. It demonstrates both audit authority and practical content-strategy expertise without collapsing the audit into a sales pitch.

Implication:
Do not redesign or add content to Content Opportunities unless explicitly reopened. Future implementation must preserve the distinction between audit findings and optional Omnipressence services, keep funnel/hub-spoke guidance as a planning layer rather than pretending the audit directly observed that architecture, and preserve evidence-confidence language. Production remains frozen. The next presentation-design target is Trust & Credibility.


---

## Decision: Trust & Credibility v2 design frozen

Date: 2026-09-18
Status: Active

Decision:
Freeze the approved Trust & Credibility presentation represented by `prysm-trust-credibility-v2.html`. Preserve the existing PRYSM shell and the approved page hierarchy: executive trust call; observed trust assets; buyer trust-question evidence; placement/timing risks; guidance for using existing proof; growth relevance across buying confidence, search visibility, and AI-search readiness; explicit non-guarantee guardrails; audit boundaries; and next-step sequence.

Reason:
The page reached the required client-facing quality threshold while connecting trust evidence to conversion, search understanding, and AI-readiness without overstating ranking, traffic, citation, or conversion guarantees.

Implication:
Do not redesign or add content to Trust & Credibility unless explicitly reopened. Future implementation must preserve the distinction between observed trust evidence, buyer-confidence effects, search/AI understanding signals, and non-guaranteed growth outcomes. Production remains frozen. The next presentation-design target is Competitor Comparison.


---

## Decision: Competitor Comparison v1 design frozen

Date: 2026-09-18
Status: Active

Decision:
Freeze the approved Competitor Comparison presentation represented by `prysm-competitor-comparison-v1.html`. Preserve the existing PRYSM shell and the approved page hierarchy: comparison call; named-competitor scope; descriptive benchmark table; meaningful differences; protect/improve/differentiate/ignore actions; anti-copy guardrail; comparison limits; and next-step sequence.

Reason:
The page reached the required client-facing quality threshold while using competitor evidence as decision context rather than vanity ranking or a reason to copy surface design.

Implication:
Do not redesign or add content to Competitor Comparison unless explicitly reopened. Future implementation must preserve named-competitor scope, descriptive non-ranking language, and the distinction between contextual comparison and evidence-backed client action. Production remains frozen. The next presentation-design target is Supporting Detail.


---

## Decision: Evidence sufficiency gates narrative state

Date: 2026-09-18
Status: Active

Decision:
Every client-facing PRYSM report page must determine its allowed narrative from both (1) observed condition and (2) evidence sufficiency. A page must not select Strong / Middle / Weak messaging from score, finding count, or severity alone.

The governing sequence is:
Evidence sufficiency → condition state → allowed narrative state → actions.

At minimum, the renderer must distinguish:
- Strong condition + sufficient evidence: positive conclusion is allowed.
- Strong condition + partial evidence: positive signals may be stated, but the page must explicitly limit the conclusion to the reviewed scope.
- Middle condition + sufficient evidence: state the working foundation and the specific weaknesses that need attention.
- Weak condition + sufficient evidence: state the material problems established by the evidence and prioritize corrective action.
- Weak condition + partial evidence: state the material problems established in the reviewed scope, but do not generalize them to the whole site.
- Insufficient / unavailable evidence: withhold the condition conclusion and state that PRYSM cannot make a reliable judgment yet.

Reason:
A three-state good / middle / weak system can otherwise turn missing evidence into false praise or false certainty. PRYSM already preserves AVAILABLE, PARTIAL, UNAVAILABLE, and UNKNOWN semantics; those semantics must constrain client-facing language rather than sit only in Supporting Detail.

Implication:
All frozen report-page designs are decision templates, not fixed narratives. Their shell and information architecture may remain stable, but executive calls, emphasis, recommendations, guardrails, and next-step sequences must change deterministically according to both evidence coverage and condition state. Missing evidence must never be treated as a positive result. Production remains frozen; this rule governs later deterministic implementation and the strong/middle/weak mockup set.


---

## Decision: Supporting Detail v2 design frozen

Date: 2026-09-18
Status: Active

Decision:
Freeze the approved Supporting Detail presentation represented by `prysm-supporting-detail-v2.html`. Preserve the existing PRYSM shell and the approved page hierarchy: evidence-completeness states; readiness dimensions; material findings; lab-performance evidence with field-data guardrail; evidence limits; source status; direct conclusion → evidence → coverage traceability; and a concise verification next step.

Reason:
The page reached the required client-facing quality threshold while providing enough evidence to prove the report without becoming a raw technical dump.

Implication:
Do not redesign or add content to Supporting Detail unless explicitly reopened. Raw crawl tables, URL dumps, schema dumps, heading-count dumps, and implementation diagnostics remain deeper evidence rather than default client-facing content. Future implementation must preserve PARTIAL / UNAVAILABLE / UNKNOWN semantics and conclusion-to-evidence traceability. Production remains frozen.


---

## Decision: Seven-page deterministic narrative-state contract frozen

Date: 2026-09-18
Status: Active

Decision:
Freeze `SPECS/PRYSM_SEVEN_PAGE_NARRATIVE_STATE_CONTRACT_v1.0.md` as the governing narrative-state contract for the seven approved report templates. The only allowed client-facing narrative states are STRONG, MIDDLE, WEAK, and INSUFFICIENT_EVIDENCE. State selection must follow evidence sufficiency → condition state → allowed narrative state → page-specific message → bounded action. Score, finding count, severity, competitor behavior, search demand, or missing evidence may not independently select narrative state.

Reason:
Without one shared contract, the same audit can produce false certainty, contradictory page messages, positive-by-absence or negative-by-absence conclusions, and unnecessary whole-site rebuild language. The frozen contract makes evidence sufficiency a hard gate and defines report-wide consistency rules before implementation.

Implication:
All seven frozen page templates are decision templates whose shell and information architecture remain unchanged while state-dependent language changes deterministically. INSUFFICIENT_EVIDENCE overrides condition classification when material evidence cannot support a reliable judgment. PARTIAL evidence may support a bounded condition only when scope is explicit. No STRONG/MIDDLE/WEAK page state, score, finding count, severity, or combination thereof automatically authorizes a whole-site rebuild recommendation. Future application work must implement this contract at the report layer only and must pass the 15 false-certainty rejection tests before production consideration. Production remains frozen.


---

## Decision: Conversion Friction Encyclopedia v1.0 contract frozen

Date: 2026-09-19
Status: Active

Decision:
Freeze `SPECS/PRYSM_CONVERSION_FRICTION_ENCYCLOPEDIA_CONTRACT_v1.0.md` as the governing diagnostic contract for PRYSM's Conversion Friction Encyclopedia and Relationship System. The contract freezes 12 diagnostic areas, 75 canonical problems, six relationship types, four client-facing friction states, evidence-lineage and duplicate controls, friction-cluster and reviewed-standalone priority rules, challenge/falsification, critical-blocker handling, causal guardrails, bounded repair specificity, verification rules, and separation from the frozen seven-page narrative-state classifier.

Reason:
The contract passed a multi-pass review gate. The original 15 core cases passed; 30 adversarial cases exposed 11 real boundary ambiguities; those governing weaknesses were corrected; the complete suite then passed 45/45 from a clean rerun; and 11/11 mutation tests correctly failed when each new safeguard was removed. The resulting architecture prevents checklist inflation, duplicate counting, pseudo-corroboration, artificial clustering, scope leakage, causal overreach, stale blocker escalation, evidence/measurement confusion, and premature mechanism-specific repair.

Implication:
Future implementation must conform to the frozen contract and must not create a second narrative-state engine. No raw finding may become a Priority Fix before whole-site mapping, relationship/materiality/duplicate/dependency review, and challenge. Critical blockers remain the explicit immediate-surfacing exception. Production remains frozen. The next governed work is implementation-boundary design only: map existing PRYSM evidence/finding surfaces to the frozen canonical model, identify exact application files and tests that would need change, prove that the seven-page narrative-state contract remains authoritative, and define the smallest coherent implementation tranche before any code is changed.


---

## Decision: Encyclopedia implementation uses autonomous GACM tranche execution

Date: 2026-09-19
Status: Active

Decision:
Authorize the PRYSM Conversion Friction Encyclopedia implementation to run as one locally autonomous Codex/GCU execution under the GACM control pattern after exact local authority is verified. The run begins with a read-only implementation-boundary tranche, then may continue automatically through bounded implementation tranches when the current tranche satisfies its frozen scope, proving tests, independent verification, affected-scope regression checks, and an evidence-backed quality-confidence floor of at least 97%. A failed test, independent-verifier FAIL/BLOCKED/UNOBSERVABLE result, unresolved major defect, authority mismatch, scope expansion, or protected release boundary overrides any numeric confidence estimate and prevents progression.

Reason:
The encyclopedia contract is frozen and has already passed adversarial contract review. Chris wants the implementation completed with minimal stop/start supervision while retaining GACM discipline: freeze before change, bounded units, one implementation owner, independent verification, scoped repair, re-verification, evidence preservation, and fail-closed progression. A numeric confidence floor is useful as an additional quality criterion but cannot replace deterministic evidence or independent PASS.

Implication:
Codex may autonomously perform local diagnosis, planning, implementation, local commits, testing, challenge, bounded repair, affected-scope re-verification, and final local whole-system acceptance on the exact PRYSM repair branch. Each tranche must produce evidence and may auto-continue only after independent PASS plus >=97% evidence-backed confidence. Up to three same-root repair attempts are allowed before mandatory diagnostic reset; the run must not game confidence or weaken tests. All generated proof/report artifacts must be written to `C:\Users\kulba\Downloads\`. The run may not push the local-only accepted baseline or implementation commits, merge, deploy, mutate production, call paid/live providers or models, start a production audit, or cross another explicit authorization boundary. Final output is a comprehensive completion report for human review before any promotion/release action.


---

## Decision: Every governed run report records execution-efficiency telemetry

Date: 2026-09-19
Status: Active

Decision:
Every future PRYSM governed tranche proof, repair proof, verification proof, and final completion report must record machine-measured execution timing and rework data from the start of the run rather than reconstructing it afterward. At minimum each report must include exact start timestamp, exact finish timestamp, wall-clock elapsed time, model identity and reasoning/effort level when available, implementation attempts, failed iterations/rework cycles, defects/errors/problems found, repairs performed, independent-verification cycles, tests run with PASS/FAIL counts, files changed, confidence/result, and any available token/cost/model-execution-time data. Final reports must also aggregate these measures across all tranches in the run.

Reason:
PRYSM and GACM need comparable evidence for autonomous-run duration, model efficiency, rework burden, error rates, and verification cost. Prior runs often lacked exact timestamps, forcing retrospective estimates and preventing reliable comparison between Luna, Terra, Sol, or other execution configurations.

Implication:
Capture timestamps directly from the execution machine in ISO-8601 with timezone offset, using America/Toronto as the human-readable project timezone when useful. Start timing immediately before the first substantive governed action and finish only after the tranche/run verification result and proof artifact are written. Use a monotonic elapsed timer where available in addition to wall-clock timestamps. Never invent unavailable timing, token, cost, or model-duration data; record `NOT_AVAILABLE` instead. Every future Codex/GACM prompt must require this telemetry block in each tranche proof and final report, and materially completed packages must be summarized in `EFFICIENCY_METRICS.md`.


---

## Decision: Whole-system reconciliation locally accepted

Date: 2026-09-19
Status: Active

Decision:
Accept local application candidate `d313643d7d49797c433dc60cf630b5bbd3c0d427` as the completed PRYSM whole-system reconciliation candidate. The governed local closure produced `LOCAL_ACCEPTANCE_PASS`, final targeted acceptance 500/500 PASS, full-worker 1015/1015 PASS, aggregate final acceptance 1515 PASS / 0 FAIL / 0 SKIP, final independent verifier PASS, protected-surface integrity PASS, and 99% evidence-backed confidence.

Reason:
The reconciliation reproduced the original eight failures at both the original encyclopedia starting SHA and the pre-reconciliation candidate, proved they were stale test/fixture authorities rather than encyclopedia product defects, grouped them into four root causes, repaired them in bounded local tranches, then detected and repaired one additional stale response-header expectation during fresh whole-system acceptance. No product scoring logic, frozen narrative-state authority, encyclopedia implementation, provider acquisition, auth, n8n, lifecycle, production configuration, or frozen contract was weakened or changed.

Implication:
The local candidate is accepted for the completed repair scope, but this does not itself authorize push, merge, promotion, deployment, production mutation, or production audit. Any release action is a separate governed tranche. Preserve the exact accepted candidate identity and use the measured 18m25.10s run telemetry as the first prospective autonomous whole-system efficiency baseline.
