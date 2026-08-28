# PRYSM Conversion-First v4.2

Date: 2026-08-28
Status: Authorized design work package

## Objective

Shift PRYSM from a technically led website audit into a governed conversion-readiness decision system.

The report should still preserve and expose technical evidence, but technical findings must no longer dominate the client-facing story merely because they are deterministic, severe, or easy to measure.

The primary question becomes:

> What is helping or preventing the right visitor from understanding the offer, trusting the business, taking action, and completing the intended conversion path?

Technical evidence supports that answer. It does not define the report hierarchy by itself.

## Current baseline

Primary production baseline:
- Target: `https://www.tbkcreative.com/`
- Audit ID: `9714c206-8ed3-4686-8fe2-ceeca0ca0f82`
- Conversion Readiness: 65/100
- Evidence Confidence: 95/100
- Evidence Coverage: 100%
- Evidence capabilities: 12/13
- Modules assessed: 10/10
- Conversion Path: 100/100
- Performance & Experience: 71/100
- Final Narrative v2 Judge pass 3: score 97, decision PASS

Previous comparison baseline:
- Audit ID: `f7e5e17c-0828-4803-843f-20213f9ad8b9`
- Conversion Readiness: 55/100
- Evidence Coverage: 76%
- Evidence capabilities: 8/13
- Modules assessed: 8/10
- Conversion Path: Not Assessed
- Performance & Experience: 47/100

The evidence system is now strong enough that the next bottleneck is primarily interpretation, prioritization, report hierarchy, and cross-module consistency.

## Product problem

The current report can still lead with items such as:
- missing meta descriptions;
- inconsistent heading structure;
- incomplete security headers;
- canonical issues;
- schema or other technical hygiene.

Those may be valid findings, but the opening client narrative should first answer:
- Is the offer understandable?
- Is the audience/fit clear?
- Is enough proof present?
- Is the main action obvious?
- Can a buyer reach and complete it?
- Is mobile/performance friction material?
- Are acquisition/search conditions limiting qualified traffic?
- Which technical conditions are actually causing or amplifying those business-facing issues?

PRYSM should therefore distinguish between:

1. **Business-facing conversion problem** — what the buyer experiences or what prevents business action.
2. **Observed evidence** — what the governed sources directly prove.
3. **Underlying technical cause** — the implementation or technical condition contributing to the problem.
4. **Recommended action** — the smallest practical change with a clear verification method.

## Conversion-first decision hierarchy

Use this hierarchy when designing executive narrative, action ranking, report sections, scoring interpretation, and recommendation ordering:

### 1. Offer and audience clarity
Can the right visitor quickly understand:
- what the business does;
- who it is for;
- the core outcome/value;
- what differentiates it;
- which service/solution is relevant?

### 2. Trust and proof
Can the visitor reduce uncertainty through:
- case studies/results;
- testimonials;
- credentials;
- named people/team expertise;
- process transparency;
- pricing/expectation clarity where appropriate;
- risk-reduction signals;
- contact legitimacy?

### 3. Conversion path and action
Can the visitor:
- identify the primary CTA;
- understand what happens next;
- access an interactable action;
- reach the conversion destination;
- complete a form/booking/contact step without material obstruction?

### 4. Friction and experience
Does the experience create avoidable hesitation through:
- slow performance;
- mobile problems;
- confusing structure;
- intrusive overlays;
- unclear labels;
- accessibility barriers;
- broken or misleading navigation/action paths?

### 5. Buyer-question and decision support
Does the content answer the questions a buyer needs at each stage:
- understand the problem;
- understand the service;
- evaluate fit;
- compare options;
- build trust;
- take action?

### 6. Acquisition and discoverability
Can qualified visitors find the important pages through:
- indexability;
- crawlability;
- canonical clarity;
- search-result messaging;
- relevant content coverage;
- useful structured/entity context?

### 7. Technical causes and resilience
Technical hygiene remains important but should generally appear as:
- an underlying cause;
- a constraint;
- a risk amplifier;
- or a specialist implementation detail supporting one of the client-facing domains above.

Pure technical hygiene should lead only when it is itself a proven foundation blocker, security/business-risk issue, or direct constraint on conversion/discoverability.

## Executive report target

The first client-facing page should make five things obvious:

1. **Overall conversion verdict** — what is most likely limiting conversion readiness.
2. **Strongest conversion asset** — what already works and should be protected.
3. **Primary buyer friction** — the highest material barrier or uncertainty.
4. **Top three actions** — ranked by expected business relevance and evidence confidence.
5. **Evidence boundary** — what is known, partial, unavailable, or requires validation.

Avoid opening with a list of technical defects unless those defects are proven to be the primary conversion constraint.

## Action-ranking target

Current durable domain ranking already prevents pure technical numeric priority from automatically outranking business-impact domains. v4.2 should extend that logic into a fuller conversion decision model.

Desired ordering principle:

1. proven foundation blocker;
2. direct conversion-path blocker;
3. major trust/proof weakness affecting action;
4. major offer/audience clarity weakness;
5. material UX/performance friction;
6. buyer-question/content decision gap;
7. material acquisition/search constraint;
8. supporting technical hygiene;
9. low-value or specialist technical optimization.

Numeric priority should order findings within a comparable business-impact class, not replace the business-impact class.

Evidence confidence remains a gate. A high-impact domain does not justify promoting an unsupported or PARTIAL observation as fact.

## Scoring-review requirement

Do not assume the existing 65/100 score itself is wrong merely because the report feels technical.

Before changing score weights:
1. map every existing scoring component into the conversion-first hierarchy;
2. identify whether the problem is scoring, finding selection, rank interpretation, narrative synthesis, or page order;
3. prove where technical signals gain disproportionate client-facing influence;
4. change scoring weights only where the evidence shows the score model itself is misaligned.

A presentation/ranking defect must not automatically become a scoring rewrite.

## Narrative target

Writer/Judge governance remains unchanged unless separately approved.

Writer should synthesize:
- buyer impact;
- business relevance;
- validated strengths;
- bounded risks;
- practical next actions.

Judge must continue to reject:
- unsupported causal claims;
- PARTIAL → absent/confirmed upgrades;
- correlation presented as business outcome;
- invented conversion/revenue impact;
- market-wide claims from small competitor samples.

Conversion-first language must never weaken evidence fidelity.

## Competitor target

Client-facing competitor analysis should normally show only:
- supplied competitors with usable evidence;
- qualified comparison candidates with sufficient evidence;
- a compact summary of meaningful comparative differences.

Large sets of SERP-discovered `Insufficient Evidence / Not Assessed` candidates should not dominate client-facing tables. They can remain in governed supporting evidence or an evidence appendix if required.

The site's own comparison fields must consume the same governed conversion/offer/trust evidence used elsewhere in the report so the competitor layer cannot say `Not Assessed` when the main report has an available governed result.

## Known contradictions to eliminate

1. Foundational Readiness says no CTA/form was detected while Conversion Path says 6/6 browser-assessed pages have visible interactable actions.
2. Technical Health can be identified as the lowest dimension while another narrative statement says it is not the lowest.
3. Competitor comparison can show the site's Conversion Path as `Not Assessed` while the main report shows 100/100.
4. The competitor page can expose dozens of unassessed search candidates even when only two actual competitors have usable evidence.

These are cross-layer consistency defects and should be mapped to their source consumers before editing.

## Boundaries

Do not:
- mutate raw/canonical evidence to make the report cleaner;
- reduce evidence confidence or Judge gates;
- invent revenue or conversion outcomes;
- hide legitimate technical findings;
- start with broad multi-file code changes;
- alter scoring merely because a renderer/narrative rank feels wrong;
- run a fresh paid audit merely to design v4.2;
- change production configuration without explicit approval.

Existing saved production reports and latest TBK audit artifacts are the preferred design/diagnostic fixtures.

## First work package

### CF-01 — Conversion influence map

No code initially.

Trace the latest TBK report from:

`evidence -> capabilities -> scoring modules -> findings -> action ranking -> Narrative Writer input -> Judge -> Report v2 sections -> competitor comparison`

For each client-facing result determine:
- source evidence;
- business domain;
- scoring influence;
- rank influence;
- narrative influence;
- report location;
- whether it is conversion-leading, conversion-supporting, or technical-only.

Output:
1. current influence map;
2. proven misalignment list;
3. target conversion-first hierarchy;
4. smallest source-file implementation sequence;
5. regression tests required before any production rerun.

Only after CF-01 is reviewed should application code changes begin.
