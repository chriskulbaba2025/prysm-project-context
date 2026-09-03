# P7 Diagnostic Evidence — Performance and Technical Client-Language Cleanup

Date: 2026-09-02  
Application candidate: `3fb3042c04d874d44ff7f984bf279fd7b452327c`  
Classification: `VERIFIED_DESIGN_GAP`  
Root defect boundary: `P7_REPORT_CLIENT_LANGUAGE_ORDER_AND_PRECISION`

## Requirement preserved

Make performance evidence interpretable to clients: use human-scale precision, define LCP/CLS/TBT in plain language, keep lab data distinct from field data, and translate provider/runtime failures into client-safe availability language while retaining technical diagnostics internally. Technical SEO must follow the governed order: direct verdict; search-performance blockers; evaluated-page health; SEO Coverage Matrix; material findings; server/security headers; secondary observations.

## Direct evidence

Read-only inspection of the executing v2 renderer at the exact candidate found:

- `services/worker/src/report/report-detail-sections.js` `performanceDetailSection` renders priority-row metrics with `orUnavailable(metrics.lcpMs, " ms")`, `orUnavailable(metrics.cls)`, and renders device metrics through `perfMetricTable`, so raw millisecond values and unbounded floating-point values can reach client HTML.
- The same performance renderer labels the detail as `Performance · Performance Detail`, exposes `Provider`, `Actual provider`, `Fallback Active`, and provider failure categories in client-facing output. Technical diagnostics are useful, but the client-facing availability explanation is not consistently separated from internal provider vocabulary.
- `technicalDetailSection` renders `Server & security headers` before `Is anything blocking search performance?`, `Evaluated-page technical health`, and `SEO Coverage Matrix`, contrary to the explicit P7 order.
- Existing `fmtSec` in `services/worker/src/report/html-helpers.js` proves the repository already has a bounded human-scale formatter, while the affected detail renderer does not use it consistently.

## Classification and boundaries

This is a verified report-layer design gap, not a provider, evidence, scoring, persistence, or model defect. No historical production selection or provider claim is reconstructed. No paid/live provider or model call is required.

## Acceptance artifact

`P7 requirement | executing producer/consumer | observed defect | bounded correction | direct proof`

| Requirement | Executing consumer | Observed defect | Bounded correction | Direct proof |
|---|---|---|---|---|
| Human-scale precision | `report-detail-sections.js` performance tables/cards | Raw ms and CLS float output | Shared client formatter for seconds, ms, and CLS | Fixture assertions reject raw values and assert bounded labels |
| Plain-language metrics | Performance detail | Acronyms appear without definitions | Add concise definitions adjacent to metric evidence | Focused render assertions for LCP/CLS/TBT explanations |
| Client-safe availability | Performance detail/diagnostics | Provider/runtime terms leak into ordinary client explanation | Keep technical fields in appendix/diagnostic detail; use safe availability copy in primary detail | Failure/partial fixture assertions |
| Lab vs field distinction | Performance detail | Must remain explicit | Preserve and test separate lab and field blocks | Focused render assertions |
| Technical order | `technicalDetailSection` | Headers precede required sections | Reorder existing blocks only | Ordered substring proof |

## Non-goals

No changes to collection, provider/adaptor behavior, scoring, storage, evidence contracts, Writer/Judge/model behavior, n8n, navigation/page count, or production deployment/configuration.
