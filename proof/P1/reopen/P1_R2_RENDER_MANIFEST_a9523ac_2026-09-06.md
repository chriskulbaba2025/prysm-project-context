# P1 R2 Render Manifest Binding

Application branch: `p1/bounded-build-cross-report-integrity`  
Application candidate commit: `a9523ac3de98de76335a05304b60bec246242b65`  
Rendered-code provenance commit: `275f3cabb6796f9d0c2e5a30df61e71c4e084b96`

The complete, immutable application render manifest is:

`proof/P1/reopen/render-v2-r2-275f3ca/manifest.json`

It is committed in the application candidate above. It contains 27 CR-43
scenario entries, each with LF-normalized SHA-256, file name, renderer, test
identifier, and the rendered-code provenance commit. Its raw UTF-8
SHA-256 at verification was:

`54b0afba719cba83e31870fb762ba14bdc6a04f35033f3051d97a4ccf1369ac0`

Required R2 scenario obligations map to this artifact as follows:

- CTA/path coherence: `path-validated-blocker.html`.
- Exact trust attribution and lab/field qualification: `assessed.html` and
  `competitor-present.html`.
- Fail-closed negative coverage: `unassessed.html`,
  `no-conversion-mechanism.html`, `no-performance.html`, `crawl-blocked.html`,
  and `provider-failed.html`.
- Complete established renderer matrix: all 27 entries, verified by CR-43.

Generation executed the deterministic CR-43 renderer test with
`P1_APPLICATION_SHA=275f3cabb6796f9d0c2e5a30df61e71c4e084b96` and produced
`52 pass, 0 fail`. The focused R2 suite, full regression, and whole-app gate
are recorded in `P1_R2_REPAIRED_CANDIDATE_PROOF_a9523ac_2026-09-06.md`.
