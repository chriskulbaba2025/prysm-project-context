# P1 Rendered Scenario Matrix

Candidate: `85bbeda3cb4bb2fefb47b5e551f9edc0432feea2`.

Artifacts: `proof/P1/rendered/*.html`; `manifest.json` records every file path and SHA-256 from `CR-43` / `renderReportV2`.

| P1 obligation | Material scenarios / proof |
|---|---|
| CTA independent from path; point-of-reading explanation | `competitor-present`, `path-validated-blocker`, `no-conversion-mechanism` |
| Trust projection | `assessed`, `competitor-present` |
| Mobile projection | `slow-mobile`, `no-performance`, `device-profile-failed` |
| Indexability projection | `http-and-noindex`, `robots-retrieved`, `crawl-blocked` |
| Negative/fail-closed | `no-performance`, `provider-failed`, `crawl-blocked`; `P1-CROSS-04` fails closed for missing projection |
| Narrative semantic handoff | `NV2-PROD-02`, `NV2-PROD-05`, `WRITER-V2-01`; structural WriterInput proof only—no live model output was generated. |

Command: `P1_RENDER_PROOF_DIR=<governance>/proof/P1/rendered P1_APPLICATION_SHA=85bbeda3cb4bb2fefb47b5e551f9edc0432feea2 node --test src/report/render-report-v2-conversion.test.js`.

Result: `CR-43` rendered freeze matrix PASS, 48/48. The full P1 deterministic suite passed 77/77 at the parent repair; the proof-export change alters test output persistence only, not runtime renderer behavior.
