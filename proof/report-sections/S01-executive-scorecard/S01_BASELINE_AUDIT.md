# S01 Baseline Audit — Executive Scorecard

Section: S01 — Executive Scorecard
Status: COMPLETE — FAIL BASELINE
Date opened: 2026-09-07
Date completed: 2026-09-07
Contract: `S01_CONTRACT.md`
Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md`

## Governing rule

This baseline is captured from the actual current rendered TBK report supplied for review after local P1 closure. No application code edit was performed during baseline capture.

## Render identity

- Live audit ID: `8d22e6b9-9246-4fb2-9f65-4cfc97a5b9e3`
- Canonical input root: `C:\Users\kulba\Downloads\PRYSM-LIVE-AUDIT-8d22e6b9-9246-4fb2-9f65-4cfc97a5b9e3`
- Intended current render: `C:\Users\kulba\Downloads\PRYSM-P1-REPAIRED-TBK-REPORT.html`
- Reviewed artifact name: `PRYSM-P1-REPAIRED-TBK-REPORT.html`
- Render verified to exist for review: YES — supplied current HTML was directly inspected.
- SHA-256 of reviewed HTML: `a3532fe9847f8779580c8dac91e77fbf44421b96b7172bf79bd3adf7c904661f`
- Reviewed size: 118425 bytes.
- Local application branch: `p1/bounded-build-cross-report-integrity`
- Repaired candidate remains an intentional dirty local worktree; historical SHA alone does not identify it.

## Baseline capture

### 1. Current hierarchy

Observed conceptual order on the S01 viewer page:

1. `How ready is your website to convert the right visitors?`
2. `Executive verdict`
3. three peer score blocks: Conversion Readiness / Evidence Confidence / Evidence Coverage
4. `What is really holding the site back?`
5. `What should you do first?`
6. `What Is Already Working`
7. `What could we not determine?`
8. `Where to go next`
9. separate viewer-page section `What Is Already Good`

This does not match the approved six-part S01 hierarchy. Evidence confidence/coverage appear too early and too prominently, the problem/action story is split across two lists, and positive content is duplicated.

### 2. Scores and visual prominence

Observed:

- Conversion Readiness: `74/100` — Moderate.
- Evidence Confidence: `95/100` — High.
- Evidence Coverage: `93%`.

All three are presented in the same three-column executive grid and use the same large-score visual treatment. This violates the contract rule that Conversion Readiness is the sole primary score and confidence/coverage are subordinate supporting information.

Internal mechanics displayed beside the secondary metrics include:

- `Known factors: 8 · Unknown (excluded): 0`
- `12 of 13 evidence capabilities`
- `Modules assessed: 10 of 10`

### 3. Ranked priorities

Exactly three priority subjects appear and their order matches the later Priority Fixes page:

1. Mobile largest contentful paint is slow.
2. Explicit FAQ content was not detected in the available partial assessment.
3. Meta descriptions were not detected on some assessed pages.

However, the executive page renders them twice:

- once under `What is really holding the site back?` with problem/business meaning;
- again under `What should you do first?` with problem/action.

The client must mentally combine the two lists. The contract requires each priority to present **Problem -> Why it matters -> Action** together.

The first action also exposes technical implementation language: `remove render-blocking work`.

### 4. Positive findings / duplicate positive sections

The executive section contains:

- `What Is Already Working`
  - Offer & Content: 94/100
  - Trust & Proof: 75/100
  - Conversion Path: 100/100

The same viewer page then contains a second separate section:

- `What Is Already Good`

That second section exposes operational/technical evidence details including crawl counts, certificate-validation limitations, browser conversion validation, `json_ld`, and `Detected on crawled pages` language.

This directly violates the requirement to combine positives into one client-facing `What is already working well?` section and remove the separate positive section.

### 5. Uncertainty and limitation wording

Observed:

`PARTIAL: 93% of intended dimension weight was assessed.`

The underlying uncertainty is preserved rather than converted into a confirmed website defect. The FAQ and search-description findings also retain scope qualifiers such as `available partial assessment`, `assessed pages`, and `unassessed pages remain unknown`.

Evidence-integrity behaviour is therefore materially stronger than the executive wording/design.

The limitation presentation still fails the S01 contract because it exposes internal weighting mechanics instead of the required short client statement:

**Assessment coverage: Nearly complete.**
A small part of the assessment could not be completed. Affected findings are marked as uncertain rather than treated as website problems.

### 6. Internal audit mechanics exposed to client

Observed on S01:

- Known factors / Unknown excluded.
- evidence-capability count.
- modules assessed count.
- intended dimension weight percentage.
- crawl page count.
- certificate-validation detail.
- browser conversion validation.
- structured-data implementation label `json_ld`.
- `Detected on crawled pages` wording.
- `supporting capability` wording.

These belong in later evidence/detail sections, not on the Executive Scorecard.

### 7. Technical/machine-language leakage

Observed executive-page language includes:

- `largest contentful paint`
- `LCP`
- `render-blocking`
- `partial assessment`
- `meta descriptions`
- `evidence capabilities`
- `modules assessed`
- `intended dimension weight`
- `certificate validity and expiry`
- `browser conversion validation`
- `json_ld`
- `supporting capability`

This prevents the intended plain-business scan experience and violates the S01 prohibited-language boundary.

### 8. Supporting-detail guidance

The current page does provide a useful pointer:

`Continue to Priority Fixes for the ranked actions, supporting evidence, and verification steps behind these executive priorities.`

This is directionally correct and should be retained/reframed under the contract heading `Where to find supporting detail`.

### 9. Evidence-integrity concerns

Directly observed uncertainty handling is mostly correct:

- FAQ absence remains explicitly bounded to the available partial assessment.
- Search-description absence remains bounded to assessed pages and says unassessed pages remain unknown.
- missing evidence is explicitly not treated as a negative finding.

No direct baseline evidence proves that these uncertainty states were upgraded into whole-site defects on S01.

One item requires verification during repair planning rather than being declared an integrity defect now: the LCP action says `remove render-blocking work`, but the executive page itself does not show the evidence basis for that specific implementation diagnosis. The repair plan must either trace that instruction to governed evidence or replace it with a bounded client action.

### 10. Contract violations

Against the approved S01 contract:

1. Required six-part hierarchy: **FAIL**.
2. Conversion Readiness sole primary score: **FAIL**.
3. Maximum three ranked priorities: **PASS on count/order**.
4. Each priority contains Problem + Why + Action together: **FAIL**.
5. Plain-business language: **FAIL**.
6. Evidence uncertainty preserved: **PASS**.
7. Positives combined into one section: **FAIL**.
8. Separate `What Is Already Good` removed: **FAIL**.
9. Internal audit mechanics removed from executive page: **FAIL**.
10. Required short assessment-coverage statement: **FAIL**.
11. Technical evidence/implementation detail deferred to later sections: **FAIL**.
12. Supporting-detail direction present: **PARTIAL PASS** — present but not under the required hierarchy/label.
13. 10–20 second client scan standard: **FAIL** — duplicate lists, duplicate positive sections, peer metrics, and technical language materially increase scan burden.

## Starting RSIP score

| Dimension | Weight | Baseline score | Rationale |
|---|---:|---:|---|
| Client decision clarity | 25 | 15 | Readiness and three issues are visible, but client decisions compete with audit mechanics and duplicate structures. |
| Actionability | 20 | 13 | Three actions exist and rank is coherent, but Problem/Why/Action are split across two lists and one action is too technical for the executive layer. |
| Plain-language readability | 15 | 5 | Multiple technical/internal terms materially violate the non-technical executive standard. |
| Evidence integrity | 20 | 18 | Partial/not-detected scope is mostly preserved correctly; one implementation-specific action requires evidence tracing before closure. |
| Information hierarchy / scanability | 10 | 3 | Three peer scores, two priority lists, and two positive sections prevent a clean 10–20 second scan. |
| Cross-report consistency | 10 | 9 | Executive priority order matches Priority Fixes and the visible uncertainty is generally consistent with later evidence; presentation duplication remains. |
| **Total** | **100** | **63** | **FAIL** |

## Hard-gate failures

Count: **2 confirmed**.

1. **Internal PRYSM mechanics presented as executive client content** where the S01 contract explicitly prohibits them.
2. **Material machine/technical language prevents the intended non-technical client understanding.**

No additional evidence-integrity hard failure is asserted from the baseline without direct proof.

## Baseline decision

**FAIL — 63/100 with 2 hard-gate failures.**

The baseline stage is COMPLETE. The repair must preserve the currently correct uncertainty boundaries while rebuilding the executive decision layer around the approved S01 contract.

Next governed stage: `REPAIR_PLAN`.
