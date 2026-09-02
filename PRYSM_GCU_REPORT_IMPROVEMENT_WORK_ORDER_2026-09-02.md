# PRYSM GCU Report Improvement Work Order

Date: 2026-09-02
Status: GOVERNED DESIGN / EXECUTION READY FOR P0 DIAGNOSIS
Execution agent: Codex
Governance protocol: `governed-coding-upgrade` v2.4.0
Application: `chriskulbaba2025/vantage-platform`
Governance: `chriskulbaba2025/prysm-project-context`
Baseline application main at work-order freeze: `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`

## 1. Purpose

Turn the September 1 TBK report/team review into a bounded, evidence-first PRYSM improvement program.

This is not one large report rewrite.

The team review contains three different kinds of requests that must not be conflated:

1. **Client-report improvements** — language, structure, actionability, visual polish, definitions, affected URLs, and removal of internal implementation vocabulary.
2. **Potential upstream defects/design gaps** — page selection/deep-content coverage, competitor qualification, entity/schema mapping, contradictory downstream interpretations, and rendered-content/location acquisition.
3. **Future product capabilities** — consultant suppress/confirm/annotate controls and visual rendered-state detection.

GCU requires each material change to be diagnosed, bounded, proven, and audited rather than implemented from assumption.

## 2. Source requirements

Primary team-review source:

`Copy of Based on Last Successful Report for TBK — September 1st.pdf`

The review's central product principle is adopted as the design test for client-facing PRYSM output:

> An observation is not yet intelligence.

Where evidence permits, client-facing material should progress through:

`what was found -> where -> why it matters -> what to do -> how to verify`

Where evidence does not permit a conclusion, client-facing material should progress through:

`what cannot be determined -> what is missing -> how to obtain/enable it -> what additional insight would then become possible`

This principle does not authorize unsupported inference. Evidence-integrity boundaries remain controlling.

## 3. Protected invariants

Codex must preserve these unless a later explicit governed decision supersedes them:

- missing/unavailable/partial evidence is not a negative finding;
- do not manufacture certainty to improve usability;
- ranked Priority Fix architecture remains a core strength;
- material recommendations remain evidence-grounded;
- unsupported causal/revenue/market/compliance claims remain prohibited;
- explicit limitations remain visible;
- underlying canonical evidence remains immutable;
- technical observations do not automatically become client findings;
- consultant-facing polish may suppress irrelevant presentation only through a separately governed future control; it must never rewrite underlying evidence;
- n8n is not a second report-generation source of truth;
- normal lifecycle, storage, auth, scoring, Writer/Judge gates, and provider behavior are protected unless direct evidence proves the current workstream causally requires a change.

## 4. GCU execution contract for every workstream

Every workstream follows this exact sequence:

1. **Preflight / repository truth**
   - verify repo root, branch, exact HEAD, working tree, remote identity, governing files, and current authorization;
   - preserve pre-existing work;
   - do not reset/clean/discard unrelated user state.
2. **Requirement Preservation**
   - record original requested outcome;
   - faithful governed interpretation;
   - explicit exclusions/non-goals;
   - observable acceptance condition.
3. **Diagnostic Evidence Gate**
   - classify as `VERIFIED_ROOT_CAUSE`, `VERIFIED_DESIGN_GAP`, or `UNRESOLVED`;
   - use the shortest high-information read-only diagnostic;
   - no production-code edit while a material cause/design gap is `UNRESOLVED`.
4. **Surgical Change Determinacy Gate**
   - freeze a GCU Surgical Change Contract;
   - state causal boundary, expected change surface, protected surface, structural change budget, proof plan, branch impact, and reopen conditions.
5. **Change Tier + Release Intent**
   - declare `T1_LOCAL`, `T2_BOUNDARY`, `T3_SYSTEM`, or `T4_RELEASE` from actual diagnosed scope;
   - default release intent for implementation tranches is `CHANGE_ONLY` until the owner explicitly advances it.
6. **Acceptance/Test Area freeze**
   - direct defect/design-gap proof;
   - positive real-path proof;
   - negative/fail-closed proof;
   - contract-at-handoff proof when applicable;
   - branch-complete assembled-system proof when applicable;
   - model-bearing proof when applicable.
7. **Bounded implementation**
   - change only the causally justified surface;
   - new material boundary => stop and reopen diagnosis/determinacy.
8. **Narrow proof first**
   - prove the actual issue is fixed once;
   - do not repeatedly broaden tests before direct proof.
9. **Causal Necessity Audit**
   - every materially changed boundary must be traceable to a frozen requirement.
10. **Branch-complete assembled-system proof**
    - required affected/adjacent production branches must be mapped and executed;
    - no `UNMAPPED`, `UNEXECUTED`, or materially `UNKNOWN` required branch permits PASS.
11. **Full exact-candidate verification**
    - applicable regression, build/static/machine/release checks, exact-head and tree-state checks.
12. **Model-Bearing Release Gate when applicable**
    - required when prompts/model-bearing narrative behavior materially changes;
    - no paid/model execution without applicable owner authorization.
13. **Independent exact-candidate audit**
    - challenge scope, branch completeness, false-PASS seams, persistence/consumer continuity, evidence integrity, and protected invariants.
14. **Close or reopen**
    - zero open CRITICAL/MAJOR findings for PASS;
    - if candidate content changes after proof, stale proof must rerun;
    - after three failed same-root repair attempts, require diagnostic reset before another repair.

## 5. Workstream sequence

The sequence below is mandatory because later report intelligence depends on earlier evidence truth.

### P0 — Deep-content/page-selection evidence trace

Type: DIAGNOSTIC FIRST; no edit authorized until root cause/design gap is verified.

Team symptom:
- large crawl but partial body-content return;
- utility/legacy URLs appearing in client-facing samples;
- concern that modern commercial pages may be underrepresented;
- apparently generic downstream content recommendations may be reasoning from a weak sample.

Required trace for the controlled TBK evidence set:

`discovered/crawled URLs -> candidate URLs -> selected deep-content URLs -> body requested -> body returned/unavailable -> page class/selection reason -> downstream modules consuming each page`

Must verify:
- must-have commercial page selection behavior;
- representative-selection behavior;
- utility/legacy exclusion/classification;
- deep-content request alignment with selected URLs;
- page-to-body identity integrity;
- failed retrieval preserved as unavailable/partial rather than substituted;
- partial evidence constrains downstream conclusions correctly.

P0 acceptance artifact:

`Selected URL | selection reason | page class | body requested | body returned/status | downstream modules`

P0 exit:
- `PASS / VERIFIED_ROOT_CAUSE / VERIFIED_DESIGN_GAP / UNRESOLVED`;
- no P3 prompt/content-strategy tuning until P0 establishes that the relevant downstream content model is receiving the intended pages.

### P1 — Cross-report contradiction integrity

Goal:
A client must not receive materially opposing conclusions from different sections unless the report explicitly explains that the sections measure different constructs.

Primary examples to trace:
- conversion-path clarity vs unclear next-step language;
- offer clarity vs conversion-path clarity;
- buyer-question coverage;
- trust/proof;
- mobile usability;
- SEO/indexability.

Diagnostic question:
Determine whether contradictions come from:
- multiple consumers re-deriving state independently;
- different underlying measures whose distinction is not explained;
- stale/incorrect projection;
- Writer/Narrative inconsistency;
- or another verified cause.

Acceptance:
- one authoritative interpretation lineage for every material cross-report assertion;
- no material contradiction in controlled replay;
- when constructs legitimately differ, the report explicitly distinguishes them.

### P2 — Client Intelligence Output Contract

Goal:
Every material client recommendation uses a standard professional-intelligence contract where evidence allows.

Required fields/answers:
- What is wrong / what condition was observed?
- Where is it?
- Why does it matter?
- What should the client do?
- How is completion verified?

Additional rules:
- affected URLs must be shown/listed/exportable when PRYSM actually has them;
- a score should include a ranked improvement path where supported;
- PASS must explain the pass criterion rather than display a bare status;
- internal implementation vocabulary must not leak when a plain client explanation exists.

Acceptance:
Controlled report review confirms material recommendations answer the five questions or explicitly state which answer cannot be established from evidence.

### P3 — Topical Map / Strategic Content Intelligence

Dependency: P0 PASS or verified upstream correction first.

Goal:
Move from generic content suggestions to site-specific strategic content intelligence.

For each governed content opportunity, aim to provide when supported:
- topic/question;
- why the business needs it;
- current evidence/existing content;
- gap;
- recommended page/content asset;
- where it belongs;
- service/commercial objective supported;
- suggested internal links;
- funnel stage;
- priority.

Preserve:
`Awareness -> Consideration -> Decision` framing where it remains valid.

Model-bearing rule:
If production prompts/model behavior are changed, the PRYSM/GCU Model-Bearing Release Gate is mandatory before production-readiness claims.

### P4 — Competitor qualification

Goal:
Improve competitor/comparator input quality before benchmark prose is changed.

Diagnostic/desired qualification factors:
- service/business similarity;
- geographic relevance;
- customer/audience similarity;
- actual commercial overlap.

Where confidence is insufficient, prefer a bounded comparator/confirmation state rather than silently asserting competitor status.

Future consultant confirm/reject control is P8; P4 must not implement P8 by scope creep.

Acceptance:
Known non-competitors from the controlled review are not silently promoted to qualified competitors under the verified qualification contract.

### P5 — Structured data/entity evidence verification

Goal:
Verify what PRYSM actually detects and what client-facing entity/schema information is produced.

Investigate before copy changes:
- whether `json_ld` is being surfaced as if it were a schema/entity type;
- which actual schema types are available in evidence;
- why location/market evidence can be reported unavailable when visible site information may exist;
- whether rendered/include/component content reaches the relevant evidence boundary.

Client-facing language when actual types exist should distinguish technical code names from human labels, for example human-readable `Local Business`, `FAQ Page`, `case studies` unless displaying schema code intentionally.

No copy patch may conceal an upstream mapping defect.

### P6 — Make unavailable/partial evidence useful

Goal:
Preserve uncertainty while turning it into an actionable data roadmap.

Standard client pattern:
- what could not be determined;
- why;
- what information/source is required;
- how to enable/collect it;
- what additional insight PRYSM could then provide.

Apply especially to:
- Accessibility & Mobile Usability;
- Evidence Appendix;
- Deferred & Unavailable Analysis;
- field/real-user performance evidence.

Acceptance:
Unavailable/partial states remain truthful and no longer end as unexplained dead ends when an enabling path is known.

### P7 — Performance and technical client-language cleanup

Goal:
Keep sections within their professional purpose and make technical evidence interpretable.

Performance requirements:
- human-scale precision (for example seconds and bounded decimals rather than raw floating-point output);
- define LCP, CLS, TBT in plain language;
- remove unrelated repeated SEO/heading/security findings from Performance when not performance findings;
- translate internal provider/runtime failures into client-safe availability language while retaining technical diagnostics internally;
- keep lab performance distinct from real-user/field performance.

Technical SEO requirements:
- show affected URLs when evidence has them;
- explain pass criteria;
- use client-oriented status language;
- preserve the intended content order:
  1. Direct technical verdict
  2. Is anything blocking search performance?
  3. Evaluated-page technical health
  4. SEO Coverage Matrix
  5. Material findings
  6. Server & security headers
  7. Secondary observations

### P8 — Consultant review/override controls

Status: FUTURE PRODUCT CAPABILITY — DESIGN ONLY in this package unless separately authorized.

Desired future controls:
- suppress an irrelevant client-facing signal;
- mark URL utility/non-commercial;
- confirm/reject a competitor;
- elevate/deprioritize a recommendation;
- add a professional note.

Hard invariant:
Underlying evidence remains unchanged and the presentation override is auditable.

Do not implement P8 incidentally while fixing current report output.

### P9 — Workflow diagrams / UI presentation polish

Goal:
Improve visual clarity of useful workflow/relationship diagrams without changing their analytical meaning.

Acceptance:
- no truncation/overlap in controlled report;
- labels remain readable;
- deterministic visuals remain reproducible and evidence-driven;
- no AI image generation for deterministic charts/relationship diagrams.

### P10 — General copy and naming normalization

Goal:
Remove internal/system/developer language that does not help a client while preserving governance underneath.

Accepted examples from team review include:
- `What the site already does well`;
- standardize `What Is Already Working`;
- simplify verbose action labels where meaning is preserved;
- `Competitor Benchmarking`;
- `Internal Link Opportunities`;
- grammar agreement for singular/plural observed signals;
- remove raw syntax such as camelCase/internal identifiers from ordinary client prose;
- avoid bare `FINDING` if a clearer client status is defined under P2.

P10 must not be used to mask unresolved P0/P1/P4/P5 defects.

## 6. Open capability questions — diagnostic backlog, not assumptions

These questions remain unresolved until independently investigated:

### Visual/rendered-state detection
Can current PRYSM reliably detect failed sliders/carousels, missing images, visual overlap, broken rendered states, invisible/offscreen controls, or JavaScript components that fail after load?

If not, record as a future visual-rendering capability gap. Do not claim current detection.

### Rendered/includes/content extraction
Can current evidence acquisition reliably extract location/business information rendered via includes, components, templates, and JavaScript?

Trace the actual production acquisition path before changing client wording.

### Platform-specific implementation guidance
Can PRYSM reliably know enough about CMS/hosting/CDN context to give platform-specific JSON-LD or response-header instructions?

If not, keep implementation guidance bounded and do not overstate platform knowledge.

## 7. Current 16-page report: collated team changes

This is a requirements index, not a direct edit list.

1. **Executive Scorecard** — simplify internal evidence vocabulary; standardize strengths language; remove redundant action wording.
2. **Priority Fixes** — verify GBP/address facts before correction; replace internal-feeling statuses; investigate broken visual capability separately.
3. **Conversion Path Architecture** — resolve contradiction lineage; improve diagram presentation.
4. **Conversion Readiness Map** — explain Offer vs Conversion Path distinction; reduce internal limitation language.
5. **Topical Map** — make recommendations business/site-specific and materially more actionable; P0 dependency.
6. **Competitor Benchmark** — rename to Competitor Benchmarking; improve competitor qualification before prose.
7. **Trust & E-E-A-T** — grammar/syntax cleanup; improve visual presentation; simplify governance language without weakening evidence boundaries.
8. **CMS & Platform Constraints** — do not imply platform-specific implementation facts until platform/hosting evidence supports them.
9. **Technical SEO Hygiene** — use requested section order; connect issues to pages; explain pass criteria; reduce internal explanatory boilerplate.
10. **Heading & Semantic Structure** — avoid utility-page noise; explain why selected pages matter; preserve raw heading counts as evidence, not conclusion.
11. **Schema & Entity Clarity** — investigate type mapping/location evidence; explain technical terms; improve score-to-action path.
12. **Performance** — define acronyms, humanize values, remove duplicated non-performance findings, hide raw implementation/provider errors, preserve lab-vs-field distinction.
13. **Accessibility & Mobile Usability** — unavailable states must explain what is missing and how future assessment becomes possible.
14. **Internal Link Opportunities** — normalize title; do not imply a weakly linked page is commercially important without supporting evidence.
15. **Evidence Appendix** — progressive human-readable summary first; technical/governance detail second/expandable where feasible.
16. **Deferred & Unavailable Analysis** — retain, but explain what is required to gain each missing insight in future.

## 8. Branch and combined-candidate proof

Codex must reconcile affected production branches for each implementing tranche using the existing PRYSM Whole-App Branch Coverage governance.

When multiple report-improvement tranches are combined:

- individual tranche PASS is not final product PASS;
- rerun assembled-system branch-complete proof on the final combined exact candidate;
- rerun applicable full regression/machine/build gates;
- rerun applicable Model-Bearing Release proof if any combined change is model-bearing;
- independently audit the final combined candidate, not only the latest diff.

## 9. Cost and production safety

Without new explicit owner authorization, Codex must not:

- start a new paid production audit;
- call paid providers merely to test presentation changes;
- invoke paid Writer/Judge/model runs merely to tune wording;
- deploy;
- change production configuration;
- merge to `main`;
- overwrite persisted production evidence/report artifacts.

Use frozen/local/offline replay and deterministic fixtures first.

When a model-bearing tranche reaches the point where real model proof is mandatory, stop at the authorization boundary and report exactly what calls/proof are required.

## 10. Codex durable evidence per tranche

For each tranche create/update durable evidence sufficient to resume from repository truth, including:

- Requirement Preservation record;
- Diagnostic Evidence record;
- Surgical Change Contract;
- affected Branch Coverage Matrix entries;
- targeted/direct proof;
- exact-candidate assembled-system/full verification evidence;
- Model-Bearing Release evidence when applicable;
- Independent Audit result;
- exact next action/status in PRYSM authoritative state.

Do not rely on chat memory as the execution ledger.

## 11. Exact first action

**P0 only. No code change.**

Codex must recover the exact current local application state and produce the P0 deep-content/page-selection evidence trace from authoritative code/artifacts/fixtures.

P0 must answer why the controlled TBK report received the selected deep-content sample and which downstream modules consumed it.

Do not proceed to report rewriting until P0 is classified and its acceptance artifact is produced.
