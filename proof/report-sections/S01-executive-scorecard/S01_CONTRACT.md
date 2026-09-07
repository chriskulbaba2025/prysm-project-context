# S01 Contract — Executive Scorecard

Section: S01 — Executive Scorecard
Status: APPROVED
Approved by: Chris
Date: 2026-09-07
Contract revision: 1.1 — adds approved report-wide information-architecture dependency
Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md`
Report-wide IA contract: `PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md`

## Client question

**How ready is your website to convert visitors, and what should you do next?**

## Required client outcome

A non-technical client scanning the page for approximately 10–20 seconds must be able to identify:

1. overall website condition;
2. the three most important improvements;
3. what is already working;
4. any material uncertainty;
5. where to find deeper supporting evidence.

## Required page hierarchy

Render in this exact conceptual order:

1. **How ready is your website to convert visitors?**
2. **What should you improve first?**
3. **What is already working well?**
4. **What could we not determine?**
5. **How confident is this assessment?**
6. **Where to find supporting detail**

## Primary score rule

- Conversion Readiness is the sole primary score on the Executive Scorecard.
- Evidence Confidence and Evidence Coverage are supporting information only.
- Supporting assessment information must not receive equal visual prominence to Conversion Readiness.

## Priority rule

Render no more than three ranked priorities.

Each rendered priority must contain all three client-facing fields:

- **Problem** — what is wrong or needs improvement, bounded to what evidence supports;
- **Why it matters** — the business/conversion consequence;
- **Action** — what the client should do.

Priority order must come from the governed action hierarchy / Client Truth boundary. The executive renderer must not invent a second ranking based on severity or raw technical metrics.

If fewer than three supported priorities exist, render only the supported priorities. Do not manufacture filler priorities.

## Plain-language rule

The executive page translates governed findings into normal business language. Technical terminology and implementation mechanics belong in later evidence/detail sections.

Required examples:

- `Largest Contentful Paint` -> **Main content takes too long to appear on mobile.**
- `Meta descriptions` -> **Search-result descriptions.**

The exact business-language sentence may vary only if it preserves the same meaning and evidence scope.

## Prohibited executive-page terminology/mechanics

The Executive Scorecard must not expose these internal/technical terms as client-facing executive content:

- render-blocking;
- partial assessment;
- evidence capability;
- supporting capability;
- JSON-LD;
- browser validation;
- Known factors / Unknown excluded;
- evidence-capability counts such as `12 of 13`;
- modules assessed counts;
- intended dimension weight percentages;
- crawl page counts;
- certificate-validation details;
- browser conversion-validation mechanics;
- JSON-LD detection mechanics;
- `Detected on crawled pages`;
- implementation-level performance metric names when plain business wording is sufficient.

## Evidence-integrity rule

The Executive Scorecard must never upgrade evidence state.

Specifically:

- `not detected` does not become `missing` or `does not exist` unless the governed evidence contract establishes complete assessed absence;
- `PARTIAL` does not become complete/site-wide certainty;
- `NOT_ASSESSED`, unavailable, failed, blocked, or not-collected evidence does not become a website defect;
- uncertainty must remain visible when material to a client decision;
- wording must remain at or below the Client Truth Contract.

Any violation is a hard-gate failure regardless of numeric score.

## Positive-findings rule

All executive positives must be consolidated under one section:

**What is already working well?**

Do not retain a separate competing executive positive section such as `What Is Already Good`.

This rule applies to the conceptual Executive Scorecard page. Detailed positive evidence may remain in later report pages when relevant.

## Assessment-coverage rule

Internal audit mechanics must be replaced on the Executive Scorecard by a short client limitation statement when coverage is nearly complete but not complete:

**Assessment coverage: Nearly complete.**

A small part of the assessment could not be completed. Affected findings are marked as uncertain rather than treated as website problems.

If the actual governed coverage state is materially different from `Nearly complete`, the renderer must use equally plain wording that truthfully reflects the governed state rather than falsely forcing this label.

## Supporting-detail rule

The Executive Scorecard must tell the client where deeper evidence can be found without reproducing the implementation detail itself.

The pointer should direct the client to the relevant later report sections rather than exposing PRYSM mechanics on S01.

Supporting technical/evidence material must follow the approved report-wide information architecture: it belongs behind the subordinate **Supporting Evidence / Technical Detail** surface, not in the primary client navigation.

## Report-wide navigation dependency

S01 is primary client destination **01 of 08**.

The primary client navigation visible from S01 must ultimately contain exactly:

1. Executive Scorecard
2. Priority Fixes
3. Conversion Journey
4. Content Opportunities
5. Competitor Comparison
6. Trust & Credibility
7. Website Speed & Performance
8. Mobile & Accessibility

S04, S08, S09, S10, S11, S14, S15, and S16 must not appear as equal-weight primary navigation items. They must remain reachable through subordinate Supporting Evidence / Technical Detail navigation.

Because S01 is the first active RSIP section and its renderer owns the viewer shell, the S01 repair may include the bounded navigation migration when exact local source/test verification proves that seam. If included, the navigation migration becomes part of S01 deterministic and human acceptance rather than a separate unmeasured cosmetic edit.

## Universal RSIP scorecard

| Dimension | Weight |
|---|---:|
| Client decision clarity | 25 |
| Actionability | 20 |
| Plain-language readability | 15 |
| Evidence integrity | 20 |
| Information hierarchy / scanability | 10 |
| Cross-report consistency | 10 |
| **Total** | **100** |

PASS: >=95/100 + zero hard-gate failures + deterministic PASS + human review PASS.

## S01 deterministic acceptance criteria

The S01 deterministic proof must establish at minimum:

1. required conceptual heading order is preserved;
2. Conversion Readiness is the sole primary executive score;
3. assessment confidence/coverage is secondary;
4. no more than three ranked priorities render;
5. each priority contains Problem / Why it matters / Action;
6. priority ordering preserves governed action hierarchy;
7. positive findings are consolidated under `What is already working well?`;
8. no separate competing executive `What Is Already Good` section remains;
9. material uncertainty is preserved;
10. the coverage limitation is plain-language and truthful;
11. supporting-detail guidance is present;
12. prohibited executive terminology/mechanics are absent from S01 client-facing output;
13. supported business-language translations replace technical executive wording;
14. no undefined/null/empty required client slots render;
15. existing relevant cross-report/evidence-integrity regressions remain green;
16. primary navigation contains exactly 8 destinations;
17. primary navigation order and client-facing labels match the approved report-wide IA contract;
18. no supporting-detail page appears as a peer primary destination;
19. all supporting-detail pages remain reachable through the subordinate supporting-detail surface;
20. viewer switching and print/save behaviour remain functional after navigation migration.

## Human acceptance test

Using the actual rendered TBK S01 page, a non-technical reviewer should be able to answer within approximately 10–20 seconds:

1. What condition is this website in?
2. What are the top three improvements?
3. What is already working?
4. Is anything materially uncertain?
5. Where should I go for supporting evidence?

The reviewer must also be able to identify the 8 primary report destinations without technical/evidence pages competing for equal attention.

Required human result: **5/5 readily identifiable**, correct 8-item primary navigation, no material machine-language leakage, and no misleading certainty.