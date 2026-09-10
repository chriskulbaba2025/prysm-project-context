# PRYSM Canonical Remediation Authority Closure — Diagnosis Checkpoint

Date: 2026-09-09
Status: READY_FOR_IMPLEMENTATION

## Application baseline
- Repository: `chriskulbaba2025/vantage-platform`
- Branch: `review/prysm-solution-directive-authority-betty`
- Starting SHA: `ed671bbd50ef836b10c77917e3a78b95963188fc`
- Diagnosis mode: READ-ONLY / Terra High
- Working tree: verified clean; no application files changed during diagnosis.

## Governing invariant

**Canonical solutions are the only client-facing remediation authority.**

Priority Fixes may own complete canonical remedy detail. Other pages may contain safe evidence/context or bounded summaries/references tied to an existing canonical solution ID. They may not serialize independent instructions, recommendations, checklists, or implied fixes.

## Diagnosis result

`RESULT: READY_FOR_IMPLEMENTATION`

The prior Writer narrative leak remains closed at `ed671bbd...`, but the active deterministic renderer still contains multiple independent remediation surfaces. The diagnosis traced the final HTML composition and found the remaining defect class is renderer-owned rather than authority/provider/Writer/Judge/persistence-owned.

## Active surfaces classified

### Preserve as canonical
- Executive Scorecard: bounded canonical summaries/references from the first eligible canonical records.
- Priority Fixes: sole full-detail canonical remediation owner.
- Supporting Detail canonical action summary / MEASURE where directly derived from canonical records.

### Preserve as safe context
- assessed path status, counts, evidence limitations, observed strengths, neutral diagnostic/evidence detail;
- competitor observations and bounded limitations when non-prescriptive;
- content coverage/buyer-stage context when non-prescriptive;
- trust evidence and limitations when non-prescriptive;
- performance metrics/coverage/limitations when non-prescriptive;
- technical/foundation/CMS/machine-readiness/evidence sections when diagnostic only.

### Confirmed competing remediation to remove or replace
- Conversion Journey hard-coded improvement/advisory copy not tied to canonical IDs.
- Competitor recommendation/advisory output including `gap.recommendation`.
- Content Opportunities action framing including recommended asset and imperative journey-connection instructions; current broad content canonical lookup is not a safe per-idea binding.
- Trust & Credibility independent “What to check or improve first” action list.
- Performance legacy Finding `businessImpact` / `recommendation` under client-facing action output.
- Schema/entity recommended candidate types and prioritization guidance.
- Supporting Detail foundation “resolve alongside these actions” independent action grouping.
- Internal-link “Implementation-Ready Recommendations” and link-addition/action table.
- Any evidence-roadmap text that crosses from evidence limitation into site-change instruction.

### Dormant future re-entry risk
`render-report-v2.js` still contains obsolete legacy remedy helpers and narrative-layer/viewer/CSS residue that are not active today but could reintroduce non-canonical remediation if reused. The diagnosis recommends removing obsolete renderer-only remedy paths/residue within the same bounded closure.

## Selected architecture

Use a canonical-only client serialization boundary inside the existing deterministic renderer modules:
- Priority Fixes remains the sole complete remedy surface.
- Other pages may render safe evidence/context or bounded canonical summaries/references with the same stable `solutionId`.
- Independent deterministic recommendations/actions/checklists are removed or rewritten as neutral context.
- No new canonical authority is invented for competitor/content/schema/internal-link ideas.
- Dormant renderer-only remedy paths are removed where safely unused.

## Exact production repair boundary

1. `services/worker/src/report/render-report-v2.js`
2. `services/worker/src/report/report-detail-sections.js`

No production-path, authority/provider/generator, scoring/evidence, Writer/Judge, lifecycle, persistence, report-content, or configuration change is currently proven necessary.

## Test boundary

Directly affected tests may include:
- `services/worker/src/report/render-report-v2.test.js`
- nearest report-detail renderer tests
- `services/worker/src/application/narrative-v2-production-path.test.js`
- nearest viewer/page architecture test only where directly required.

Permanent invariant coverage must prove:
- with `canonicalSolutions` fixed, mutating Writer remedy fields cannot change client HTML;
- mutating legacy Finding `recommendation`, `businessImpact`, `verificationMethod`, `affectedUrls`, competitor/content/internal-link action fields, and other discovered non-canonical remedy inputs cannot change client remediation;
- every remaining client action-like surface is either canonical full detail or a canonical summary/reference tied to the same stable solution ID;
- identified independent phrases/headings/action structures are absent;
- malformed/missing canonical authority fails closed and never falls back to legacy remedy prose;
- canonical order, IDs, evidence grades, prescription modes, site anchors, dispositions, and PARTIAL/UNKNOWN semantics remain unchanged;
- six primary pages plus Supporting Detail remain unchanged;
- persisted Writer/Judge artifacts remain internal and preserved.

Keyword scans may support discovery but are insufficient by themselves. Structural/semantic invariance tests are required.

## Critical implementation caution

Do not solve authority closure by simply deleting useful content indiscriminately. Preserve neutral evidence/context and canonical references so pages remain useful. After the consolidated repair, a browser-rendered human review using persisted production-shaped inputs is mandatory before release advancement.

## Separate queued blind spots — not part of this repair
- Static authority registry currently defaults supported entries to `PARTIAL / CONDITIONAL / FIX_LATER`; diagnose separately after renderer closure.
- Exact per-finding URL/count scope is not present in canonical records; do not restore legacy `affectedUrls` as authority.
- Future canonical authority for schema/content/internal-link opportunity records, if desired, requires its own governed data/authority tranche.

## Hard stops
No merge to application main, deploy, production promotion, release provider/model execution, production audit rerun, production artifact mutation, or broader report redesign in this tranche.

## Exact next action

Starting from application SHA `ed671bbd50ef836b10c77917e3a78b95963188fc`, use **Terra High** to implement one consolidated renderer-only remediation-authority closure across the two exact production files, add permanent invariant tests, run full comparable regressions, publish one bounded review candidate, then run a separate adversarial preflight before external Betty.
