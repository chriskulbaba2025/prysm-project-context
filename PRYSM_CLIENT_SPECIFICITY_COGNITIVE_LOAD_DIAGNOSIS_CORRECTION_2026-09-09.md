# PRYSM Client Specificity & Cognitive Load — Diagnosis Correction

Date: 2026-09-09
Application candidate: `61f43682ec425a0708064386c8bde18d94d7f8ca`
Branch: `review/prysm-solution-directive-authority-betty`

## Result
The uploaded Client Specificity & Cognitive Load diagnosis correctly identifies several bounded presentation repairs, but its single BLOCKED conclusion is rejected after exact-SHA source verification.

## Rejected blocker
The diagnosis claimed `render-narrative-v2.js` visibly renders `WriterOutput.actionPlan` as a competing client-facing action plan.

Exact source at `61f43682ec425a0708064386c8bde18d94d7f8ca` proves otherwise:
- `actionPlanNarrativeSection(writerOutput)` is included only inside `deeperNarrative`;
- `deeperNarrative` is rendered only inside `<div id="narrative-diagnostic-layer" ... hidden aria-hidden="true">`;
- CSS enforces `.narrative-diagnostic-layer { display:none !important; }`.

Therefore WriterOutput.actionPlan is diagnostic-only in the current render and is not a visible competing client remedy source. No production-source change to `render-narrative-v2.js` is required for this human-facing repair tranche.

## Accepted remaining repairs
1. Priority Fix card repeats canonical `problem` as both card title and “What needs attention”. Remove the presentation duplicate only.
2. Current 15-rule canonical `howToFix` copy is sufficiently practical for this tranche; no provider/authority repair is required.
3. Replace vague client-facing scope language with bounded governed-scope wording where exact per-finding counts/URLs are not available. Do not invent counts and do not restore legacy `affectedUrls` as authority.
4. Reduce repetitive verification presentation while retaining canonical `implementationCheck` in the data model. Priority Fix retains the meaningful check; Supporting Detail should not repeat the same check as a separate prominent verification column when the MEASURE section already consolidates next-audit checks.
5. Clarify positive trust score versus absence of a Priority Fix without inventing a numeric threshold. Preferred relationship: trust may be a relative strength while no trust issue crossed the governed Priority Fix threshold.
6. Orphan / Weakly Linked Pages: keep five examples by default but state total identified and shown count, with progressive disclosure of the full governed orphan list when available.
7. Supporting Detail: apply only bounded orientation/progressive-disclosure improvements; no general redesign.
8. Primary navigation requires no source repair based on current code. Existing page-ID navigation scrolls primary pages to top; explicit subsection hashes use deep-link scrolling. If a browser-specific defect persists later, reproduce it separately before changing routing.

## Governed scope-data distinction
Canonical records do not currently carry exact per-finding assessed-page counts or complete per-finding URL sets. If exact `N of M` or complete affected-URL specificity is later required, that must be a separate governed scope-data sub-tranche sourced from independently governed evidence. It is not a blocker to the bounded presentation repair.

## Implementation boundary
Expected production files:
- `services/worker/src/report/render-report-v2.js`
- `services/worker/src/report/report-detail-sections.js`

Expected tests:
- `services/worker/src/report/render-report-v2-canonical-solutions.test.js`
- nearest directly affected renderer/orphan/trust/detail tests
- `services/worker/src/report/render-narrative-v2.test.js` may receive test-only locking coverage proving Writer actionPlan remains hidden/non-authoritative; production `render-narrative-v2.js` remains preserved.

## Preservation
No changes to solution authority/provider/resolver/contract/validator/generator/sequence, scoring, evidence, DecisionEvidence, CapabilityEvidence, Writer/Judge contracts, lifecycle, persistence, report-content contract, production configuration, page count, or deployment state.

## Next
Proceed with bounded Client Specificity & Cognitive Load presentation repair from exact SHA `61f43682ec425a0708064386c8bde18d94d7f8ca`, then run focused/comparable regressions, publish the non-production candidate, and send the combined candidate to deferred Betty review before release actions.
