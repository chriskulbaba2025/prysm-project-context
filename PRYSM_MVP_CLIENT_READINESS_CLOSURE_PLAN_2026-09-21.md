# PRYSM MVP Client-Readiness Closure Plan — 2026-09-21

Status: ACTIVE
Execution mode: continuous governed closure
Application repository: `chriskulbaba2025/vantage-platform`
Active branch: `repair/prysm-mvp-client-readiness-2026-09-21`
Starting SHA: `af95823350d580d47027b4ad1e60e98cb08abc0f`
Authoritative audit: `6dca53ed-ae00-484c-bf77-b59c059eef51`
Production: FROZEN

Governing decision: `DECISION_PRYSM_MVP_CLIENT_READINESS_CLOSURE_2026-09-21.md`

## Outcome

Produce one exact application SHA that is genuinely launch-ready as an MVP, with the seven-page PRYSM report functioning as one coherent client product. The run auto-continues through diagnosis, repair, verification, GitHub synchronization, Vercel Preview, Railway staging, browser/report acceptance, PDF acceptance, lineage reconciliation, and independent challenge.

The run stops only at `MVP_READY_FOR_PRODUCTION_ACTIVATION`. Production activation is a separate user decision.

## Root defect hypothesis to prove or falsify

The current report has an incomplete authoritative synthesis bridge between the frozen Conversion Friction Encyclopedia and the seven-page client projection. The implementation can hydrate an Encyclopedia projection and call it AVAILABLE while accepted priority units are absent from the client-facing consumers. Downstream renderers then fall back to raw findings, capability statuses, generic narrative states, and page-specific logic.

T0 must prove the actual boundary before any source edit. Do not force priority units merely to satisfy the hypothesis.

## Observed acceptance defects that must be explained by the repair

### Encyclopedia / priority authority
- Priority Fixes renders: “No Encyclopedia priority unit with first diagnostic checks is linked to these primary actions.”
- Conversion Journey renders: “No accepted priority unit is available to support a friction card.”
- Existing integration regression proves Encyclopedia presence/mapping but does not prove accepted priority-unit production and consumption.
- Raw priority actions still appear even when Encyclopedia priority-unit linkage is empty, creating a false-PASS path against the frozen contract.

### Cross-page semantic coherence
- Executive shows numeric readiness `78/100 Moderate` alongside narrative state `WEAK` and “Material readiness problems…” without translating why those two systems differ.
- Supporting Detail says no assessed dimension is below Adequate while Executive exposes a WEAK verdict.
- Internal governance terms such as STRONG/MIDDLE/WEAK, AVAILABLE/PARTIAL, “bounded action”, “accepted priority unit”, and “recorded placement guidance” are exposed as client copy.
- Scope figures `250 pages`, `25/35 content bodies`, and `6/6 path pages` are valid separate evidence scopes but are not explained as separate programs.

### Priority confidence and materiality
- Supporting Detail labels mobile LCP High/deterministic/evidence AVAILABLE while its Priority Fix says “Some evidence — confirm before making the change.”
- “Some buyers may still have questions” is promoted to primary action despite the underlying signal being a partial buyer-question/FAQ-content observation; promotion must be justified by the frozen Encyclopedia materiality/challenge contract or downgraded.
- Material technical observations that remain in Supporting Detail need an explicit disposition explaining why they are not primary priorities.

### Buyer journey
- Current journey stage cards use crawl/page-count presence and service-label counts as proxies for buyer progression.
- A real journey must use the assessed conversion-path evidence, accepted friction evidence, relevant decision questions, and explicit limitations without implying abandonment or conversion outcomes.

### Content opportunities
- Raw/noisy crawl labels appear in client output, including labels such as “tagged by kindness inc”, “apply to work at tbk”, “4 0”, and “create”.
- Opportunity recommendations must come from verified decision-support gaps or governed Opportunity dispositions, not from unfiltered crawl labels.
- Content page recommendations must reconcile with other pages; for example existing pricing/investment proof cannot coexist with an unqualified recommendation to create pricing content without explaining the difference between presence, completeness, and placement.

### Trust
- Trust score is `75/100`, every displayed buyer trust question is PASS, and the page says no material trust gap was established. The client needs one explanation of what the score does and does not mean.
- Proof presence and proof placement must remain distinct; placement not assessed cannot be silently turned into either a strength or a defect.

### Competitor comparison
- Like-for-like comparison is violated when TBK “Service depth” is shown as `250 page(s) reviewed` while competitor cells are qualitative “Strong visible signal”.
- “Your conversion path is holding its own” appears even where the same section says relative conversion-path strength is not established.
- Client own-site fixes such as LCP/schema should not be injected into the competitor page as though competitor evidence created them.
- Competitor differences remain context only and cannot manufacture Encyclopedia findings.

### Supporting Detail
- Generic/duplicate labels such as repeated “Evidence area”, repeated conversion-path rows, and repeated technical-check rows reduce traceability.
- “Competitor review: not collected” conflicts with a rendered two-competitor comparison and must be reconciled to the actual source taxonomy.
- Large tables clip/overflow in PDF.
- The page contains legacy/deep technical sections that must be curated as supporting evidence rather than becoming a second report narrative.
- Canonical/title/meta/schema, internal-link, machine-readability, platform-risk, accessibility, and other lower-priority observations need explicit dispositions: primary, supporting, watch, evidence limitation, or out of scope.
- Machine-readability `40/100 PARTIAL` must not appear as an orphan score with no relation to the main assessment.

### Print / PDF
- Content Opportunities produces a materially blank page due to pagination/break behavior.
- Supporting Detail tables overflow the printable width.
- Print acceptance must validate page breaks, table fit, orphan headings, repeated headers/footers, and no loss of materially visible content.

### Release / launch lineage
- Current GitHub `main` is `0e4a97e68f19b974e7ef3dfdd1480cbc390d090b`.
- Starting candidate is 23 commits ahead and one commit behind main, merge base `60169bf23eec37c29683937d459d7d96f82aba73`.
- Final launch candidate cannot be declared until the main-only commit is intentionally reconciled and the complete candidate is reverified.
- Current Vercel production deployment at `0e4a97e68f19b974e7ef3dfdd1480cbc390d090b` contradicts older durable state that named `60169bf...` as current production identity; durable state is corrected, but production remains untouched.
- Railway metadata/export image-digest discrepancy remains unresolved and must be closed before staging PASS.

## Continuous execution tranches

### T0 — Exact diagnosis and authority freeze

Read-only.

1. Verify app branch/head is exactly the active closure branch and starts from `af95823350d580d47027b4ad1e60e98cb08abc0f`.
2. Load the complete authoritative Sept. 14 audit artifacts, not report prose as substitute input:
   - canonical findings;
   - scores / decision hierarchy;
   - decision evidence;
   - capability evidence;
   - conversion-path evidence;
   - report/narrative artifacts required for deterministic replay.
3. Recompute the Encyclopedia projection from the exact persisted current findings using the current candidate code.
4. Record every projected finding with:
   - ruleId;
   - canonicalProblemId;
   - scoreBearing/materiality input;
   - confidence;
   - severity;
   - evidence status;
   - scope;
   - frictionState;
   - challenge result;
   - priority-unit inclusion/exclusion reason.
5. Prove exactly why `priorityUnits` is empty or disconnected.
6. Trace accepted units through:
   `findings -> encyclopedia projection -> relationships -> challenge -> priorityUnits -> current report model -> narrative state -> seven page renderer`.
7. Trace existing `decisionHierarchy.actions` separately and prove where raw actions bypass or conflict with the Encyclopedia authority.
8. Identify exact source/test files needed for one coherent repair.
9. Verify no scoring/provider/auth/lifecycle/persistence change is required unless T0 directly proves one.

Gate: one evidenced root boundary, complete producer/contract/consumer map, no guess.

### T1 — Authoritative synthesis repair

Builder-owned.

Repair the smallest coherent boundary proven by T0.

Required architecture:
- one authoritative accepted-priority-unit view;
- no second prioritization engine;
- no raw finding promoted around the frozen Encyclopedia challenge gate;
- preserved decisionHierarchy/scoring authority where it provides materiality/rank inputs, but not used to bypass Encyclopedia acceptance;
- explicit exclusion/disposition reasons for material findings that do not become priorities;
- preserved evidence scope and uncertainty.

Add direct contract tests before proceeding.

### T2 — Seven-page client synthesis

Treat all seven pages as one output contract.

Executive Scorecard:
- numeric score/band and client narrative must be mutually understandable;
- internal narrative-state labels stay internal unless translated;
- show what is working, what is materially constraining readiness, and the accepted high-level priority units without contradiction.

Priority Fixes:
- only accepted priority units;
- one plain-language “why this is a priority” sentence;
- up to three first diagnostic checks;
- what is known vs what must be checked;
- how to verify;
- no raw-finding bypass.

Conversion Journey:
- map assessed entry/understanding/action stages using actual conversion-path evidence;
- show accepted friction at the relevant stage;
- preserve strengths;
- do not infer abandonment, conversion rate, or user behavior from structure alone.

Content Opportunities:
- only governed opportunities / verified decision-support gaps;
- filter raw crawl labels from normal client view;
- reconcile opportunity language with existing content/trust evidence;
- distinguish create / improve / place / verify.

Trust & Credibility:
- explain score/proof relationship;
- preserve proof-presence vs proof-placement distinction;
- no fabricated trust gap.

Competitor Comparison:
- like-for-like dimensions only;
- no market rank;
- no client defect created from competitor context;
- no own-site action masquerading as competitor conclusion.

Supporting Detail:
- curated supporting evidence;
- explicit disposition for non-primary material observations;
- unique evidence-area names;
- consistent source-status wording;
- technical depth available without creating a second client narrative.

### T3 — Client-language and consistency gate

Add automated regressions that fail on:
- unexplained client-facing STRONG/MIDDLE/WEAK;
- unexplained AVAILABLE/PARTIAL status strings in primary narrative;
- “bounded action” or internal Encyclopedia implementation terms in client copy;
- contradictory score/state claims;
- raw crawl-label noise in primary pages;
- competitor cells with incompatible evidence types;
- trust/content cross-page contradiction;
- source-status contradiction;
- priority confidence contradiction;
- unsupported site-wide/generalized language.

The renderer may retain technical terms in Supporting Detail when they are necessary evidence labels and are clearly explained.

### T4 — Print/PDF and responsive rendering closure

Add deterministic/visual print checks for:
- all seven report views;
- no materially blank page produced by avoidable `break-inside` behavior;
- tables fit printable width or transform to print-safe layouts;
- headings remain with following content where practical;
- no clipped columns;
- no navigation-only artifacts in print;
- repeated report identity/footer is legible;
- browser view remains unchanged or improved.

Create fresh PDFs from the exact candidate and inspect them, not only HTML snapshots.

### T5 — Full local exact-SHA verification

Run:
- targeted Encyclopedia/synthesis tests;
- renderer tests;
- seven-page false-certainty contract;
- current report-model tests;
- canonical-solution/current-consumer parity tests;
- full worker regression;
- Whole-App branch coverage gate;
- applicable clean-deploy/staging identity tests.

Run independent Verifier/Challenger after Builder PASS.

A failure auto-routes back only to the proven owning boundary. Same root: maximum three repair attempts before diagnostic reset.

### T6 — Main-line reconciliation

Before declaring a release candidate:
1. Reconcile the main-only commit `0e4a97e68f19b974e7ef3dfdd1480cbc390d090b` into the active repair lineage without force push.
2. Resolve any conflict by preserving current intended semantics, not by mechanically choosing branch sides.
3. Rerun every affected T1-T5 gate on the new exact combined SHA.
4. Freeze one final candidate SHA.

### T7 — GitHub and non-production release

1. Push exact final candidate to the active repair branch.
2. Prove local/remote equality.
3. Synchronize governance memory.
4. Deploy exact SHA to Vercel Preview.
5. Deploy exact SHA to Railway staging.
6. Verify Vercel project/team/deployment/branch/SHA.
7. Verify Railway project/environment/service/deployment/branch/SHA, actual worker startup, PostgreSQL and S3 staging connectivity.
8. Reconcile Railway image metadata/export/runtime digest mapping. Do not accept “same commit” as a substitute for image identity.

No production action.

### T8 — Real staging product acceptance

Use a real browser and authorized staging reviewer identity.

Required chain:
`login -> dashboard -> authoritative audit -> View Draft Report -> all seven report pages -> internal navigation -> cross-page links -> print/PDF -> refresh -> session continuity -> dashboard return`.

Validate:
- presentation;
- content;
- evidence integrity;
- Encyclopedia-derived priority story;
- buyer journey;
- language;
- navigation;
- responsive behavior;
- print/PDF;
- no client-facing internal diagnostics;
- no broken report links;
- no stale report artifact;
- exact audit identity.

Do not reopen passed product logic unless this chain exposes direct evidence of a real defect.

### T9 — Final independent staging challenge and launch freeze

A fresh Auditor must independently falsify:
- candidate identity;
- changed-file scope;
- Encyclopedia producer/contract/consumer closure;
- no duplicate authority;
- semantic honesty;
- cross-page consistency;
- branch coverage;
- persistence/replay;
- PDF/browser acceptance;
- Vercel identity;
- Railway runtime/digest identity;
- no TBK-specific overfit;
- no production mutation.

PASS only with zero open CRITICAL/MAJOR findings.

Then update:
- `CURRENT_STATE.md`;
- applicable decision/state files;
- efficiency metrics;
- exact candidate SHA;
- staging deployment identities;
- one exact next action: production activation.

Final state:
`MVP_READY_FOR_PRODUCTION_ACTIVATION`.

## Production activation boundary

Not part of this plan's autonomous authority.

When separately authorized, production activation must:
- promote/merge only the exact frozen candidate;
- prove GitHub main identity;
- prove Vercel production identity;
- prove Railway production worker identity;
- run minimal post-deploy smoke and exact-SHA independent check;
- preserve rollback identity.

No new product repair begins during activation. Any defect returns to a new governed repair checkpoint.
