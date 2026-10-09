# PRYSM Enterprise Improvement PRD (LLM handoff)

- **Version:** 1.4.3 — bounded consistency pass on v1.4.2: within-Top-3 order justification, tighter 9.3 tie/challenger validation, two new hard fails, realistic G0 handling of pre-existing CI failures, and removal of residual vote language. Preserves all v1.4.2 contracts, v1.4.1 deployment/evidence corrections and v1.3.0 Google helpful-content guidance (BS-17–BS-19, P1.8).
- **Change status:** Targeted revision of v1.4.2 (lineage: v1.3.0 baseline → v1.4.0–v1.4.2); all architecture, thresholds and process changes remain **PROPOSED**, not accepted or implemented.
- **Previous self-score:** 97/100 for v1.3.0 (not independently validated). **No score claimed for v1.4.0–v1.4.3**; independent review and contract qualification remain pending.
- **Date:** 2026-10-09
- **Owner:** Chris Kulbaba, Omnipressence
- **Status:** PROPOSED. This file is planning authority only. It authorizes no code change, deployment, provider or model call, database migration or production action.
- **Companion:** the human-facing Claude Doc "PRYSM Enterprise Improvement PRD", which uses the same IDs.
- **Application repos (one per role; not interchangeable):**
  - Source snapshot analyzed by this PRD: `chriskulbaba2025/production-prysm@c807a951e17cdaf9fb386c6f7374b66ae8fae487` (production frontend source; worker runtime identity unverified, see 0.4 and 3.1).
  - Isolated staging application (target for authorized Builder work): `chriskulbaba2025/prysm-staging-isolated` (branch and SHA established by P0.1).
- **Context repo:** `chriskulbaba2025/prysm-project-context`

---

## Revision record — v1.4.3

Bounded consistency pass on the complete v1.4.2 PRD. Areas with diminishing returns were deliberately left unchanged. No IDs renumbered; scope, site types, provider restrictions, gate meanings and production protections are unchanged.

1. **Order justification (9.3 / P1.3 / D-19 / NC-31):** each published record now justifies "why this before that" against the next published item via `belowRankComparison`, closing a gap against Section 1 item 2. Genuine order ties reuse the existing `ORDER_WITHIN_TOP3` path.
2. **Tighter 9.3 validation:** `unresolvedCouldOutrank=true` only with `materialChallenge=UNRESOLVED` (schema-enforced); `tiedWithId` validated per tie scope; canonical-ID tie-break applies to both selection branches; the strongest resolved challenger is still explained when the unresolved branch selects.
3. **Hard fails (Section 5):** HF-14 (publishing a `REVIEW_REQUIRED` or unqualified provisional Top 3) and HF-15 (PASS without indispensable artifacts, or an unsupported `G1-COMPLETE` claim).
4. **G0 realism (P0.1 / P0.2 / G0):** pre-existing failures in suites newly wired by P0.2 become listed, owner-assigned exceptions rather than silent blockers or hidden failures; P0.1 owns the receipt append-only CI check (NC-29).
5. **Cleanups:** residual "winning record" vote language removed (Sections 10–11); Phase 1 estimate totals added; BS-15 language hardcode explicitly scoped in P1.2; 7.3 marked retired; Section 13 now reviews Sections 5 and 12.

**Left alone (diminishing returns):** older revision records, hour estimates outside Phase 1, vendor/JEV research, data contracts 9.1–9.2 and 9.4–9.9 (except P0.1 ownership of the receipt CI check), and the metric targets.

All changes remain **PROPOSED**. This is not approval to build, deploy, call providers, run new audits or touch production.

## Revision record — v1.4.2

Four targeted fixes to the complete v1.4.1 PRD. Section numbering, existing ID families, site-type scope, provider restrictions, G0/G2/G3 meaning and production protections are unchanged.

1. **Material challenger selection (9.3 / D-19 / NC-25):** remove eight-dimension vote counting from selection of the strongest excluded alternative; record every eligible alternative's scoped, source-linked material challenge with a rule identifier, full pairwise comparisons and cross-reference validation. An unknown that could change the decision is not silently discarded.
2. **Honest unresolved orders (9.3 / NC-26):** stable, non-evidence-based presentation ordering for genuine ties; explicit provisional qualification or reviewer HOLD for unresolved Top 3 inclusion. Confidence is not treated as business importance.
3. **Fixture fidelity (P0.5 / P1.1 / P1.4 / Section 10):** completed reports use NDP plus rendered report; REI/MEC Judge-rejected audits use persisted topic/funnel context, Writer pass candidate and Judge verdict. No published report is demanded where none exists; missing indispensable rejected-draft artifacts remain UNKNOWN, not PASS.
4. **Two calibration acceptance levels (G1 / Sections 10–11):** `G1-BOUNDED` covers exactly listed replay fixtures and negative controls; `G1-COMPLETE` requires qualifying evidence across all five archetypes, their required authority boundaries and the applicable Adam targets. Neither gate silently lifts the production HOLD. No multiday observation requirement.

All changes remain **PROPOSED**. This is not approval to build, deploy, call providers, run new audits or touch production.

## Revision record — v1.4.1

Targeted fixes to v1.4.0 only; no IDs renumbered, no scope added.

1. **Identity:** header no longer names a single "application repo"; it separates the analyzed snapshot from the staging target. The identity receipt now has a named proposed location, writer and append-only rule (9.9).
2. **Priority authority:** defines how the strongest excluded alternative is selected without relying on the rank it justifies, and what `undecidable=true` does to ranking and client projection (9.3).
3. **Graph/JEV:** V4 now states exact per-predicate cycle rules; P1.3's no-graph fallback is a single defined path rather than "approved pre-graph context".
4. **Evidence semantics:** INV-02 reconciled with INV-20 (`NO_DATA` ≠ `UNAVAILABLE`); added an explicit legacy-coverage mapping table (9.7.1); removed the P2.3 "legacy UI mapping" escape hatch.
5. **Execution/test readiness:** "Day-30 re-audit rate" renamed to an approved-schedule metric consistent with INV-21; P2.6 deletion scope tied to stores actually integrated; Section 10 fixtures now declare artifact source and a no-artifact-no-PASS rule.

## Revision record — v1.4.0

Revised **the complete v1.3.0 supplied document**, preserving its scope, numbering, safeguards, helpful-content guidance and issue IDs unless an explicit reconciliation was required. Five coordinated corrections:

1. **Identity:** separate production/staging frontend and worker authorities; non-self-referential context manifest plus independently verified release receipt; no automatic 7/14/30-day schedule.
2. **Judgment:** complete and constrain the proposed priority JSON Schema; replace equal-dimension majority-vote logic with evidence-backed material trade-off and calibrated undecidable/VERIFY behavior.
3. **Graph/JEV:** build minimal typed graph validation before its priority consumer; prohibit OUTRANKS feedback; keep JEV shadow, statistically modest and optional.
4. **Evidence semantics:** distinguish NOT_CONNECTED, NO_DATA, UNAVAILABLE, UNKNOWN and NOT_APPLICABLE; classify YMYL sensitivity separately from REGULATED.
5. **Execution:** require durable claimable jobs before HTTP 202; avoid a duplicate queue phase; short replay-only qualification first, optional paid studies later, per-action blockers and runtime proof.

**Not a release certificate.** No application runtime, hosted JEV, paid provider, database migration or code change is authorized by the PRD. The supporting application source snapshot was used in the preceding independent audit for the client-timeout and goal-default checks; the current live worker runtime is still not certified by this document.

---

## 0. How to use this file

You are either (a) an independent reviewer asked to critique this PRD, or (b) a Builder agent asked to execute ONE approved action from Section 8. Follow these rules.

1. **Precedence.** Active `CONSTRAINTS.md` and `DECISIONS.md` entries, and explicit approvals from Chris, override this file. On conflict, stop and report `PRD CONFLICT: <PRD id> vs <governing file + heading>`.
2. **One action at a time.** Execute only the action ID you were given. Never start the next action, phase or gate yourself.
3. **Evidence labels.** Every factual statement below carries one of these labels:
   - `[CODE]`: read from application source in the snapshot archive named in 0.4.
   - `[DOC]`: stated in the context repository.
   - `[WEB]`: public vendor documentation checked on 2026-10-09.
   - `[UNVERIFIED-RUNTIME]`: not reproduced against staging. Reproduce it before you fix it.
   - `[PROPOSED]`: introduced by this PRD and still needs approval.
4. **Snapshot identity and repository roles.** Application archive `production-prysm-c807a951e17cdaf9fb386c6f7374b66ae8fae487`, context archive `prysm-project-context-7bd5055a960a71b318651c31aa81b5fdc329a8ed`. These are source snapshots, **not a unified live application**. The Oct 9 Vercel production deployment was read-only identified as `dpl_DFP22GBd7eCBz4Hk6y9pHQSgbaob` with frontend source `chriskulbaba2025/production-prysm@c807a951e17cdaf9fb386c6f7374b66ae8fae487`. The exact *running* Railway worker code was **not** verified to match it; prior Railway deployment records and service config disagree. P0.1 must independently establish both components and the domain routing. Never infer worker identity from a frontend ZIP or deployed SHA from a repository label.
5. **Context hygiene.** The context repo holds 518 files from different periods. Never treat them as simultaneously current. Read in this order: `PROJECT.md`, `CURRENT_STATE.md`, `CONSTRAINTS.md`, `DECISIONS.md`, `PRYSM_PERMANENT_MEMORY.md`, then the two 2026-10-09 proposals (`SPECS/PRYSM_JUDGMENT_CLASSIFICATION_GRAPH_JEV_ARCHITECTURE_DISCUSSION_2026-10-09.md` and `REFERENCE/PRYSM_INTAKE_INTENT_AND_ADAM_DISCUSSION_2026-10-09.md`), then this file.
6. **Unknowns.** If you cannot see an input, write `UNKNOWN` and name the missing artifact. Never guess.

---

## 1. Product definition

PRYSM is a consultant-led, evidence-governed **conversion advisor** for websites and business owners. For each audited site it must:

1. state what stops qualified visitors from converting, with traceable evidence;
2. say what to do first and **why this before that**;
3. state what is unknown, and how to find out (VERIFY);
4. on re-audit, show whether each prior finding was resolved. `[PROPOSED]`

**Seven gaps the 2026-10-09 proposals do not close** (details in Section 6):
1. a trustworthy declared goal (BS-15, BS-16);
2. real visitor data (BS-02);
3. an outcome loop (BS-03);
4. measured quality of model-written text (BS-04, BS-12);
5. operations basics (BS-01, BS-08, BS-09);
6. one source of truth for "current" (BS-07), plus CI gaps (BS-05, BS-06);
7. Google's people-first and gen-AI guidance, both for auditing client sites and for PRYSM's own published content (BS-17 to BS-19).

Non-goals:
- self-serve or white-label operation;
- new report pages;
- mobile report viewing (reports are desktop-only by design; audits still evaluate mobile visitors' experience);
- revenue or conversion forecasts;
- generic SEO checklists.

## 2. Users

| User | App role | Job | Gap this PRD closes |
|---|---|---|---|
| Consultant (Chris, Brad) | `reviewer`, `tenant_admin` | Produce and defend a specific advisory | Stored priority rationale; visitor data; review queue |
| Business owner | `viewer` | Know what to fix first and whether it worked | Re-audit comparison; plain-language VERIFY steps |
| Owner's implementer | report recipient | Fix without guessing | Metric, page, device, starting check and verification on every FIX and VERIFY |
| Platform admin | `platform_admin` | Safety, cost, uptime | Monitoring, job status, retention |

Roles `platform_admin`, `tenant_admin`, `reviewer` and `viewer` exist in `services/worker/src/identity/identity-model.js`. `[CODE]`

**Proposed client path:** Snapshot (lead magnet) → consultant call → Executive Audit (approved report architecture) → **consultant-approved action plan** → optional re-audit → plan update. A “30-day plan,” 7/14/30-day windows and day-30 re-audit are **proposals, not automatic timelines**: dates may appear only after a separately approved planning/scheduling authority establishes them. The historical G6 failure involved invented calendar timing when the canonical timing state was `UNASSIGNED`. Do not reintroduce that defect through this PRD.

---

## 3. Baseline (what exists)

| Area | Fact | Label |
|---|---|---|
| Historical staging checkpoint | 2026-10-07 T1–T3 proof reported worker 1185/1185, Vercel READY and isolated Railway SUCCESS. **Not evidence of current Oct 9 live staging or production.** | `[DOC]` historical checkpoint; `[UNVERIFIED-RUNTIME]` now |
| Web | Next.js ^15.5.24 on Vercel; Cognito login | `[CODE]` package.json |
| Worker | Node ≥20 (CI uses 22), single `src/server.js` of 1,665 lines, Railway Dockerfile, `/health` check | `[CODE]` |
| Storage | Postgres (`prysm.lifecycle_*`, `prysm.tenants`, `prysm.users`, `prysm.tenant_memberships`); S3 artifact store | `[CODE]` migrations 001–003 |
| Evidence | DataForSEO On-Page, SERP and Backlinks adapters; PageSpeed with a Lighthouse fallback; CrUX key; GA4 and Search Console clients (OAuth or service account); screenshots; conversion-path validator; sitemap footprint | `[CODE]` `src/adapters`, `src/evidence` |
| Coverage | Five states: PASS, FINDING, PARTIAL, UNAVAILABLE, NOT_APPLICABLE | `[DOC]` |
| Intelligence | Encyclopedia `registry.js`, `relationships.js`, `projection.js`, `prioritization.js`; `trust/buyer-decision-context.js`; `report/action-priority.js`; seven profile diagnostics | `[CODE]` |
| Narrative | Narrative v2 Writer and Judge on an OpenAI-compatible URL; ≤4 automatic model calls per audit, 6 absolute ceiling, cost preflight, fail-closed usage accounting; Terra default and Sol escalation routing; ~USD 2 LLM budget per audit | `[CODE]` `narrative-v2/live-binding.js`; `[DOC]` MVP spec |
| Report | Frozen pages: 1 Executive Scorecard, 2 Priority Fixes, 3 Conversion Journey, 4 Trust & Credibility, 5 Competitor Comparison, 6 Content Opportunities, 7 Supporting Detail; Snapshot v1 | `[DOC]` freeze manifest 2026-10-03 |
| Review | Append-only reviewer overrides with a required non-empty reason | `[CODE]` `audit/review-gate.js` |
| Re-audit contract | NDP accepts `priorAudit.comparisonsByFindingId`. Progress states are `RESOLVED`, `IMPROVED`, `UNCHANGED`, `REGRESSED`, `NEW`, `STILL UNKNOWN` and `VERIFIED`, gated by `authorized`, `identityComparable`, `scopeComparable`, `evidenceComparable`, `findingMappingComparable` and `priorArtifactValid` | `[CODE]` `narrative-v2/ndp-contract.js`, `ndp-producer.js` |
| Holds | Narrative v2 production freeze: HOLD. Model-bearing release gate: HOLD (Plane 1 partial PASS; Planes 2–7 pending) | `[DOC]` DECISIONS.md, AIC decision 2026-10-02 |

### 3.1 Deployment and evidence identity matrix — required before edits `[PROPOSED]`

| Boundary | Observed source on Oct 9 | What remains to establish |
|---|---|---|
| GitHub source archive | `chriskulbaba2025/production-prysm@c807a951e17cdaf9fb386c6f7374b66ae8fae487` | Source tree is not a worker-runtime attestation |
| Production Vercel frontend | Deployment `dpl_DFP22GBd7eCBz4Hk6y9pHQSgbaob`; repository and SHA above; READY as inspected | Domain alias at gate time, runtime login/health, deployment environment and configuration (without exposing secrets) |
| Production Railway worker | Multiple services and historical/removed deployments were present when inspected | Actual serving service/domain, READY/SUCCESS runtime, exact source/image digest; do **not** assume a code match |
| Isolated staging frontend and worker | Separate staging app and Railway project; old current-state documents reference earlier SHAs | Each alias, project, service, repository, branch, deployment and exact code/image SHA |
| Context repository | History includes a stale Oct 4 G6 checkpoint and Oct 9 proposals | Current reviewed context commit and dated authority without forcing same SHA across different repositories |

The identity matrix is a **baseline input**, not a product feature in itself. Differences between frontend and worker SHAs can be legitimate across distinct components; contradictions are conflicts **within the same component** or a claimed synchronized release. Keep SHA evidence in an independently timestamped, read-only verification receipt.

---

## 4. Invariants (never break)

| ID | Invariant |
|---|---|
| INV-01 | Evidence decides what PRYSM may claim. UNKNOWN, PARTIAL, UNAVAILABLE and NOT_ESTABLISHED never become absence, weakness, FIX, CREATE or prescription. |
| INV-02 | A provider success with zero usable records has source state `NO_DATA` (never `AVAILABLE` and never `UNAVAILABLE`, which means the attempt itself failed). In the lossy legacy coverage projection it maps to `UNAVAILABLE` per 9.7.1, but the typed source state is carried alongside and drives client wording. |
| INV-03 | Numeric scores are deterministic. No model, graph or classifier output changes a score. |
| INV-04 | The NDP is the sole authority for client-surface priority and synthesis. Renderers never re-rank. Snapshot and Executive share NDP meaning. |
| INV-05 | The seven-page architecture and freeze manifest stay unchanged. No new pages. Reports remain desktop-only. |
| INV-06 | Approved reports are immutable. |
| INV-07 | Tenant isolation holds on every read and write. Tenant-scoped jobs, traces and artifacts carry an authorized tenant identifier; log entries include tenant correlation **where applicable**, with no private client content, tokens, secrets or unredacted sensitive evidence. |
| INV-08 | Tests and CI make zero live paid provider or model calls. They use replay only. |
| INV-09 | Named audits (Gluckstein, Hepburn, Jobber, REI, MEC, City Media, Adam's 14) are regression fixtures only. Production logic contains no audit-ID or business-name literals. |
| INV-10 | Production is read-only without explicit authorization from Chris. |
| INV-11 | `siteStatus` rules: a missing value resolves to `live`. Staging and development keep indexability evidence, but intentional blocking is non-score-bearing. Never impute credit. |
| INV-12 | Client-facing competitor comparison covers only explicitly supplied competitors (max 3). SERP-discovered sites are opportunity evidence only. |
| INV-13 | No invented score deltas, forecasts, lead/conversion/revenue effects or causal outcome claims. This includes re-audit and GA4 trends. |
| INV-14 | Declared intake is authority for declared fields. No default goal is ever invented. A missing legacy field resolves to `NOT_DECLARED`. |
| INV-15 | Graph edges and JEV output are advisory **inputs**. Only governed, source-qualified rules may support final priority adjudication. Neither graph edges nor JEV can directly invent evidence/findings/FIX, change scores, or independently set an NDP rank; JEV shadow proposals are quarantined from authority consumers. |
| INV-16 | Model-call budget per audit: ≤4 automatic calls, 6 absolute ceiling, preflight before each call. A new model-bearing step must fit within it or get a separately approved budget. |
| INV-17 | Repairs land at the owning producer, contract or consumer boundary, never in report copy. |
| INV-18 | No internal governance jargon in client-visible text. |
| INV-19 | PRYSM never claims a client page is AI-generated, casually labels a single signal a "ranking factor", or claims that Google "penalizes" a page. Helpful-content questions are assessment lenses: become evidence-bounded VERIFY hypotheses, not default findings. A changed date with unchanged comparable content supports a date-integrity **check**, not intent or deception. |
| INV-20 | `NOT_CONNECTED` (not configured/granted), `UNAVAILABLE` (attempted but inaccessible), `NO_DATA` (query succeeded, zero usable rows), `NOT_APPLICABLE` (demonstrably irrelevant), and `UNKNOWN` (not yet assessed) remain distinct even when mapped into a legacy coverage projection. Absence of connection is not evidence of site weakness. |
| INV-21 | Timing is explicit: a 7/14/30-day window or day-30 re-audit is never published without approved schedule authority. An `UNASSIGNED` timing state stays undated. |
| INV-22 | HTTP 202 / `QUEUED` is allowed only after a durable, recoverable job has been committed. No in-process detached work as the sole execution owner. Retries reconcile uncertain provider completion before repeating billable steps. |
| INV-23 | Priority comparisons and strongest excluded alternative selection use source-linked material buyer/business consequence, **not** a vote count across eight dimensions. Genuine unresolved choices use stable *presentation* order and visible qualification or review HOLD—not confidence as a surrogate for business importance. `OUTRANKS_WITH_REASON` only records an already authorized decision. |
| INV-24 | A versioned state manifest cannot attest its own containing Git commit SHA. Context anchor, source identities and verified hosted deployments are distinct fields; the manifest commit is confirmed by an **external post-commit verification receipt**. |

## 5. Hard fails (any one blocks a gate)

| ID | Hard fail |
|---|---|
| HF-01 | Claim of absence or weakness without evidence |
| HF-02 | Fabricated corrective authority (FIX/CREATE without an authorized finding) |
| HF-03 | Priority inheritance without an authorized edge and exact source ID |
| HF-04 | Competitor analysis beyond the supplied competitors |
| HF-05 | NDP and rendered report disagree (Top 3, counts, states) |
| HF-06 | Unapproved, uncapped or CI-time paid provider or model call |
| HF-07 | Production mutation without authorization |
| HF-08 | Cross-tenant read or write |
| HF-09 | Classifier or graph output independently changes a score, authorizes FIX, or sets NDP rank |
| HF-10 | HTTP 202/QUEUED accepted without a persisted, claimable and crash-recoverable job and idempotent reconciliation |
| HF-11 | `NOT_CONNECTED` or `NO_DATA` mislabeled as `NOT_APPLICABLE` or treated as observed site failure |
| HF-12 | REGULATED alone asserted as proof of YMYL, a missing author, a trust defect, or a need for a specific corrective action |
| HF-13 | A self-referential or mismatched release manifest is presented as independent deployment-currentness proof |
| HF-14 | A Top 3 is published while any of its 9.3 records is `REVIEW_REQUIRED`, or a `QUALIFIED_PROVISIONAL` item reaches any client surface without its qualifier and settling check |
| HF-15 | A fixture, Adam target or archetype is reported PASS without its indispensable artifact (Section 10), or `G1-COMPLETE` is claimed while a required archetype or authority boundary is missing |

---

## 6. Blind spots

Sorted by severity. Every item is `[CODE]` or `[DOC]` evidence and `[UNVERIFIED-RUNTIME]` unless noted.

| ID | Sev | Finding | Evidence | Owning boundary | Action |
|---|---|---|---|---|---|
| BS-01 | High | Web create-audit client has a 5 s default request timeout, while the audit service awaits `orchestrator.execute(...)` before responding. This is a source-confirmed responsiveness/recovery **risk**, not a verified staging HTTP 500 or proof that no queue exists anywhere. Diagnose exact deployed execution path before changing it. | `lib/worker-client.ts` (`timeoutMs = 5000` default; `createAudit` passes none); `app/api/audits/route.ts` maps errors to 500; worker `server.js` `POST /api/v1/audits` → `audit-service.js` `await orchestrator.execute(...)` | Web↔worker API; orchestration | P0.3, P2.1 |
| BS-02 | High | Owned visitor data is unreachable from intake. GA4 and Search Console clients exist and support a service account, and `lib/audit-request.ts` validates `ga4PropertyId` and `gscSiteUrl`, but `app/audits/new/page.tsx` renders neither field. | files named | Intake UI; payload | P1.2, P2.3 |
| BS-03 | High | No outcome loop. The NDP consumes `priorAudit`, but no non-test code produces it. | `ndp-producer.js` lines ~155/166; no producer found | Re-audit producer | P2.5 |
| BS-04 | High | Model-written output is not measured across real reports. AIC-2 to AIC-4 changed Writer and Judge; the release gate is HOLD; no tracing or eval tooling exists in code. | AIC decision; dependencies | Eval harness | P1.1 |
| BS-05 | High | Test folders outside every runner: `trust/` (23 test files, which hold the buyer-decision context Phase 1 depends on), `report-intelligence/` (5) and `local/` (3) are referenced by no `package.json` script, gate script or workflow. | `services/worker/package.json`; `scripts/prysm-closure-gate.js`; `.github/workflows/*` | CI | P0.2 |
| BS-06 | High | The broadest workflow (`prysm-mvp-hosted-verification.yml`: npm test + Narrative v2 + whole-app + closure) only runs when `github.head_ref == 'repair/prysm-mvp-client-readiness-2026-09-21'`. `worker-ci.yml` runs on PRs and pushes to `main`; a `repair/*` branch deployed without a PR is unchecked. Installs use `npm install`, not `npm ci`. | workflow files | CI | P0.2 |
| BS-07 | High | Differing source, memory and deployed component identities are being conflated. Historical staging `PROJECT/CURRENT_STATE` and app `CLAUDE.md` mention distinct prior branches; Oct 9 inspected production Vercel source is `production-prysm@c807a951` while running Railway worker identity remains unresolved. A single unqualified current SHA would reproduce this defect. | files named | Project memory | P0.1 |
| BS-14 | High | Gate 0 inputs are absent from the package: Adam's 14 Snapshot reports and the two benchmark PDFs (AI Sales Coach; Betty competitor analysis). | Only summarized | Inputs | D-04 |
| BS-15 | High | The goal can be invented. There are five site-type-agnostic goal strings; an empty "Other" becomes `"Generate qualified enquiries"`; the schema `primaryGoal` is free text (≤256 characters). Language is hardcoded to `en-CA`. | `app/audits/new/page.tsx` (`GOAL_OPTIONS`; `primaryGoal: goal \|\| "Generate qualified enquiries"`; `language: "en-CA"`); `audit-request.schema.json` | Intake | P1.2 |
| BS-17 | High | No verified helpful-content author/reviewer/date extraction in the inspected source snapshot; REGULATED alone does not establish YMYL status. Topic sensitivity, observed author data and declared regulation require separate assessment before changing prioritization. | No matches for byline, YMYL, datePublished or dateModified in `services/worker/src`; `evidence/internal-link-opportunity.js` filters `author/` paths as utility URLs | Evidence; adjudication | P1.8 |
| BS-18 | High | Planned public Encyclopedia problem pages have no publish gate. AI-drafted pages at scale without original value match Google's description of scaled content abuse. | P3.5; Google gen-AI guidance `[WEB]` | Publishing | P3.5, D-16 |
| BS-08 | Medium | No error monitoring, structured logging or tracing library in web or worker. | both `package.json` files | Ops | P2.2 |
| BS-09 | Medium | No retention, deletion or export policy for crawled content, screenshots or analytics data. | No retention logic except the sitemap URL cap | Data governance | P2.6 |
| BS-11 | Medium | The Accessibility Readiness profile is active, but no accessibility engine is installed. | `axe-core` absent from worker dependencies | Evidence | P2.4 |
| BS-12 | Medium | Reviewer overrides (with reasons) stay per audit and are never pooled into a labelled dataset for calibration. | `audit/review-gate.js` | Review data | P1.1, P3.1 |
| BS-16 | Medium | Proposed intent taxonomy uses a "Marketplace / Directory" site type; code has `PROGRAMMATIC_SEO_DIRECTORY` (site type) and `MARKETPLACE` (modifier). | schema enums; `lib/audit-request.ts` | Intake contract | D-11, P1.2 |
| BS-19 | Medium | Nothing prevents search-engine-first advice (word-count targets, date refreshes, topic sprawl, mass page production); the Publisher profile's `content_depth` check uses word count as its evidence. | `audit/profile-engines.js` | Writer/Judge client advice | P1.5 |
| BS-10 | Low | Fixture-specific route in production code: `GET /api/v1/audits/d3b4cc62-9217-4c0b-b169-e24beb46a79c/uat-render`. Violates INV-09. | `server.js` ~line 443 | Worker API | P0.4 |
| BS-13 | Low | PRYSM's own funnel (Snapshot view → booking → Executive purchase) is not instrumented. | No event tracking found | Business analytics | P3.4 |

---

## 7. Tool register

### 7.1 Proposed by Chris (Oct 9 documents)

| ID | Proposal | Verdict | Conditions |
|---|---|---|---|
| C-01 | New Audit form in 5 groups; primary goal required, secondary/tertiary optional; target audience; business context | ADOPT WITH CHANGES | Add GA4 and Search Console fields; NOT_DECLARED for legacy; remove the invented default (BS-15) |
| C-02 | Site-type intent taxonomy | ADOPT | Versioned `intent-v1`; store IDs; reconcile site types per D-11 |
| C-03 | Reasoning chain site type → goals → intent → buyer questions → evidence → findings → recommendations | ADOPT | Buyer questions are VERIFY hypotheses only |
| C-04 | FIX / VERIFY / KEEP / WITHHOLD + funnel modes | ADOPT | Coverage, action state, stage and priority stay separate fields |
| C-05 | Pairwise priority adjudication | ADOPT (core) | Section 9.3 record at the governed owner |
| C-06 | Typed bounded graph (10 node types, 14 edges) on Postgres + JS | ADOPT WITH CHANGES | v1 implements 7 edges (9.4); the other 7 are reserved |
| C-07 | Neo4j / external graph DB | REJECT (for now) | Revisit only on measured Postgres latency or integrity limits |
| C-08 | JEV.ai classifier | ADOPT, SHADOW ONLY | After P1.1 and D-03; 9.5 contract |
| C-09 | Five archetypes + negative controls | ADOPT, EXTEND | Golden set ≥15 incl. Adam's 14 |
| C-10 | Six-question rubric | ADOPT | Golden-set scoring rubric |
| C-11 | Independent LLM architecture audit | ADOPT | Use Section 13 response format |
| C-12 | Time-boxed gates, tranches A–F | ADOPT WITH CHANGE | P1.1 precedes any adjudication promotion |
| C-13 | Autonomous Codex execution under frozen contracts | KEEP | Exit gate includes P0.2 suites |

**JEV facts `[WEB]`:**
- JEV is TypeSafe's hosted classification model. Question types are Choice (returns `choice`, `probabilities` and `confidence`), Score (returns `score`, `probabilities` and `confidence`) and Noul (returns a 0–1 probability that a statement is true).
- Several questions can go in one call and are evaluated in isolation.
- The Pipecat integration documents base URL `https://api.typesafe.ai`, a pinned default model `jev-1.13.0` (or `jev-latest`), typical latency of about 0.1 s, a 10 s default timeout, retries on HTTP 429/529, and at most 255 options per choice question.
- JEV is also available through Vercel AI Gateway as `typesafe-ai/jev`.
- **Not documented on the pages checked:** pricing, data retention, training on customer data, input-size limits, and a JS SDK.

Pin the model version; never use `jev-latest` in governed runs.

### 7.2 Recommended additions

| ID | Tool | Purpose | Closes | Action | Constraints |
|---|---|---|---|---|---|
| R-01 | `STATE.json` + independent post-commit identity receipt | Machine-readable **per-component** source/deployment matrix (9.9) | BS-07 | P0.1 | Manifest stores an earlier context anchor, not its own containing SHA; external receipt attests the manifest commit and live aliases. Written only under release authority. |
| R-02 | Durable Postgres jobs (pg-boss is a candidate, not preapproved) | Persist/claim/resume work **before** returning 202; idempotency, retries and caps | BS-01 | P0.3 minimal durable path; P2.1 hardening | Confirm compatibility and migration under D-06/D-18; no request-scoped fire-and-forget. Provider uncertainty must be reconciled, not retried blindly. |
| R-03 | Lightweight redacted local eval receipts; Langfuse optional | Baseline replay, safe model-call accounting and later tracing | BS-04, BS-12 | P1.1 local first; optional later | No hosted product or provider data transfer required for G1. Langfuse Cloud/self-host choice and DPA/privacy/cost approval occur only before its integration (D-02), not before replay-only calibration. |
| R-04 | GA4 Data API, Search Console API (existing clients) | Real traffic, key events and queries as evidence | BS-02 | P1.2 (service account), P2.3 (OAuth UI) | Service-account path exists `[CODE]`; OAuth may need Google app verification |
| R-05 | Microsoft Clarity Data Export API | Dead clicks, rage clicks, quickbacks, scroll depth, excessive scroll, script errors and error clicks by URL/device | BS-02 | P2.3 | `GET https://www.clarity.ms/export-data/api/v1/project-live-insights`; bearer token; `numOfDays` ∈ {1,2,3}; ≤3 dimensions; ≤10 requests/project/day; ≤1,000 rows, no pagination `[WEB]`. Requires daily snapshots. |
| R-06 | axe-core via Playwright | WCAG rule evidence | BS-11 | P2.4 | Playwright is already an optional dependency |
| R-07 | Playwright above-the-fold measurement | Deterministic CTA position, size, contrast and visibility at 1366×768 and 390×844 | Adam: vague CTA-obstruction evidence | P2.4 | No model |
| R-08 | Sentry | Errors and performance for web and worker, tagged with tenant/audit/request IDs | BS-08 | P2.2 | Pricing to confirm |
| R-09 | Dependabot + gitleaks | Dependency alerts; secret scanning in CI | Security | P2.7 | Free / open source |

### 7.3 (Retired)

Intentionally empty. The number is kept so existing references to 7.4 stay stable.

### 7.4 Google guidance mapping `[WEB]`

Sources: "Using generative AI content" (updated 2026-10-01) and "Creating helpful, reliable, people-first content" (updated 2026-10-05).

| ID | Google guidance | PRYSM today | Add | Action |
|---|---|---|---|---|
| G-01 | Who: bylines where expected, author background; fabricated profiles (AI headshots, made-up names, false credentials) are deceptive | Trust covers experience/credentials; no byline/author detection | Detect byline, `author`/Person markup, author and About pages, reviewer attribution (REGULATED). Suspected fabrication stays VERIFY. | P1.8 |
| G-02 | YMYL/sensitive topics call for appropriately strong credibility checks | REGULATED exists as a modifier but is not equivalent to YMYL | Classify **topic sensitivity independently** of legal/regulatory status, with evidence and review; REGULATED may additionally activate sector-specific rules. Explain what each changed, without automatic new defects or score changes. | P1.8, P1.3 |
| G-03 | Content and expertise self-assessment questions (originality, depth, insight, sourcing, headings, comparative value, accuracy, trust signals) | No question bank | Versioned VERIFY question bank linked to buyer questions | P1.8 |
| G-04 | Search-engine-first warning signs: content made mainly for search, many topics hoping some rank, extensive automation, summarizing without value, trend-chasing, word-count targeting, entering niches without expertise, unanswerable promises, date changes without substantial change, adding/removing content to seem fresh | Nothing prevents such advice | Recommendation hygiene rule in Writer and Judge | P1.5 |
| G-05 | Changing page dates to seem fresh when content hasn't substantially changed | No date or content tracking | Persist main-content hash and dates; on re-audit, VERIFY when the date moved but the hash did not | P2.5 |
| G-06 | Review titles, meta descriptions, structured data and alt text; follow structured-data policies per Search feature and validate markup | Crawled; schema advice generic (Adam: 14/14) | Schema advice only for a named eligible Search feature, with validation as its verification step | P1.5, P1.8 |
| G-07 | Page experience: look at many aspects, not one or two | PageSpeed/CrUX | Adjudication may not let one metric lead without a stated consequence (Jobber) | P1.3 |
| G-08 | AI images need IPTC `DigitalSourceType` = `TrainedAlgorithmicMedia`; AI product titles/descriptions must be specified separately and labelled in Merchant Center | Not covered | ECOMMERCE VERIFY item only; no AI-detection claim (INV-19) | P1.8 |
| G-09 | Scaled content abuse; manually fact-check all AI content before publishing; explain how automation was used | Applies to PRYSM's own Encyclopedia pages | Publish gate (P3.5) | P3.5, D-16 |
| G-10 | Give readers context on how content was created | Reports do not currently document the generation process | Consider a verified short method statement **only after** separately approving the frozen-page presentation change, and only if claimed consultant review truly occurred | D-15 |

**Vendor and infrastructure research retained from v1.3.0 (not an implementation dependency):** The earlier PRD cited pg-boss as MIT-licensed with Node/PostgreSQL compatibility requirements to confirm in the target environment; it also noted that Langfuse self-hosting involves separate web, worker, PostgreSQL, ClickHouse, Redis/Valkey and S3 components, with Railway support described as community-maintained. Those findings remain research inputs, not authorization to install either product. Use the original vendor sources in Section 14 and recheck compatibility, privacy/retention and pricing before approval.

**Not recommended:**
- Neo4j (C-07).
- Hotjar or FullStory: Clarity is free and exportable.
- A second judging LLM vendor.
- Promptfoo as the primary eval runner. OpenAI announced on 2026-03-09 that it is acquiring Promptfoo, which stays open source `[WEB]`; local replay receipts plus existing replay fixtures suffice (Langfuse remains optional under D-02).

---

## 8. Actions

Common rules for every action:
- **Entry:** the prior **applicable** gate PASS and exact per-component start SHA are in the versioned state manifest and independent receipt. A branch/worker mismatch, missing currentness evidence or approval boundary triggers STOP, not silent selection.
- **Scope:** only the named boundary and files. A diff outside them triggers STOP.
- **Exit:** targeted tests + full closure gate (with the P0.2 suites) + golden-set non-regression (from P1.1 on) + diff review.
- **Stop:** any HF; out-of-scope path; 3 failed repairs of the same root cause; or UNKNOWN evidence **required for the specific action**. Do not stop unrelated read-only qualifications merely because another fixture or benchmark is unavailable; mark it excluded/UNKNOWN and prevent unsupported PASS.
- **Owners:** Builder = Codex. Brad = OUTCOME_REVIEW for client-visible change. Chris = CLOSURE and decisions.
- **Estimates:** provisional active Builder hours, excluding human review. Confidence is high for Phase 0, medium for Phase 1, and low for Phases 2–3 (they depend on Google app verification, client access and an external pen tester). Re-estimate at every gate from actual hours.
- **Rollback:** each authorized action is bounded by a reviewable commit/flag and proof. Staging rollback must use the accepted **component-specific Vercel and Railway release identities**, not one manifest SHA. Any schema change must be additive/backward-compatible or include independently tested rollback and data-restoration steps. Never roll back production without its own approval.

### Phase 0: Baseline and safety (7.5–14.5 h, provisional active Builder time)

**P0.1 Component identity and authority manifest (1–2 h).**
- Scope: capture the **separate** source/deployment identities of isolated-staging frontend, isolated-staging worker, production frontend and actual production worker; verify GitHub source, aliases, Vercel deployment and Railway serving service without reading secrets. Add a context-repo `STATE.json` design per 9.9, an `ARCHIVE_INDEX.md` for superseded documents, and carefully correct only current app navigation instructions in `CLAUDE.md` after owner/ref verification.
- Store the context snapshot **anchor commit** and a distinct independent read-only receipt of the subsequently published manifest commit. No file may claim to contain its own full Git SHA.
- Out of scope: modifying accepted contracts, changing deployments or enforcing same SHA across different components.
- DoD: timestamped identity matrix with each runtime component verified or individually UNKNOWN, and a machine-check that rejects unsupported alias↔deployment or component↔source claims; `CURRENT_STATE.md` points to the receipt, not to a falsely shared app SHA. The context-repo CI check enforcing 9.9's append-only and non-author rules on `RECEIPTS/identity/` exists and passes NC-29 (this action owns it).
- Needs: Chris approves this documentation/configuration tranche. Owner: Builder; Chris accepts source authority.

**P0.2 CI completeness (1–2 h).**
- Scope: add `src/trust/*.test.js`, `src/report-intelligence/*.test.js` and `src/local/*.test.js` to the correct existing runner(s); make broad workflows run on relevant PRs and pushes for `repair/**` and `main`, remove stale single-branch pins, and use `npm ci` where compatible.
- DoD: suites execute under exact-head replay-only CI. Existing failures are separately reported, never hidden by changing assertions.
- Needs: P0.1.

**P0.3 Durable and responsive create-audit (4–8 h; only if risk reproduced).**
- Step 1 (read-only reproduction): inspect deployed worker create path, HTTP timing, persisted request/job evidence and failure response. Do not claim an observed 500 from source inspection alone.
- Step 2 (bounded implementation only on approval): atomically durably persist the audit request **and claimable job** before returning `202 {auditId, jobId, status:"QUEUED"}`; a persistent worker consumer claims/leases work, records progress, renews/reclaims stale leases and reuses idempotency keys. No detached in-process promise as the sole owner.
- Step 3: recover after worker termination; reconcile uncertain billable provider/model completion against persisted receipts before any retry. If deduplication cannot be established, stop for human review rather than paying twice.
- DoD: accepted HTTP 202 in ≤2 s on qualifying fixture; same audit/job for repeat submit; no lost jobs after restart; authorization and tenant isolation preserved; simulated provider-uncertain recovery has **no silent repeat call**; status polling and existing lifecycle semantics remain correct. A complete durable core is part of this action, not deferred to P2.1.
- Needs: P0.1, D-06 (if migration required), D-18. Owner: Builder; Brad reviews UI changes.

**P0.4 Remove fixture route (0.5 h).**
- Scope: remove or default-off gate the hard-coded fixture UAT route after verifying its current owner and runtime use.
- DoD: a targeted test asserts no fixture-specific audit UUID in production route matchers.

**P0.5 Gate 0 defect qualification (1–2 h, read-only).**
- Scope: classify J-01/J-02, F-01/F-02, T-01/T-02, P-01/P-02, N-01/N-02, X-01, S-01, D-01 and C-01 and relevant Adam observations as `CONFIRMED | ALREADY_FIXED | NOT_REPRODUCED | UNKNOWN | OUT_OF_SCOPE`, with exact version, artifact and owner.
- Do not run a new paid audit. If Adam's originals or benchmark PDFs are absent, mark those cases `UNKNOWN/NOT IN INITIAL SET` and request them; continue read-only qualification on available source/fixtures without pretending all cases passed. Apply Section 10's **two fixture types**: REI/MEC do not need a rendered client report when the Judge withheld publication.
- Needs: D-04 **for any case whose actual outputs are indispensable**. DoD: defensible short table accepted by Chris, including coverage count and missing fixture list.

**Gate G0:** P0.1, P0.2, P0.4 and P0.5 closed. P0.3 is either `NOT REPRODUCED`, `CONFIRMED AND REMEDIATED`, or `CONFIRMED / HOLD AWAITING AUTHORIZATION`; a confirmed-but-unrepaired job-risk **blocks a responsiveness/reliability release claim** even when the diagnostic Gate 0 is complete. CI is green at each relevant component SHA, except pre-existing failures in suites newly wired by P0.2, each listed in the P0.2 report with owner and a Chris-accepted exception (no assertion edits, no new failures; each exception blocks any release claim that depends on that suite); unresolved identities block hosted-release currentness; Chris accepts the Gate 0 table. No forced staging/production deployment or multiday observation requirement.

### Phase 1: Conversion intelligence (18–36 h core + 3–6 h optional P1.7; provisional, re-estimate per tranche)

**Non-circular implementation order (IDs retained):** P1.1 replay baseline → P1.2 intent intake (where approved) and P1.4 funnel contract (independent) → **P1.6 minimal graph/ontology** → P1.3 priority adjudication → P1.5 client projection → P1.8 topic sensitivity/helpful-content lens. P1.7 JEV shadow is **optional, parallel and never a blocker of core G1**. Graph persistence and model calls are separate later approvals.

**P1.1 Compact evaluation harness (initial 2–4 h; expanded corpus later).**
- **Initial no-paid-call qualification:** use the five named archetypes **only where their appropriate Section 10 artifacts exist** (completed-report or rejected-Judge), plus five contrasting negative controls. Freeze exact versions and determine which cannot be replayed; missing inputs are `UNKNOWN`, not synthetic substitutes. This produces `G1-BOUNDED` evidence, not a claim that every archetype passed.
- **Expansion:** include Adam's 14 and supplied benchmarks once originals are provided; set case count from actual **unique** auditable cases (do not assert that five archetypes + fourteen + five controls equals `≥15 audits` by default: controls aren't necessarily audits).
- Rubric: Context, Truth, Action authorization, Priority quality, Comparative justification, Advisory usefulness; each 1–5. Brad labels the **disputed or representative** initial cases, not necessarily every historical report in one session. Record reviewer identity and disagreements.
- Produce redacted, replayable local event records: exact input/output hashes, prompt/model versions when already known, model-call and cost receipts if present; no hosted Langfuse dependency, no client payload upload. CI uses replay only.
- **Optional live Writer/Judge baseline:** separately obtain D-13 explicit model-call authorization, budget, privacy review and candidate identity. A no-paid-call G1 qualification path may use archived approved model outputs; it cannot claim new stochastic reliability evidence.
- DoD: baseline rubric and failure matrix for **each available initial fixture**, with its artifact type, exact SHA/output versions and `UNKNOWN` listed for missing cases. A completed-report rubric item is not scored using nonexistent REI/MEC client report pages; use stage-authority/Judge criteria for those rejected cases. A future model-judge accuracy study needs a declared, sufficiently varied labelled sample; `±1 on ≥85%` is a research target, not permission to release a judge from five cases.
- Needs: P0.5 and available fixtures. D-02 is **not** required; D-08 applies only to the review time actually approved; D-13 only before paid live runs.

**P1.2 Intake and buyer intent (2–4 h).**
- Scope: `app/audits/new/page.tsx`, `lib/audit-request.ts`, `services/worker/src/contracts/audit-request.schema.json`, `application/intake-contract.js`, `application/audit-service.js`, `narrative-v2/writer-business-context.js`, `trust/buyer-decision-context.js`.
- Contract: 9.1/9.2, no invented goal. Investigate the existing `audienceScope` UI state that does not enter `buildAuditPayload`; preserve existing meaning of competitive scope. Expose GA4/GSC optional IDs without confusing `NOT_CONNECTED` with `NOT_APPLICABLE`.
- Language (BS-15): keep current `en-CA` behaviour and record the hardcode as a known limitation in the P1.2 report. A declared-language field needs its own approval and is out of scope here.
- DoD: per-field round-trip including new, legacy and not-connected cases; legacy output stable where semantics are unchanged; Writer allow-list intentional; no applicable golden-set regression.
- Needs: P1.1 (minimal available baseline), D-05, D-11.

**P1.3 Priority adjudication record (3–6 h).**
- Scope: governed priority owner (`report/action-priority.js` and NDP producer), using P1.6's **validated deterministic graph/context interface** where useful. **No-graph fallback (single defined path):** if the validated P1.6 interface is unavailable, the same adjudicator runs on canonical NDP evidence and declared intake fields only. Any 9.3 dimension that would need a graph relationship is recorded `assessment=UNKNOWN`, `reasonCode=GRAPH_UNAVAILABLE`. No other source substitutes for the graph, and no phantom edge is created. If the remaining evidence cannot settle a comparison, the 9.3 undecidable rules apply.
- Produce one 9.3 record per **actually published** Top 3 item, and explain why each outranks the strongest eligible excluded alternative (and, for each item above another published item, why it comes first) based on the stored, independently reproducible material-challenge comparisons—not an axis vote. A materially unresolved inclusion requires the `QUALIFIED_PROVISIONAL` or `REVIEW_REQUIRED` disposition in 9.3; never publish an unqualified claim of superiority. If fewer than three qualifying items exist, output only the authorized count with reason.
- Low score with no FIX triggers **reasoned explanation** and a VERIFY only where a specific, sourced check is useful; otherwise qualified `NO ACTION / UNKNOWN` is allowed.
- DoD: 100% of published priorities have rationales, and every adjacent published pair has a `belowRankComparison`; Section 9.3 rejects nonmember strongest-alternative IDs, missing pairwise records, invalid `tiedWithId` values and unexplained unresolved inclusions or orderings; the Gluckstein/Hepburn/Jobber comparisons are assessable, rubric Q4/Q5 do not regress, and Snapshot/Executive use one governed NDP ranking.
- Needs: P1.1 and P1.6 minimal graph; P1.2 only for cases depending on newly declared goals.

**P1.4 Funnel opportunity authority (2–4 h).**
- Preserve independent topic relevance, funnel stage, coverage state, priority authority and action. No forced non-empty arrays.
- Parent-topic/TOFU priority can reach a child/stage only with an explicit authorized exact-source mapping; otherwise `priority=UNASSIGNED`. Stage-specific VERIFY/FUTURE_ASSESSMENT can be useful without a corrective FIX.
- DoD: REI under-generation and MEC over-inheritance qualify on their **actual persisted topic/funnel and rejected-Judge artifacts** under the same generalized contract, plus a valid-empty negative control. If either required draft/verdict or governed topic record is unavailable, that case is `UNKNOWN/BLOCKED`, never PASS.
- Needs: P1.1 available REI/MEC evidence, or mark test BLOCKED/UNKNOWN rather than pretending it passed.

**P1.5 Client meaning and Snapshot (3–6 h).**
- “Why it matters” explains a distinct buyer/business consequence, not evidence repeated in different words. Lexical Jaccard ≥0.6 is a **triage flag**, not an automatic fail (paraphrases can be repetitive with low overlap, and legitimate short text can share tokens).
- Structured-data advice requires a named, evidence-supported purpose and competitive priority justification; no generic schema mandate. Performance priorities show `{metric, url, device, startingCheck, verification}` when actually available and explain missing detail when not.
- Keep supported strengths visible. Apply G-04 recommendation hygiene without forbidding lawful site-relevant topics merely because text is a suggestion; distinguish an unverified topic from a corrective gap.
- Source client titles from proved subtypes; FIX/VERIFY/KEEP grouping must reconcile across Executive, Problems and Snapshot; no governance jargon or “the assessment affects buyers” language.
- DoD: Section 11 Adam targets on **available** evidence plus manual review for nuanced distinctions. A missing original report cannot be counted PASS; incomplete archetype coverage permits only `G1-BOUNDED`, not `G1-COMPLETE`.
- Needs: P1.3 for ranked-output changes; independent semantic text repairs may be separately authorized.

**P1.6 Minimal typed graph core (initial 3–6 h; persistence separately estimated).**
- Start from existing Encyclopedia registry, relationship engine and provenance system. Freeze 9.4 node/predicate signatures, source scopes and deterministic validation first; add a **read-only/in-memory projection and traversal** to provide context to P1.3, with no mandatory migration.
- The `OUTRANKS_WITH_REASON` edge is **written only after** an authorized priority rationale; it cannot serve as an input proving its own ranking. All JEV candidate edges live in a separate shadow store and are ignored by authority consumers.
- Only if evidence demonstrates persistence is required: separately approve PostgreSQL `prysm.graph_edges` schema and reversible migration under D-06. Do not introduce Neo4j without a proven need.
- DoD: typed/tenant/audit-scoped edges and provenance checks pass V1–V10 (9.4), graph does not silently change decisions, and P1.3 can consume the validated interface.
- Needs: P1.1 minimal fixtures. D-06 only for persistent storage, not a read-only graph adapter.

**P1.7 JEV classifier — optional SHADOW (3–6 h after provider review).**
- A bounded `src/classifier/jev-shadow.js` adapter, pinned provider version, minimal redacted inputs, recorded responses for replay and independent shadow output (9.5).
- DoD: per-class confusion matrix, agreement and abstention, confidence calibration and confidently-wrong **counts with denominators**; zero change to canonical output. No percentage-based promotion from a tiny initial sample.
- Needs: P1.1 and D-03 privacy/terms/pricing/explicit paid-call permission. **Not** a G1 dependency.

**P1.8 Helpful-content and sensitivity lens (3–6 h).**
- Existing crawl observations may be extended with `bylinePresent`, `authorRef`, `authorPageReachable`, `aboutPageReachable`, `reviewerAttribution`, dates and main-content hash, but only when sources and scope support them.
- Define **separate** `topicSensitivity` / YMYL-relevant assessment and `regulatedStatus`. A regulated industry flag may activate relevant legal/claim caution, but never automatically proves YMYL or author absence. Non-regulated high-impact advice may need stronger evidence.
- `helpful-content-v1` questions are bounded assessment/VERIFY prompts, not content quotas. Do not infer AI authorship from a writing style. Dates changed + comparable hash unchanged → VERIFY only.
- DoD: evidence and reasons round-trip; Gluckstein documents the **specific** applicable trust/reviewer/sensitivity lens; NC-13–NC-15 plus non-regulated sensitive-topic counterexample pass.
- Needs: P1.1; P1.3 only if the approved change modifies adjudication behavior.

**Gate G1 is split by evidence coverage, not by additional days of auditing:**
- **`G1-BOUNDED` (targeted, replay-only qualification):** disclose the *exact* available fixture IDs/versions, artifact type, tested boundaries, tested negative controls, absent archetypes and denominators; use the six-question rubric only on questions actually observable in those artifacts. Aim for mean ≥4.0 and no observed dimension <3.5 in labelled, applicable cases; zero HF. Brad reviews the affected judgments and Chris may accept this *limited* result. Do not label missing fixture families PASS.
- **`G1-COMPLETE` (five-archetype calibration):** each of Gluckstein, Hepburn and Jobber has a complete-report fixture with its required NDP, source evidence and rendered outcome; REI and MEC each have qualified rejected-Judge artifacts or subsequent **equivalent** evidence that exercises both under-generation and unauthorized priority inheritance. Run the named and relevant negative controls; the six-question rubric meets its thresholds on applicable completed-report cases; all Adam targets claimed as closed are checked against their original reports, and any Adam target required for full calibration but lacking original evidence blocks `G1-COMPLETE` rather than counting as an exception. Every required five-archetype authority boundary must be independently evidenced, not merely present in a list. Brad OUTCOME_REVIEW and Chris CLOSURE are recorded. If a required archetype or an indispensable artifact is missing, status is `G1-BOUNDED`/`G1-COMPLETE HOLD`, not complete PASS.
- **Both:** no new paid call or multiday observation is required for replay evidence. Neither gate asserts population-wide model reliability, authorizes JEV promotion, changes production, or lifts the separate model-bearing production HOLD. JEV shadow and hosted Langfuse remain optional.

### Phase 2: Enterprise platform (33–61 h, provisional; P2.1 is hardening, not a second queue)

**P2.1 Durable-job operations hardening (3–6 h; P0.3 supplies the minimum safe core).**
- Add operational fairness, global/per-tenant concurrency caps, longer-horizon monitoring and throughput management to the **already durable** P0.3 job mechanism; select pg-boss only if approved.
- Keep job states operational and existing audit lifecycle states canonical. Test restart and uncertain paid-provider result reconciliation; do not blindly promise exactly-once external provider effects.
- DoD: recovery, idempotency and cost receipts remain intact under concurrent tenants and restart, with monitoring of stuck jobs. No duplicated infrastructure.
- Needs: completed P0.3 if an async queue was introduced; otherwise diagnose whether a queue is still warranted.

**P2.2 Observability (3–5 h).**
- Sentry in web and worker; JSON logs with `tenantId`, `auditId`, `executionId`, `requestId`; cost per audit (providers + LLM); failure-rate alert routed to Chris (email or Slack).
- DoD: a forced error is visible within 1 minute with all IDs; p50 and p95 audit duration are reported.

**P2.3 Owned-data connectors (8–14 h).**
- Google OAuth consent UI for GA4 and Search Console (tokens encrypted at rest).
- Clarity connector: per-client token, daily snapshot job (9.7), ≤10 requests/project/day.
- Source status follows INV-01 and INV-02.
- DoD: a GA4-connected audit shows sourced evidence on Conversion Journey; an unconnected audit carries source state `NOT_CONNECTED` and client wording driven by that state (its legacy coverage value follows 9.7.1), **not** `NOT_APPLICABLE`, and no weakness. A zero-row success stays `NO_DATA`.
- Needs: P1.2, D-09.

**P2.4 Accessibility and above-the-fold (3–6 h).**
- axe-core results become evidence `{ruleId, impact, url, nodeCount}`. CTA measurement `{url, viewport, ctaSelector, top, height, contrastRatio, visibleWithoutScroll}`.
- DoD: findings cite rule IDs and measurements; no new page.

**P2.5 Outcome loop (8–16 h).**
- A re-audit producer builds `priorAudit` exactly to the existing NDP contract (Section 3). It may set `authorized=true` only when all five comparability flags are established; otherwise the state stays `STILL UNKNOWN`.
- Plan items carry a status. GA4 trends may be displayed without causal language (INV-13).
- Freshness check (G-05): compare `mainContentHash` and dates with the prior audit; date moved + hash unchanged → VERIFY.
- DoD: re-auditing a fixture with one fixed issue marks exactly that finding `RESOLVED` and the rest `UNCHANGED`; an incomparable pair yields `STILL UNKNOWN` everywhere.

**P2.6 Data governance (6–10 h).**
- Per-tenant retention (D-07); tenant export (JSON + report HTML); deletion across Postgres, S3 and every other store actually integrated at the time (for example, a trace store only if D-02 approved one; local P1.1 eval receipts are in scope).
- Append-only user-action audit trail: login, create, review, override, approve, report view.
- DoD: a deletion test finds no residue; the trail names the approver of every report.

**P2.7 Security baseline (2–4 h + external test).**
- Dependabot, gitleaks in CI, `npm ci`, MFA for consultant accounts in Cognito, and an external tenant-isolation penetration test.
- DoD: a planted test secret fails CI; no cross-tenant read is found.

**Gate G2:** persistent-job concurrency and recovery (P0.3/P2.1 where applicable), P2.6 deletion, and P2.7 isolation tests pass; alerts and cost accounting are evidenced. Neither a hypothetical queue nor missing optional vendor connector is marked PASS.

### Phase 3: Scale (33–64 h)

- **P3.1 Review queue (6–12 h):** flags for low confidence, conflicting evidence and JEV disagreement; labelled-data export.
- **P3.2 Owner portal (16–30 h):** owner comments and marks items done, feeding P2.5. `viewer` role; desktop-only. A user marking work complete is a **claim**, not proof that site evidence changed.
- **P3.3 SSO federation (4–8 h):** SAML/OIDC through Cognito.
- **P3.4 PRYSM funnel analytics (3–6 h):** first-party events `snapshot_viewed`, `booking_clicked`, `executive_purchased` in Postgres; consent-aware.
- **P3.5 Encyclopedia links and publish gate (4–8 h):** finding type → public problem page. Publish gate per page:
  - named human author or reviewer with a real bio (Chris or Brad);
  - "How this page was made" note (AI-assisted drafting, human fact-check, data source);
  - human fact-check before publishing;
  - original value from PRYSM's anonymized aggregate findings, shown only when ≥10 audits contribute (D-16);
  - validated structured data;
  - dates change only with substantive edits;
  - no page without unique data or expert commentary.

**Gate G3:** each action's DoD is met; no HF.

---

## 9. Data contracts `[PROPOSED]`

### 9.1 Intake delta (`audit-request.schema.json`, which keeps `additionalProperties: false`)

```json
{
  "intent": {
    "type": "object",
    "additionalProperties": false,
    "required": ["taxonomyVersion", "primaryGoalId"],
    "properties": {
      "taxonomyVersion": { "const": "intent-v1" },
      "primaryGoalId":   { "type": "string", "pattern": "^(svc|ecom|saas|pub|dir|mkt)\\.[a-z_]+$" },
      "secondaryGoalId": { "type": "string", "pattern": "^(none|(svc|ecom|saas|pub|dir|mkt)\\.[a-z_]+)$", "default": "none" },
      "tertiaryGoalId":  { "type": "string", "pattern": "^(none|(svc|ecom|saas|pub|dir|mkt)\\.[a-z_]+)$", "default": "none" },
      "otherGoalText":   { "type": "string", "minLength": 3, "maxLength": 120 }
    }
  },
  "targetAudience":  { "type": "string", "minLength": 3, "maxLength": 160 },
  "businessContext": { "type": "string", "maxLength": 1000 }
}
```

Validation rules:
- `otherGoalText` is required if and only if a chosen goal ID ends in `.other`.
- Goal IDs must belong to the set allowed for the declared `siteType` (and `siteModifiers` for `mkt.*`).
- Secondary and tertiary must differ from the primary and from each other unless the value is `none`.
- `primaryGoal` (the legacy string) stays readable for legacy audits. New audits write `intent` and must not write the invented default.
- Legacy audits without `intent` resolve to `NOT_DECLARED` everywhere downstream.
- Existing `ga4.propertyId` and `gsc` blocks are reused.
- The "Competitive market scope" label rename changes no stored meaning.

### 9.2 Intent taxonomy v1 (option IDs)

| Site type (code enum) | Goal IDs |
|---|---|
| SERVICE_LEAD_GEN | `svc.generate_leads`, `svc.book_appointment`, `svc.request_quote`, `svc.call_contact`, `svc.visit_location`, `svc.other` |
| ECOMMERCE | `ecom.purchase`, `ecom.visit_location`, `ecom.subscribe`, `ecom.create_account`, `ecom.other` |
| SAAS_B2B | `saas.book_demo`, `saas.start_trial`, `saas.generate_leads`, `saas.subscribe`, `saas.download_resource`, `saas.other` |
| CONTENT_PUBLISHER | `pub.grow_readership`, `pub.newsletter_signup`, `pub.subscribe_member`, `pub.donate`, `pub.other` |
| PROGRAMMATIC_SEO_DIRECTORY | `dir.find_compare_connect`, `dir.create_listing`, `dir.create_account`, `dir.other` |
| any site type + modifier MARKETPLACE | adds `mkt.find_compare_connect`, `mkt.create_listing`, `mkt.create_account`, `mkt.purchase_book` |

The mapping of "Marketplace / Directory" is pending D-11. The `dir.*` row is an assumption to confirm.

### 9.3 PriorityRationale record (one per published Top 3 item, governed priority owner)

A priority comparison is an **auditable justification**, not a new score. It compares the selected candidate with its strongest eligible excluded alternative, while keeping evidence certainty, buyer consequence and action authorization separate. The structured dimensions are *reason categories*, not equal-weight ballot votes.

Illustrative **JSON Schema design fragment** (valid standalone schema; runtime ID and contract version subject to approved integration):

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "https://vantage-platform.io/prysm/contracts/v1/priority-rationale.schema.json",
  "type": "object",
  "additionalProperties": false,
  "required": [
    "rationaleId",
    "tenantId",
    "auditId",
    "ndpVersion",
    "rank",
    "candidateId",
    "candidateActionState",
    "strongestExcludedAlternativeId",
    "comparedAlternativeIds",
    "pairwiseComparisons",
    "alternativeSelectionRule",
    "sharedCriterion",
    "contraryEvidenceRefs",
    "limits",
    "undecidable",
    "evidenceRefs",
    "decisionBasis",
    "decidedBy",
    "createdAt"
  ],
  "properties": {
    "rationaleId": {
      "type": "string",
      "minLength": 1
    },
    "tenantId": {
      "type": "string",
      "minLength": 1
    },
    "auditId": {
      "type": "string",
      "minLength": 1
    },
    "ndpVersion": {
      "type": "string",
      "minLength": 1
    },
    "rank": {
      "type": "integer",
      "enum": [
        1,
        2,
        3
      ]
    },
    "candidateId": {
      "type": "string",
      "minLength": 1
    },
    "candidateActionState": {
      "enum": [
        "FIX",
        "VERIFY"
      ]
    },
    "strongestExcludedAlternativeId": {
      "type": [
        "string",
        "null"
      ],
      "minLength": 1
    },
    "noAlternativeReason": {
      "type": "string",
      "minLength": 5
    },
    "comparedAlternativeIds": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "string",
        "minLength": 1
      }
    },
    "pairwiseComparisons": {
      "type": "array",
      "items": {
        "$ref": "#/$defs/pairwise"
      }
    },
    "belowRankComparison": {
      "$ref": "#/$defs/pairwise",
      "description": "v1.4.3: comparison against the next-ranked published item (rank r vs r+1); see Rules"
    },
    "dimensions": {
      "$ref": "#/$defs/dimensions"
    },
    "alternativeSelectionRule": {
      "const": "alternative-selection-v2"
    },
    "sharedCriterion": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "goalId",
        "buyerQuestionId"
      ],
      "properties": {
        "goalId": {
          "type": "string",
          "minLength": 1
        },
        "buyerQuestionId": {
          "type": [
            "string",
            "null"
          ]
        }
      }
    },
    "contraryEvidenceRefs": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "string"
      }
    },
    "limits": {
      "type": "array",
      "items": {
        "type": "string",
        "maxLength": 240
      }
    },
    "undecidable": {
      "type": "boolean"
    },
    "undecidableResolution": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "tiedWithId",
        "tieScope",
        "tieBreakRule",
        "resolutionMode",
        "settlingCheck"
      ],
      "properties": {
        "tiedWithId": {
          "type": "string",
          "minLength": 1
        },
        "tieScope": {
          "enum": [
            "ORDER_WITHIN_TOP3",
            "INCLUSION_VS_EXCLUDED"
          ]
        },
        "tieBreakRule": {
          "const": "stable-order-v1"
        },
        "resolutionMode": {
          "enum": [
            "QUALIFIED_PROVISIONAL",
            "REVIEW_REQUIRED"
          ]
        },
        "settlingCheck": {
          "type": "string",
          "minLength": 12,
          "description": "Plain-language check that would settle the ordering or inclusion"
        }
      }
    },
    "evidenceRefs": {
      "type": "array",
      "minItems": 1,
      "uniqueItems": true,
      "items": {
        "type": "string",
        "minLength": 1
      }
    },
    "decisionBasis": {
      "type": "string",
      "minLength": 12,
      "description": "Material buyer-goal trade-off, grounds for selection and acknowledged uncertainty"
    },
    "decidedBy": {
      "const": "DETERMINISTIC_ADJUDICATOR"
    },
    "advisoryInputs": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "string"
      }
    },
    "createdAt": {
      "type": "string",
      "format": "date-time"
    }
  },
  "$defs": {
    "comparison": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "assessment",
        "reasonCode",
        "evidenceRefs"
      ],
      "properties": {
        "assessment": {
          "enum": [
            "CANDIDATE_STRONGER",
            "ALTERNATIVE_STRONGER",
            "EQUAL",
            "UNKNOWN"
          ]
        },
        "reasonCode": {
          "type": "string",
          "minLength": 1
        },
        "evidenceRefs": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "type": "string"
          }
        }
      }
    },
    "dimensions": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "goalRelevance",
        "decisionStageProximity",
        "siteTypeModifierRelevance",
        "directImpairment",
        "confidenceAndScope",
        "reachAndDependencies",
        "actionViability",
        "relationToOtherCandidates"
      ],
      "properties": {
        "goalRelevance": {
          "$ref": "#/$defs/comparison"
        },
        "decisionStageProximity": {
          "$ref": "#/$defs/comparison"
        },
        "siteTypeModifierRelevance": {
          "$ref": "#/$defs/comparison"
        },
        "directImpairment": {
          "$ref": "#/$defs/comparison"
        },
        "confidenceAndScope": {
          "$ref": "#/$defs/comparison"
        },
        "reachAndDependencies": {
          "$ref": "#/$defs/comparison"
        },
        "actionViability": {
          "$ref": "#/$defs/comparison"
        },
        "relationToOtherCandidates": {
          "$ref": "#/$defs/comparison"
        }
      }
    },
    "pairwise": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "alternativeId",
        "materialChallenge",
        "materialityRuleId",
        "controllingCriterion",
        "materialReason",
        "materialEvidenceRefs",
        "unresolvedCouldOutrank",
        "dimensions"
      ],
      "properties": {
        "alternativeId": {
          "type": "string",
          "minLength": 1
        },
        "materialChallenge": {
          "enum": [
            "HIGH",
            "MEDIUM",
            "LOW",
            "UNRESOLVED"
          ]
        },
        "materialityRuleId": {
          "type": "string",
          "minLength": 1
        },
        "controllingCriterion": {
          "enum": [
            "GOAL_IMPAIRMENT",
            "BUYER_DECISION",
            "ENABLING_DEPENDENCY",
            "REACH",
            "ACTION_VIABILITY",
            "OTHER"
          ]
        },
        "materialReason": {
          "type": "string",
          "minLength": 12
        },
        "materialEvidenceRefs": {
          "type": "array",
          "minItems": 1,
          "uniqueItems": true,
          "items": {
            "type": "string",
            "minLength": 1
          }
        },
        "unresolvedCouldOutrank": {
          "type": "boolean"
        },
        "dimensions": {
          "$ref": "#/$defs/dimensions"
        }
      },
      "if": {
        "properties": {
          "unresolvedCouldOutrank": {
            "const": true
          }
        },
        "required": [
          "unresolvedCouldOutrank"
        ]
      },
      "then": {
        "properties": {
          "materialChallenge": {
            "const": "UNRESOLVED"
          }
        }
      }
    }
  },
  "allOf": [
    {
      "if": {
        "properties": {
          "strongestExcludedAlternativeId": {
            "type": "null"
          }
        },
        "required": [
          "strongestExcludedAlternativeId"
        ]
      },
      "then": {
        "required": [
          "noAlternativeReason"
        ],
        "properties": {
          "comparedAlternativeIds": {
            "maxItems": 0
          },
          "pairwiseComparisons": {
            "maxItems": 0
          }
        },
        "not": {
          "required": [
            "dimensions"
          ]
        }
      },
      "else": {
        "required": [
          "dimensions"
        ],
        "not": {
          "required": [
            "noAlternativeReason"
          ]
        },
        "properties": {
          "comparedAlternativeIds": {
            "minItems": 1
          },
          "pairwiseComparisons": {
            "minItems": 1
          }
        }
      }
    },
    {
      "if": {
        "properties": {
          "undecidable": {
            "const": true
          }
        },
        "required": [
          "undecidable"
        ]
      },
      "then": {
        "required": [
          "undecidableResolution"
        ]
      },
      "else": {
        "not": {
          "required": [
            "undecidableResolution"
          ]
        }
      }
    }
  ]
}
```

Rules:
- Each factual `evidenceRefs` and `pairwiseComparisons[].materialEvidenceRefs` resolves to same-tenant, same-audit canonical evidence or the recorded evidence/coverage limitation for an authorized VERIFY. Graph similarity and JEV probability cannot substitute for evidence.
- `goalId` may be `NOT_DECLARED` for legacy records; it must not be transformed into an invented goal.
- **Frozen eligible set:** all *excluded* authorized FIX/VERIFY candidates in the same tenant, audit and `ndpVersion`, excluding candidates in the selected item's proven `DUPLICATES` equivalence class. Do not include unauthorized content opportunities. Record **every** eligible ID in `comparedAlternativeIds` (even if there is no clear business case for that alternative); `pairwiseComparisons` has exactly one record per ID.
- **Replayable comparison:** for each eligible candidate, store its evidence-referenced `materialChallenge` (`HIGH`, `MEDIUM`, `LOW`, `UNRESOLVED`), the preapproved `materialityRuleId`, one controlling business criterion, plain-language material consequence and the eight diagnostic dimension assessments. These are *auditable observations of comparison*, not equal-weight ballot votes. `HIGH` means source-established major buyer/goal impairment or enabling consequence; `MEDIUM` means source-established material but narrower consequence; `LOW` means supported but comparatively limited consequence; `UNRESOLVED` means insufficient evidence to fix material relevance. `unresolvedCouldOutrank` flags **only** a plausible unresolved contender with specific sourced reason; it is not a covert ranking weight.
- **Selecting the strongest excluded challenge (`alternative-selection-v2`):** select first among unresolved contenders with `unresolvedCouldOutrank=true` (and require `undecidable=true`), if any; otherwise select the highest challenge class in `HIGH → MEDIUM → LOW → UNRESOLVED`. In either branch, canonical candidate ID ascending is used only to choose between *equally qualified challengers*. When the unresolved branch selects and a `HIGH` or `MEDIUM` challenger also exists, `decisionBasis` must also address the highest-class resolved challenger, so the strongest proven alternative is never left unexplained. The selection is independent of published rank and of raw dimension-win counts. The audit must retain `materiality-rules-v1` definitions and exact evidence so an independent reviewer can challenge the class. The selected challenger is **the hardest alternative to justify excluding**, not proof that it deserves the published position. If there are no eligible excluded candidates, use `null`, `noAlternativeReason` and empty comparison arrays.
- **Cross-record semantic validation (mandatory, beyond JSON Schema):** frozen eligible set = set of `comparedAlternativeIds` = set of unique `pairwiseComparisons[].alternativeId`; the `strongestExcludedAlternativeId` is either null only when both sets are empty, or a member of both sets and the exact result of `alternative-selection-v2`. `dimensions` must be identical to the selected pairwise record's `dimensions`. Each record's rule ID and evidence pointers must resolve. The JSON Schema does **not** by itself prove equality between dynamic IDs/arrays: the owning adjudicator validator must enforce all these invariants and negative tests must reject a nonmember selected ID, duplicate/missing pairwise record, and ungrounded challenge class.
- **Within-Top-3 order (`belowRankComparison`, v1.4.3):** every published record that has a lower-ranked published item carries exactly one `belowRankComparison` whose `alternativeId` is that next item's `candidateId` (rank r vs r+1). It uses the same material-challenge fields and answers "why this before that" (Section 1, item 2). The last published item omits it. It is never derived from the rank it justifies or from an `OUTRANKS_WITH_REASON` edge. If the lower item plausibly outranks this one (`unresolvedCouldOutrank=true`), set `undecidable=true` with `tieScope=ORDER_WITHIN_TOP3`; the order then follows `stable-order-v1` with its qualifier.
- **Tie validation (v1.4.3):** `unresolvedCouldOutrank=true` is valid only with `materialChallenge=UNRESOLVED` (schema-enforced). For `tieScope=INCLUSION_VS_EXCLUDED`, `tiedWithId` must equal `strongestExcludedAlternativeId`. For `tieScope=ORDER_WITHIN_TOP3`, `tiedWithId` must be the `candidateId` of an adjacent published record in the same audit and `ndpVersion`, and both records must carry the same tie. If one record has both an inclusion tie and an order tie, record the inclusion tie and use `resolutionMode=REVIEW_REQUIRED`. Reject any other value.
- **Material decision authority:** the priority owner must explain in `decisionBasis` why the chosen candidate deserves current attention against the selected challenge, considering the primary goal, direct impairment, buyer decision, dependencies, actionable confidence, reach and preservation risk. A count of eight `ALTERNATIVE_STRONGER` labels or a `HIGH` challenger alone does not mechanically cause reranking. If unresolved evidence could change the inclusion/order, use `undecidable=true` or HOLD as below; never assert that PRYSM proved the better order.
- **What `undecidable=true` does:**
  - *Presentation order only:* `stable-order-v1` sorts equally authorized but genuinely tied candidates by their **canonical candidate ID ascending**, with no claim that confidence or funnel proximity makes one more important. All candidate eligibility/authorization decisions remain upstream under the NDP. This is a stable display convention, not a new priority score.
  - *Unresolved `ORDER_WITHIN_TOP3`:* `resolutionMode=QUALIFIED_PROVISIONAL` permits the existing eligible items to be shown in stable display order **only with** the NDP's human-language explanation that their relative importance was not established and a concrete `settlingCheck`.
  - *Unresolved `INCLUSION_VS_EXCLUDED`:* if both sides have valid but not decisively comparable authorization and the published choice can safely be framed as provisional, `QUALIFIED_PROVISIONAL` may show the selected item **and identify the excluded challenger as worth checking**, with the settling check. If inclusion would be misleading, violates a hard authorization rule, or cannot be defended even provisionally, set `resolutionMode=REVIEW_REQUIRED`, hold client publication and obtain a governed reviewer decision. Never silently omit a materially plausible alternative.
  - *No evidence promotion:* either mode cannot create FIX, upgrade VERIFY, alter deterministic scores, or create authority through a graph edge. `REVIEW_REQUIRED` is **not** a published Top 3; it is a stop state until separately qualified. The reviewer must not backfill unsupported evidence.
- A top-three VERIFY describes an important **check**, not a proven impairment. A low-scored dimension with no FIX is explained, but VERIFY is not fabricated to fill three slots.
- Ranking is computed upstream once by the governed priority owner. `OUTRANKS_WITH_REASON`, if materialized, records a finalized authorized rationale, never an input to itself. Snapshot and Executive project the same NDP ranking **and the same provisional qualifiers**.
- Before implementation approval, test JSON Schema draft 2020-12 validation **and** the semantic cross-record validator with positive and negative fixtures. Parsing this Markdown or the embedded schema alone does not prove execution readiness.

### 9.4 GraphEdge — typed graph proposal (persistence requires separate D-06)

The initial graph may be a versioned, **read-only projection** of existing Encyclopedia registry, NDP evidence and site/goal context. A PostgreSQL `prysm.graph_edges` table is optional until there is a demonstrated need for persistence or cross-run replay; it is not a precondition for P1.3.

Fields in the conceptual edge contract:
- `edgeId`, `tenantId`, `auditId` (both null **only** for explicitly approved global ontology vocabulary edges);
- `subjectType`, `subjectId`, `predicate`, `objectType`, `objectId`;
- `ontologyVersion="prysm-ontology-v1"`;
- `basis: OBSERVED | DECLARED | RULE_DERIVED | HYPOTHESIS`;
- `provenanceRefs[]`, `ruleId` where rule-derived, `scope={url,device,stage}`;
- `sourceState`, `createdBy: RULE_ENGINE | INTAKE`;
- `supersedes`, `createdAt`.

JEV may propose **separate shadow candidates**, not trusted graph edges. Only an explicit governed adoption process could later validate any candidate into the graph.

v1 predicates and type signatures:

| Predicate | Subject → Object | Authority boundary |
|---|---|---|
| RELEVANT_TO_GOAL | Finding \| Unknown \| Candidate → BusinessObjective | Context relevance, not a priority grant |
| ANSWERS_BUYER_QUESTION | ContentTopic \| PageRole \| EvidenceObservation → BuyerQuestion | Coverage/source-specific |
| APPLIES_AT_STAGE | BuyerQuestion \| ContentTopic \| Candidate → JourneyStage | Stage does not imply priority |
| SUPPORTED_BY | Finding \| Candidate → EvidenceObservation | Must link canonical evidence or an explicit coverage-limit record |
| CONTRADICTED_BY | Finding \| Candidate → EvidenceObservation | Retain contradictory source and scope |
| DUPLICATES | Finding → Finding; EvidenceObservation → EvidenceObservation | Dedupes only proven duplicate identity/lineage |
| OUTRANKS_WITH_REASON | Candidate → Candidate | **Output only**, requires valid approved `rationaleId`; not an input or independent rank |

Reserved for later (no consumer): DECLARED_GOAL_OF, OBSERVED_ON_PAGE, REQUIRES, SAME_DECISION_POINT, DEPENDENCY_OF, SUGGESTS_CHECK, AUTHORIZED_ACTION_FOR.

Validation (each requires a positive and negative test):
- **V1** Reject unknown predicates or ontology versions.
- **V2** Reject type-signature violations and dangling node IDs.
- **V3** `OBSERVED` needs resolvable canonical observation provenance; `RULE_DERIVED` needs rule ID plus resolvable inputs. `DECLARED` cites intake authority; `HYPOTHESIS` remains explicitly nonfactual.
- **V4** Cycle rules are per predicate, with no case-by-case judgment:
  - `OUTRANKS_WITH_REASON` (Candidate → Candidate): reject any directed cycle of any length.
  - `DUPLICATES` (same-type, symmetric): store only in canonical direction (lexically lower ID → higher ID); reject self-edges and reverse-direction edges. Treat as an equivalence class (transitive closure), so no cycle check applies.
  - `SUPPORTED_BY`, `CONTRADICTED_BY`, `RELEVANT_TO_GOAL`, `ANSWERS_BUYER_QUESTION`, `APPLIES_AT_STAGE`: each connects different node types under its V2 signature, so a single-predicate cycle cannot form. The validator asserts this (any detected cycle is a V2 signature failure), rather than relying on it silently.
- **V5** `DUPLICATES` requires overlapping lineage or exact identity, and duplicate references must not double-count canonical evidence.
- **V6** Missing relationship or page never implies a missing fact, page or business opportunity.
- **V7** No per-audit cross-tenant or cross-audit edge. Shared ontology edges cannot read private tenant data or become evidence of another audit.
- **V8** JEV shadow proposals are not in the graph returned to authority consumers; unvalidated candidate IDs are rejected.
- **V9** Stage, topic specificity, page/URL, device and owner scope are checked before any relationship traversal supports adjudication; parent-topic priority cannot inherit downstream without a separate explicit mapping.
- **V10** Derived `OUTRANKS_WITH_REASON` edges require an existing authorized rationale whose candidate/alternative IDs match and must never support their own rationale (no ranking feedback loop).

### 9.5 JEV shadow contract

A JEV.ai account is reported by the user; the effective API/terms/cost/data-handling contract remains subject to D-03. The following is an **internal conceptual adapter contract**, not an assertion of the vendor's wire format.

```json
{ "task": "PAGE_ROLE | BUYER_STAGE | INTENT_CLASS | TOPIC_STAGE_RELEVANCE",
  "ontologyVersion": "prysm-ontology-v1", "tenantId": "…", "auditId": "…", "subjectId": "…",
  "candidateClassIds": ["…"], "stateText": "approved minimal text, PII-stripped, length-capped",
  "evidenceRefs": ["…"], "providerModel": "jev-<pinned version>" }
```

Normalized response:

```json
{ "status": "CLASSIFIED | ABSTAINED | ERROR | TIMEOUT | COST_CAP | REJECTED_OUT_OF_ENUM",
  "classId": null, "probabilities": {}, "confidence": null,
  "providerModel": null, "requestId": null, "latencyMs": 0, "costUsd": null }
```

Rules:
- Only classify within supplied IDs; reject out-of-enum results. JEV's confidence describes uncertainty **about its classification**, never an observed site fact or priority magnitude.
- Classified outputs enter a **quarantined shadow ledger** with exact model version, input hash, candidate set and provenance; canonical scores, findings, NDP, FIX/VERIFY states and ranking stay **byte-identical** to the run without JEV.
- On provider error, no authorization, missing privacy clearance, timeout, cost cap or abstention, preserve existing deterministic behavior. CI uses recorded responses only; never a paid call.
- Do not introduce a direct JEV→graph authoritative edge path, a second scoring model or an extra Writer/Judge call by implication.

**Evidence for shadow promotion:** Initial small-sample metrics are **descriptive only**: report confusion counts, denominator for each ambiguous class, abstentions, false confidences and critical unsafe errors. A proposed ≥10 percentage-point improvement over the deterministic baseline and ≤2% confident errors can be considered only **after** independent labelling of a sufficiently sized and varied sample and an approved statistical/operational release gate. Five sites cannot establish a 2% error rate. Zero authority-boundary escapes is mandatory regardless of sample size. D-03 is a separate later approval; **no automatic promotion after shadow tests**.

### 9.6 Audit job states (P0.3 / P2.1)

- **Only after durable transaction success**: `POST /api/v1/audits` returns `202 {auditId, jobId, status:"QUEUED"}`. Failure to commit the job means no accepted 202; surface an accurate retryable error with idempotency handling.
- Job record: `{jobId, auditId, tenantId, idempotencyKey, attempt, status: QUEUED|RUNNING|SUCCEEDED|FAILED|CANCELLED|RECONCILIATION_REQUIRED, lastErrorCode, leaseOwner, leaseExpiresAt, startedAt, heartbeatAt, finishedAt}` (proposed).
- Worker claims job with a durable lease, records start/finish, heartbeats and resumes after lease expiry. Idempotent creation returns the same audit/job for the same authorized key.
- For external paid operations, retain provider request/receipt identity and completion evidence. On uncertain completion, go to `RECONCILIATION_REQUIRED` until it is safe to retry; do **not** claim exactly-once provider execution without evidence.
- Existing audit lifecycle remains the client-facing status authority. Job state is operational metadata only; a job retry must not retroactively mutate an approved report.
- P2.1 adds concurrency/fairness/observability hardening, not delayed existence of durable jobs.

### 9.7 Owned-data snapshots

- **GA4** (service account or OAuth): sessions, engaged sessions and key events by landing page and device class over the last 28 days `[PROPOSED window]`.
- **Search Console:** clicks, impressions, CTR and position by page and query over the last 28 days.
- **Clarity** daily row: `{tenantId, clientProjectId, dateUtc, url, device, deadClickCount, rageClickCount, quickbackClick, scrollDepth, excessiveScroll, scriptErrorCount, errorClickCount, sessions}`, with ≤2 API requests per day per project `[PROPOSED budget]`.

**Source/connection states (all three):**

| State | Meaning | Permitted conclusion |
|---|---|---|
| `NOT_CONNECTED` | No authorized/configured connection or user has not granted access | No evidence of site weakness; invite optional connection |
| `UNAVAILABLE` | Attempted, but permissions, timeout or source failure prevent usable retrieval | Name access/availability limit; no imputed weakness |
| `NO_DATA` | Successful authorized query with zero usable records within an explicit window | Record actual zero-row coverage; not a negative site finding |
| `UNKNOWN` | Source not assessed or evaluation provenance insufficient | Do not imply connection status or site health |
| `NOT_APPLICABLE` | Source is demonstrably irrelevant for this audit goal/scope | Explain non-applicability; not synonymous with unconnected |
| `AVAILABLE` | Valid source and one or more usable scoped observations | May inform reach and consequence with dated provenance |

If the existing canonical evidence enum lacks one of these connector-specific states, add a **typed connection/attempt metadata layer** (`sourceState`) and map to the current report coverage vocabulary using exactly 9.7.1. Do not silently turn `NOT_CONNECTED` or `NO_DATA` into `NOT_APPLICABLE` or a FAIL. Owned data never establishes causal conversion/revenue effects (INV-13).

#### 9.7.1 Legacy coverage mapping (contract)

The legacy coverage vocabulary (PASS, FINDING, PARTIAL, UNAVAILABLE, NOT_APPLICABLE) is lossy. The typed `sourceState` is always stored alongside the legacy value and is the only input to client wording about data sources.

| `sourceState` | Legacy coverage value | Client wording driven by | Never becomes |
|---|---|---|---|
| `NOT_CONNECTED` | `UNAVAILABLE` | `sourceState` ("not connected") | `NOT_APPLICABLE`, `FINDING`, weakness |
| `UNAVAILABLE` | `UNAVAILABLE` | `sourceState` (access/availability limit) | `FINDING`, weakness |
| `NO_DATA` | `UNAVAILABLE` | `sourceState` (query ran, zero usable rows, with window) | `AVAILABLE`, `PASS`, `NOT_APPLICABLE`, weakness |
| `UNKNOWN` | `UNAVAILABLE` | `sourceState` (not yet assessed) | any connection or health claim |
| `NOT_APPLICABLE` | `NOT_APPLICABLE` | stated reason for non-applicability | — |
| `AVAILABLE` | `PASS`, `FINDING` or `PARTIAL`, set by the check's own evidence, never by source state alone | the check result | — |

Rules:
- `NOT_APPLICABLE` is the **only** state that maps to legacy `NOT_APPLICABLE`.
- A consumer that reads only the legacy value cannot produce client wording about a source; it must read `sourceState`. A renderer that prints source wording from the legacy value alone violates this contract; if that mislabels `NOT_CONNECTED` or `NO_DATA`, it is HF-11.
- Mapping is one-way (typed → legacy). No code reconstructs `sourceState` from a legacy value.

### 9.8 Prior-audit comparison producer (P2.5)

- Fill `priorAudit` as `{comparable, reason, materialChanges[], comparisonsByFindingId: {<canonicalFindingId>: {authorized, identityComparable, scopeComparable, evidenceComparable, findingMappingComparable, priorArtifactValid, progressState}}}`.
- Use only the existing `NDP_PROGRESS_STATES`. Inputs: the approved prior audit artifact and the current audit, same tenant and canonical host.

### 9.9 `STATE.json` — component manifest plus independent release receipt

**Never encode the Git commit that contains this file inside itself.** A committed manifest may identify a pre-manifest `contextAnchorCommit`. After committing, a separate verifier records the actual manifest-containing SHA, hash and component deployment proof in an **external verification receipt**. A later manifest update does not make that receipt retroactively self-attesting.

**Receipt location, writer and integrity `[PROPOSED, approval under D-17]`:**
- **Location:** one JSON file per verification, at `RECEIPTS/identity/<checkedAt UTC, YYYYMMDDTHHMMSSZ>__<componentId>.json` in the context repo. Each receipt attests an **earlier** manifest commit, so it is never self-referential.
- **Append-only:** new files only. A CI check on the context repo rejects any commit that modifies, renames or deletes an existing file under `RECEIPTS/identity/`. A correction is a new receipt that references the one it supersedes.
- **Writer:** the verifier must not be the agent or person who authored the manifest commit being attested. Default verifier is Chris or the independent reviewer (Section 13); the Builder (Codex) never writes a receipt for its own manifest commit. `verifierIdentity` records who it was.
- **Evidence:** read-only checks only (GitHub, Vercel and Railway metadata, live alias response), with no secrets in the receipt.

Illustrative valid JSON **schema shape / null means unverified until filled by the authorized gate**, not a ready-to-publish runtime snapshot:

```json
{
  "schemaVersion": "1.1.0",
  "updatedAt": null,
  "updatedBy": null,
  "context": {
    "repo": "chriskulbaba2025/prysm-project-context",
    "contextAnchorCommit": null,
    "manifestBlobHash": null,
    "identityReceiptRef": null
  },
  "staging": {
    "frontend": {"repo": "chriskulbaba2025/prysm-staging-isolated", "branch": null, "sourceSha": null, "vercelDeploymentId": null, "alias": "https://prysm-staging-isolated.vercel.app", "verifiedAt": null, "status": "UNKNOWN"},
    "worker": {"repo": null, "branch": null, "sourceSha": null, "imageDigest": null, "railwayProjectId": null, "railwayServiceId": null, "railwayDeploymentId": null, "domain": null, "verifiedAt": null, "status": "UNKNOWN"}
  },
  "production": {
    "mode": "READ_ONLY",
    "frontend": {"repo": "chriskulbaba2025/production-prysm", "branch": null, "sourceSha": null, "vercelDeploymentId": null, "alias": "https://prysm.omnipressence.com", "verifiedAt": null, "status": "UNKNOWN"},
    "worker": {"repo": null, "branch": null, "sourceSha": null, "imageDigest": null, "railwayProjectId": null, "railwayServiceId": null, "railwayDeploymentId": null, "domain": null, "verifiedAt": null, "status": "UNKNOWN"}
  },
  "lastGate": {"id": null, "result": null, "at": null},
  "activeAction": null,
  "nextAction": null,
  "frozenContracts": [],
  "superseded": []
}
```

Required verifier receipt: `{manifestRepo, manifestCommitSha, manifestBlobHash, checkedAt, verifierIdentity, componentId, deploymentId, sourceRepo, sourceShaOrImageDigest, alias, result, evidenceRefs[]}` for **each** declared active deployment. No claim that `current STATE.sha == production SHA` or that frontend and worker come from one repo. Compare each component with its own recorded expectation and remote proof; compare across components only where a specific release pairing contract requires it.

**Status `UNKNOWN` is a real failure to establish currentness for a release gate, not a cue to invent a value.** Every staging/production mutation remains independently authorized.

---

## 10. Test contract

**Fixture artifact rule — two distinct artifact types:**
- **Completed-report fixtures — Gluckstein, Hepburn, Jobber:** require persisted declared intake, scoped canonical evidence and coverage, exact-version NDP/priorities, Judge/publication result where applicable, and the rendered Snapshot/Executive pages being evaluated. These support all **applicable** six-rubric questions and client-projection parity.
- **Rejected-Judge fixtures — REI, MEC:** require persisted site/context/intake, exact governed topic and funnel-stage coverage rows, relevant readiness/priority source IDs, the Writer candidate(s) actually submitted to the Judge (including pass 2 **only if retained**), and the Judge rejection/defect decision with version and provenance. There may be **no approved NDP client report or rendered report**, and none is required for this fixture type. Only the funnel-opportunity authority and judge-contract assertions supported by these artifacts may be scored. If the specific pass-2 candidate is unavailable, mark pass-2 wording review `UNKNOWN`; do not claim to have inspected it. A current rejected candidate and decisive Judge record are required to close that rejected-Judge scenario; absence blocks that case rather than substituting fabricated text.
- **NC-\* fixtures:** constructed or redacted replay fixtures built for each stated condition; no live client data required, but the replay artifacts and expected behavior must be committed before use.
- **No artifact, no PASS:** a fixture missing an indispensable artifact for its type is `BLOCKED/UNKNOWN`; it is neither PASS nor FAIL. Gate reports record availability **by fixture and by evaluation boundary**. Do not score a nonexistent client report as a completed report or treat a Judge rejection as an entire site-acquisition failure.
- **Gate labeling:** `G1-BOUNDED` means only the listed available tests qualified; `G1-COMPLETE` requires all five archetypes' relevant completed/rejected outputs and checks, plus applicable Adam evidence. Missing artifacts and any uncovered semantic boundary remain named exceptions, not hidden in an average.

| Fixture | Expected |
|---|---|
| Gluckstein (legal/service, REGULATED) | The 9.3 record explains schema vs trust/fit after mobile performance and names what REGULATED changes. Trust states are not collapsed. |
| Hepburn (local plumbing) | The 9.3 record justifies schema vs pricing/process reassurance; no "proof missing" claim where experience/portfolio proof is observed |
| Jobber (SaaS) | Trial/plan goal and Conversion Path 50 are reconciled with LCP/schema/meta/heading priorities, or a VERIFY is raised; no invented FIX |
| REI (large ecommerce; rejected-Judge fixture) | Stage-specific VERIFY/FUTURE_ASSESSMENT only from persisted topic rows and the actual rejected Writer candidate; an empty array is valid when no supported question exists; verify the Judge's fail-closed decision without requiring a rendered report |
| MEC (ecommerce; rejected-Judge fixture) | Rejected candidate and Judge defect show the Decision-stage opportunity retained with `priority=UNASSIGNED` unless exact source-stage-topic authority is established; no published report required |
| NC-01 technical-first is correct | A technical item stays #1 with a supported 9.3 record (material consequence plus `belowRankComparison`), not a dimension tally |
| NC-02 no relevant content question | Empty arrays; no forced items |
| NC-03 JEV unavailable | Output identical to the deterministic run |
| NC-04 source references missing | UNKNOWN; no finding |
| NC-05 conflicting evidence | Conflict surfaced; no silent choice |
| NC-06 classifier confidently wrong | Shadow log records it; output unchanged |
| NC-07 edge lacks authorization | Edge rejected (V1–V3); no inheritance |
| NC-08 legacy audit without new intake fields | `NOT_DECLARED`; byte-identical render |
| NC-09 GA4 connected, zero rows | `NO_DATA`; explicit attempted period; no site weakness; never `NOT_APPLICABLE` |
| NC-10 re-audit incomparable | `STILL UNKNOWN` for all findings |
| NC-11 cross-tenant job ID | 404; no data returned |
| NC-12 worker killed mid-audit | Durable lease/recovery and job continuity; uncertain paid provider receipt → `RECONCILIATION_REQUIRED`, never blind retry |
| NC-13 REGULATED site, author evidence not observed | Topic sensitivity assessed separately; UNKNOWN/PARTIAL author observation; VERIFY where meaningful, no missing-author claim |
| NC-14 re-audit: date changed, main-content hash unchanged | One VERIFY (G-05); no FIX |
| NC-15 page that looks AI-written | No unsupported AI-generation claim (INV-19) |
| NC-16 regulated but non-YMYL site | Regulatory context remains declared; no automatic YMYL classification or missing-expertise FIX |
| NC-17 non-regulated high-impact medical/finance page | Sensitivity assessment may qualify stronger VERIFY questions; lack of formal regulation does not suppress the lens |
| NC-18 HTTP 202 then immediate worker kill | Job remains durably claimable; request and idempotency key recover; no dropped work |
| NC-19 JEV returns high confidence on fabricated relation | Shadow only; no graph adoption, source promotion or NDP change |
| NC-20 graph rationale feedback | An OUTRANKS edge cannot be an input to its own ranking; V10 rejects cycle |
| NC-21 context state self-reference | Manifest commit recorded only in independent receipt; no self-certified SHA or false frontend/worker equality |
| NC-22 customer has no GA4 connection | `NOT_CONNECTED`; never `NOT_APPLICABLE` by default; no conversion-health conclusion |
| NC-23 declared goal unavailable in legacy audit | `NOT_DECLARED`; no inferred intent-based rank or default goal |
| NC-24 score low with no correction evidence | Transparent uncertainty and check only if useful; no forced FIX/VERIFY in Top 3 |
| NC-25 material strongest excluded challenger | Re-running `alternative-selection-v2` on every `pairwiseComparisons` record reproduces the challenger without rank or dimension voting; reject a strongest ID not in compared IDs, missing/duplicated pairwise records, and unsourced HIGH materiality; plausible UNRESOLVED challenger triggers undecidable |
| NC-26 genuinely undecidable pair | `undecidable=true`, `stable-order-v1` canonical ID presentation order, and identical NDP/Executive/Snapshot qualifiers; unresolved inclusion is explicitly `QUALIFIED_PROVISIONAL` or `REVIEW_REQUIRED` HOLD; confidence cannot silently decide; no new FIX or score change |
| NC-27 legacy coverage consumer | `NOT_CONNECTED`, `NO_DATA` and `UNKNOWN` all project to legacy `UNAVAILABLE` per 9.7.1, but each produces its own client wording from `sourceState`; only `NOT_APPLICABLE` maps to legacy `NOT_APPLICABLE` |
| NC-28 graph unavailable during P1.3 | Graph-dependent dimensions are `UNKNOWN` / `GRAPH_UNAVAILABLE`; no substitute source and no phantom edge |
| NC-29 receipt tampering | A commit that modifies or deletes an existing file under `RECEIPTS/identity/` is rejected by CI; a receipt written by the manifest's own author is rejected |
| NC-30 bounded vs complete gate | Run only Gluckstein/Hepburn available and REI/MEC missing: `G1-BOUNDED` can qualify available cases, but `G1-COMPLETE` is HOLD and missing archetype/authority boundaries are listed; adding independently evidenced rejected-Judge cases permits full five-archetype consideration |
| NC-31 Top 3 order justification | Every adjacent published pair has a `belowRankComparison`; a missing one, an `alternativeId` that is not the next published item, `unresolvedCouldOutrank=true` with a non-`UNRESOLVED` class, or a `tiedWithId` outside 9.3's rules is rejected; a plausible lower-ranked challenger yields `ORDER_WITHIN_TOP3` with identical qualifiers across NDP, Executive and Snapshot |

---

## 11. Metrics and targets

**Gate notation:** `G1` in the table means *measure on the listed applicable cases*. It qualifies as `G1-BOUNDED` only with disclosed fixtures/denominators; a `G1-COMPLETE` claim additionally requires the five-archetype and source-artifact conditions in Section 8/10. Never average missing observations into PASS.

| Metric | Baseline | Target | Gate |
|---|---|---|---|
| "Why it matters" restates evidence | 42/42 pairs (Adam, unverified) | 0 | G1 |
| Generic structured-data advice | 14/14 Snapshots | Only with a supported 9.3 record naming an eligible Search feature and its validation step (G-06) | G1 |
| Performance priorities missing diagnostics | 9/14 | 0 | G1 |
| "No additional strengths" beside high scores | 13/14 | 0 where supported strengths exist | G1 |
| Six-question rubric mean | set in P1.1 with observed **applicable** case/questions and case-type breakdown | ≥4.0 and no observed applicable dimension <3.5; completed-report questions are not scored on Judge-rejected drafts; no population-wide reliability inference | G1-BOUNDED / G1-COMPLETE |
| Published Top 3 with supported 9.3 record | unmeasured, not assumed 0% | 100% of **actually authorized published** priorities, including adjacent-order comparisons; no forced three items | G1 |
| Snapshot/Executive FIX/VERIFY/KEEP parity | not measured | 100% on applicable **completed-report** fixtures; no invented REI/MEC report | G1-BOUNDED / G1-COMPLETE |
| Create-audit response | 5 s client timeout **source-confirmed**; actual staging HTTP failure UNVERIFIED | ≤2 s HTTP 202 **after durable job commit**, idempotent and restart-recoverable | G0 if reproduced; G2 throughput |
| Completion rate (excl. crawler-blocked sites) | not measured | ≥95% | G2 |
| Median LLM cost per audit | ~USD 2 guardrail | ≤ USD 2 | G1, G2 |
| Executive audits with GA4 or GSC | 0% | ≥50% `[PROPOSED]` | after P2.3 |
| Approved re-audit completion rate (re-audits completed within the window set by approved schedule authority ÷ re-audits scheduled under that authority; no default window, per INV-21) | not measured | ≥60% `[PROPOSED]` | after P2.5 and schedule authority approval |
| p95 audit duration | not measured | Publish observed p95 with sample count; customer SLA set only after a representative measurement window chosen under D-14 (not a prerequisite to calibration) | G2 |
| Client advice breaking Google people-first guidance (G-04) | not checked | 0 on the golden set | G1 |
| Encyclopedia pages passing the publish gate | no pages yet | 100% | P3.5 |

---

## 12. Decisions

All items are **recommendations requiring approval**, not completed decisions. “MUST DECIDE NOW” means before the **specific proposed action**, not blanket authority to start all phases.

| ID | Class | Decision | Revised recommendation | Before |
|---|---|---|---|---|
| D-01 | MUST DECIDE BEFORE EXECUTION | Approve P0.1 read-only source/deployment identity and the gated phase order | Approve **discussion → explicit action authority**, not Phase 0 autonomous execution | P0.1 |
| D-04 | MUST DECIDE FOR AFFECTED CASE | Supply Adam's 14 source reports, benchmarks and complete archetype artifacts | Use available exact completed-report and rejected-Judge fixtures; absent inputs are UNKNOWN; no rendered report is required for REI/MEC rejection cases; originals required before claiming each relevant source target PASS | P0.5 / case inclusion |
| D-05 | MUST DECIDE | Target audience required for new intake; GA4/GSC optional | Approve with legacy `NOT_DECLARED` compatibility and connection-state distinctions | P1.2 |
| D-08 | CAN SCOPE NOW | Brad independent labels and time | Start with small disputed fixture set; expand to 5–10 h only if justified by observed coverage | P1.1 review |
| D-11 | MUST DECIDE | Marketplace / Directory mapping | Retain `PROGRAMMATIC_SEO_DIRECTORY` code enum and `MARKETPLACE` modifier; label separately; confirm `dir.*` goals | P1.2 |
| D-17 | MUST DECIDE FOR G0 | Which production/staging components constitute current runtime | Independently identify both frontends and workers; store separate SHAs/deployment IDs plus external receipt at the 9.9 location, written by a verifier other than the manifest author; never infer worker from production source ZIP | P0.1 |
| D-18 | MUST DECIDE FOR ASYNC | Durable execution mechanism and data migration for HTTP 202 | Approve atomic claimable job+idempotency+crash recovery **in P0.3**; P2.1 is hardening only | P0.3 |
| D-19 | MUST DECIDE FOR RANKING | Priority rationale selection rule | Approve traceable `alternative-selection-v2`, all-eligible pairwise records, adjacent-order `belowRankComparison` and semantic cross-ID/tie validation (not eight-axis voting); approve `stable-order-v1` solely for tied presentation and `QUALIFIED_PROVISIONAL` vs `REVIEW_REQUIRED` behavior for unresolved inclusion, per 9.3 | P1.3 |
| D-02 | CAN DEFER | Langfuse self-host vs cloud | Replay-only local receipts first; DPA/terms/security and explicit approval before hosted traces | Optional integration |
| D-13 | CAN DEFER | Live Writer/Judge baseline spend | No-paid-call replay first; only authorize budget/PII handling before each proposed external live run; no implied approval | Paid P1.1 extension |
| D-14 | CAN DEFER | Client-facing turnaround SLA | Publish actual durations and sample size; decide representative observation period later | G2/SLA publication |
| D-03 | CAN DEFER | JEV terms, pricing, retention, model and shadow permissions | Advisory shadow only after account/API and data terms verified; no automatic promotion | P1.7 |
| D-06 | CONDITIONAL | Postgres migrations (graph, jobs, retention, audit trail) | P0.3 durability may require a migration; minimal graph projection needs none by default; separate approval and backward-compatibility per migration | Each migration action |
| D-07 | CAN DEFER | Retention period | Suggested raw crawl/screenshots 12 months, approved reports until tenant deletion; confirm privacy/contracts first | P2.6 |
| D-09 | CAN DEFER | Clarity installation and Google data access | Optional explicit client grant, engagement terms and connection status | P2.3 |
| D-10 | CAN DEFER | Lift Narrative v2 production HOLD | Never implied by G1; separate verified full model-bearing release gate and production approval | Future production release |
| D-15 | CAN DEFER | “How this report was made” line on frozen page 7 | Requires explicit presentation migration and factually verified human review; no unearned approval claim | Report change |
| D-16 | CAN DEFER | Encyclopedia publication rules | Named human review, source-grounded original value and ≥10 contributing audits for aggregate statistics, after privacy proof | P3.5 |
| D-12 | SHOULD REJECT | Neo4j now, JEV as ranking authority, new report pages, Promptfoo as default eval | Reject for this scope | — |

## 13. Required response format (independent reviewer)

1. **Verdict per section** (3.1, 4, 5, 6, 7 including 7.4, 8, 9, 10, 11, 12): ACCEPT / ACCEPT WITH CHANGES / REJECT / INSUFFICIENT EVIDENCE; never assume implementation.
2. **Objections:** `{id, section, invariant at risk, concrete bad outcome, proposed fix, owner}`.
3. **Existing vs planned vs unknown:** a table keyed by BS/R/C/P IDs, with an evidence basis per row.
4. **Simplifications:** anything removable without losing an acceptance criterion.
5. **Test additions:** fixture, input, expected TRUE/UNKNOWN/FAIL.
6. **Estimate challenge:** per action, your active-hour range and confidence, with reasons.
7. **Unanswered questions** that block a particular action, keyed by action ID.
8. **Authority conflicts and deployment identity:** list the current repo/branch/component source and runtime evidence actually inspected, manifest self-reference risks and any mismatched dependencies.
9. **Quality of corrections:** verify no new unsupported priorities, circular graph authority, duplicated queues, missing source-state distinctions, non-replayable pairwise comparisons, unjustified Top 3 orderings, or unjustified complete-calibration claims were introduced.

Do not generate code or claim anything is implemented. Mark anything not directly evidenced as `UNKNOWN`.

---

## 14. Sources

Application files (snapshot):
- `lib/worker-client.ts`, `lib/audit-request.ts`, `app/audits/new/page.tsx`, `app/api/audits/route.ts`
- `services/worker/src/server.js`, `src/application/audit-service.js`
- `src/narrative-v2/live-binding.js`, `ndp-contract.js`, `ndp-producer.js`
- `src/audit/review-gate.js`, `src/identity/identity-model.js`
- `src/evidence/ga4-client.js`, `gsc-client.js`
- `src/contracts/audit-request.schema.json`
- `services/worker/package.json`, `scripts/prysm-closure-gate.js`
- `.github/workflows/worker-ci.yml`, `prysm-mvp-hosted-verification.yml`, `prysm-report-failure-regression.yml`
- `migrations/001–003`, `PROJECT.md`, `CURRENT_STATE.md`, `CONSTRAINTS.md`, `DECISIONS.md`, `CLAUDE.md`

Context files:
- `PRYSM_PERMANENT_MEMORY.md`
- `SPECS/PRYSM_JUDGMENT_CLASSIFICATION_GRAPH_JEV_ARCHITECTURE_DISCUSSION_2026-10-09.md`
- `REFERENCE/PRYSM_INTAKE_INTENT_AND_ADAM_DISCUSSION_2026-10-09.md`
- `REFERENCE/PRYSM_INDEPENDENT_LLM_ARCHITECTURE_AUDIT_BRIEF_2026-10-09.md`
- `PRYSM_REPORT_INTELLIGENCE_MVP_SPEC_2026-09-24.md`
- `DECISION_PRYSM_ADVISORY_INTELLIGENCE_CLOSURE_2026-10-02.md`
- `PRYSM_SEVEN_PAGE_PRESENTATION_FREEZE_MANIFEST_2026-10-03.md`
- `SPECS/Vantage_Production_PRD_v3.md`

Web (checked 2026-10-09):
- TypeSafe Jev docs: https://docs.typesafe.ai
- Pipecat JEV classifier: https://docs.pipecat.ai/api-reference/server/classifiers/jev
- Vercel, "Jev for Python engineers": https://vercel.com/blog/jev-for-python-engineers
- Microsoft Clarity Data Export API: https://learn.microsoft.com/en-us/clarity/setup-and-installation/clarity-data-export-api
- Langfuse joining ClickHouse: https://langfuse.com/blog/joining-clickhouse
- Langfuse self-hosting: https://langfuse.com/self-hosting
- OpenAI to acquire Promptfoo: https://openai.com/index/openai-to-acquire-promptfoo/
- pg-boss: https://npmjs.com/package/pg-boss
- Google, "Using generative AI content" (updated 2026-10-01): https://developers.google.com/search/docs/fundamentals/using-gen-ai-content
- Google, "Creating helpful, reliable, people-first content" (updated 2026-10-05): https://developers.google.com/search/docs/fundamentals/creating-helpful-content
