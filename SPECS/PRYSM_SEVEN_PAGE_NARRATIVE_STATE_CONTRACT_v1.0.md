# PRYSM Seven-Page Deterministic Narrative-State Contract

Version: 1.0
Status: FROZEN
Date: 2026-09-18
Scope: Seven frozen client-facing report templates only

## Purpose

Define one deterministic narrative-state contract for the frozen seven-page PRYSM report before any application implementation.

This contract governs presentation-layer narrative selection only. It does not change evidence collection, provider/adaptor behavior, scoring logic or versions, audit lifecycle, storage, canonical evidence, Writer/Judge governance, orchestration, authentication, n8n, or production.

The governing sequence is:

```text
evidence sufficiency
→ condition determination
→ allowed narrative state
→ page-specific message
→ bounded action
```

Scores, finding counts, severity, competitor behavior, search demand, or missing evidence may inform supporting evidence where already governed, but none may independently select the narrative state.

---

## 1. Canonical narrative states

Exactly four client-facing narrative states are allowed:

### STRONG

Meaning:
The reviewed evidence establishes that the page's decision question is materially working well enough that the primary client message should preserve the existing foundation rather than lead with corrective action.

Requirements:
- Evidence is sufficient for the material question being answered.
- Material evidence does not establish a contradictory weak condition.
- Positive language stays within the reviewed scope.
- Any PARTIAL evidence is disclosed and cannot be silently converted into a site-wide positive conclusion.

Allowed language pattern:
- "The foundation is working."
- "Keep this."
- "Improve selectively."

Prohibited:
- "No problem exists."
- "The whole site is strong" when only a bounded sample was assessed.
- Any conclusion based mainly on absence of evidence.

### MIDDLE

Meaning:
The reviewed evidence establishes a usable foundation with material weaknesses that should be corrected without implying broad failure.

Requirements:
- Evidence is sufficient to establish both what is working and what materially needs attention.
- Weaknesses are specific and traceable to observed evidence.
- The page must preserve visible strengths rather than presenting the site as uniformly deficient.

Allowed language pattern:
- "The foundation is workable, but these issues are holding it back."
- "Keep the current foundation and fix the identified friction."

Prohibited:
- Converting a few findings into a whole-site failure.
- Treating common causes as proven causes.
- Escalating to rebuild language merely because multiple fixes exist.

### WEAK

Meaning:
The reviewed evidence establishes material problems in the page's decision area that justify prioritized corrective action.

Requirements:
- Evidence is sufficient to establish the material weakness.
- The weakness is not merely a low-value technical observation.
- The conclusion is bounded to the evidence and affected decision area.
- Any action is tied to proven or explicitly bounded evidence.

Allowed language pattern:
- "Material problems are established in the reviewed scope."
- "Correct these issues first."

Prohibited:
- Generalizing a bounded weak result to the whole website without evidence.
- Treating PARTIAL or unavailable evidence as additional proof of weakness.
- Using WEAK as an automatic rebuild trigger.

### INSUFFICIENT_EVIDENCE

Meaning:
PRYSM cannot make a reliable condition judgment for the material question yet.

Requirements:
- Material evidence is UNAVAILABLE, UNKNOWN, blocked, not connected, or too incomplete to establish a reliable condition; or
- the remaining evidence cannot safely distinguish STRONG, MIDDLE, and WEAK.

Required language pattern:
- State what could not be determined.
- State what evidence was available.
- State what conclusion was withheld.
- State whether another page or report-level conclusion is affected.

Prohibited:
- PASS-by-absence.
- FINDING-by-absence.
- assigning STRONG, MIDDLE, or WEAK because the score, count, or severity appears decisive while material evidence is insufficient.

---

## 2. Evidence-sufficiency mapping

Existing evidence semantics remain authoritative:

- AVAILABLE
- PARTIAL
- UNAVAILABLE
- UNKNOWN
- NOT APPLICABLE where applicable

Narrative sufficiency is derived from those semantics without changing them.

### SUFFICIENT

Use when the material evidence needed to answer the page's client question is AVAILABLE and adequate for the governed scope.

Permits:
STRONG, MIDDLE, or WEAK.

### BOUNDED_PARTIAL

Use when evidence is PARTIAL but still sufficient to establish a condition within a clearly bounded reviewed scope.

Permits:
STRONG, MIDDLE, or WEAK only with explicit scope limitation.

Rule:
A BOUNDED_PARTIAL STRONG state may say positive signals were established in the reviewed scope. It may not silently become a site-wide STRONG conclusion.

### INSUFFICIENT

Use when material evidence is UNAVAILABLE, UNKNOWN, blocked, not connected, or PARTIAL to a degree that prevents reliable condition classification.

Permits:
INSUFFICIENT_EVIDENCE only.

### NOT_APPLICABLE

Use when the page question or a subordinate evidence area genuinely does not apply.

Rule:
NOT APPLICABLE is neutral. It cannot increase or decrease condition strength by itself.

---

## 3. Deterministic selection rule

For every frozen page:

1. Identify the material evidence required to answer that page's client question using existing governed report inputs only.
2. Determine narrative sufficiency: SUFFICIENT, BOUNDED_PARTIAL, INSUFFICIENT, or NOT_APPLICABLE.
3. If INSUFFICIENT, select INSUFFICIENT_EVIDENCE and stop condition classification for that material question.
4. Otherwise determine condition from the existing governed evidence and page-specific materiality rules. Do not introduce new scoring thresholds in the renderer.
5. Select STRONG, MIDDLE, or WEAK.
6. Render the page-specific message, evidence, limitations, and actions allowed by that state.
7. Run cross-page consistency checks before final report publication.

No renderer or narrative layer may reverse this order.

---

## 4. Cross-page consistency invariants

The seven pages are separate views of one governed audit. They may emphasize different evidence, but they may not contradict one another.

### Invariant A — evidence status cannot improve downstream

If source evidence is PARTIAL, UNAVAILABLE, or UNKNOWN, a downstream page may narrow its use but may not relabel it as AVAILABLE or imply complete coverage.

### Invariant B — absence is neutral

Missing, unavailable, unknown, blocked, or not-connected evidence is never positive proof and never a negative finding by itself.

### Invariant C — executive synthesis cannot outrank underlying truth

The Executive Scorecard may summarize the other pages, but it may not:
- convert an INSUFFICIENT_EVIDENCE page into a positive conclusion;
- describe a materially WEAK area as healthy;
- claim site-wide certainty when page evidence is bounded or partial.

### Invariant D — recommendation strength cannot exceed evidence strength

A recommendation may be more urgent when evidence establishes greater material impact, but its certainty cannot exceed the evidence supporting it.

Common checks, likely causes, and planning guidance must remain labeled as such.

### Invariant E — competitor context cannot manufacture a defect

Competitor behavior may provide context. It does not independently create a recommendation or a weak state.

### Invariant F — content opportunity is not content failure

Search demand, competitor coverage, funnel planning, or hub-and-spoke strategy may qualify an opportunity. They do not independently prove that existing content is weak.

### Invariant G — performance evidence type stays explicit

Lab evidence must not be described as field performance. Missing field data cannot make lab performance look stronger or weaker than it is.

### Invariant H — bounded acquisition remains bounded

A representative assessed sample cannot be described as an exhaustive full-site assessment when the discovered footprint is larger or incomplete.

---

## 5. Rebuild guardrail

Narrative state and rebuild recommendation are separate decisions.

The following may never, alone or in combination, trigger "rebuild the whole site":

- a low score;
- a WEAK page state;
- multiple findings;
- high severity;
- competitor differences;
- missing evidence;
- PARTIAL / UNAVAILABLE / UNKNOWN evidence;
- technical debt that can be corrected within the current site;
- a narrative model's preference.

For this seven-page report contract, the default architecture message is:

```text
preserve the current site/foundation
→ fix proven material issues
→ verify outcomes
```

Rebuild language is allowed only if a separate, explicit, evidence-backed platform/architecture determination already exists in governed audit evidence and proves that material priority fixes cannot reasonably be achieved within the current site. The report renderer may not invent that determination.

If no such governed determination exists, the report must not recommend a whole-site rebuild.

---

## 6. Seven frozen page contracts

### Page 1 — Executive Scorecard

Frozen design authority:
`prysm-executive-scorecard-final-language-v6.html`

Decision question:
What is the overall client decision from the reviewed audit evidence?

STRONG:
- Lead with preservation.
- Name the strongest established foundations.
- Actions are selective improvements and verification.
- Do not say "nothing to fix."

MIDDLE:
- Lead with "keep the current site/foundation and fix the material constraints."
- Name the few issues that most affect business outcomes.
- Preserve visible strengths.
- This is the default pattern for a workable site with meaningful friction.

WEAK:
- Lead with the material readiness problems established by evidence.
- Prioritize correction.
- Do not equate WEAK with rebuild.

INSUFFICIENT_EVIDENCE:
- Withhold the overall readiness conclusion when material evidence is too incomplete.
- Summarize what can still be said safely.
- Direct the reader to the missing evidence boundary.

Cross-page rule:
The executive call must be explainable from the six supporting page states and cannot contradict them.

### Page 2 — Priority Fixes

Frozen design authority:
`prysm-priority-fixes-v2.html`

Decision question:
What should the client fix first?

STRONG:
- Show only genuinely material refinements.
- Do not manufacture three "problems" to fill the design.
- Preserve what is already working.

MIDDLE:
- Show the highest-value proven fixes.
- Keep the approved structure: What we know → Check these first → How to know it worked.
- "Check these first" remains diagnostic guidance, not asserted cause.

WEAK:
- Lead with the few highest-impact proven corrections.
- Sequence work by governed business-impact priority.
- Keep lower-value cleanup subordinate.

INSUFFICIENT_EVIDENCE:
- Do not create a ranked fix list from uncertain causes.
- Show only actions justified by established evidence plus explicit verification steps.

Cross-page rule:
A Priority Fix cannot be more certain than the page evidence from which it is derived.

### Page 3 — Conversion Journey

Frozen design authority:
`prysm-conversion-journey-middle-road-v4.html`

Decision question:
Can a buyer move from interest to action with enough clarity and confidence?

STRONG:
- Show the journey elements that are working.
- Limit actions to selective friction reduction or measurement.

MIDDLE:
- Preserve the approved middle-road pattern: a workable journey with specific friction.
- Keep evidence seen, status, impact, keep guidance, measurement boundary, and next steps distinct.

WEAK:
- State where material buyer movement breaks down or becomes unclear.
- Prioritize the few journey repairs most directly supported by evidence.
- Do not infer user abandonment without behavioral evidence.

INSUFFICIENT_EVIDENCE:
- Withhold a broad journey judgment.
- State which stages were observable and which were not.

Cross-page rule:
Journey friction must remain consistent with Priority Fixes and Executive Scorecard language.

### Page 4 — Content Opportunities

Frozen design authority:
`prysm-content-opportunities-v2.html`

Decision question:
Where can content better answer buyer questions and support the buying journey?

STRONG:
- Lead with existing content strengths.
- Opportunities are expansion, refinement, or distribution opportunities, not proof of deficiency.

MIDDLE:
- Show material buyer-question gaps alongside working coverage.
- Rank only qualified opportunities supported by audit evidence.

WEAK:
- State where material buyer questions or decision support are demonstrably thin in the reviewed scope.
- Recommendations remain qualified; search demand or competitor content alone is insufficient.

INSUFFICIENT_EVIDENCE:
- Withhold broad content-coverage conclusions.
- Show only opportunities supported by available evidence and label planning guidance separately.

Cross-page rule:
Funnel, hub-and-spoke, adaptation, and distribution guidance is a planning layer, not observed site evidence unless separately established.

### Page 5 — Trust & Credibility

Frozen design authority:
`prysm-trust-credibility-v2.html`

Decision question:
Does visible proof reduce buyer uncertainty at important decision points?

STRONG:
- Lead with proof that is visible and well placed.
- Recommend preservation and selective amplification.

MIDDLE:
- Distinguish existing trust assets from placement/timing gaps.
- State that proof exists but is underused where evidence supports that conclusion.

WEAK:
- State the material trust gaps established in the reviewed scope.
- Do not promise conversion, ranking, traffic, or AI-citation outcomes from adding proof.

INSUFFICIENT_EVIDENCE:
- Withhold a broad trust conclusion when important proof surfaces could not be assessed.
- Name observed trust assets separately from unknown areas.

Cross-page rule:
Trust conclusions must not conflict with Executive Scorecard or Competitor Comparison claims about proof strength.

### Page 6 — Competitor Comparison

Frozen design authority:
`prysm-competitor-comparison-v1.html`

Decision question:
What meaningful differences exist between the reviewed site and the named competitors?

STRONG:
- State where the reviewed site is already competitive or differentiated.
- "Ignore" remains valid when competitor behavior lacks client value.

MIDDLE:
- Show a mixed benchmark: protect strengths, improve material differences, differentiate deliberately.
- Keep descriptive comparison separate from action.

WEAK:
- State only material competitive buying-experience gaps established by comparable evidence.
- Do not rank the client overall or recommend copying competitors.

INSUFFICIENT_EVIDENCE:
- Withhold broad comparative conclusions when competitor scope or comparable evidence is insufficient.
- State exactly what was compared.

Cross-page rule:
Competitor evidence may strengthen context but cannot create a defect unsupported by the client's own audit evidence.

### Page 7 — Supporting Detail

Frozen design authority:
`prysm-supporting-detail-v2.html`

Decision question:
What evidence supports the report, and where are its limits?

STRONG:
- Evidence coverage is sufficient for the material conclusions being made.
- Healthy/available evidence is visible.

MIDDLE:
- Evidence is usable but bounded, mixed, or partially incomplete.
- Explicitly connect each limitation to the conclusions it affects.

WEAK:
- This state applies only to evidence quality/coverage itself when material evidence integrity or coverage is demonstrably poor.
- Do not translate poor evidence coverage into poor website condition.

INSUFFICIENT_EVIDENCE:
- Material report conclusions must be suppressed where supporting evidence is insufficient.
- Preserve AVAILABLE / PARTIAL / UNAVAILABLE / UNKNOWN exactly.

Cross-page rule:
Supporting Detail is the final truth check. Any conclusion elsewhere that cannot be traced to sufficient or bounded-partial evidence is invalid.

---

## 7. False-certainty rejection tests

The report contract fails if any of the following is possible:

1. Missing evidence causes STRONG.
2. Missing evidence causes WEAK.
3. A score alone selects narrative state.
4. Finding count alone selects narrative state.
5. Severity alone selects narrative state.
6. PARTIAL evidence is rendered as complete coverage.
7. A page makes a site-wide claim from a bounded assessed sample.
8. A common cause is stated as a proven cause.
9. Competitor behavior alone creates a recommendation.
10. Search demand alone creates a content recommendation.
11. Lab performance is stated as field performance.
12. Supporting Detail says evidence is insufficient while another page expresses certainty from that same missing evidence.
13. Priority Fixes gives a confident remedy for an unverified cause.
14. A WEAK state automatically recommends a rebuild.
15. Executive Scorecard contradicts a material page state without an explicit evidence-based explanation.

All 15 must be impossible before implementation acceptance.

---

## 8. Deterministic contract matrix

| Evidence sufficiency | Condition can be established? | Allowed narrative |
|---|---:|---|
| SUFFICIENT | Yes | STRONG / MIDDLE / WEAK |
| BOUNDED_PARTIAL | Yes, within reviewed scope | STRONG / MIDDLE / WEAK with explicit scope limit |
| INSUFFICIENT | No | INSUFFICIENT_EVIDENCE only |
| NOT_APPLICABLE | Not required for that area | Neutral; no condition effect by itself |

The condition classifier remains downstream of governed evidence and existing materiality/scoring logic. This contract does not create new score thresholds.

---

## 9. Implementation boundary for the next tranche

Future implementation may add only the minimum deterministic report-layer logic required to:

- derive narrative sufficiency from existing evidence semantics;
- select one of the four frozen narrative states;
- map each state to the approved seven-page templates;
- enforce cross-page consistency and rebuild guardrails;
- preserve explicit evidence limitations;
- add deterministic positive/negative tests for the 15 rejection cases.

Future implementation must not alter evidence acquisition, scoring, Writer/Judge semantics, provider calls, storage, lifecycle, authentication, orchestration, or production configuration to satisfy this contract.

If implementation appears to require any of those changes, stop and reopen the boundary rather than broadening scope.

---

## 10. Freeze declaration

This contract is the authoritative deterministic narrative-state specification for the seven frozen PRYSM report templates.

Frozen states:
- STRONG
- MIDDLE
- WEAK
- INSUFFICIENT_EVIDENCE

Frozen governing sequence:
```text
evidence sufficiency
→ condition state
→ allowed narrative state
→ page-specific message
→ bounded action
```

Frozen safety rules:
- no positive-by-absence;
- no negative-by-absence;
- no score/count/severity-only state selection;
- no cross-page evidence contradiction;
- no recommendation certainty beyond evidence certainty;
- no automatic rebuild logic.

Production remains frozen.
