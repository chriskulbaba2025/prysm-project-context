# Surgical Change Contract — P7 Performance and Technical Client-Language Cleanup

Application candidate baseline: `3fb3042c04d874d44ff7f984bf279fd7b452327c`  
Change tier: `T1_LOCAL`  
Release intent: `CHANGE_ONLY`  
Root boundary: `P7_REPORT_CLIENT_LANGUAGE_ORDER_AND_PRECISION`

## Causal surface

Only the v2 client renderer is in scope: `services/worker/src/report/report-detail-sections.js`, plus its focused report test seam if required. The change will format existing metrics, add plain-language explanatory text, sanitize primary client availability wording without deleting internal diagnostics, and reorder existing technical subsections.

## Protected surface and budget

Protected: evidence acquisition, provider adapters, scoring, persistence, contracts, Writer/Judge/model behavior, n8n, navigation, deployment, and canonical artifacts. Structural budget: one renderer source file and one focused test file maximum; no new production boundary.

## Frozen acceptance

1. LCP is shown in seconds with bounded decimal precision; TBT in whole milliseconds; CLS to three decimals.
2. LCP, CLS, and TBT each have plain-language definitions.
3. Lab and field performance remain distinct; unavailable/partial states remain truthful and actionable.
4. Provider/runtime implementation terms do not replace client-safe availability language in the primary performance explanation; technical diagnostics remain available in evidence detail.
5. Technical section order is exactly verdict, blocker question, evaluated-page health, SEO Coverage Matrix, material findings, server/security headers, secondary observations.
6. Existing status labels and evidence integrity remain unchanged.

## Proof plan

Run focused renderer tests first, then worker regression and the exact-candidate Whole-App branch-complete gate. Run Causal Necessity/Surgical Determinacy checks and verify clean exact HEAD. No model-bearing gate applies because prompts, model inputs, and stochastic behavior are unchanged.

## Reopen conditions

Any need to alter evidence shape, provider behavior, scoring, persistence, model behavior, page contract, or client conclusions beyond formatting/order reopens diagnosis before editing.
