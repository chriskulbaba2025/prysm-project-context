# S02 Baseline Audit — Priority Fixes

Date: 2026-09-07
Section: `S02 — Priority Fixes`
RSIP stage: `BASELINE_AUDIT`
Result: **FAIL**
Universal score: **67/100**
Hard-gate failures: **2**
Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md` v1.2.0
Report-wide IA contract: `PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md` v1.1.0

## Review object

Locked actual TBK report:

`C:\Users\kulba\Downloads\PRYSM-S01-TBK-CURRENT-REVIEW.html`

SHA-256:

`857CC9CAFF4127EE3A721BB72E3122FA0953FA946C362AE1E0111DD867E72BE8`

Audit ID:

`8d22e6b9-9246-4fb2-9f65-4cfc97a5b9e3`

Viewer: `2.3.0`

Governed source sections rendered on the Priority Fixes destination:

- `blockers`
- `foundations`
- `action-plan`

The baseline was reviewed from the actual locked report and corroborated by the current four-page Priority Fixes screenshot supplied by Chris. No provider/model call, evidence recollection, new production audit, production mutation, application edit, push, merge, or deployment was used.

## Current information order

The current Priority Fixes surface presents multiple overlapping decision structures:

1. **What should you fix first? / E. What should be fixed first?** — ranked five-row priority findings table.
2. **First Things First — Foundational Readiness** — separate foundation matrix with PASS / FINDING / UNAVAILABLE states.
3. **Client Action Plan** — repeats the same governed priorities under `DO NOW`, `DO NEXT`, `LATER / OPTIMIZE`, and `MEASURE`.
4. Additional **Root Cause**, **Business consequences**, **Conversion**, and **Action plan** blocks repeat or reframe the same priority story again.

The result is not a single client action sequence. The client must reconcile several structures to determine what actually comes first.

## Ranked findings currently visible

The governed ranked action order is understandable inside the first priority table and is broadly consistent with locked S01:

1. mobile main-content loading performance;
2. buyer-question content not detected within the available assessed scope;
3. search-result descriptions not detected on some assessed pages;
4. inconsistent heading structure;
5. incomplete assessed security headers.

The top-three sequence matches the locked S01 priority story. The problem is presentation: later `First Things First` and action-plan structures compete with this hierarchy rather than reinforcing it.

## What the page currently tells the client to change

The page contains real actions, but they are expressed with mixed client and implementation language:

- optimize the largest above-the-fold asset and remove render-blocking work;
- add FAQ content based on buyer questions before booking prospects ask;
- write unique 150–160 character descriptions;
- use one descriptive H1 with sequential H2/H3 sections;
- configure missing response headers at the hosting layer.

These instructions are actionable for a technical implementer but too implementation-heavy for the primary client decision layer.

## Mechanical / technical language leakage

Examples visible on the primary client page include:

- rule IDs such as `VAN-PERF-001`;
- classes such as `HIGH_CONVERSION` and `OPTIMIZATION`;
- raw effort codes such as `M` and `L`;
- `deterministic evidence confidence`;
- `LCP` / Largest Contentful Paint mechanics;
- `render-blocking` work;
- `hosting layer`;
- `structured data` verification mechanics;
- repeated `re-crawl` instructions;
- long raw affected-URL lists.

These details are useful supporting evidence but crowd the primary client page and make the language read like an audit system rather than a prioritized client recommendation.

## Duplication

Material duplication exists across:

- Priority Findings;
- Foundational Readiness;
- Client Action Plan;
- Root Cause / Business consequences;
- later Action plan.

The same five priorities are repeated in different shapes, with overlapping rationale and verification language. This increases page length without improving the client decision.

## Evidence integrity and uncertainty

Evidence boundaries are generally strong.

Positive examples:

- buyer-question content remains bounded to the available partial assessment rather than being upgraded into a site-wide absence;
- unavailable foundation checks remain `UNAVAILABLE` instead of becoming defects;
- unassessed pages remain unknown;
- conversion outcomes are not claimed where they were not measured.

No unsupported certainty was identified in the baseline review.

## Cross-report consistency

The first ranked priority sequence is consistent with locked S01, especially:

- mobile loading friction remains the principal priority;
- buyer-question uncertainty remains scoped to assessed pages;
- search-result description work remains the third executive priority.

The cross-report weakness is structural: `First Things First — Foundational Readiness` creates a competing sense of what comes before the governed ranked priorities.

## Scanability / client usefulness

The page is visually crowded and text-dense.

Primary causes:

- seven-column priority tables;
- long sentences inside narrow cells;
- long raw URL lists;
- repeated five-item action tables;
- large foundation status matrix;
- multiple headings that appear to answer the same question;
- internal status/classification fields competing with the action itself.

A client can eventually recover the correct order, but the page does not currently support a fast 10–20 second decision scan.

## Universal RSIP score

| Dimension | Score |
|---|---:|
| Client decision clarity | 16/25 |
| Actionability | 15/20 |
| Plain-language readability | 7/15 |
| Evidence integrity | 20/20 |
| Information hierarchy / scanability | 3/10 |
| Cross-report consistency | 6/10 |
| **Total** | **67/100** |

PASS threshold: `95/100 + zero hard-gate failures`.

## Hard-gate failures

### HG-1 — material machine/technical language blocks intended client understanding

The client-facing page exposes enough internal and implementation terminology that a non-technical client must decode PRYSM mechanics to understand the recommendation.

**Result: FAIL.**

### HG-2 — competing priority hierarchy

`First Things First — Foundational Readiness` creates a second apparent priority hierarchy alongside the governed ranked action sequence. This weakens the meaning of the governed order and leaves the client uncertain whether to follow the ranked findings or the foundation list first.

**Result: FAIL.**

## Root cause

**S02 exposes audit machinery and client action guidance as equal-weight content instead of translating the governed evidence into one authoritative ranked client action sequence.**

## Single strongest repair direction

Make S02 one authoritative ranked action sequence.

Each supported priority should communicate only the client decision fields needed to act:

1. **What needs attention**
2. **Why it matters**
3. **What to change**
4. **Where it applies**
5. **How to confirm it improved**
6. **Material uncertainty**, only when required by the evidence boundary

Move rule IDs, classes, raw confidence mechanics, raw effort codes, large URL inventories, detailed foundation matrices, and implementation-level verification mechanics to `Supporting Detail`.

Foundational readiness must not create a second independent priority list. If a foundation materially changes the governed action order, it must be represented in that same governed sequence; otherwise it remains supporting detail.

## Baseline decision

`S02 BASELINE_AUDIT: FAIL — 67/100 — 2 hard-gate failures.`

The baseline is complete. No application repair is authorized by this artifact.