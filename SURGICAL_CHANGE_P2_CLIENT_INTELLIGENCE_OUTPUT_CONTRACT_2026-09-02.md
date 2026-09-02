# Surgical Change Contract — P2 Client Intelligence Output Contract

Change tier: Tier 1 — bounded report presentation contract
Release intent: CHANGE_ONLY
Root defect: `P2-CLIENT-INTELLIGENCE-WHERE-PASS-001`

## Files and surfaces

- `services/worker/src/report/render-report-v2.js`: Priority Findings location cell and zero-action PASS wording.
- `services/worker/src/report/render-report-v2.test.js`: direct assertions for URL-present and URL-absent location behavior and the explicit PASS criterion.
- `services/worker/src/report/render-report-v2-conversion.test.js`: re-freeze the complete deterministic render matrix after direct inspection confirms the same bounded P2 output contract across every established report branch.

## Producer / contract / consumer

Producer: deterministic findings in `score-components.js`.
Contract: finding schema and action plan preserve `affectedUrls`, evidence, impact, recommendation, and verification.
Consumer: report-v2 `blockersSection`.

## Frozen acceptance / proof areas

- Direct renderer proof for URL-present and URL-absent actions.
- Direct renderer proof for zero-action PASS wording.
- Worker report tests, schema/contract tests, and exact-candidate Whole-App gate.
- Causal necessity: removing URL rendering must fail the URL acceptance; removing PASS criterion wording must fail the PASS acceptance.

No live provider or model calls are permitted or required. Model-Bearing Release Gate: N/A unless the bounded diff unexpectedly changes prompts or model inputs.

## Implemented boundary and determinacy result

The implementation changed only the frozen report presentation surface: a Priority Finding now shows vetted client-owned `affectedUrls` as `Affected page(s)`; an action without a usable URL shows its governed evidence location; and the zero-action PASS names the assessed-evidence-scope criterion. The render-matrix golden hashes were re-frozen only after the direct P2 assertions and all established conversion branches were inspected and passed. No producer, persistence, scoring, priority ordering, provider, prompt/model, n8n, or deployment surface changed.
