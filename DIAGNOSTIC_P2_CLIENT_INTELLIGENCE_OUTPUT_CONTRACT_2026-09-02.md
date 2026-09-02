# Diagnostic — P2 Client Intelligence Output Contract

Date: 2026-09-02
Classification: VERIFIED_DESIGN_GAP
Application candidate: `repair/prysm-report-improvement` at `9a1612c7e2388297120d5196b0be099762c97e2b`

## Requirement preserved

Every material client recommendation must answer what was found, where it is, why it matters, what to do, and how completion is verified. When the evidence cannot establish an answer, the output must say so explicitly.

## Direct evidence

The deterministic Finding contract already requires `affectedUrls`, `evidence`, `businessImpact`, `recommendation`, and `verificationMethod` in `services/worker/src/contracts/finding.schema.json`. `buildActionPlan` carries the complete finding into the client action plan in `services/worker/src/report/action-priority.js`.

In `services/worker/src/report/render-report-v2.js`, `blockersSection` currently builds the “where” cell from only `f.evidence[].field` / provider names. It does not render `f.affectedUrls`, despite those URLs being available in the producer contract. The no-action branch renders “No score-bearing finding produced a prioritized action from the assessed evidence” without stating the pass criterion or evidence scope.

## Classification and boundary

This is a client-output presentation/design gap, not a provider or evidence-generation defect. The bounded correction is limited to the report-v2 Priority Findings section and its deterministic tests: render affected URLs when present, label the evidence location, and make the zero-action PASS state the criterion explicit. No scoring, ranking, provider policy, prompt/model input, n8n, or production configuration changes are justified.

## Acceptance

1. A material action with affected URLs visibly lists those URLs in the client-facing “where” output.
2. A material action without URLs remains truthful and identifies the available evidence field/source rather than inventing a location.
3. The no-action PASS states that no score-bearing finding was produced from the assessed evidence and therefore no prioritized action is required under the current evidence scope.
4. Existing report rendering and whole-app contracts remain green.

## Exact-candidate proof

Candidate: `repair/prysm-report-improvement` at `a2c54692ce231c34e4f693a6bb34ed3db527d1d6`.

- Direct report renderer and conversion-matrix proof: **61/61 PASS**.
- Worker regression: **968/968 PASS**.
- Whole-App Tranche Gate: **87/87 PASS**; P-B01 through P-B15 explicitly covered.
- No live provider or model calls occurred. Model-Bearing Release Gate: **N/A**; the diff changes no prompt, model input, or semantic orchestration.
