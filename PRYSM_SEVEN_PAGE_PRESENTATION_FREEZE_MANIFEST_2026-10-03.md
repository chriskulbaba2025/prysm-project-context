# PRYSM Seven-Page Presentation Freeze Manifest

**Date:** 2026-10-03  
**Status:** ACTIVE / FINAL PRESENTATION FREEZE FOR GOVERNED IMPORT  
**Applies to:** isolated-staging presentation import only  
**Production mutation:** PROHIBITED  
**Release intent for page-import tranches:** CHANGE_ONLY unless separately changed by explicit authorization

## Governing rule

**Freeze presentation structure, not sample mock truth.**

**Exact presentation structure; dynamic governed truth.**

The frozen artifacts define client-facing presentation structure, hierarchy, interaction, disclosure pattern, and visual organization. They do **not** authorize any sample business identity, score, finding, proof state, competitor value, content state, recommendation, causal relationship, metric, narrative sentence, or conclusion.

Runtime truth remains governed by the canonical PRYSM pipeline and approved Narrative Decision Package (NDP).

## Authoritative application checkpoint before import

- Repository: `chriskulbaba2025/prysm-staging-isolated`
- Local root: `C:\Users\kulba\Desktop\prysm-staging-isolated`
- Branch: `repair/prysm-bulk-closure-20260927`
- Starting HEAD: `99fc3eb97f63a4cc8a37feda7ea2d81a68362a70`
- Remote branch HEAD at preflight: `99fc3eb97f63a4cc8a37feda7ea2d81a68362a70`
- Pre-existing unrelated worktree modification: `services/worker/src/server.js`
- Rule: preserve that modification; do not stage, reset, overwrite, or absorb it into presentation-import commits.
- Production: untouched.

## Exact frozen presentation identities

| Page | Frozen artifact | SHA-256 | Bytes |
|---|---|---:|---:|
| 1 | `01-prysm-executive-scorecard-final.html` | `1F1D36AA0C084C12551C5D61983BE46CE02A0F6B3931C3D5B798D7488ABD5572` | 29,215 |
| 2 | `02-prysm-priority-fixes-final.html` | `E10C3D5BD9F30F83925AF9FEE489CFB02D1380E36D2AC2BE8D844558AA80B681` | 15,596 |
| 3 | `03-prysm-conversion-journey-final.html` | `B86EA0412C7827122FC8D5CD15F916B15F0A4265C51EC57F267ABE2482C1A537` | 7,023 |
| 4 | `04-prysm-trust-credibility-final.html` | `20E0D7E741DD918012298D0F512B10AB9D5D5577F5443890B2C22214410ADF19` | 27,452 |
| 5 | `05-prysm-competitor-comparison-final.html` | `30779992E310035E50CA56114A64495461E6ECEBDDF8748A9B694057FEFB2646` | 16,334 |
| 6 | `06-prysm-content-opportunities-final.html` | `E1955A203CF85F5165BB360C995615F57A509420FC27B7E67D694D282902D79E` | 21,389 |
| 7 | `07-prysm-supporting-detail-final.html` | `42BAA2F1D0DF4CBD7358C800822EF00CE462F563F820E57BC9579EB98DF2C196` | 9,253 |

Integrated review artifact:

- File: `prysm-full-report-integrated-review-v1.html`
- SHA-256: `4CE098D59FD07EECC71DD9412B94BF30DDEC745E2D2999AE673BC96DF57F7193`
- Bytes: 164,713
- Lines: 2,072
- Library path: `/Prysm update/prysm-full-report-integrated-review-v1.html`
- Library file ID observed at preflight: `libfile_d9755e8cc53c81919b00ea2fc588c236`
- Session verification: exact bytes were recovered from the persistent Library text surface and independently re-hashed on ChrisPC; byte count, line count, and SHA-256 match this frozen identity.

Freeze package:

- File: `prysm-seven-page-report-freeze-package.zip`
- SHA-256: `6BDEC24CE5E48B865687D0FC62D10BEEAACE24D95FC89ECF5127677E5507018E`
- Bytes observed in Library: 80,505
- Library path: `/Prysm update/prysm-seven-page-report-freeze-package.zip`
- Library file ID observed at preflight: `libfile_d89056291fac8191b9f5cff674fa5dce`
- Verification state: the exact Library object is located; its raw bytes are not exportable through the current file-materialization path, so this session does **not** claim an independent ZIP re-hash. The package SHA above remains the durable frozen identity previously recorded in PRYSM decisions.

The independently verified integrated artifact is the mandatory presentation reference during import. Do not recreate any page from chat memory or from a later approximation.

## Page presentation authority

1. **Executive Scorecard** — approved presentation architecture. Runtime score/detail combinations must reconcile. Strategic synthesis/pattern presentation is conditional on NDP-authorized synthesis.
2. **Priority Fixes** — approved row-based presentation.
3. **Conversion Journey** — approved restrained/current three-stage journey approach.
4. **Trust & Credibility** — approved proof-matrix and progressive-disclosure presentation. Current governed v2 semantics override older sample/mock truth.
5. **Competitor Comparison** — approved fixed comparison matrix.
6. **Content Opportunities** — approved collapsed 13-item presentation pattern: 3 Create, 8 Check first, 2 Already covered in the frozen sample. Those counts are sample presentation state only; runtime counts/states must come from governed content opportunity data.
7. **Supporting Detail** — approved light expandable-row presentation.

## Runtime semantic authority

The import MUST preserve the existing canonical runtime boundary:

`governed evidence / deterministic scoring -> approved NDP -> validated client publication package -> v13 runtime projections -> page presentation`.

The presentation layer must not reinterpret raw evidence or re-authorize meaning.

Preserve:

- deterministic scoring and score-state authority;
- evidence provenance and exact source status;
- publication semantics and semantic-hash continuity;
- client-language authority;
- lifecycle rules;
- tenant/client/audit identity;
- existing UNKNOWN / PARTIAL / NOT_ESTABLISHED / UNAVAILABLE / NOT_CONNECTED / NOT_APPLICABLE distinctions;
- existing fail-closed behavior;
- current production paths outside the presentation tranche.

## Hard semantic constraints

1. Executive score/detail combinations must reconcile from the same governed runtime scorecard.
2. A relationship, pattern, connector, or synthesis arrow is permitted only when backed by an authorized NDP `strategicSyntheses[]` record with at least two `contributingCanonicalFindingIds` and resolved evidence refs. Writer root-cause prose alone is not relationship authority.
3. Trust proof categories are diagnostic vocabulary, not universal requirements.
4. Trust proof placement is advisory unless the approved NDP/publication evidence authorizes a stronger statement.
5. UNKNOWN / PARTIAL / NOT_ESTABLISHED / UNAVAILABLE must never silently become a weakness, absence claim, FIX, CREATE, or prescription.
6. No invented score deltas, forecasts, pseudo-precise simulations, lead/conversion/revenue effects, or unmeasured outcome claims.
7. Competitor directional claims require governed comparability.
8. Content CREATE requires governed absence authority; uncertain/partial coverage remains check-first/verify.
9. No client-visible internal governance jargon unless explicitly part of a permitted governance view.
10. Seven-page order and navigation remain fixed.

## Mock/sample literal exclusion rule

The frozen artifacts contain sample City Media values. Those values are design fixtures only.

No application implementation may copy any sample-specific literal into an authoritative runtime decision. This includes, without limitation:

- business/client/domain identity;
- score or band values;
- finding titles/conclusions;
- proof-presence/absence claims;
- competitor names, values, rankings, or comparison outcomes;
- content-opportunity states/counts/topics;
- performance measurements;
- evidence counts/coverage;
- action timing;
- recommendations;
- causal/pattern relationships;
- narrative sentences.

A sample literal may appear only inside a clearly isolated presentation reference/test fixture used to prove non-leakage. Generic runtime logic must be driven by canonical fields.

## Current owning implementation boundary

Read-only preflight established the current renderer seam:

- `services/worker/src/report/render-report-v13.js` strips prototype data and binds `RUNTIME`.
- `services/worker/src/report/v13/build-v13-runtime-data.js` builds governed projections from canonical model + approved client publication package.
- `services/worker/src/report/v13/prysm-report-v13-pages.js` owns the seven page presentation functions.
- `services/worker/src/report/v13/prysm-report-v13-template.html` owns shared presentation CSS/shell.
- `services/worker/src/report/v13/client-publication-package.js` preserves NDP/client-language/action authority.
- `services/worker/src/narrative-v2/ndp-contract.js` validates `strategicSyntheses[]` authority.

Therefore the import is a presentation projection migration, not a scoring/evidence redesign.

## Smallest governed import sequence

Each page is a separate execution tranche and stop boundary.

### P0 — Freeze/preflight
- Create and verify this manifest.
- No application code change.

### P1 — Executive Scorecard
- Import only Page 1 presentation architecture.
- Bind all displayed values to current runtime projections.
- Add only the minimum runtime projection needed to expose NDP-authorized synthesis relationships if Page 1 connectors/pattern arrows are rendered.
- Prove score/detail reconciliation, top-3 priority density, strengths, bounded unknowns, restraint, and synthesis authorization.
- Do not modify Pages 2–7 except shared CSS that is strictly required for Page 1 and proven non-regressive.
- STOP after P1 acceptance boundary.

### P2 — Priority Fixes
- Import Page 2 row presentation against the complete governed sequence.
- Preserve VERIFY/deferred/unknown semantics.
- STOP.

### P3 — Conversion Journey
- Import restrained three-stage journey presentation.
- Preserve advisory/opportunity semantics and unmeasured outcome boundary.
- STOP.

### P4 — Trust & Credibility
- Import proof matrix and progressive disclosure.
- Treat proof categories as diagnostic vocabulary.
- Preserve advisory placement and all unknown/partial states.
- STOP.

### P5 — Competitor Comparison
- Import fixed matrix.
- Bind only canonical comparator rows/values/comparability/directional claims.
- STOP.

### P6 — Content Opportunities
- Import collapsed opportunity presentation.
- Counts and states are runtime-derived; frozen 3/8/2 is not a universal invariant.
- CREATE remains gated by absence authority.
- STOP.

### P7 — Supporting Detail
- Import light expandable-row presentation.
- Preserve evidence states, scope, provenance, and measurement semantics.
- STOP.

## Per-tranche acceptance contract

Before any page tranche can be reported PASS:

- exact starting SHA and changed-file scope recorded;
- only the named page plus minimum shared presentation/runtime binding files changed;
- no unrelated dirty work absorbed;
- target-page presentation matches the frozen structure;
- all client-visible semantic values are runtime-derived;
- mock/sample literal leakage scan passes;
- strong / mixed / weak production-shaped generalization proof passes;
- unknown/partial negative paths pass;
- cross-surface parity against already migrated pages passes;
- applicable Surface Migration Gate checks pass;
- targeted regression passes;
- required broader exact-candidate regression / Whole-App gate passes where applicable;
- local browser-rendered review is performed for the client-facing presentation;
- exact diff is reviewed;
- no provider/model calls occur;
- no production mutation occurs;
- no deployment or alias move occurs without separate authorization.

## First authorized implementation tranche

The current user instruction authorizes beginning **P1 — Executive Scorecard** after this manifest is committed and verified.

It does not authorize automatic continuation into P2.

