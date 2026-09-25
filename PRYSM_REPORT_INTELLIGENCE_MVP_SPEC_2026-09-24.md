# PRYSM Report Intelligence MVP Specification

Date: 2026-09-24 America/Toronto
Status: AUTHORIZED FOR NON-PRODUCTION GOVERNED IMPLEMENTATION

## Frozen application baseline

Repository: `chriskulbaba2025/vantage-platform`
Frozen SHA: `80aa279907c7dc6ab0db905d5cf31be618c51b6a`
Frozen branch: `freeze/prysm-mvp-pre-report-intelligence-20260924`
Authorized working branch: `repair/prysm-report-intelligence-terra-sol-20260924`

The frozen branch is the exact pre-tranche baseline. Do not move, rewrite, or use it as the Builder branch. All implementation work begins from the authorized working branch.

Production remains frozen at `a68dd235a3ca09977c84313536b5b884e3694782`. No production mutation or promotion is authorized.

## Product objective

Improve PRYSM from a strongly governed but sometimes over-constrained reporting system into a useful, accurate, internally coherent consulting product.

The priority order is:

1. preserve evidence integrity;
2. eliminate material contradictions;
3. increase practical usefulness and business judgment;
4. increase consistency across report pages and site types;
5. preserve bounded uncertainty rather than forcing certainty;
6. do not optimize for perfect wording consistency at the expense of useful interpretation.

A useful, well-bounded consulting conclusion is preferred over a mechanically exact but commercially unhelpful statement.

## Governing architecture

The target architecture is:

Deterministic Evidence Engine
→ Evidence Contract
→ Terra default semantic analysis
→ Interpretation-confidence / contradiction gate
→ Sol escalation when required
→ Whole-report reconciliation
→ Usefulness Judge
→ Integrity / finalization gate
→ Seven-page report

### Authority boundary

Models MAY:
- interpret governed evidence;
- connect equivalent evidence forms;
- judge materiality;
- determine whether a technically valid finding deserves client priority;
- distinguish create / improve / expand / consolidate / make easier to find;
- synthesize business meaning;
- reconcile conclusions across report pages;
- generate client-facing wording;
- explain uncertainty;
- recommend verification steps.

Models MUST NOT:
- change evidence status;
- invent evidence;
- rewrite measurements;
- turn PARTIAL into complete certainty;
- turn UNKNOWN/UNAVAILABLE/FAILED/NOT_CONNECTED into a negative finding;
- fabricate analytics or conversion outcomes;
- change source identities;
- erase evidence provenance;
- create unsupported causal or revenue certainty.

Governing rule:

**Models may interpret evidence, but they may not redefine evidence.**

## Model routing

### Terra

Terra is the default semantic interpretation model for report intelligence.

Use Terra for:
- evidence interpretation;
- trust/proof equivalence;
- business relevance;
- priority interpretation;
- content-opportunity reconciliation;
- client-language generation;
- first-pass cross-section synthesis;
- usefulness evaluation when no material ambiguity remains.

Do not call Sol merely because a report exists.

### Sol

Sol is an escalation model, not a universal second pass.

Escalate only when a governed trigger is present, including:
- material contradiction between report conclusions;
- competing evidence that cannot be reconciled confidently;
- ambiguous PARTIAL evidence interpretation;
- uncertainty over whether evidence forms are semantically equivalent;
- mismatch between dimension score/label and narrative conclusion;
- own-site evidence conflicts with competitor-normalized evidence;
- recommendation usefulness remains uncertain after Terra;
- Terra returns below the configured semantic confidence threshold;
- final whole-report reconciliation identifies a material unresolved inconsistency.

Every Sol escalation must record:
- trigger;
- relevant evidence IDs/states;
- Terra conclusion;
- unresolved ambiguity;
- Sol conclusion;
- whether Sol changed the interpretation and why.

Sol may resolve interpretation. It may not alter immutable evidence truth.

## MVP release standard

PRYSM does not need to produce identical prose every run.

A report is client-ready when all three conditions hold:

1. No material factual or cross-report contradiction.
2. No unsupported certainty or evidence-state conversion.
3. No client recommendation that a competent consultant would regard as obviously useless, generic, redundant, or contradicted by existing site content.

## Benchmark evidence motivating this tranche

Real report review across Hepburn Plumbing, Reboot Business Coaching, New Era Plumbing, 1-800-GOT-JUNK?, and ServiceMaster exposed recurring classes rather than isolated fixture defects.

Named businesses are regression fixtures only. No implementation may target their domains, names, URLs, audit IDs, industries, or exact sentences.

### Material recurring classes

1. Composite score / narrative contradiction.
   Example pattern: a dimension may be labelled Strong while the primary business outcome represented by that dimension is described as Weak.

2. Cross-page semantic contradiction.
   Example pattern: pricing/proof is said to be observed in one section and absent in another.

3. Proof-classification rigidity.
   Testimonials, customer stories, galleries, before/after evidence, documented examples, and outcome narratives may provide meaningful proof without using a formal taxonomy label such as "case study."

4. Content-opportunity non-reconciliation.
   PRYSM can recommend creating topics/process/pricing/customer-result content that is already materially present.

5. Generic ontology-filling recommendations.
   Examples of the failure class include basic "what is [service]" topics that add little decision value for the specific business.

6. Competitor evidence disconnect.
   Own-site evidence can be sufficient for strong PRYSM conclusions while competitor comparison says "Not enough evidence" about the client because normalized comparator records do not consume the already-available own-site evidence.

7. Competitor conclusion contradiction.
   Descriptive stronger competitor trust signals may coexist with a later conclusion that no trust/proof difference was established without adequately explaining the distinction.

8. Technical-hygiene over-prioritization.
   Easily proven technical observations such as schema, headings, or metadata can outrank more material buyer/trust/content work simply because they are deterministic.

9. Technical-to-conversion projection.
   Missing structured data or similar machine-readability issues must not be framed as direct visitor decision friction without evidence.

10. Provenance contamination.
    Tracking parameters such as `utm_source=chatgpt.com` must not leak into client-facing canonical evidence locations.

11. Repetitive defensive governance language.
    Evidence limits must remain visible but should not overwhelm client pages.

12. Generic verification language.
    "The specified change is present at the assessed scope" is weaker than finding-specific verification.

13. Low-score interpretability.
    A low/moderate dimension score should have an understandable business explanation, not merely a numeric label.

14. Detection versus business absence.
    "Not detected" is not automatically equivalent to "commercially absent."

15. Evidence confidence versus business priority.
    High evidence confidence does not itself make a finding a top client priority.

## Required generalized repairs

### P0

- Create or strengthen a canonical semantic conclusion layer so one business concept cannot carry mutually incompatible client-facing states without explicit reconciliation.
- Add whole-report reconciliation before finalization.
- Prevent broad client labels from mechanically overstating composite dimension meaning.
- Reconcile Content Opportunities against observed existing content before ranking or recommending creation.
- Add usefulness acceptance in addition to integrity acceptance.
- Preserve finalization fail-closed evidence-state protections.

### P1

- Broaden semantic proof recognition without weakening evidence provenance.
- Separate detector result from commercial interpretation.
- Add materiality-aware prioritization.
- Allow a valid technical finding to remain supporting detail instead of a top priority.
- Propagate own-site evidence into competitor comparison where governed contracts permit.
- Reconcile descriptive competitor signals with comparative conclusions.
- Canonicalize client-facing URLs and remove known tracking/referral contamination.
- Generate finding-specific verification.
- Improve score interpretability.

### P2

- Reduce repeated evidence-limit prose while preserving required disclosures.
- Make usefulness/site-type context part of content-opportunity reasoning.
- Preserve technical observations in Supporting Detail without automatically creating client actions.
- Improve language quality without changing evidence truth.

## Cross-report reconciliation contract

Before release, assemble a compact semantic ledger covering at least:
- overall readiness;
- each dimension score and label;
- conversion-path state;
- pricing/cost reassurance;
- trust/proof state;
- experience/results proof;
- testimonials/reviews;
- completed-work/customer-outcome proof;
- content coverage/opportunities;
- technical priorities;
- competitor differences;
- accepted action priorities;
- evidence limitations.

Run contradiction detection on the ledger.

Material contradictions must either:
- be reconciled into one client-coherent conclusion; or
- be explicitly explained as different scopes/meanings.

Do not silently publish both.

## Content opportunity contract

For each proposed opportunity, classify it as one of:
- CREATE;
- EXPAND;
- IMPROVE;
- CONSOLIDATE;
- MAKE_EASIER_TO_FIND;
- NO_ACTION.

Before recommending CREATE, check available assessed content for semantic coverage.

Do not require exact heading/title matches.

Reject or downgrade generic suggestions that:
- merely define the core service for an audience that already understands the category;
- duplicate existing material coverage;
- cannot explain the buyer decision they improve;
- are business-type noun substitutions without specific decision value.

## Usefulness Judge

The usefulness layer must assess at minimum:
- Does this change a client decision or priority?
- Is the recommendation already materially satisfied?
- Is it specific enough to act on?
- Is it proportionate to business impact?
- Does it merely repeat a detector result?
- Is the causal language supported?
- Would a competent consultant be comfortable saying this to the client?
- Is it consistent with the rest of the report?

A technically valid finding may remain evidence/supporting detail even if it does not pass client-priority usefulness.

## URL normalization

Client-facing evidence URLs must use canonical normalized URLs when available.

Strip known tracking/referral parameters from display/provenance presentation where doing so does not alter resource identity.

Preserve raw source URL internally when needed for traceability.

## Testing and generalization

Named benchmark sites are regression fixtures only.

The implementation must prove generalized behavior across:
- strong site;
- weak site;
- mixed site;
- partial evidence;
- unavailable evidence;
- customer story without "case study" label;
- gallery/completed-work evidence;
- content already present;
- content partially present;
- genuinely absent content;
- technical issue with low business impact;
- technical issue with high business impact;
- competitor evidence richer than client comparator record;
- contradictory semantic inputs;
- clean non-contradictory inputs;
- tracking-contaminated source URL.

Whole-App branch coverage must be updated for every new materially distinct branch.

## Cost guardrail

Internal MVP planning assumption: approximately **USD $2 of LLM budget per completed audit**.

This is a budget guardrail, not a quality cutoff.

Do not avoid a justified Sol escalation to save a small fraction of an audit cost.

Do not run Sol universally when no escalation trigger exists.

Record model token/cost telemetry per audit where the runtime already supports usage/cost recording, without adding unrelated infrastructure.

## Scope controls

Do not:
- weaken evidence statuses;
- weaken the ServiceMaster PARTIAL finalization fix;
- change provider integrations unless direct evidence proves the report-intelligence requirement is owned there;
- make AWS production changes;
- mutate production;
- target benchmark businesses;
- add a second independent scoring system;
- replace deterministic measurements with model guesses;
- allow free-form model outputs to bypass contracts/validation;
- hide contradictions rather than resolving them.

## Definition of done

The tranche is complete only when:

- frozen baseline remains independently recoverable;
- all changes are on the authorized working branch;
- Terra is verified as the default semantic interpretation model where this architecture applies;
- Sol escalation is explicit, bounded, observable, and tested;
- immutable evidence fields cannot be changed by model interpretation;
- whole-report reconciliation is implemented;
- usefulness validation is implemented;
- content opportunities reconcile against existing coverage;
- proof equivalence is improved without fabrication;
- competitor own-site evidence coherence is improved;
- canonical display URLs do not leak tracking contamination;
- targeted tests pass;
- full worker regression passes;
- Whole-App gate passes with updated branch matrix;
- Model-Bearing Release Gate is run where applicable;
- independent semantic challenge passes;
- exact-head audit has zero CRITICAL/MAJOR repository-controlled defects;
- at least the governed benchmark corpus demonstrates materially improved usefulness and coherence without evidence-integrity regression;
- no production mutation occurred;
- terminal proofs are written to a dedicated named subfolder under `C:\Users\kulba\Downloads\`;
- authoritative project context is updated with exact final SHA, gates, residual risks, cost observations, and next action.
