# PRYSM Human Review — Client Specificity & Cognitive Load Gate

Date: 2026-09-09
Status: QUEUED AFTER RENDERER / CROSS-PAGE CANONICAL SOLUTION INTEGRATION

## Purpose
Capture team human-review feedback that should be applied after the canonical renderer integration is complete, without changing the current implementation direction.

## Accepted feedback themes
1. Remove redundant repetition between the Priority Fix title/problem and a separate “What needs attention” field.
2. Priority Fixes must explain HOW to fix the issue, not merely restate “fix the problem.” Use the canonical `howToFix` authority field.
3. Avoid vague quantifiers such as “some”, “several”, or “many” when exact governed counts or URLs are available. Prefer exact forms such as “3 of 18 assessed pages” and identify affected pages when evidence supports it.
4. Tighten Material Uncertainty wording to the exact assessed scope. Caveats should be finding-specific rather than generic whole-report disclaimers.
5. Keep governed implementation verification in the data model, but reduce repetitive client-facing verification copy. Prefer one meaningful implementation check when it adds information; avoid repeating self-evident “retest/check again” language throughout Supporting Detail when the Measure / next-audit evidence section already covers verification.
6. Fix primary-page navigation so selecting Conversion Journey or another primary page opens that conceptual page at its top rather than landing mid-page because of a stale/deep target anchor.
7. Clarify Trust wording so a positive relative score and absence of a material finding cannot read as contradictory. Preferred relationship: trust may be a relative strength while no trust issue crossed the Priority Fix threshold.
8. Orphan / Weakly Linked Pages must clearly explain the display subset. If 42 are identified and 5 are shown, state “42 identified · showing 5 examples” and provide a governed progressive-disclosure mechanism to view the full supported set where practical.
9. Supporting Detail should remain technically complete but use progressive disclosure and plain-language orientation so non-technical clients can understand what they are looking at without reading every diagnostic detail.

## Sequencing
Do NOT interrupt the current canonical renderer/cross-page implementation.

Sequence:
1. Complete bounded Renderer / Cross-Page Canonical Solution Integration.
2. Verify and publish the bounded non-production candidate.
3. Run a Client Specificity & Cognitive Load diagnosis/gate against the rendered report.
4. Apply only evidence-supported presentation/specificity repairs.
5. Preserve canonical solution authority, evidence grades, scoring, Writer/Judge, lifecycle, persistence, page architecture, and release gates.

## Important distinction
Presentation-only issues (redundancy, navigation, trust wording, verification repetition, orphan display explanation) may be renderer/UX repairs.

Exact finding scope (counts/URLs) must not be guessed by the renderer. If current canonical solution records do not carry enough governed specificity, diagnose the authority/evidence boundary and make the smallest governed change rather than falling back to legacy `affectedUrls` or vague wording.

## Release rule
This gate is human-review acceptance criteria for the final project. It does not authorize merge, deployment, production promotion, provider/model calls, audit rerun, or any weakening of Betty/release governance.
