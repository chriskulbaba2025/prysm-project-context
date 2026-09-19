# PRYSM Conversion Friction Encyclopedia and Relationship Contract

Version: 1.0
Status: FROZEN
Date: 2026-09-19
Scope: Diagnostic taxonomy, relationship analysis, friction clustering, prioritization, diagnostic checks, bounded repair guidance, and verification
Production: FROZEN
Implementation: NOT AUTHORIZED BY THIS SPECIFICATION ALONE

## 1. Purpose

PRYSM performs a full conversion audit.

The governing analysis sequence is:

```text
whole-site discovery
→ issue mapping
→ relationship analysis
→ friction clustering
→ challenge / falsification
→ first diagnostic checks
→ priority repair plan
→ verification
```

PRYSM identifies friction signals and evidence-backed conditions.

It does not claim that a condition caused conversion loss unless causation has actually been established.

The system must answer:

- Where does meaningful conversion friction appear?
- Which findings appear connected?
- What deserves investigation first?
- What should not be assumed yet?
- Who may need to help?
- How will PRYSM know whether a repair worked?

## 2. Hard architecture boundary

The Conversion Friction Encyclopedia is a diagnostic layer.

It may produce:

- canonical findings;
- relationships;
- friction clusters;
- diagnostic hypotheses;
- reviewed standalone material findings;
- priority candidates;
- first diagnostic checks;
- bounded repair directions;
- verification requirements.

It must NOT independently select the frozen seven-page report narrative states:

- STRONG;
- MIDDLE;
- WEAK;
- INSUFFICIENT_EVIDENCE.

There is no one-to-one mapping such as:

```text
Friction → WEAK
Clear → STRONG
```

The governing boundary is:

```text
governed evidence
→ encyclopedia finding / relationship / cluster
→ accepted diagnostic output
→ existing page evidence inputs
→ frozen seven-page narrative-state contract
→ client report
```

The encyclopedia must not become a second narrative classifier.

## 3. Twelve diagnostic areas

The broad issue universe is consolidated into exactly 12 major diagnostic areas.

1. Acquisition and Search Entry
2. Site Structure and Findability
3. Offer and Page Understanding
4. Content and Decision Support
5. Trust, Proof and Risk Reduction
6. Conversion Actions and Lead Capture
7. Booking, Commerce and Completion
8. Mobile, Accessibility and Interaction
9. Performance, Delivery and Reliability
10. Technical Integrity and Search Foundations
11. Measurement and Experimentation
12. Evidence, Scope and Business Context

## 4. Canonical problem taxonomy

The frozen canonical problem count is 75.

Variations live beneath these canonical problems and do not become new canonical entries.

### Area 1 — Acquisition and Search Entry

| ID | Canonical problem | Primary classification | Main journey point |
|---|---|---|---|
| A01 | Search entry does not match buyer intent | Acquisition issue | Acquire |
| A02 | Important page is not discoverable or indexable | Acquisition issue | Acquire |
| A03 | Search-result message is unclear or misaligned | Acquisition issue | Acquire |
| A04 | Local search relevance is incomplete or inconsistent | Acquisition issue | Acquire |
| A05 | Language or geographic targeting is mismatched | Acquisition issue | Acquire |
| A06 | Key offer or entity information is unclear to search and answer systems | Acquisition issue | Acquire |

### Area 2 — Site Structure and Findability

| ID | Canonical problem | Primary classification | Main journey point |
|---|---|---|---|
| B01 | Navigation hides an important path | Conversion influence | Understand |
| B02 | Information architecture makes important content difficult to find | Conversion influence | Understand |
| B03 | Internal links do not support buyer progression | Conversion influence | Decide |
| B04 | Important page is orphaned or weakly connected | Technical foundation issue | Understand |
| B05 | URL or path integrity creates dead ends or confusion | Technical foundation issue | Understand |
| B06 | Site search fails to surface relevant choices | Conversion influence | Decide |

### Area 3 — Offer and Page Understanding

| ID | Canonical problem | Primary classification | Main journey point |
|---|---|---|---|
| C01 | Page purpose is unclear | Direct conversion friction | Understand |
| C02 | Offer or value proposition is unclear | Direct conversion friction | Understand |
| C03 | Intended customer or fit is unclear | Conversion influence | Understand |
| C04 | Differentiation is unclear | Conversion influence | Decide |
| C05 | The decision path is unclear | Direct conversion friction | Decide |
| C06 | Important page information conflicts or contradicts itself | Direct conversion friction | Decide |
| C07 | Important context appears too late for the decision being asked | Conversion influence | Understand |

### Area 4 — Content and Decision Support

| ID | Canonical problem | Primary classification | Main journey point |
|---|---|---|---|
| D01 | Important buyer questions are unanswered | Conversion influence | Decide |
| D02 | Critical service or product details are missing | Conversion influence | Decide |
| D03 | Cost or pricing expectations are unclear where they materially affect the decision | Conversion influence | Decide |
| D04 | Process, timing or next-step expectations are unclear | Conversion influence | Decide |
| D05 | Material objections are not addressed | Conversion influence | Decide |
| D06 | Content is too thin or generic to support the decision | Conversion influence | Understand |
| D07 | Content overload or weak hierarchy makes the decision harder | Direct conversion friction | Decide |

### Area 5 — Trust, Proof and Risk Reduction

| ID | Canonical problem | Primary classification | Main journey point |
|---|---|---|---|
| E01 | Important trust proof is absent where it is needed | Conversion influence | Trust |
| E02 | Proof does not clearly support the claim or offer | Conversion influence | Trust |
| E03 | Useful proof appears at the wrong point in the decision | Conversion influence | Trust |
| E04 | Relevant expertise or authority is not demonstrated | Conversion influence | Trust |
| E05 | Important risk reducers, policies or assurances are unclear | Conversion influence | Trust |
| E06 | Brand or visual inconsistency weakens confidence | Conversion influence | Trust |
| E07 | Privacy, security or consent experience undermines confidence or action | Conversion influence | Trust |

### Area 6 — Conversion Actions and Lead Capture

| ID | Canonical problem | Primary classification | Main journey point |
|---|---|---|---|
| F01 | Primary action control is unclear | Direct conversion friction | Act |
| F02 | Primary action is difficult to see or reach | Direct conversion friction | Act |
| F03 | Action wording and destination do not match | Direct conversion friction | Act |
| F04 | Form submission is broken or fails | Direct conversion friction | Act |
| F05 | Form requests unnecessary or excessive information | Direct conversion friction | Act |
| F06 | Form instructions, requirements or errors are unclear | Direct conversion friction | Act |
| F07 | Phone or contact path is broken or difficult to use | Direct conversion friction | Act |
| F08 | Competing actions create unnecessary decision friction | Direct conversion friction | Act |

### Area 7 — Booking, Commerce and Completion

| ID | Canonical problem | Primary classification | Main journey point |
|---|---|---|---|
| G01 | Booking flow is broken or unavailable | Direct conversion friction | Complete |
| G02 | Booking flow contains unnecessary steps or confusion | Direct conversion friction | Complete |
| G03 | Product, service or option selection is difficult | Direct conversion friction | Decide |
| G04 | Cart or checkout flow is broken | Direct conversion friction | Complete |
| G05 | Checkout creates avoidable completion friction | Direct conversion friction | Complete |
| G06 | Payment, shipping, tax or fulfilment expectations are unclear | Conversion influence | Complete |
| G07 | Post-conversion confirmation or next steps are unclear | Conversion influence | Complete |

### Area 8 — Mobile, Accessibility and Interaction

| ID | Canonical problem | Primary classification | Main journey point |
|---|---|---|---|
| H01 | Mobile layout obstructs important content or action | Direct conversion friction | Act |
| H02 | Tap targets or controls are difficult to use | Direct conversion friction | Act |
| H03 | Keyboard or focus behaviour creates an interaction barrier | Direct conversion friction | Act |
| H04 | Important visual or media content is inaccessible | Conversion influence | Understand |
| H05 | Contrast or readability creates a usability barrier | Direct conversion friction | Understand |
| H06 | Layout movement disrupts reading or interaction | Direct conversion friction | Act |
| H07 | Interaction response is slow enough to interfere with use | Direct conversion friction | Act |

### Area 9 — Performance, Delivery and Reliability

| ID | Canonical problem | Primary classification | Main journey point |
|---|---|---|---|
| I01 | Slow primary content display | Conversion influence | Understand |
| I02 | General page loading or response delay | Conversion influence | Understand |
| I03 | Third-party resources delay or block important experience | Technical foundation issue | Act |
| I04 | Resource delivery is inefficient | Technical foundation issue | Understand |
| I05 | Server, hosting or CDN reliability is poor | Technical foundation issue | Acquire |
| I06 | Page or site is unavailable or repeatedly fails | Direct conversion friction | Act |

### Area 10 — Technical Integrity and Search Foundations

| ID | Canonical problem | Primary classification | Main journey point |
|---|---|---|---|
| J01 | Indexing directives unintentionally block an important page | Acquisition issue | Acquire |
| J02 | Broken links, redirects or errors interfere with access | Technical foundation issue | Understand |
| J03 | Document structure makes content harder to understand or interpret | Technical foundation issue | Understand |
| J04 | Structured data is invalid, misleading or materially absent | Technical foundation issue | Acquire |
| J05 | Duplicate or canonicalized content creates ambiguity | Technical foundation issue | Acquire |
| J06 | CMS, template or migration defect creates repeated site-wide errors | Technical foundation issue | Understand |

### Area 11 — Measurement and Experimentation

| ID | Canonical problem | Primary classification | Main journey point |
|---|---|---|---|
| K01 | Primary conversion action is not measured | Evidence/measurement limitation | Act |
| K02 | Analytics data is incomplete, duplicated or misconfigured | Evidence/measurement limitation | Complete |
| K03 | Funnel or source attribution cannot answer the key business question | Evidence/measurement limitation | Complete |
| K04 | A change cannot be evaluated against a usable baseline | Evidence/measurement limitation | Complete |

### Area 12 — Evidence, Scope and Business Context

| ID | Canonical problem | Primary classification | Main journey point |
|---|---|---|---|
| L01 | Evidence coverage is insufficient for the judgment | Evidence/measurement limitation | Relevant stage |
| L02 | Evidence is stale, conflicting or unrepresentative | Evidence/measurement limitation | Relevant stage |
| L03 | Business goal, page role or conversion objective is unclear or mismatched | Evidence/measurement limitation | Relevant stage |
| L04 | Third-party, ownership or platform constraints prevent reliable diagnosis or repair | Evidence/measurement limitation | Relevant stage |

## 5. What is not a canonical problem

The following belong to system logic rather than the canonical problem list:

- compound problems;
- false positives;
- contradictory evidence;
- prioritization problems;
- repair dependencies;
- post-fix verification;
- scope/representativeness controls;
- opportunities;
- competitor observations by themselves.

A competitor doing something differently is not a canonical client problem.

## 6. Canonical problem schema

Every canonical problem must ultimately contain:

- Canonical problem ID
- Canonical problem name
- Diagnostic area
- Definition
- Applicability
- Observation mode
- Primary conversion classification
- Primary journey stage
- Secondary journey stage, optional
- Page role
- Page intent: High / Medium / Low / Unknown
- Primary conversion action
- Secondary conversion actions, optional
- Scope: section / page / template / device / site / external flow
- Device context
- Observable signals
- Required evidence
- Evidence sufficiency rule
- Evidence lineage key
- Evidence independence key
- Evidence freshness rule
- Conflicting-evidence rule
- Client-facing friction-state rule
- Materiality rule
- Why it may matter
- First diagnostic checks, maximum three
- Prohibited assumptions
- Possible findings
- Likely help needed
- Ownership constraints
- Repair risk / blast radius
- Positive pattern to preserve
- Verification method
- Relationship eligibility
- Duplicate fingerprint
- Critical-blocker eligibility
- Disposition
- Remedy specificity: outcome-level or mechanism-specific
- Mechanism evidence status
- Business-outcome evidence status
- Report placement

## 7. One-primary-canonical-problem rule

Every independently observed condition receives exactly one primary canonical problem ID.

A second canonical problem is permitted only when it represents a genuinely separate observable condition with its own evidence and scope.

A technical mechanism may support another finding without becoming another independent client problem.

Use:

```text
observed business-facing condition = primary canonical problem
technical mechanism = evidence, diagnostic hypothesis, or verified cause
```

where appropriate.

Duplicate labels are not independent findings.

## 8. Conversion classification contract

Exactly six primary classifications are allowed:

### Direct conversion friction
The observed condition directly interferes with moving forward.

### Conversion influence
The condition may influence understanding, confidence or decision quality but does not directly block the action.

### Acquisition issue
The condition primarily affects whether suitable visitors reach the site or page.

### Technical foundation issue
The condition primarily affects delivery, integrity, accessibility, crawlability or technical operation.

### Evidence/measurement limitation
The condition limits PRYSM's or the client's ability to judge performance safely.

### Low direct conversion relevance
The observation may be technically valid but has little direct relevance to the current business conversion objective.

Classification is separate from severity and priority.

## 9. Buyer-journey contract

The only client-facing journey stages are:

```text
Acquire
→ Understand
→ Trust
→ Decide
→ Act
→ Complete
```

These are diagnostic tags, not proof of a perfectly linear funnel.

One stage must remain primary. A canonical problem may affect one additional secondary stage when materially justified.

## 10. Client-facing friction states

Exactly four friction states are allowed.

### ● Clear
No material friction was established in the reviewed area.

Requirements:
- enough evidence exists to judge the condition;
- no material contradictory finding remains unresolved;
- the conclusion stays within reviewed scope.

Clear must never be inferred from missing evidence.

### ▲ Watch
A real signal exists, but its material effect, scope or relationship to conversion is not strong enough to call material friction.

Watch must not substitute for missing evidence.

### ■ Friction
A material observed condition or accepted issue cluster may be making the relevant buyer action or decision harder.

Requirements:
- the condition itself is established;
- evidence is sufficient or explicitly bounded;
- materiality is established;
- wording does not claim conversion loss or unproven causation.

### ○ Not enough evidence
PRYSM cannot safely determine the condition.

Required output:
- what could not be determined;
- what evidence was available;
- what evidence was missing;
- which conclusion was withheld.

Not enough evidence is not a failure score.

## 11. Friction-state participation rules

### Clear
Cannot support a friction cluster.
A Clear result in the same material scope must be considered as possible counterevidence during challenge.

### Watch
May participate in relationship analysis.
Several Watch findings do not automatically become Friction through count.
Watch findings may contribute to a cluster only when evidence is independent, the findings share a genuine friction target, compounding is materially supported, and the challenge gate survives.

### Friction
May directly support a friction cluster when relationship and scope rules pass.

### Not enough evidence
Cannot increase cluster strength.
Cannot count as corroboration.
It may narrow the conclusion or create an evidence-gathering dependency.

## 12. Plain-language output contract

Client-facing encyclopedia language should normally use:

- What we found
- Why it may matter
- Check these first
- What not to assume
- Who may need to help
- How we will verify it

Internal terminology such as bounded sufficiency, constraint strength, causal inference, relationship confidence calculation, or deterministic classifier remains internal.

Do not write:
"This is causing users to abandon the conversion funnel."

Without behavioral evidence, use:
"This may make it harder for visitors to move forward."

## 13. First-three-check contract

Every canonical problem may contain zero to three first diagnostic checks.

Three is a maximum, not a quota.

Checks are ordered by diagnostic information value, not by easiest fix.

A first check must:
1. distinguish between plausible cause classes;
2. connect directly to the observed condition;
3. avoid assuming a root cause;
4. avoid becoming a disguised repair instruction;
5. stop when enough evidence exists to identify the next diagnostic boundary.

## 14. Causal and assumption guardrail

These levels must remain separate:

```text
observed finding
→ related findings
→ friction cluster
→ first things to check
→ likely shared cause
→ verified mechanism cause, if proven
→ repair package
→ verification
→ business-outcome evidence, if separately available
```

"Root cause" is reserved for a cause demonstrated by evidence.

Before proof, use:
- diagnostic hypothesis;
- likely shared cause;
- possible cause;
- friction cluster.

Relationship, correlation or common timing does not establish causation.

## 15. Mechanism cause versus business-outcome cause

PRYSM distinguishes two kinds of causal proof.

### Mechanism cause
Example:
"A third-party script delayed the primary interaction."

This may be established through direct technical evidence such as request traces, execution timing, dependency isolation, or controlled technical retest.

### Business-outcome cause
Example:
"The slow interaction caused lost conversions."

This requires materially stronger outcome evidence.

A technically verified mechanism does not establish a business outcome.

PRYSM may establish:
"Script X caused the observed interaction delay."

while still stating:
"We have not established that this delay caused conversion loss."

## 16. Six relationship types

Exactly six relationship types are allowed.

1. Repeats
2. Compounds
3. Depends on
4. May share a cause
5. Same journey point
6. Duplicate symptom

### Repeats
Same canonical problem appears across pages/templates.
It increases scope, not finding count.

### Compounds
Independent problems occur together and may create greater friction.

### Depends on
One condition should be diagnosed or addressed before another.
This relationship is directional.

### May share a cause
Several symptoms are worth diagnosing together.
This creates a hypothesis, not proof.

### Same journey point
Several problems affect the same material buyer decision or action.

### Duplicate symptom
Several findings substantially describe the same underlying condition.
They must be collapsed, not added.

## 17. Relationship eligibility gate

PRYSM must not compare every finding with every other finding.

Two findings become relationship candidates only when they share at least one meaningful boundary such as:

- same page;
- same template;
- same conversion action;
- known technical or diagnostic dependency;
- same explicitly identified buyer decision question.

Sharing a journey stage alone is NOT sufficient.

"Same journey point" requires:
- the same page/template plus the same material buyer decision; or
- the same conversion action; or
- the same explicitly identified buyer decision question.

Additional rules:

### Scope compatibility
Site-wide and page-specific findings cannot be combined casually.

### Device compatibility
Mobile-only and desktop-only findings remain separate when the experience materially differs.

### Evidence independence
Two rules derived from the same underlying source signal do not become independent corroboration because they have different rule IDs or providers.

### Evidence state
An unknown condition does not strengthen a known finding.

### No theme-only linking
Two issues are not related merely because both are "SEO," "trust," "content," or "performance."

## 18. Evidence-lineage and source-independence rule

Independent corroboration is based on independent underlying observations, not:

- number of rules;
- number of provider responses;
- number of generated findings;
- number of tools displaying the same condition.

Every finding must retain an evidence lineage key identifying the underlying observation family.

Signals sharing the same underlying event, DOM condition, request, metric or source measurement count as one corroborating evidence family unless independence is demonstrably established.

## 19. Repetition rule

A template problem found on many URLs is normally:

```text
one canonical problem
+ one Repeats relationship
+ broad affected scope
```

not many independent problems.

Repeated scope may increase materiality.

It must not inflate confidence merely through duplicated instances of the same defect.

Repeats does not prove a shared cause.

The same symptom across many pages may come from one template defect or several separate implementations. A shared cause must be established before prescribing one shared mechanism-specific repair.

## 20. Friction-cluster contract

A friction cluster is a small group of related findings describing one meaningful business or buyer difficulty.

Every cluster requires one clearly named friction target.

Examples:
- contacting the company from mobile service pages;
- understanding the offer on high-intent landing pages;
- completing a booking;
- trusting a high-value purchase;
- entering an important service page from organic search.

A normal cluster requires:
- at least two distinct canonical problems;
- a valid relationship boundary;
- no duplicate counting;
- enough evidence for the included findings;
- one meaningful friction target.

A single confirmed critical blocker may form a priority unit without multiple supporting findings.

A cluster must not be formed merely because several findings share a diagnostic area.

## 21. Cluster naming rule

Cluster names must describe the observed friction boundary, not invent a cause or business outcome.

Allowed:
- High-intent mobile contact friction
- Service-page decision friction
- Booking completion friction

Not allowed without proof:
- Slow server causing lost leads
- Poor trust causing abandonment
- Weak content reducing revenue

## 22. Cluster evidence rules

A cluster must distinguish:

### Independent corroboration
Different underlying evidence supports the same friction target.

### Compounding
One issue may make another harder to tolerate.

### Dependency
One problem sits upstream of another.

### Redundancy
Two findings describe substantially the same condition and must not strengthen the cluster.

### Blocking override
One confirmed blocker may outweigh several moderate observations.

There is no additive formula such as:

```text
20 + 20 + 20 = 60
```

## 23. Standalone material finding rule

A raw finding never goes directly to Priority Fixes.

Every meaningful finding must first pass through:

```text
whole-site mapping
→ relationship review
→ materiality review
→ dependency / duplicate review
→ challenge
```

After that process, the allowed priority units are:

- confirmed critical blocker;
- accepted friction cluster;
- reviewed standalone material finding.

A standalone finding is allowed only when:
- no legitimate cluster exists;
- evidence is sufficient or explicitly bounded;
- materiality is established;
- duplicate and dependency review is complete;
- challenge passes;
- the priority can be explained in one plain-language sentence.

This rule prevents both premature promotion and artificial clustering.

## 24. Cluster report limits

The client report may show no more than approximately five major priority units.

Each priority unit may show no more than:
- three primary supporting issues;
- three first diagnostic checks.

Additional observations belong in Supporting Detail.

The report is not required to fill all five slots.

## 25. Challenge and falsification gate

A candidate cluster or standalone material finding cannot become a Priority Fix until it survives challenge.

The challenger must test:

### Connection
Do the findings truly affect the same decision, action or dependency boundary?

### Duplication
Are any findings different descriptions of the same condition?

### Materiality
Would the issue reasonably matter to the current conversion objective?

### Alternative explanation
Could the evidence support a materially different interpretation?

### Contradictory evidence
Does strong evidence challenge the proposed interpretation?

### Evidence independence
Are the apparent supporting signals genuinely independent?

### Scope
Is the issue section-specific, page-specific, template-wide, device-specific or site-wide?

### Opportunity test
Is this actually an improvement opportunity rather than existing friction?

### Priority displacement
Does a stronger blocker or dependency belong first?

### Falsification test
What evidence would show this interpretation is wrong?

A failed challenge produces one of:
- reject;
- split;
- downgrade to Watch;
- move to Supporting Detail;
- collect more evidence.

It must not be forced into Priority Fixes.

## 26. Prioritization contract

The unit of client prioritization is:

- confirmed critical blocker;
- accepted friction cluster;
- reviewed standalone material finding.

The governing domain order is:

1. Confirmed critical blocker
2. Direct conversion friction
3. Trust and decision friction
4. Performance / usability friction
5. Acquisition / search issue
6. Technical foundation / hygiene
7. Other

Evidence and measurement limitations do not compete as if they were website friction. They may become enabling dependencies when they prevent safe judgment or verification of a material business objective.

Within the same domain, priority is determined in this order:

```text
primary conversion action relevance
→ high-intent page relevance
→ breadth of affected scope
→ independent corroboration
→ dependency leverage
→ evidence quality and freshness
→ repair practicality and risk
```

Repair ease may break close cases.

Finding count alone never determines priority.

## 27. Measurement dependency rule

Measurement limitations remain evidence/measurement limitations.

They must not be relabeled as conversion friction merely because measurement is missing.

When missing measurement prevents safe verification of a material repair or business objective, it may become an enabling dependency through Depends on.

Example:

```text
repair material website condition
+
establish measurement needed to verify outcome
```

## 28. Audit evidence versus business measurement

Area 11 covers the website/business measurement system.

Examples:
- conversion event not tracked;
- analytics duplication;
- unusable attribution;
- no usable baseline.

Area 12 covers limitations on what PRYSM can safely conclude from the audit.

Examples:
- incomplete audit coverage;
- stale evidence;
- conflicting evidence;
- unclear business objective;
- inaccessible third-party evidence.

L01 must not be generated every time an individual canonical problem receives Not enough evidence.

L01 exists only when evidence coverage itself is a material audit-level limitation.

## 29. Priority explanation requirement

Every displayed Priority Fix must answer:

**Why is this a priority?**

in one plain-language sentence.

Example:

"We prioritized this because three separate issues occur on the same high-intent pages at the point where visitors decide whether to contact you."

The explanation must be traceable to:
- friction target;
- journey point;
- important page/template;
- supporting evidence.

## 30. Critical-blocker exception

Whole-site discovery normally finishes before final repair planning.

A confirmed catastrophic condition must be surfaced immediately.

Critical-blocker candidates include:
- website outage;
- broken checkout;
- broken primary booking flow;
- broken primary lead form;
- severe primary contact-path failure;
- browser/security warning materially blocking trust or access;
- accidental noindex or comparable blocking condition on important commercial pages;
- severe conversion-path failure preventing completion.

Critical-blocker escalation requires evidence that is:
- current enough for the affected system;
- directly observed or freshly reproducible;
- correctly scoped;
- sufficiently reliable to establish that the blocker exists now.

Historical or stale failure evidence does not automatically create a current blocker.

Immediate surfacing does not require PRYSM to stop discovery or begin repair immediately.

Use:

```text
surface blocker immediately
→ continue discovery where possible
→ preserve blocker as priority override
```

## 31. Opportunity, preserve and do-nothing outcomes

Every canonical finding receives one disposition:

### Repair
A material condition should be corrected.

### Investigate
The condition is real, but cause or best response is not yet known.

### Collect evidence
The judgment cannot safely be made yet.

### Opportunity
A potentially useful improvement exists, but evidence does not establish current friction.

### Preserve
A positive pattern should be protected.

### Do nothing
The condition is low-value, immaterial, redundant, not applicable, or not worth the repair risk under current business goals.

An Opportunity must not become Friction merely to create more recommendations.

Not enough evidence must not become Do nothing.

## 32. Positive-pattern rule

PRYSM must record meaningful things that are working.

A repair package must identify nearby positive patterns that should be preserved.

Examples:
- a strong CTA that should not be removed while redesigning another element;
- existing trust proof that should be moved rather than deleted;
- working mobile behavior that should not be destabilized by desktop changes.

## 33. Page-role and intent rule

Materiality depends partly on page role and page intent.

Page intent values are:
- High
- Medium
- Low
- Unknown

Unknown remains unknown when business context cannot support classification.

High-intent examples may include:
- checkout;
- contact;
- booking;
- pricing;
- important service;
- product;
- high-intent landing pages.

Lower-intent examples may include:
- utility pages;
- legal pages;
- archives;
- informational content.

Page intent informs materiality and prioritization.
It does not independently determine friction state.

## 34. Primary-action rule

Every high-value page should identify:
- primary conversion action;
- relevant secondary actions.

A problem affecting the primary action normally carries greater conversion relevance than an equivalent problem affecting a minor secondary action.

PRYSM must not assume every interaction is equally important.

## 35. Mobile and desktop rule

Device conditions are separate evidence boundaries.

A mobile problem may not be generalized to desktop.

Desktop success may not cancel a mobile problem.

When the same canonical problem appears on both and evidence supports the same underlying condition, Repeats may combine scope without inventing a shared cause.

## 36. Evidence freshness and conflict rule

Every evidence-bearing finding must retain:
- collection time;
- source;
- scope;
- device where relevant;
- evidence status;
- freshness status.

Conflicting evidence must be preserved.

PRYSM may:
- narrow the conclusion;
- downgrade the state;
- request another diagnostic check;
- classify the area as Not enough evidence.

It must not silently select the evidence that creates the strongest recommendation.

## 37. Third-party and ownership rule

PRYSM must distinguish:

```text
condition observed
from
client can directly repair it
```

Examples:
- third-party booking tools;
- payment providers;
- hosted ecommerce;
- consent tools;
- external forms;
- CDN/platform restrictions.

Ownership affects:
- likely help needed;
- diagnostic sequence;
- repair feasibility;
- repair risk.

It does not invalidate the observed condition.

## 38. Repair-risk rule

A repair recommendation must account for possible blast radius.

Higher-risk changes require stronger evidence than lower-risk changes.

Examples:
- global template changes;
- checkout changes;
- analytics configuration;
- canonical/indexing rules;
- site-wide scripts;
- navigation architecture.

A large repair must not be recommended merely because a small observation exists.

## 39. Repair-specificity rule

A proven observed problem may produce an outcome-level repair objective.

Example:
"Restore reliable form submission."

A mechanism-specific repair requires mechanism evidence.

Example:
"Replace the form API because it is timing out."

That statement requires evidence establishing the API timeout as the mechanism.

Therefore:

```text
observed condition proven
→ outcome-level repair target allowed

mechanism-specific repair
→ mechanism evidence required
```

## 40. Off-site business-performance rule

PRYSM audits website conversion friction.

It does not assume weak business performance is caused by the website.

Possible off-site causes include:
- traffic quality;
- pricing;
- sales follow-up;
- inventory;
- service availability;
- product-market fit;
- reputation outside the site;
- seasonality;
- economic conditions.

Poor business outcomes must not be converted into website findings without website evidence.

## 41. Competitor-evidence rule

Competitor evidence provides context.

It may support:
- comparison;
- opportunity;
- buyer-expectation understanding.

It cannot independently create a client problem.

"Competitor X has live chat" does not establish:
"Client needs live chat."

The client's own evidence must establish the need.

## 42. Compliance-overreach rule

PRYSM may identify observable accessibility, privacy, consent and security conditions that affect usability or conversion.

Examples:
- keyboard users cannot reach the submit button;
- consent experience obscures the primary action;
- browser displays a security warning.

PRYSM must not automatically convert those observations into:
- legal non-compliance;
- formal accessibility conformance failure;
- formal privacy-law violation.

Such conclusions require separately governed evidence appropriate to that determination.

## 43. Verification contract

Every canonical problem must define a verification method.

Verification has two separate levels.

### Condition verification
Did the observed website condition change?

Examples:
- form submits successfully;
- CTA reaches correct destination;
- important page is indexable;
- mobile control is usable;
- LCP improves under the governed test method.

### Outcome verification
Did the business outcome change afterward?

This requires suitable measurement evidence.

A condition can be technically repaired without proving that conversions increased.

PRYSM must never substitute condition verification for causal outcome proof.

## 44. Repair-package verification

A repair package is not closed until:
- observed condition has been retested;
- relevant page/template/device scope has been checked;
- dependent problems have been reconsidered;
- important preserved patterns still work;
- no new material regression has been introduced in the affected boundary.

Behavioral outcome data, when available, is reported separately as observed association unless causation has been independently established.

## 45. Debugging architecture

The system must be independently testable at four layers.

### Layer 1 — Detection
Question:
Did PRYSM observe the actual condition correctly?

Test:
- false positives;
- false negatives;
- stale evidence;
- device errors;
- scope errors.

### Layer 2 — Classification
Question:
Did PRYSM map the observation to the correct canonical problem?

Test:
- duplicate canonical assignment;
- overly narrow classification;
- acquisition issue mislabeled as direct conversion friction;
- evidence limitation mislabeled as website weakness.

### Layer 3 — Relationship
Question:
Did PRYSM connect only genuinely related findings?

Test:
- unrelated clustering;
- duplicate counting;
- same-source evidence presented as independent corroboration;
- wrong dependency direction;
- cross-page/device overreach.

### Layer 4 — Prioritization
Question:
Did the correct blocker, cluster or standalone material issue rise to the top?

Test:
- minor SEO volume outranking broken conversion path;
- finding-count inflation;
- opportunity presented as friction;
- technical hygiene outranking material conversion friction;
- uncertain cluster outranking proven cluster.

## 46. Deterministic rejection tests

The contract fails if any of the following is possible:

1. Missing evidence creates Clear.
2. Missing evidence creates Friction.
3. Twenty minor observations outrank one confirmed conversion blocker because of count.
4. Duplicate symptoms increase cluster strength.
5. Several findings from one raw signal count as independent corroboration.
6. A competitor difference creates a client defect by itself.
7. An opportunity is reported as existing friction.
8. A likely cause is presented as a verified cause.
9. A mechanism-specific repair is prescribed before mechanism evidence exists.
10. Mobile evidence is generalized to desktop without support.
11. A single-page issue becomes site-wide without repeated/template evidence.
12. Partial acquisition becomes full-site certainty.
13. Measurement absence becomes evidence of poor conversion.
14. Technical repair verification becomes a claim of conversion lift.
15. A high-risk repair is recommended from weak evidence.
16. Clear areas are omitted in a way that makes the report appear uniformly negative.
17. An encyclopedia friction state directly selects STRONG/MIDDLE/WEAK narrative.
18. A friction cluster survives while materially contradictory evidence is ignored.
19. A low-intent utility-page issue outranks equivalent evidence on the primary conversion path.
20. A third-party limitation is presented as though the client directly controls it.
21. A material standalone issue is excluded solely because it has no cluster partner.
22. One observed condition becomes multiple independent canonical problems.
23. Same journey stage alone creates a relationship.
24. Repetition is treated as proof of one shared cause.
25. Multiple providers reporting one source condition count as independent corroboration.
26. Several Watch findings become Friction through count alone.
27. Historical failure evidence creates a current critical blocker without confirmation.
28. An individual Not enough evidence result automatically creates an audit-level L01 limitation.
29. A proven technical mechanism is described as proven conversion loss.
30. An observed accessibility/privacy/security issue is automatically presented as legal non-compliance.

All 30 must be impossible before implementation acceptance.

## 47. Required behavioral fixtures

The implementation test set must include at minimum:

- broken primary lead form;
- missing meta descriptions;
- slow LCP with oversized hero as an unverified cause;
- one template defect across many URLs;
- same canonical symptom across separate implementation seams;
- weak CTA plus missing trust proof at same high-intent action;
- several rules derived from one raw signal;
- several providers reporting one raw condition;
- unmeasured conversion event;
- measurement missing for material repair verification;
- competitor feature with no client evidence of need;
- opportunity without proven weakness;
- strong sampled pages with partial site coverage;
- mobile failure with healthy desktop behavior;
- third-party booking failure;
- high-risk repair proposed from weak evidence;
- conflicting evidence;
- confirmed checkout blocker plus moderate issues;
- duplicate symptoms;
- single material non-blocking standalone issue;
- two unrelated findings sharing only journey stage;
- one issue eligible under two canonical labels;
- several Watch findings from one raw signal;
- independent Watch findings at same action point;
- Clear evidence contradicting a proposed friction cluster;
- Not enough evidence inside a proposed cluster;
- historical outage evidence;
- current reproducible outage;
- intentionally excluded noindex page;
- unintended noindex on important commercial page;
- Unknown page intent;
- low-intent utility issue versus high-intent conversion issue;
- proven third-party performance mechanism;
- proven mechanism without business-outcome evidence;
- outcome-level repair target with unknown mechanism;
- mechanism-specific remedy with unknown mechanism;
- observed accessibility barrier without legal conclusion;
- observed consent friction without legal conclusion;
- audit-level evidence gap;
- individual problem with insufficient evidence;
- post-repair technical success without outcome evidence.

## 48. Interaction with the seven-page report

### Executive Scorecard
Receives accepted high-level priority units and evidence limits as inputs.
It still applies the frozen narrative-state contract.

### Priority Fixes
Uses accepted priority units, maximum three first checks, and one priority explanation sentence.

### Conversion Journey
Uses journey-stage mapping and accepted friction evidence without assuming abandonment.

### Content Opportunities
Uses Opportunity dispositions and verified decision-support gaps.
Opportunity remains distinct from friction.

### Trust & Credibility
Uses trust-related canonical problems and positive proof patterns.

### Competitor Comparison
Uses competitor context but cannot manufacture encyclopedia findings.

### Supporting Detail
Receives lower-value findings, evidence limitations, Watch items, scope, source details and findings omitted from top priorities.

The encyclopedia cannot change the frozen seven-page structure.

## 49. Client-report simplicity rule

Internal analysis may include:
- 75 canonical problems;
- scope modelling;
- evidence lineage;
- relationship graphs;
- dependency logic;
- falsification;
- repair risk;
- prioritization.

The normal client view remains:

- What we found
- Why it may matter
- Check these first
- What not to assume
- Who may need to help
- How we will verify it

No confidence decimals or graph-theory language appear by default.

## 50. Review-gate evidence

Before freeze, this contract underwent:

- 15/15 original core challenge cases PASS;
- 30 additional adversarial cases, which exposed 11 real boundary ambiguities;
- correction of those 11 governing-rule weaknesses;
- fresh 45/45 full rerun PASS;
- 11/11 mutation tests correctly FAIL when each new safeguard is removed;
- final restored-contract 45/45 PASS.

The review did not weaken or remove failed tests to obtain PASS.

The contract passed because the governing logic was repaired and then rerun from a clean reasoning boundary.

## 51. Freeze declaration

This contract is the authoritative governed specification for the PRYSM Conversion Friction Encyclopedia and Relationship System.

Frozen counts:
- 12 diagnostic areas;
- 75 canonical problems;
- 6 relationship types;
- 4 client-facing friction states.

Frozen governing sequence:

```text
whole-site discovery
→ issue mapping
→ relationship analysis
→ materiality / duplicate / dependency review
→ friction cluster or reviewed standalone material finding
→ challenge / falsification
→ first diagnostic checks
→ priority repair plan
→ verification
```

Frozen safety rules:
- no raw finding becomes a Priority Fix immediately;
- no fake precision;
- no additive finding-count score;
- no duplicate symptom inflation;
- no pseudo-independent corroboration;
- no unproven cause language;
- no business-outcome causal claim from technical mechanism evidence alone;
- no site-wide claim from bounded evidence;
- no opportunity-to-friction inflation;
- no missing-evidence failure claim;
- no relationship from journey stage alone;
- no repetition-as-shared-cause assumption;
- no mechanism-specific repair without mechanism evidence;
- no automatic legal/compliance conclusion;
- no encyclopedia-to-narrative direct state mapping.

Production remains frozen.

This specification does NOT by itself authorize:
- application code changes;
- production deployment;
- evidence-acquisition changes;
- scoring changes;
- Writer/Judge changes;
- provider/model calls;
- storage changes;
- lifecycle changes;
- authentication changes;
- orchestration changes;
- a new production audit.

The next governed tranche is implementation-boundary design against this frozen specification.
