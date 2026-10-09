# PRYSM — Judgment Calibration, Knowledge Graph and JEV.ai Architecture

**Date:** 2026-10-09  
**Status:** PROPOSED / DISCUSSION ONLY — NOT APPROVED FOR IMPLEMENTATION  
**Repository role:** PRYSM context/memory; `chriskulbaba2025/prysm-project-context`  
**Application role:** Isolated staging; `chriskulbaba2025/prysm-staging-isolated`  
**Purpose:** A complete, independently auditable architecture proposal that consolidates the Adam Snapshot review, Gluckstein, Hepburn, Jobber, REI, MEC, the new intake design, the proposed knowledge graph, JEV.ai classification and the calibration method. This specification does **not** claim the components are implemented.

## 1. Strategic objective

PRYSM must become a **governed conversion-decision advisor**, not a generic technical checklist.

Required reasoning chain:

`Declared site/business context → buyer intent and decision questions → applicable evidence → established facts and meaningful unknowns → graph-supported relationships → bounded classification (rules + optional JEV.ai) → priority adjudication → authorized FIX / VERIFY / KEEP → NDP/Judge-controlled report surfaces → regression proof`.

Two complementary principles:
1. **Evidence determines what PRYSM is allowed to claim.**
2. **Buyer consequence and business context determine which authorized actions or checks deserve attention.**

The system must explain *why this ahead of that*, not only label the most easily measured problem as first. A low score does not automatically authorize FIX; a highly relevant uncertainty does not automatically establish a defect.

### Existing strengths to preserve

- Canonical evidence/status and provenance controls; no unknown-as-absence.
- Deterministic score and NDP authority, existing Writer/Judge and report architecture.
- Improved Service/Legal/SaaS content and journey interpretation, bounded content suggestions, preservation logic.
- Current Conversion Friction Encyclopedia, relationships, prioritization, site classification, buyer-decision context.
- Judge fail-closed behavior in ecommerce cases rather than fabricated fixes.
- Existing Snapshot/Executive parity contracts and approved-report immutability.

Do not conflate proposed capability with tested existing implementation.

## 2. Calibrated action and opportunity vocabulary

**Client-facing actions (business decision):**
- `FIX`: established materially relevant problem with an authorized corrective action.
- `VERIFY`: relevant uncertainty with a specific diagnostic question and next check; **not** a proven defect.
- `KEEP / NO ACTION`: established useful condition or insufficiently important reason to change.
- `WITHHOLD`: nothing relevant, safe and source-linked to present. Genuine empty arrays are permitted.

**Funnel planning modes (not equivalent to corrective actions):**
- `ESTABLISHED_GAP`: could qualify CREATE/FIX under separate G2 and finding authorization.
- `VERIFY`: inspect buyer-stage coverage; do not assert it is missing.
- `FUTURE_ASSESSMENT`: a bounded stage-specific question worth assessing; no corrective or ranking authority.
- `ALREADY_COVERED`: preserve or improve access/consolidation only where justified.
- `WITHHOLD`: no defensible buyer-stage opportunity.

**Never promote** buyer-topic relevance, graph proximity, JEV confidence, or a weak score into a proven issue. Keep coverage truth, action state, stage and priority independent.

## 3. Proposed knowledge graph — bounded scope, not a general-purpose graph

### Existing foundation and proposed technology

Source-code inspection identified `services/worker/src/encyclopedia/registry.js`, `relationships.js`, `projection.js` and `prioritization.js`, plus governed intake classification, evidence and buyer-decision contracts. These are **foundation components**, not a complete, implemented knowledge graph.

**Architecture candidate:** extend the existing JavaScript/TypeScript relationship layer; use existing PostgreSQL where persistence is justified. No Neo4j or external graph database unless measured scale, query and integrity requirements show it is necessary. No database migration is authorized by this document.

### Minimal typed ontology (versioned)

| Node type | Examples / identifiers | Authority |
|---|---|---|
| Site/business context | siteType, modifiers, market, declared audience, industry/regulatory context | Explicit intake or evidenced inference with provenance |
| Business objective | primary/secondary/tertiary conversion goals | Declared intent; never evidence of a working path |
| Buyer intent & buyer question | choose a plan, ask for estimate, compare fit, assess risk, request a consultation | Qualified contextual hypotheses; observed where evidence supports |
| Journey stage & page role | Awareness, Consideration, Decision; product, service, plan/pricing, contact, checkout | Explicit or evidenced classification |
| Content topic and scope | topic, subtopic, template, URL and device scope | Canonical content/evidence source |
| Evidence observation | result, measurement, source, timestamp, scope, source status | Canonical evidence authority only |
| Finding / unknown / preservation | canonical findingId, truthState, confidence, score-bearing status | Governing finding and NDP contracts |
| Candidate action / opportunity | FIX, VERIFY, KEEP, FUTURE_ASSESSMENT, WITHHOLD | Governed authorization |
| Priority decision | candidate set, chosen rank, competing candidate, rationale, limits | Explicit priority-adjudication authority |
| Proof artifact | evidence references, evaluation receipt, report version, fixture/test ID | Verifiable record |

**Graph edges** are typed and directional, not undifferentiated similarity:
`DECLARED_GOAL_OF`, `RELEVANT_TO_GOAL`, `ANSWERS_BUYER_QUESTION`, `APPLIES_AT_STAGE`, `OBSERVED_ON_PAGE`, `SUPPORTED_BY`, `CONTRADICTED_BY`, `REQUIRES`, `SAME_DECISION_POINT`, `DUPLICATES`, `DEPENDENCY_OF`, `SUGGESTS_CHECK`, `AUTHORIZED_ACTION_FOR`, `OUTRANKS_WITH_REASON`.

Each edge requires: subject ID, predicate, object ID, ontology version, provenance references where factual, confidence/source state, scope, and whether it is **observed**, **declared**, **rule-derived**, or **hypothesis-only**. Deny unsupported edges; do not infer that absence of an edge proves absence of a fact.

### Graph reasoning rules

- Typed edge traversal may **retrieve context and propose comparisons**, but cannot create score-bearing evidence, corrective findings or priority authority by itself.
- Scope and specificity matter: parent topic → child topic, TOFU → Decision, service → product, or one URL → sitewide requires explicit eligible mapping.
- Cross-domain synthesis must distinguish *content discusses outcomes* from *specific proof of outcomes exists and is seen before commitment*.
- Graph hypotheses (“may share cause”, “buyer may ask”) remain hypotheses until confirmed independently.
- Contradictory evidence must surface conflict; do not silently choose the more confident classifier.
- Circular reasoning, self-support, duplicate evidence counted twice, unrelated cross-site relationships and false fact promotion are prohibited.
- Preserve site-status and modifier effects. For regulated sites, the calibration must identify **what rule/check actually changes**; checking a box without semantic impact is not success.
- Graph edits are versioned and reversible; accepted canonical contracts remain source of truth.

### Graph completeness for this specific product

“Complete” means a versioned typed ontology, validated relationship semantics, source/reachability and provenance, scoped traversal/relationship checks, conflict checks, persistence/replay where necessary, and tests demonstrating better context classification. **It does not mean having a huge global knowledge base.**

## 4. JEV.ai — classifier, not judge of evidence

The user reports having a JEV.ai account. This establishes account ownership as user-supplied context only; **no API, endpoint, SDK, model, pricing, credential or supported output schema was verified in this architectural note**. Integration feasibility is pending provider/account documentation.

### Proposed bounded duties

- Resolve among predefined buyer-intent or site-context classes **when evidence/rules are ambiguous**.
- Classify which buyer stages/questions a governed topic is relevant to.
- Propose relevant graph edges as **non-authoritative candidates** with exact source IDs.
- Assess *comparative business relevance* of eligible, evidence-backed priority candidates under a declared goal.
- Flag uncertainty or abstain; abstention is valid and must not be coerced into a forced label.

### Explicit exclusions

JEV.ai cannot create or rewrite observations, mark missing content without evidence, override classification declared by authorized intake, invent competitors, change canonical scores, convert VERIFY into FIX, assign NDP priority authority, publish a report, or approve a Judge failure.

### Suggested classification contract (conceptual; not provider API)

Input: `ontologyVersion`, `siteType`, `goalSet`, `buyerQuestionCandidateIds`, `eligibleGraphNodeIds`, `eligibleEdgeIds`, `canonicalEvidenceRefs`, `status/coverage`, `candidateClasses` and explicit classification task.

Output: `classId`, `confidenceOrAbstain`, `candidateNodeIds`, `supportingEvidenceRefs`, `proposedEdgeIds`, `reasonCategory`, `providerVersion`, `requestId` and `modelVersion` **only where actually supported and verified**. No prose-only classification without traceable IDs. Calibration must not turn an unsupported provider field into a required runtime guarantee.

### Enforcement rules

1. Deterministic, explicit authority wins over JEV classification.
2. JEV's returned confidence measures classifier uncertainty, **not truth or business impact**.
3. Unsupported/missing IDs, out-of-enum labels, conflicting authority and unchecked source references ⇒ reject or abstain.
4. Provider error, timeout or cost limit ⇒ fall back to existing bounded deterministic/UNKNOWN path, not a fabricated result.
5. Provider/model prompts and payloads carry minimal necessary data; no secrets or private client artifacts without approved privacy review.
6. Calls must be cost-governed, logged, deterministic-fixture replayable, and explicitly authorized before live use.
7. Begin with a bounded **shadow comparison** against existing labeled fixture data; promotion only upon objective evidence of better outcomes.
8. Do not require days of audit. Use focused positive and negative controls, a pre-agreed short acceptance gate and a fail-closed stop on any critical authority breach.

Open implementation question: where JEV sits relative to graph compilation, deterministic classification, candidate generation and priority adjudication; choose only after identifying current owning consumer/producer contracts.

## 5. Priority adjudication — distinct from scoring and JEV

**Input:** only eligible governed findings, verified unknowns and separately authorized verification candidates.

For each candidate evaluate these **dimensions as structured reasons**, not blind numerical weights:
- primary conversion-goal relevance;
- buyer decision-stage proximity;
- site-type/modifier relevance;
- direct impairment and likely commercial consequence;
- confidence, observation scope and evidence limits;
- frequency/reach, dependencies and strategic leverage;
- action viability, implementation effort and preservation risk;
- relation to other valid candidates.

**Pairwise judgment:** compare each intended Top 3 item with its strongest excluded alternative. Store “why this before that”, the shared buyer-goal criterion, contrary evidence, and any undecidable trade-off. A lower scored dimension cannot automatically override proven action authority, but a low dimension must be **explained** if no corresponding action is prioritized.

Site-type priors are **advisory lenses, never fixed rankings**:
- Service / Lead Gen: action path, service fit, trust and reassurance, process/pricing expectations, performance/discovery/hygiene.
- SaaS / B2B: product fit, value, plan/trial/demo decision path, adoption and proof, performance/discovery/hygiene.
- Ecommerce: product/category discovery, suitability, availability, shipping/returns/checkout, proof, performance and acquisition.
- Publisher / Directory: discovery, relevance, navigation, credibility, reader action, performance/technical integrity.

Technical issues may be first when evidence shows they are more consequential. Do **not** insert an arbitrary “no more than one technical issue in Top 3” quota; instead demand a defensible comparison.

**Owner and governance:** decide upstream at the actual governed priority owner; do not rerank Snapshot or Executive independently in a renderer or JEV output. Preserve numeric scoring and NDP parity unless a separate authorized contract change exists.

## 6. Systemic defect families (all currentness unverified until Gate 0)

| Key | Defect / question | Primary qualification target |
|---|---|---|
| J-01 | Priority list dominated by technical hygiene without buyer-goal comparison | Candidate qualification / priority adjudication |
| J-02 | Low-scored conversion/trust area with no priority or explicit VERIFY explanation | Evidence → action-state reconciliation |
| F-01 | REI under-generation of useful stage-specific VERIFY/FUTURE_ASSESSMENT | Funnel topic/stage/coverage/Writer/Judge contract |
| F-02 | MEC inherited HIGH priority from broad TOFU to Decision-stage subtopic | Exact priority source/graph relation authorization |
| T-01 | Trust present/partial/strength/placement/absent conflation | Canonical projection and client language |
| T-02 | Repetitive Trust exposition across equivalent statuses | Evidence-aware grouping/synthesis |
| P-01 | Internal parent problem taxonomy broadens proved subtype | Finding-to-client-title mapping |
| P-02 | FIX/VERIFY/KEEP groups and counts contradict semantic states | Report index/section projection |
| N-01 | Business objective leaks into buyer-facing content title | Intent translation / Writer |
| N-02 | Governance jargon and “the assessment affects buyers” subject errors | Client-language projection / Judge |
| X-01 | Content coverage vs Trust proof strength seems contradictory | Cross-domain meaning/scope synthesis |
| S-01 | Snapshot less strategically useful than Executive or repeats evidence as why | Shared NDP meaning and Snapshot condensation |
| D-01 | Diagnostics lack metric/page/device, starting checks and verification | Finding detail authorization |
| C-01 | Competitor/site-modifier context is misapplied or not operative | Qualification, applicable-rule invocation |

Per issue disposition: `CONFIRMED`, `ALREADY_FIXED`, `NOT_REPRODUCED`, `UNKNOWN`, or `OUT_OF_SCOPE` with source, version and exact producer/consumer boundary. Never repair a pattern simply because an older report contained it.

## 7. Five regression archetypes and discriminating questions

| Archetype | Preserve | Key calibration challenge |
|---|---|---|
| **Gluckstein** — legal/service + regulated | More careful Trust states, stronger intent-specific Content, 0 Create/10 Check/2 Covered | Why schema before unresolved trust/fit work after speed? Actual subtype title and FIX/VERIFY group parity; identify regulated=true effect |
| **Hepburn** — local plumbing | Trust priority and restrained CTA interpretation, 2 Create/9 Check/1 Covered | Why structured data before pricing/process reassurance? Avoid unproven “proof missing where needed” |
| **Jobber** — SaaS/B2B | Trial/plan framing in Journey/Content, 0 Create/10 Check/2 Covered | Why schema/meta/headings before trial/plan verification with Conversion Path 50? Explain VERIFY without inventing FIX |
| **REI** — large ecommerce | Judge blocks invented funnel claims | From actual persisted topic rows, provide stage-specific checks only when justified; inspect rejected pass-2 candidate if retained |
| **MEC** — ecommerce | Useful Decision-stage question under limited evidence | Preserve opportunity with `priority=UNASSIGNED` when broad TOFU topic does not authorize child/stage priority |

These named examples are **regression fixtures, not targets for special-case code**. Add unrelated positive/negative fixtures to prove generalization.

Sources: Adam's 14-report Snapshot audit; Gluckstein Oct 7→9 comparative review; Hepburn; Jobber; REI/MEC. These are reviewer descriptions; current-run defects are not independently verified by this document.

## 8. Six-question audit rubric

An external model should examine the **evidence and actual outputs** before scoring:
1. **Context:** Does PRYSM understand the business model, declared goals, buyer, stage and active modifiers?
2. **Truth:** Are conclusions supported by precise source, scope and truth states?
3. **Action authorization:** Does the report distinguish FIX, VERIFY, KEEP/FUTURE_ASSESSMENT/WITHHOLD correctly?
4. **Priority quality:** Does it surface what most matters for the business decision rather than the easiest detectable issue?
5. **Comparative justification:** Can it defend why the chosen Top 3 outrank the best eligible alternatives, or explicitly qualify uncertainty?
6. **Advisory usefulness:** Are next checks, role/tools, verification method, measurement and what to preserve clear and plain-language?

Hard FAIL on unsupported evidence/absence, fabricated corrective authority, priority-inheritance without edge proof, invented competitor analysis, NDP/report disagreement, unsafe provider call, or unauthorized production mutation. Report `UNKNOWN` rather than guessing when current input/output is inaccessible.

## 9. Proposed operating process — time-bounded, no multi-day audit requirement

**Discussion and approval first.** No code or cloud mutation is authorized here.

- **Gate 0: Read-only baseline (timebox proposed 30–60 minutes).** Resolve context vs staging repository roles; exact GitHub HEAD; existing report/fixture versions; persisted evidence, NDP, Judge receipts; current Vercel/Railway alias only if required. Report missing artifacts as UNKNOWN; do not launch new paid audits.
- **Gate 1: Decision-model review and bounded definitions of done (proposed 30–60 minutes).** Independent LLM checks ontology, graphs/JEV boundaries, candidate authorization, comparative priority contract, five fixture questions and critical negative controls. Freeze one repair tranche if approved.
- **Proposed A: Funnel authority.** REI and MEC; no empty-array pressure or priority inheritance.
- **Proposed B: Comparative priority adjudication.** Gluckstein, Hepburn, Jobber; no unproved FIX.
- **Proposed C: Cross-surface client meaning.** Trust synthesis, titles, grouping, Snapshot parity and language.
- **Proposed D: New Audit intake and buyer-intent capture.** Explicit primary + optional goals, target audience and context through governed contracts.
- **Proposed E: Knowledge graph core (if accepted).** Typed ontology, sourced edges, validation and deterministic graph reasoning.
- **Proposed F: JEV.ai bounded classifier (if accepted).** Verify account/API/privacy/cost; contract; shadow tests; fail-closed gate.
- **Final gate:** Exact-head targeted and full regression + currentness/visual acceptance where authorized; require named evidence and independent review, not self-declared PASS.

Tranche letters are *discussion sequencing*, not execution permission or dependencies chosen without design review. For speed: avoid redundant full regression between tiny edits, use representative fixtures with negative controls, limit provider cost, and stop at the actual failing authority boundary. A multi-day observation period is **not** a prerequisite for architectural acceptance.

**Previous planning estimate:** 8–16 active hours for intake + intent + original Adam calibration, provisional and NOT inclusive of fully implemented graph and JEV work. Additions require a separately assessed effort estimate after scope is frozen. Do not represent commit spacing as wall-clock release time.

## 10. Required independent audit output

Reviewer must return:
1. **Verdict:** ACCEPT / ACCEPT WITH CHANGES / REJECT / INSUFFICIENT EVIDENCE for the **proposal**.
2. **Existing vs proposed map:** Explicitly distinguish current source-level capabilities from new graph/JEV work.
3. **Missing concepts or unsafe authority crossings:** cite architecture section, source file, violated invariant, consequence.
4. **Simplification opportunities:** identify needless moving parts, redundant data stores or overengineering.
5. **Exact rule/contract amendments:** proposed typed nodes/edges, JEV inputs/outputs, priority rationale schema, version/legacy plan.
6. **Fixture test plan:** Gluckstein/Hepburn/Jobber/REI/MEC plus counterexamples; expected TRUE/UNKNOWN/FAIL behavior.
7. **Open decisions:** necessary information about provider API, data permissions, time/cost caps and source availability.
8. **Bounded sequence:** shortest safe stepwise design+implementation path with measurable STOP/PASS gates and no premature deployment.

Audit proposal merits on reasoning and contracts, not number of checklist ticks. Explicitly challenge assumptions, and never declare the feature implemented simply because a Markdown document describes it.

## 11. Boundaries and outstanding decisions

- **No application changes** under this documentation task. No JEV live calls, PostgreSQL schema change, Neo4j, staging/production deploy, or paid audit.
- **No blanket “JEV should handle X” claims** without confirming actual provider capability. Account is reported by user; integration semantics remain unknown.
- **No hardcoded business rules by fixture**; client-specific cases are regression evidence only.
- **No new site/report pages** unless separately approved; preserve existing governed presentation architecture and report freeze.
- **No automatic next tranche.** Before execution, reconcile project-memory authority, inspect latest app HEAD/runtime proof, agree on definitions of done, and approve exact method.
- Open: ontology detail, taxonomy version, which existing relationship types cover new graph links, quality metric definition and baseline, persistence representation, fallback operation, JEV API contract, privacy classification, provider costs, model call authority, and graph/classifier evaluation budget.

**Exact next discussion action:** commission a read-only independent-LLM architecture audit using this document and the current project context. Receive its objections and incorporate approved corrections before implementation planning.
