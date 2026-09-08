# S05 — Content Opportunities Baseline Audit

Date: 2026-09-07
Status: COMPLETE
Baseline score: **58/100**
Hard-gate failures: **0**

## Root cause

The Content Opportunities page is structured as a topical/content export rather than as a prioritized client decision page. It presents buyer-need rows, generated opportunities, covered topics, and leading search intents, but does not make the first commercially meaningful content action obvious.

## CRO / content-strategy blind spots

- No clearly prioritized first content action is identified.
- Buyer-stage grouping exists but does not explain the client decision sequence.
- Recommendations do not consistently state why the opportunity matters commercially.
- Generic journey connection text does not identify the actual destination.
- Covered topics are listed without showing which buyer question or decision they support.
- Leading search intents add SEO detail without a clear conversion role.
- Opportunity order follows generated stage grouping rather than a clearly governed commercial priority.
- Generic fallback labels weaken confidence when source fields are incomplete.
- The page does not clearly distinguish current strength, evidence-backed gap, qualified opportunity, and inferred recommendation.
- The intended decision-support outcome of each asset is not explicit enough.

## UX / UI defects

- Technical/repetitive headline hierarchy.
- Buyer-question coverage is shown as a dense table that requires interpretation.
- The primary opportunity table is too dense to scan as an executive decision sequence.
- Strengths, gaps, and opportunities are not visually differentiated.
- No obvious `start here` treatment.
- High-value opportunities and supporting search-intent detail receive similar visual weight.
- Long rows make the page feel like an export rather than an executive report.
- No concise top-level verdict.
- No clear visual explanation of where an opportunity fits in the existing conversion journey.

## Evidence-integrity limitations

- Content-body evidence remains PARTIAL.
- Unassessed pages remain unknown and must not be treated as missing content.
- Search demand, competitor presence, or topic existence must remain opportunity signals, not confirmed deficiencies.
- Coverage counts do not prove complete page-level quality or buyer comprehension.
- Trust-score proxies should not be presented as direct content coverage without qualification.
- No traffic, ranking, revenue, conversion-uplift, search-volume, or causal outcome claim is established.

## What should remain

- governed `contentIdeas` inputs and persisted evidence lineage;
- buyer-question framing;
- awareness, evaluation, and decision stages as organizing concepts;
- qualified-opportunity filtering;
- meaningful-topic suppression for malformed/low-value labels;
- explicit evidence limitations;
- Content Opportunities as a primary destination;
- Supporting Detail reachability;
- rule that search demand or competitor coverage alone does not create a recommendation;
- canonical evidence, scores, findings, Client Truth, and Writer/Judge semantics.

## What should be removed or consolidated

- dense five-column opportunity table on the primary client surface;
- generic journey-connection wording;
- separate leading search-intent table competing with the main story;
- raw topical lists that do not explain buyer relevance;
- repeated `Topical Map` terminology;
- mechanical coverage states with weak client meaning;
- fallback/duplicate labels with no meaningful opportunity title;
- equal-weight presentation of supporting SEO detail and commercially important opportunities.

## Minimum client outcome

Within approximately 10–20 seconds, the client should understand:

- what content already helps buyers;
- which content gap is commercially meaningful;
- what to create or improve first;
- which buyer stage the opportunity supports;
- why it matters to conversion or decision support;
- where the asset should connect in the existing journey;
- what remains unknown because content-body evidence is PARTIAL.

## Approved bounded contract

Kicker:
`Content Opportunities`

H2:
`What content would help buyers move forward?`

Primary client story:
1. `What is already helping buyers`
2. `Where decision support is thin`
3. `What to create or improve first`

Primary qualified opportunities should render as concise cards with:
- buyer question / need;
- buyer stage;
- why it matters;
- recommended asset;
- journey connection;
- intended decision-support role;
- evidence qualification.

Rules:
- preserve governed opportunity order; do not recompute ranking;
- make the first opportunity visually obvious without creating a new scoring system;
- distinguish current strength, evidence-backed gap, and qualified opportunity;
- journey connection must be specific where governed, otherwise explicitly bounded;
- keep search-intent and raw topical/technical detail subordinate and move it to Supporting Detail where possible;
- preserve PARTIAL content-body scope and unassessed-page uncertainty;
- search demand or competitor presence alone must not create a recommendation;
- do not claim traffic, rankings, revenue, conversion uplift, or search volume without evidence;
- follow the locked report rule: **Primary pages interpret. Deeper pages explain.**

## Likely ownership to inspect next

- `services/worker/src/report/render-report-v2.js`
- `services/worker/src/report/render-report-v2-sections.test.js`
- `services/worker/src/report/render-report-v2.test.js`
- `services/worker/src/report/render-narrative-v2.js`
- `services/worker/src/report/render-narrative-v2.test.js`

No implementation file is authorized for editing by this baseline proof alone.

## Exact next action

Perform S05 build-boundary diagnosis only. Determine exact render ownership, exact stale tests, whether the narrative seam requires editing or inspection only, any additional file required, the bounded build scope, and the verification command set. Stop before editing.
