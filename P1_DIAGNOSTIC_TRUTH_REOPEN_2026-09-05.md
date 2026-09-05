# P1 Reopened Diagnostic Truth

Date: 2026-09-05
Classification: VERIFIED_DESIGN_GAP

## Verified cause

The failed client conclusions originate in report-model projection and renderer consumers, not evidence acquisition, scoring, or page selection. Four linked patterns permit a narrower fact or unavailable state to become a broader positive conclusion:

1. `foundation-readiness.js` marks any non-empty `robotsText` PASS without parsed directive evidence.
2. `render-report-v2.js` emits a reassuring PASS/no-blocker message whenever no scored finding exists, including when page-level evidence is unavailable, blocked, or failed.
3. `render-report-v2.js` uses decision-stage ideas as a proxy for an observed conversion route; `report-detail-sections.js` groups alternatives such as pricing, policies, and guarantees into one PASS explanation.
4. The current cross-report projection and rendered readiness surfaces expose raw capability states and derive assessment labels independently from evidence availability, allowing measured performance to be presented beside a conflicting “Not Assessed” label.

## Bounded repair seam

Expected application changes: `services/worker/src/report/foundation-readiness.js`, `render-report-v2.js`, `report-detail-sections.js`, `report-model/cross-report-interpretation.js`, and their deterministic tests/render fixtures. The repair must preserve exact observed facts, use client-language explanations, fail closed for incomplete evidence, and reconcile CTA invitation versus usable path at the point of reading.

Explicitly excluded: evidence acquisition/adapters, scoring, Writer/Judge/model calls, page-selection redesign, deployment, and application main.

## Required proof

Regression coverage must prove each Brad scenario family: no conversion mechanism, blocked conversion path, absent pricing, retrieved-but-unparsed robots, crawl blocked, provider failure, measured performance with other incomplete evidence, and client-facing absence of raw machine capability terminology where a business conclusion is shown.
