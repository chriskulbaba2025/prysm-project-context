# S01 Source Boundary Proof — Executive Scorecard + Viewer IA

Section: `S01 — Executive Scorecard`
Date: 2026-09-07
Status: VERIFIED
Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md`
Repair plan: `S01_REPAIR_PLAN.md`
Report-wide IA contract: `PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md`

## Evidence source

Chris supplied the read-only local diagnostic `PRYSM-S01-SOURCE-BOUNDARY.txt`, generated from the exact current local application worktree on 2026-09-07.

The diagnostic was created outside the governed repositories and did not modify application code.

## Exact local candidate identity

- Application branch: `p1/bounded-build-cross-report-integrity`
- Local HEAD: `a9523ac3de98de76335a05304b60bec246242b65`
- This HEAD is only the historical committed base; the repaired P1 candidate remains an intentional dirty local worktree and is not identified by HEAD alone.

Observed dirty paths at source-boundary capture:

```text
 M src/contracts/score-current.schema.json
 M src/report-model/cross-report-interpretation.js
 M src/report-model/cross-report-interpretation.test.js
 M src/report/render-report-v2-conversion.test.js
 M src/report/render-report-v2.js
 M src/report/report-detail-sections.js
 M src/report/sections-conversion.js
 M src/scoring/report-finalization-gate.js
 M src/scoring/report-model.js
 M src/scoring/score-components.js
 M src/scoring/score-components.test.js
 M src/scoring/vantage-score.js
 M src/scoring/vantage-score.test.js
?? src/report-model/client-truth-gate.js
?? src/report-model/client-truth-gate.test.js
?? src/scoring/report-model-content-integrity.test.js
?? src/scoring/score-components-faq-coherence.test.js
```

All existing dirty work must be preserved. No reset, clean, checkout-overwrite, discard, or unrelated rewrite is authorized.

## Verified ownership — S01 renderer

`src/report/render-report-v2.js` owns the current deterministic Executive Scorecard through `executiveScorecard(model, pillars)`.

Verified current behavior:

- `readiness` comes from `model.scores.conversionReadiness`.
- `confidence` comes from `model.evidenceConfidenceScore`.
- `assessedWeight` comes from `model.assessedWeight`.
- the top-three executive actions come from `buildActionPlan(...).actions.slice(0, 3)`.
- the executive renderer currently splits each action across two lists:
  - title + `finding.businessImpact` under `What is really holding the site back?`;
  - title + `finding.recommendation` under `What should you do first?`.
- positive dimension scores are independently rebuilt from `pillars`.
- limitation wording exposes assessed-weight and confidence-factor mechanics.

Therefore the S01 hierarchy/copy repair can be implemented in the renderer without changing scoring or action ranking.

## Verified priority lineage

`src/report/action-priority.js` owns deterministic ordering through `buildActionPlan(model, checklist)`.

The action object retains the governed `finding`, including:

- Problem source: `finding.title`;
- Why source: `finding.businessImpact`;
- Action source: `finding.recommendation`;
- Rank source: deterministic `buildActionPlan` sort, then `rank = index + 1`.

S01 must continue to consume this order. It may translate the three fields into shorter client-facing executive wording but may not create a different ranking or strengthen the underlying evidence claim.

## Verified VAN-PERF-001 / render-blocking lineage

The diagnostic proves the underlying wording is created in `src/scoring/score-components.js` for `VAN-PERF-001` when mobile LCP is finite and greater than 4000 ms.

Observed governed finding fields:

- title: `Mobile largest contentful paint is slow`
- evidence: `lcp_ms`
- businessImpact: `Slow LCP may create friction for mobile visitors.`
- recommendation: `Optimize the largest above-the-fold asset and remove render-blocking work`
- verification: `Re-run PageSpeed Insights and confirm LCP is under 2.5 seconds.`

The direct evidence establishes slow mobile LCP; it does not independently establish `render-blocking work` as the sole observed root cause. The S01 repair therefore must NOT change `score-components.js` in this work package. Instead, S01 must summarize the action at a bounded business level, for example: `Reduce the time it takes for the main mobile content to appear, then retest the page.`

The underlying detailed recommendation remains available to later sections and will be reviewed when its owning client section becomes ACTIVE. This is a bounded executive translation, not a finding mutation.

## Verified strengths duplication seam

`src/report/report-detail-sections.js` exports `strengthsSection(model, checklist)`, which produces `<section id="strengths">` with heading `What Is Already Good` and technical/mechanical detail.

`src/report/render-report-v2.js` currently:

- imports `strengthsSection`;
- renders it in `pageShell(...)`;
- maps Executive Scorecard to `sectionIds: ["executive", "strengths"]`.

S01 duplication can be removed without editing the already-dirty `report-detail-sections.js`: remove S01 ownership/rendering of the separate strengths section from `render-report-v2.js`, consolidate supported positives inside `executiveScorecard(...)`, and leave the existing exported helper untouched unless a later governed section proves it needs migration.

## Verified viewer/navigation ownership

`src/report/render-report-v2.js` also owns:

- `REPORT_V2_VIEWER_PAGES`;
- sidebar link generation in `renderViewerNav()`;
- serialized `viewerConfig`;
- hash resolution;
- page activation;
- browser back/forward handling;
- current-page printing.

Current `REPORT_V2_VIEWER_PAGES` contains 16 peer pages. `renderViewerNav()` renders every entry as the same primary navigation link.

The viewer engine already supports any page contained in serialized `viewerConfig`. Therefore the lowest-risk migration is:

1. retain all 16 conceptual viewer destinations for hash/page switching and supporting-detail reachability;
2. classify each destination as `PRIMARY` or `SUPPORTING` in the viewer page definition;
3. render exactly 8 `PRIMARY` links in the main client navigation;
4. render the 8 `SUPPORTING` links under a visibly subordinate `Supporting Evidence / Technical Detail` surface;
5. keep stable `pageId` values so existing hash routing remains traceable;
6. keep all retained supporting sections reachable and printable.

This avoids deleting evidence pages merely to simplify navigation.

## Verified affected tests

The diagnostic proves the following test files contain assertions that must migrate with the approved contract:

### Direct viewer contract
- `src/report/render-report-v2-section-viewer.test.js`
  - hard-codes 16 peer page titles;
  - hard-codes `REPORT_V2_VIEWER_PAGES.length === 16`;
  - hard-codes one peer navigation link per page;
  - includes `strengths` in the expected Executive Scorecard section ownership.

The conceptual page count may remain 16, but the test must distinguish 8 PRIMARY from 8 SUPPORTING and verify reachability/print/page switching for both tiers.

### S01 / evidence-backed positives
- `src/report/render-report-v2-conversion.test.js`
  - `CR-15` hard-codes `What Is Already Good` and currently tests evidence-backed strength rendering through that separate section.

This proof must migrate to the consolidated `What is already working well?` executive section while preserving the same assessed-evidence safeguard.

### Legacy executive-shape assertions
- `src/report/karen-style-regression.test.js`
  - hard-codes A/B/C executive scorecard mechanics and `What Is Already Good` as deterministic depth.
- `src/report/render-report-v2-sections.test.js`
  - hard-codes `A. Conversion Readiness`, `B. Evidence Confidence`, and `C. Evidence Coverage` as unchanged executive goldens.
- `src/report/render-report-v2.test.js`
  - hard-codes the old A/B/C executive structure.
- `src/report/render-narrative-v2.test.js`
  - asserts the deterministic layer retains old B/C executive labels.

These assertions are migration targets because Chris has explicitly approved a new client-facing executive/IA contract. They must be replaced with assertions for the new contract, not removed without replacement.

### Non-governing 16-page references
The diagnostic also found older approved-page/v1 activation tests referencing a locked 16-page set. Those references belong to separate v1/approved-page contracts and must not be changed merely because Viewer v2 primary navigation becomes 8 items.

## Exact authorized application BUILD boundary

Application code allowed for S01 BUILD:

1. `src/report/render-report-v2.js`

Application tests allowed as needed to migrate/verify this exact approved behavior:

2. `src/report/render-report-v2-section-viewer.test.js`
3. `src/report/render-report-v2-conversion.test.js`
4. `src/report/render-report-v2.test.js`
5. `src/report/render-report-v2-sections.test.js`
6. `src/report/karen-style-regression.test.js`
7. `src/report/render-narrative-v2.test.js`

No edit is authorized to `score-components.js`, `action-priority.js`, `report-detail-sections.js`, scoring contracts, evidence acquisition, lifecycle, storage, Writer/Judge, or other dirty P1 files for this S01 build unless a new deterministic failure proves that an additional file is required and the repair plan is reopened before editing it.

## Viewer versioning decision for BUILD

Because the viewer information architecture changes materially while the evidence/scoring/report-data contract remains unchanged, the BUILD should increment only the viewer presentation version from `2.2.0` to `2.3.0`.

Do not change the report design/data contract solely for this navigation migration.

## Required BUILD sequence

1. Update/extend the focused S01 + viewer tests first to encode the approved contract.
2. Run the focused tests and preserve the expected pre-implementation failures as proof that the old implementation violates the new contract.
3. Change only the authorized renderer seam.
4. Re-run focused tests to PASS.
5. Stop before broad closure and return the focused proof for review.

No provider/model calls, production mutation, deployment, merge, push, or destructive Git operation is authorized.

## Source-boundary conclusion

`PASS — COMPLETE`.

The repair plan now has enough exact local evidence to authorize the bounded BUILD stage.