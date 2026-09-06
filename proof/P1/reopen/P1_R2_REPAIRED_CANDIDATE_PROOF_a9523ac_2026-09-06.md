# P1 R2 Repaired Candidate Proof

Date: 2026-09-06  
Stage completed: `BOUNDED_BUILD`  
Stable root: `P1-CROSS-REPORT-PROJECTION-RECONCILIATION`  
Application branch: `p1/bounded-build-cross-report-integrity`  
Repaired candidate: `a9523ac3de98de76335a05304b60bec246242b65`  
Rendered-code provenance SHA: `275f3cabb6796f9d0c2e5a30df61e71c4e084b96`

## Bounded repair result

The candidate resolves only the three R2 client-visible projection families:

1. A present CTA/form now says, at the Foundation Readiness point of reading,
   that an observed mechanism does not establish usable completion when the
   governed conversion path is weak.
2. The positive trust answer names the exact observed reassurance signal. A
   policy/terms observation no longer implies pricing, guarantees, or other
   unobserved evidence.
3. A numeric lab-performance result remains usable lab evidence while clearly
   stating that unavailable real-user field data prevents a complete real-user
   readiness conclusion. The qualification appears in the performance pillar
   and direct readiness answer without leaking internal state vocabulary.

No evidence acquisition, scoring policy, provider, Writer/Judge, storage,
lifecycle, deployment, or robots/indexability behavior was changed.

## Deterministic verification

- Focused R2 report suites: `node --test src/report-model/cross-report-interpretation.test.js src/report/render-report-v2-conversion.test.js src/report/render-report-v2.test.js src/report/render-report-v2-sections.test.js` — `80 pass, 0 fail`.
- Full worker regression: `npm test` — `987 pass, 0 fail`.
- Whole-app composition: `npm run verify:prysm-whole-app` — `PRYSM WHOLE-APP TRANCHE GATE: PASS`.
- Render generation: `P1_APPLICATION_SHA=275f3cabb6796f9d0c2e5a30df61e71c4e084b96 P1_RENDER_PROOF_DIR=proof/P1/reopen/render-v2-r2-275f3ca node --test src/report/render-report-v2-conversion.test.js` — `52 pass, 0 fail`.

## Rendered proof and scenario mapping

The immutable matrix is application artifact
`proof/P1/reopen/render-v2-r2-275f3ca/manifest.json`, committed in candidate
`a9523ac3de98de76335a05304b60bec246242b65`. Each of its 27 entries records
its normalized SHA-256 and the rendered-code provenance SHA above.

- `path-validated-blocker.html` proves CTA/path reconciliation with a visible
  conversion mechanism and a weak governed path.
- `assessed.html` and `competitor-present.html` prove exact trust attribution
  and the qualified lab/field performance conclusion.
- `unassessed.html`, `no-conversion-mechanism.html`, `no-performance.html`,
  `crawl-blocked.html`, and `provider-failed.html` preserve negative and
  fail-closed states.
- The remaining matrix scenarios preserve the established report consumer
  branches under CR-43's golden-hash assertion.

## Candidate disposition

All Builder-owned bounded repair, regression, whole-app, rendered-proof, and
provenance obligations are complete. The candidate is ready for independent
Brad `OUTCOME_REVIEW`; this evidence makes no human outcome verdict.
