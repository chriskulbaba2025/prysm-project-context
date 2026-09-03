# P10 Diagnostic Evidence — General Copy and Naming Normalization

**GCU protocol:** 2.4.0  
**Candidate/base SHA:** `13921d7d6c1364a57adc8a27b9f8607ff2e322d4`  
**Owner:** Builder

## Protected outcome

Make ordinary client-facing report copy clear and consistently named while preserving evidence, scoring, contracts, and governance semantics.

## Observed condition

The active report renderers use inconsistent client labels: the v2 scorecard says `What is already working?` and both renderer paths label the competitor section `Competitor Benchmark`. The approved report page contract already uses `Internal-Link Opportunities`, so the P10 change is limited to the directly evidenced inconsistent labels.

## Executing boundary

`services/worker/src/report/render-report-v2.js` and `services/worker/src/report/render-approved-report.js` produce client-facing report page titles and section labels. `render-report-v2-section-viewer.test.js` freezes the v2 page-title contract.

## Evidence

| Evidence ID | Source/artifact | Exact identity | What it proves |
|---|---|---|---|
| D10-01 | `render-report-v2.js:268`, `:689`, `:783` | application `13921d7d6c1364a57adc8a27b9f8607ff2e322d4` | Active v2 output contains the inconsistent working-strength and competitor labels. |
| D10-02 | `render-approved-report.js:41` | application `13921d7d6c1364a57adc8a27b9f8607ff2e322d4` | Approved output exposes the same competitor naming boundary. |
| D10-03 | `render-report-v2-section-viewer.test.js:108-125` | application `13921d7d6c1364a57adc8a27b9f8607ff2e322d4` | Viewer contract asserts the client-facing page labels and requires synchronized test expectation. |

## Facts versus unresolved questions

### Observed facts

- The labels are emitted by deterministic renderers.
- The requested normalization does not require changes to evidence, scoring, persistence, prompts, models, provider calls, or n8n.
- The existing page contract uses title case for comparable client-facing labels.

### Unresolved

- None material to this bounded copy-only correction.

## Cause classification

`VERIFIED_DESIGN_GAP`

The presentation contract has not normalized the requested labels across its two report renderer paths.

## Ownership

Application report presentation renderer and its deterministic contract tests.

## Repair-attempt accounting

Same-root evidence-based repair attempts before this checkpoint: `0`.

## Gate result

`PASS` for bounded P10 renderer/test correction. Model-Bearing Release Gate: `N/A`; no prompt, model input, or stochastic behavior changes.
