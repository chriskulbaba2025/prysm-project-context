# P7 Exact-Candidate Evidence — Performance and Technical Client-Language Cleanup

Application candidate: `2e4f40d97a4a197e20948b26fb73c639ba913864`
Branch: `repair/prysm-report-improvement`
Root boundary: `P7_REPORT_CLIENT_LANGUAGE_ORDER_AND_PRECISION`
Release intent: `CHANGE_ONLY`

## Proof

- Focused renderer: **48/48 PASS** (`services/worker/src/report/render-report-v2-conversion.test.js`).
- Worker regression: **981/981 PASS** (`npm test`).
- Whole-App assembled gate: **PASS, 87/87**, P-B01 through P-B16 covered (`npm run verify:prysm-whole-app`).
- `git diff --check`: PASS before commit.
- No live provider calls or paid/live model calls.
- Model-Bearing Release Gate: N/A; prompts, model inputs, and stochastic behavior are unchanged.

## Acceptance mapping

1. Client performance tables use seconds for LCP, whole milliseconds for TBT, and three decimals for CLS.
2. LCP, CLS, and TBT definitions are adjacent to the visitor-experience performance explanation.
3. Lab performance and field performance remain separate and unavailable/partial states remain explicit.
4. Primary availability wording is client-safe; provider/runtime details remain labeled as technical diagnostics.
5. Technical detail order is verdict, blocker question, evaluated-page health, SEO Coverage Matrix, material findings, headers, secondary observations.
6. Existing status labels and evidence integrity are preserved by the focused matrix and full regression.

## Handoff

Candidate is ready for independent Auditor challenge. Production remains protected and no merge/deploy is authorized.
