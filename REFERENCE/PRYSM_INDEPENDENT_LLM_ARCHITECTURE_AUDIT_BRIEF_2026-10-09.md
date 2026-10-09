# Independent LLM Audit Brief — PRYSM Judgment, Knowledge Graph, JEV.ai

**Date:** 2026-10-09
**Status:** External design review request / NOT implementation authority
**Package:** Entire `chriskulbaba2025/prysm-project-context` repository at a recorded commit
**Application source is separate:** `chriskulbaba2025/prysm-staging-isolated`

## Start here

You are reviewing a **proposed PRYSM architecture**, not being asked to build it, deploy it or approve it by default. The repository contains substantial history and some superseded guidance; do not read all old files as simultaneously current.

Read in order:
1. `PROJECT.md`, `GITHUB_PROJECT_MEMORY_PROTOCOL.md`, `CURRENT_STATE.md`, `CONSTRAINTS.md`, active `DECISIONS.md` excerpts.
2. `SPECS/PRYSM_JUDGMENT_CLASSIFICATION_GRAPH_JEV_ARCHITECTURE_DISCUSSION_2026-10-09.md` — primary proposal.
3. `REFERENCE/PRYSM_INTAKE_INTENT_AND_ADAM_DISCUSSION_2026-10-09.md` — earlier intake / Adam planning.
4. `PRYSM_REPORT_INTELLIGENCE_MVP_SPEC_2026-09-24.md`, `CONVERSION_FIRST_V4_2.md` and relevant Encyclopedia/decision-authority context where needed.
5. Optional historical report proofs for comparison only; do not let historical dates or state override newer verified checkpoints.

The **application repo is not in this archive**. Any conclusion about current code, live APIs, deployed staging, the current Writer/Judge implementation, PostgreSQL schema or provider behavior must be marked **UNVERIFIED** unless separate direct evidence is supplied. The user reports a JEV.ai account but no verified provider integration contract, credential, API shape or costs are supplied.

## Primary audit question

Can PRYSM use the existing Conversion Friction Encyclopedia plus a **bounded, typed knowledge graph** and **JEV.ai classifier** to improve the choice and explanation of priority actions *without* crossing canonical evidence, status, score, NDP, Writer/Judge, publication, cost/privacy or human-approval boundaries?

Challenge whether this is the **simplest sufficient architecture**. An external graph database is not assumed necessary. JEV is not assumed capable of any particular API until checked.

## Questions to test

### A. Scope and simplicity
- Which required graph capabilities are truly missing versus already present?
- Is an ontology+validated-edge layer over the existing JavaScript/TypeScript engine and PostgreSQL enough? What threshold would justify Neo4j?
- Can JEV be postponed, reduced or safely fail-open **only as advisory** (never fail-open as authority)? Distinguish the alternatives.

### B. Ontology, provenance and knowledge-graph completeness
- Is the node/edge vocabulary minimal, stable, typed, versioned and traversable?
- Are directed relations scope-aware? Does the graph prevent circular proof, duplicated evidence, false absence and unauthorized topic/stage propagation?
- Are observed, declared, inferred and hypothesized facts kept separate?
- Is every business-impact relationship grounded or clearly advisory?

### C. JEV.ai
- What exact decisions would JEV classify that deterministic rules cannot?
- What is the input/output schema, candidate enum, provenance binding, abstention behavior, validation, failure fallback and data minimization?
- Can classification errors or confidence accidentally become a FIX, numeric score or NDP rank?
- What documentation remains needed before provider calls? No speculative endpoints.

### D. Comparative judgment
- Does the proposed priority adjudication distinguish **importance** from **certainty**?
- How does it compare technical hygiene against conversion-path and buyer-decision alternatives without generic weights or arbitrary bans?
- Is “why this before that” traceable and honest about uncertainty?
- How are low-scoring dimensions reconciled when no action is proven?

### E. Funnel states and REI/MEC opposites
- Does REI generate supported VERIFY/FUTURE_ASSESSMENT questions when warranted **without** a forced nonempty array?
- Does MEC preserve a relevant decision-stage opportunity **without** inheriting HIGH priority from a broader TOFU topic?
- Can parent-topic priority propagate only through explicit authorized mapping and exact source ID?
- Can both pass simultaneously under one generalized contract?

### F. Trust, client projection and Snapshot parity
- Can existing trust proof coexist with unresolved proof strength/placement without declaring absence?
- Do FIX/VERIFY/KEEP counts and group membership agree?
- Are client titles bound to established failure subtype rather than broader parent taxonomy?
- Is client prose business-specific, natural, concise and useful?
- Can Snapshot compress the Executive's actual *decision* rather than mirror a technical checklist?

## Mandatory regression cases

- **Gluckstein:** Why schema versus trust/fit content after mobile performance? Explain what regulated context changes.
- **Hepburn Plumbing:** Why schema before pricing/process reassurance? Do not claim observed experience/portfolio proof is absent.
- **Jobber:** SaaS plan/trial goal and Conversion Path 50 must be explicitly reconciled with priorities led by LCP/schema/meta/headings.
- **REI:** Judge reached; verify whether useful stage-specific questions could be produced from actual persisted content rows; inspect real pass-2 output *only if confirmed retained*.
- **MEC:** Preserve stage-specific verification without unauthorized priority inheritance.

Named sites are regression fixtures, **not** rules. Include negative controls: technical-first is justified; no relevant content question so empty arrays are correct; JEV unavailable; source references missing; conflicting evidence; classifier confidently wrong; graph edge lacks authorization; legacy audit missing optional intake fields.

## Requested response format

1. **Verdict:** ACCEPT / ACCEPT WITH CHANGES / REJECT / NOT ENOUGH EVIDENCE (for proposal only).
2. **Concise architecture diagnosis:** strongest parts, highest risks, duplication/overengineering.
3. **Existing vs planned vs unknown:** exact table with clear evidence basis.
4. **Critical governance concerns:** identify source/section, violated invariant and concrete bad outcome.
5. **Proposed corrections:** changed rule, contract or component, why necessary, scope and owner.
6. **Test contract:** top positive/negative tests, expected result, fixture and critical fail conditions.
7. **Short execution strategy:** minimal safe sequence, exact checkpoints, estimated *active* hours with confidence ranges—not conventional week-based estimates without evidence.
8. **Unanswered questions:** facts needed from JEV account/docs or the active staging repo before implementing.
9. **Decision table:** MUST DECIDE NOW / CAN DEFER / SHOULD REJECT.

Critique rather than praise; preserve genuinely good existing controls. Do not generate code or claim PRYSM deployment success. If source evidence is missing, state precisely what is unknown.

## Boundaries

Discussion-only. No application code edits, shell commands against user systems, secrets review, external paid JEV/model calls, browser automation, staging alias changes, Railway/Vercel mutation, database changes or production changes without separate explicit approval.

Design top down; build bottom up. If an execution method is later frozen, follow it literally and stop on conditions outside its scope.
