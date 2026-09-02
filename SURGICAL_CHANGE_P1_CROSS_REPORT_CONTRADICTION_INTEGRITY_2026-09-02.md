# Surgical Change Contract — P1 Cross-report contradiction integrity

Date: 2026-09-02
Status: FROZEN FOR IMPLEMENTATION
Root defect: P1-CROSS-REPORT-DERIVATION-001
Classification: VERIFIED_DESIGN_GAP
Change tier: T2_BOUNDARY
Release intent: CHANGE_ONLY

## Causal boundary

Scoring already produces governed conversion-path/readiness semantics, but report consumers independently re-derive related labels. The bounded repair is a single deterministic interpretation projection plus consumer migration.

## Expected change surface

- one producer/projection module in `services/worker/src/report-model/` or adjacent semantic-model boundary;
- the current report-model assembly boundary;
- affected report consumers and focused tests only.

## Protected surface

Canonical evidence, scoring formulas, provider adapters, Writer/Judge prompts, n8n, persistence/lifecycle/auth, locked CSS/JS/template assets, production configuration, and `main`.

## Structural change budget

At most one new projection module, one assembly wiring change, and bounded consumer/test updates. No new source of truth and no duplicate report-generation path.

## Acceptance/Test Areas

1. Direct: one controlled fixture produces one projection consumed identically by legacy and v2 report consumers.
2. Positive: clear and weak/missing path cases retain their governed statuses.
3. Negative: contradictory consumer input is rejected or normalized to the shared projection; no silent fallback to raw counts.
4. Construct distinction: offer clarity, CTA clarity, and conversion-path clarity remain separately named and explicitly distinguishable.
5. Regression: current worker suite and exact Whole-App branch matrix remain green.
6. Causal necessity: every changed consumer is directly mapped to the contradiction lineage.

## Proof and handoff

Narrow proof first, then affected report tests, full worker regression, exact-candidate Whole-App gate, and independent Auditor challenge. No paid/live provider or model calls. Model-Bearing Release Gate is not applicable unless prompts/model inputs change.

