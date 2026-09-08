# PRYSM Solution-Depth Governance

Date: 2026-09-08
Status: GOVERNED DIRECTION — ACTIVE

## Purpose

Strengthen PRYSM so the client report does not stop at identifying and prioritizing problems, but also gives credible, specific, evidence-governed guidance on how to solve them.

The existing report architecture remains intact. This is not a redesign of evidence, scoring, prioritization, Writer/Judge, or the six-primary-page information architecture.

Core rule:

**Every page should answer “what should I do here?” Priority Fixes should answer “exactly how should I do it?”**

## Problem being corrected

The current report is strong at diagnosis and prioritization, but comparatively lean on execution guidance. Many recommendations identify what should change and why it matters without enough detail on how to make the change, where it applies, what capability is required, what should happen first, and how completion should be verified.

Adding solution text everywhere without controls would create duplication, contradictory advice, generic best-practice filler, false precision under PARTIAL evidence, unclear ownership, poor sequencing, and report bloat.

## Canonical solution architecture

One actionable problem must map to one canonical solution record.

Other pages may summarize or reference that record, but must not independently invent a competing fix.

The canonical set covers all actionable findings. Priority Fixes may display only the top client-prominent subset. Canonical coverage and page display are not the same thing.

## Canonical solution record

Each canonical record must include:

1. Issue ID
2. Merged-from references, where multiple findings describe the same underlying issue
3. Problem
4. Why it matters
5. What to change
6. How to fix it
7. Where it applies
8. Capability required
9. Effort band
10. Sequence / dependency
11. Implementation check — mandatory and binary
12. Outcome signal — optional and only when a defensible baseline exists
13. Disposition — fix now / fix later / accept / investigate
14. Evidence grade
15. Site-specific artifact anchor

## Evidence-governed emission gate

Evidence qualification is not a disclaimer appended after a recommendation. It governs what kind of recommendation may be emitted.

- CONFIRMED: prescriptive fix is allowed when supported by a site-specific artifact.
- PARTIAL: only a conditional fix is allowed. The recommendation must state the condition or uncertainty that must be resolved.
- UNKNOWN: the recommendation is investigation or validation, not a prescriptive fix.

A recommendation may never imply more certainty than the evidence supports.

## Site-specificity gate

Every prescriptive or conditional “What to change” must anchor to an actual site-specific artifact where the evidence supports one, such as:

- URL
- page or template
- actual heading
- actual copy string
- observed CTA
- observed missing element
- component or journey-stage location
- persisted evidence reference

No site-specific anchor means no prescriptive solution record. The disposition must instead be investigate, accept, or otherwise appropriately bounded.

## Capability rule

Do not assign recommendations to assumed client job titles or organizational roles.

Use capability required, such as:

- copy
- content strategy
- UX / design
- front-end development
- technical SEO
- analytics
- subject-matter input

The client decides which person or vendor owns that capability.

## Effort and sequencing

Every actionable canonical record must carry a bounded effort band suitable for planning. At minimum distinguish work such as:

- copy edit / configuration
- page or template change
- design / front-end build
- larger build / cross-system change

Dependencies plus effort and governed priority feed one global sequence plan. Individual records may not independently claim to be “first” outside that plan.

## Verification rule

Implementation verification and business outcome measurement are separate.

Implementation check:
- mandatory
- binary
- directly tied to the recommended change
- examples: target copy is present, CTA exists, form friction is reduced to the specified state, missing element is now present

Outcome signal:
- optional
- must not be presented as a promised result
- only emitted when a defensible baseline and measurement path exist

## Dedupe / merge rule

Canonical records must deduplicate overlapping findings using an issue identity based on the underlying location / scope and failure mode.

Where multiple findings map to one underlying issue, merge them into one canonical record and preserve the source finding references in `merged-from`.

## Disposition rule

Not every finding becomes a fix.

Allowed dispositions:

- FIX_NOW
- FIX_LATER
- ACCEPT
- INVESTIGATE

The report should explicitly identify areas where the client should not spend time or money when the evidence supports acceptance or deprioritization.

## Page ownership

### Executive Scorecard

Show only the top actions and expected decision impact. No deep implementation manual.

### Priority Fixes

Own the canonical client-facing solution detail for the highest-priority displayed issues. This is the main “how to solve it” page.

### Conversion Journey

Show stage-specific remedy summaries and reference the matching canonical issue. Do not create independent solutions.

### Content Opportunities

Explain what content to create or improve, where it belongs, who/buyer-stage it supports, and what decision it helps. Reuse canonical issue identity where overlapping.

### Competitor Comparison

Show improvement implications only. Do not duplicate a full action plan.

### Trust & Credibility

Show exact trust improvements, referencing canonical issues where the work overlaps with Priority Fixes.

### Supporting Detail

Hold deeper implementation evidence, technical context, evidence limitations, and verification detail where useful. Do not turn it back into a raw audit dump.

## Report-level artifacts

PRYSM must produce:

1. a global sequence plan derived from governed priority, dependency, and effort; and
2. a client-prominence/display rule that limits how much solution detail appears on primary pages without deleting canonical solution records.

Do not impose an arbitrary hard cap that discards valid actionable findings. Cap prominence, not canonical traceability.

## Generation-time validators

The solution contract must be enforceable. Validator rules must exist before the generator is considered complete.

Minimum required assertions:

- every actionable prescriptive/conditional record has a site-specific anchor;
- prescription strength is consistent with evidence grade;
- every actionable record has a binary implementation check;
- UNKNOWN evidence cannot emit a prescriptive fix;
- PARTIAL evidence cannot emit an unqualified fix;
- canonical issue IDs are unique after merge/dedupe;
- page-level references resolve to a canonical issue;
- page summaries do not create orphaned or contradictory solutions;
- global sequence plan contains only eligible actionable records;
- outcome signals require a baseline/measurement path;
- accepted or investigated findings are not rendered as active fixes.

## Mandatory Betty real-progress gate

The project-wide Betty rule in `PRYSM_BETTY_REAL_PROGRESS_GATE.md` is mandatory for this tranche.

After every implementation tranche and before governance advances:

1. Builder/Codex completes the authorized implementation and proof artifact.
2. Betty independently checks actual code, git diff, tests, and governed requirements.
3. Governance may advance only when Betty returns:

`REAL PROGRESS VERIFIED — READY TO ADVANCE`

A Builder/Codex PASS or proof artifact is not sufficient by itself.

If Betty returns `PROGRESS NOT VERIFIED — [exact reason]`, the current tranche remains open and must be repaired/reverified before any next implementation phase begins.

Betty verification is mandatory after validator implementation, generator implementation, canonical integration, renderer/cross-page reference implementation, Supporting Detail changes, full regression/fireproofing, and the final human-review candidate before production promotion.

## First implementation phase

Before generator or renderer changes, run a Solution Coverage Audit against the accepted TBK report and current governed data model.

For each actionable finding, assess at minimum:

- current problem statement
- current solution guidance
- site-specific artifact anchor present? yes/no
- evidence grade
- prescription strength allowed by evidence? yes/no
- binary implementation check present? yes/no
- capability required identifiable?
- effort band derivable without invention?
- dependency / sequencing issue?
- duplicate / merge candidate?
- current disposition
- pages where the issue appears
- risk of conflicting or orphaned advice

The audit must identify the exact model, validator, generator, renderer, and test seams required before code is changed.

## Preservation constraints

Do not change during the audit phase:

- audit evidence collection
- evidence grades
- scoring
- priority order
- Client Truth
- Writer/Judge facts
- lifecycle semantics
- persistence contracts
- existing production report
- six-primary-page architecture
- Supporting Detail status as subordinate, not Page 7

No production deploy or audit rerun is authorized by this governance document alone.
