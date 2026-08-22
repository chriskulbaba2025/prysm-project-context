# PRYSM Final Report Rebuild — Page-by-Page Handoff

# Current Verified Implementation Checkpoint — 2026-08-22

- The full report scaffold below is approved.
- Current visible report UI was reviewed before implementation.
- The existing dark, numbered left-hand navigation and one-page-at-a-time viewer concept remain approved.
- The report redesign primarily changes page content hierarchy, interpretation, explanatory states, and deterministic visuals.
- The current Executive Scorecard already contains useful elements — readiness, confidence, evidence coverage, strengths, executive conclusion, and preserve/change/do-next — but these will be reorganized into the approved executive decision flow rather than replaced indiscriminately.
- A standalone Accessibility & Mobile Usability Readiness page is part of the approved final scaffold, bringing the scaffold to 16 pages.
- GitHub/repository changes are currently being completed elsewhere. **Do not begin report code implementation until the repository update finishes and the exact stable branch/head is confirmed.**
- Exact implementation method remains: **one page only → inspect → propose smallest change → approve → edit → test → verify → approve next page**.

---

## Purpose

Continue the PRYSM final-report rebuild from this exact design checkpoint.

This handoff governs **report structure and presentation only**.

## Hard Boundary

Do **not** change:

- evidence collection
- adapters/providers
- scoring logic
- lifecycle/state transitions
- storage
- canonical evidence plumbing
- Writer/Judge governance
- audit orchestration
- n8n flows
- report-data contracts unless an existing field must simply be displayed
- unrelated CSS/UI work being handled elsewhere

The goal is to update the **final report page by page**, manually and surgically.

## Required Working Method

For every report page:

1. Inspect the current implementation for that page.
2. Compare it against the approved scaffold below.
3. Propose the **smallest report-layer change** needed.
4. Stop for review before editing.
5. After approval, make only that page's change.
6. Test that page.
7. Verify no unrelated report behavior changed.
8. Only then move to the next page.

Do not batch multiple report pages into one change.

Do not redesign plumbing to achieve a presentation improvement.

---

# Report-Wide Rules — Frozen

Every report page must follow these principles:

- Begin with a **plain-language client question**.
- Show the formal report/technical category beneath it.
- **Answer the question before presenting technical evidence.**
- Use client-facing statuses:
  - PASS
  - FINDING
  - PARTIAL
  - UNAVAILABLE
  - NOT APPLICABLE
- Every status must include an explanation.
- Never leave unavailable, partial, missing, blocked, or not-connected evidence unexplained.
- Important commercial/conversion pages should drive the client-facing narrative.
- Low-value utility-page observations must not dominate site-level conclusions.
- Distinguish **technical observations** from **material findings**.
- Always show **what is already working**.
- Technical metrics are evidence, not the conclusion.
- Recommendations should appear only when materially relevant to:
  - search visibility
  - conversion
  - trust
  - accessibility
  - usability
  - crawl/indexation
  - defined business objectives
- Missing evidence is never a negative finding by itself.
- Report visuals should default to lightweight **inline SVG**, not AI-generated imagery.
- Visuals must use existing report values only and must not create or alter scoring.

## Standard Page Order

Where applicable, pages should use this sequence:

1. Client-facing question
2. Formal assessment category
3. Plain-language answer
4. Coverage/status summary
5. Material findings
6. What this means
7. Recommended action
8. Verification
9. What is already working
10. Limitations / unavailable evidence

Not every page needs every block, but the reading logic should remain consistent.

---

# Approved Page Scaffolds

## 1. Executive Scorecard

### Client question
**How ready is your website to convert the right visitors?**

### Formal category
**Executive Scorecard**

### Structure

1. Executive verdict — concise plain-language determination.
2. Supporting measures:
   - Conversion Readiness
   - Evidence Confidence
   - Evidence Assessed
   - plain-language meaning for each
3. **What is really holding the site back?**
   - one primary root-cause statement
   - three findings that best explain it
4. **What should you do first?**
   - three ordered actions
5. **What is already working?**
6. **What could we not determine?**
   - compact evidence limitation note
7. **Where to go next**
   - direct user toward Priority Fixes

### Frozen rule
The Executive Scorecard must tell the client the answer, the most important cause, the three highest-priority actions, and the completeness of the evidence without requiring them to interpret the rest of the report.

---

## 2. Priority Fixes

### Client question
**What should you fix first?**

### Formal category
**Priority Findings & Recommendations**

### Structure

Show a maximum of five primary fixes.

For each:

- Priority
- What we found
- Why it matters
- What to do
- Where
- How to verify
- Why this priority ranks where it does

Add a secondary note for lower-priority observations.

### Frozen rule
The Priority Fixes page shows only actions important enough to warrant client attention, in the order PRYSM recommends they be addressed, with a plain-language explanation of why each action earned that position.

---

## 3. Conversion Path Architecture

### Client question
**Can visitors easily move from interest to action?**

### Formal category
**Conversion Path Architecture**

### Structure

1. Direct answer
2. Primary conversion-path visual/sequence:
   - Entry
   - Service understanding
   - Trust/proof
   - Primary CTA
   - Conversion destination
3. Important path status table
4. **Where visitors may hesitate**
5. **What is working**
6. Material findings only
7. Limitations

### Frozen rule
Explain the visitor’s most important routes to action and identify where those routes become unclear, weak, or interrupted. Do not catalogue every navigation element.

---

## 4. Conversion Readiness Map

### Client question
**Where is the site helping or hurting conversion?**

### Formal category
**Conversion Readiness Map**

### Structure

Use the five existing PRYSM dimensions:

- Conversion Pathways & Offer Clarity
- Trust, E-E-A-T & Risk Reduction
- Content & Funnel Coverage
- Technical & Performance Readiness
- Entity, Schema & AI-Search Readiness

Include:

1. Direct answer
2. Five-axis radar/spider chart using existing dimension scores only
3. Plain-language bands:
   - Strong
   - Adequate
   - Needs Attention
   - Material Gap
4. Limited-evidence marking where applicable
5. **What is driving weaker areas**
6. **Where the foundation is strong**
7. Evidence limitations by dimension

### Frozen rule
The radar is explanatory only. It does not create or change scoring.

---

## 5. Topical Map & Qualified Content Opportunities

### Client question
**Does your content answer the questions buyers actually have?**

### Formal category
**Topical Map & Qualified Content Opportunities**

### Structure

1. Direct answer
2. Buyer-question coverage visual:
   - Understand the problem
   - Understand the service
   - Evaluate fit
   - Build trust
   - Compare options
   - Take action
3. Coverage states:
   - Strong
   - Adequate
   - Thin
   - Gap
   - Limited Evidence
4. Coverage table
5. Material content gaps
6. Qualified opportunities
7. **Where content is already doing its job**
8. Evidence limitations

For opportunities show:

- Buyer question
- Current coverage
- Why it matters
- Recommended content
- Where it should connect

### Frozen rule
Search demand and competitor coverage may strengthen an opportunity, but neither alone is sufficient to create a recommendation.

---

## 6. Competitor Benchmark

### Client question
**How does your website compare with the competitors buyers are likely to consider?**

### Formal category
**Competitor Benchmark**

### Structure

1. Direct answer
2. Who was compared and why
3. Comparative overview using material areas only:
   - offer clarity
   - trust evidence
   - service depth
   - buyer questions
   - conversion path
4. **Where you are already competitive**
5. **Where competitors provide a stronger buying experience**
6. Qualified comparative gaps
7. Evidence limitations

For each retained comparison:

- What competitors do
- What your site does
- Why the difference matters
- PRYSM judgment

### Frozen rule
Competitor behavior alone never creates a recommendation.

---

## 7. Trust, E-E-A-T & Risk Reduction

### Client question
**Can a buyer find enough proof to feel confident taking the next step?**

### Formal category
**Trust, E-E-A-T & Risk Reduction**

### Structure

1. Confidence verdict
2. Buyer trust questions:
   - Who are these people?
   - Do they understand my problem?
   - Have they done this successfully before?
   - Why should I believe the claims?
   - What happens if I contact them?
   - What reduces my risk?
3. Claim → Proof → Reassurance → Action visual
4. **Where confidence breaks down**
5. **Proof already available but underused**
6. Material trust findings
7. Assessment limitations

### Frozen rule
Evaluate whether visible evidence reduces buyer uncertainty at important decision points. Do not merely count trust signals.

---

## 8. CMS & Platform Constraints

### Client question
**Is your website platform making important improvements harder?**

### Formal category
**CMS & Platform Constraints**

### Structure

1. Direct answer
2. Platform capability matrix:
   - content editing
   - SEO controls
   - structured data
   - performance flexibility
   - mobile/accessibility flexibility
   - conversion components
3. **Is this really a platform problem?**
4. **What can be improved within the current site**
5. Material platform constraints only
6. Assessment limitations

### Frozen rule
Never imply a rebuild is necessary simply because a technical issue exists.

---

## 9. Technical SEO Hygiene

### Client question
**Can search engines reliably discover, understand, and trust your important pages?**

### Formal category
**Technical SEO Hygiene**

### Structure

1. Direct technical verdict
2. **Is anything blocking search performance?**
3. Priority-page technical-health table
4. Organize technical coverage under:
   - Reach
   - Index
   - Understand
   - Deliver
5. Full SEO Coverage Matrix
6. Material findings
7. Secondary observations
8. Unavailable / partial evidence

### SEO Coverage Matrix

Every row must show:

- Audit area
- Status
- What was assessed
- Explanation

Coverage should include existing evidence such as:

- titles
- meta descriptions
- canonicals
- indexability
- robots
- HTTP status
- redirects
- broken links
- sitemap evidence
- duplicate content
- structured data
- response time
- page size
- mobile/desktop performance where relevant

Reserve report rows for Adam’s genuine additions when evidence exists:

- HTTP → HTTPS validation
- redirect chains/loops
- mixed content
- compression diagnostics
- material JavaScript errors
- Open Graph/social metadata

### Frozen rule
Distinguish a technically observable issue from a technically material issue. Important pages and search interpretation drive the narrative.

---

## 10. Heading & Semantic Structure

### Client question
**Are your important pages structured clearly for visitors and search engines?**

### Formal category
**Heading & Semantic Structure**

### Structure

1. Direct answer
2. Important-page heading-health table
3. For relevant pages:
   - Primary page purpose
   - Expected main topic
   - Observed heading structure
   - Why the difference matters
4. Optional outline visual:
   - H1
   - H2
   - H2
   - etc.
5. Material hierarchy findings
6. What is already structured well
7. Secondary observations
8. Limitations

### Frozen rule
Raw H1/H2 counts are supporting evidence, not the conclusion. Low-value utility pages must not dominate site-level heading conclusions.

---

## 11. Schema & Entity Clarity

### Client question
**Can search engines clearly understand who you are and what you offer?**

### Formal category
**Schema & Entity Clarity**

### Structure

1. Direct answer
2. Entity-question matrix:
   - Who is the business?
   - What does the business offer?
   - Where does the business operate?
   - Who is behind the expertise?
   - How are key pages connected?
3. Simple entity relationship SVG:
   - Business
   - Services
   - People / Expertise
   - Locations
   - Supporting Content
4. **What search engines can already understand**
5. **Where structured clarity is weak**
6. Material findings only
7. Unavailable / partial evidence

### Frozen rule
Judge whether structured signals materially improve or weaken search-engine understanding. Do not simply count schema types.

---

## 12. Performance

### Client question
**Are your most important pages fast enough for visitors?**

### Formal category
**Performance**

### Structure

1. Direct answer
2. Priority-page mobile/desktop performance table
3. **What does the visitor actually experience?**
4. Separate:
   - Lab performance
   - Field performance
5. What is already performing well
6. Material performance findings
7. Partial / unavailable evidence

Metrics such as LCP, CLS, INP, TBT, page size, and response time support the conclusion but do not become the conclusion.

### Frozen rule
Performance should be interpreted by its effect on important user and conversion paths.

---

## 13. Accessibility & Mobile Usability Readiness

### Client question
**Can visitors comfortably understand, navigate, and act on your site?**

### Formal category
**Accessibility & Mobile Usability Readiness**

### Structure

1. Readiness summary
2. Material barriers
3. Coverage notes
4. Areas:
   - Mobile viewport
   - Responsive layout
   - Font legibility
   - Tap targets
   - Accessibility readiness
5. Explain every unavailable/partial state

### Permanent disclaimer
Accessibility Readiness identifies observable barriers and risks. It does not certify legal compliance with AODA, WCAG, or other accessibility standards.

### Frozen rule
Present accessibility and mobile usability as decision-oriented readiness, not a flat checklist.

---

## 14. Internal-Link Opportunities

### Client question
**Can visitors and search engines easily reach related important pages?**

### Formal category
**Internal-Link Opportunities**

### Structure

1. Direct answer
2. Important relationship table:
   - Homepage → Core Services
   - Blog → Relevant Service
   - Service → Trust Evidence
   - Service → Conversion Action
   - Related Content → Related Content
3. Inline SVG pathway:
   - Discovery Content
   - Service / Offer
   - Proof / Trust
   - Conversion
4. **Where the journey weakens**
5. **What is already working**
6. Qualified link opportunities
7. Limitations

For each recommendation show:

- Source page
- Destination page
- Why the relationship matters
- Suggested contextual role
- Expected visitor benefit

### Frozen rule
Link quantity alone is not a finding.

---

## 15. Evidence Appendix

### Client question
**What evidence was available for this audit?**

### Formal category
**Evidence Appendix**

### Structure

1. Direct answer
2. Evidence coverage table:
   - Evidence source / area
   - Status
   - Coverage
   - Used for
   - Explanation
3. **What this affected**
4. Evidence confidence summary
5. Technical provenance details as secondary information

For every partial/unavailable source explain whether it:

- reduced confidence
- limited a section
- suppressed a conclusion
- had no effect on readiness scoring

### Frozen rule
Audit completeness must be understandable without requiring the client to interpret provider logs or raw metadata.

---

## 16. Deferred & Unavailable Analysis

### Client question
**What could PRYSM not determine yet?**

### Formal category
**Deferred & Unavailable Analysis**

### Structure

1. Direct summary
2. Mandatory table:
   - Area
   - Status
   - What was unavailable
   - Why it matters
   - What PRYSM did instead
3. For each gap explain:
   - What is missing
   - Why it is missing, if known
   - What conclusion cannot be made
   - Whether anything else in the report is affected
4. **What this does NOT mean**
5. **What can be assessed later**

### Frozen rule
No unavailable, partial, blocked, or not-connected evidence may appear without an explanation of what is missing, why it matters, what conclusion was withheld, and whether the rest of the report is affected.

---

# Adam Recommendation Alignment

The report redesign is intended to honor three core recommendations:

## 1. Expose existing SEO evidence

Make visible what PRYSM already assessed using explicit status and explanation.

## 2. Add genuine missing high-value areas to the report scaffold

Highest-value categories include:

- Accessibility Readiness
- Mobile viewport/responsiveness
- Font legibility
- Tap-target sizing
- Mixed-content detection
- HTTP → HTTPS validation
- Redirect chain/loop detection
- Compression diagnostics where material
- JavaScript errors where material
- Deeper authority/backlink assessment when evidence exists
- Conditional local SEO
- Basic Open Graph/social metadata

Do not invent evidence for these. If evidence is not presently available, report it as unavailable/partial/not assessed rather than changing collection plumbing during this report-layer rebuild.

## 3. Preserve PRYSM judgment

Do not penalize or create findings merely because a site lacks:

- a social platform account
- Facebook Pixel
- a particular authority score
- a large backlink count
- HTTP/3
- favicon
- iframe presence/absence without demonstrated impact

Technical observations should become recommendations only when they materially affect the business-relevant decision model.

---

# Implementation Order

Work in this exact page sequence:

1. Executive Scorecard
2. Priority Fixes
3. Conversion Path Architecture
4. Conversion Readiness Map
5. Topical Map & Qualified Content Opportunities
6. Competitor Benchmark
7. Trust, E-E-A-T & Risk Reduction
8. CMS & Platform Constraints
9. Technical SEO Hygiene
10. Heading & Semantic Structure
11. Schema & Entity Clarity
12. Performance
13. Accessibility & Mobile Usability Readiness
14. Internal-Link Opportunities
15. Evidence Appendix
16. Deferred & Unavailable Analysis

Do not skip ahead.

---

# Exact Next Action in the New Chat

Start with **Executive Scorecard only**.

1. Locate the existing final-report implementation for the Executive Scorecard.
2. Inspect current inputs and markup.
3. Compare it with this approved scaffold.
4. Propose the smallest report-layer change.
5. Do not edit code until the user approves that specific change.

After approval:

6. Update only the Executive Scorecard.
7. Test it.
8. Verify no unrelated page changed.
9. Present the result for review.
10. Do not proceed to Priority Fixes until explicitly approved.
