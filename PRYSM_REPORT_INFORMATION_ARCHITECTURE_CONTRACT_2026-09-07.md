# PRYSM Report Information Architecture Contract

Date: 2026-09-07
Status: APPROVED
Owner: Chris
Applies to: PRYSM Report Viewer / RSIP section-improvement program

## Governing outcome

The primary PRYSM report navigation must contain only sections that help a non-technical client understand:

- conversion performance;
- customer friction;
- competitive gaps;
- what to improve.

Audit mechanics, implementation diagnostics, evidence provenance, and technical detail must not compete with client decision pages in the primary navigation.

## Root cause

The current 16-page navigation mixes client decisions with audit mechanics. This creates unnecessary cognitive load and makes internal diagnostic material appear equal in importance to conversion decisions.

## Primary client navigation — required final state

The primary menu must contain exactly these 8 client-facing destinations, in this order:

| Primary menu # | Stable source section ID | Current source title | Client-facing title | Decision |
|---:|---|---|---|---|
| 01 | S01 | Executive Scorecard | **Executive Scorecard** | KEEP |
| 02 | S02 | Priority Fixes | **Priority Fixes** | KEEP |
| 03 | S03 | Conversion Path Architecture | **Conversion Journey** | KEEP + RENAME |
| 04 | S05 | Topical Map & Qualified Content Opportunities | **Content Opportunities** | KEEP + RENAME |
| 05 | S06 | Competitor Benchmarking | **Competitor Comparison** | KEEP + RENAME |
| 06 | S07 | Trust & E-E-A-T Readiness | **Trust & Credibility** | KEEP + RENAME |
| 07 | S12 | Performance | **Website Speed & Performance** | KEEP + RENAME |
| 08 | S13 | Accessibility & Mobile Usability Readiness | **Mobile & Accessibility** | KEEP + RENAME |

Stable source IDs are retained for governance/history. Primary-menu numbering is a presentation order and does not renumber historical S## identifiers.

## Supporting Evidence / Technical Detail tier

These sections must not appear as peer destinations in the primary client menu. They remain available behind a clearly subordinate **Supporting Evidence / Technical Detail** entry or equivalent secondary navigation surface:

| Stable source section ID | Current source title | Supporting client label | Decision |
|---|---|---|---|
| S04 | Conversion Readiness Map | Conversion Readiness Detail | REMOVE FROM MAIN MENU; retain only as supporting detail unless a later governed decision removes it entirely |
| S08 | CMS & Platform Constraints | CMS & Platform Detail | SUPPORTING DETAIL |
| S09 | Technical SEO Hygiene | Technical SEO Detail | SUPPORTING DETAIL |
| S10 | Heading & Semantic Structure | Heading & Structure Detail | SUPPORTING DETAIL |
| S11 | Schema & Entity Clarity | Schema & Entity Detail | SUPPORTING DETAIL |
| S14 | Internal-Link Opportunities | Internal-Link Detail | SUPPORTING DETAIL |
| S15 | Evidence Appendix | Supporting Evidence | SUPPORTING DETAIL |
| S16 | Deferred & Unavailable Analysis | Assessment Limitations | SUPPORTING DETAIL |

## Navigation hard rules

1. Exactly 8 primary client destinations must be visible in the main navigation.
2. Primary menu order must match the table above.
3. Client-facing primary labels must match the approved names above unless Chris explicitly approves a later versioned rename.
4. S04, S08, S09, S10, S11, S14, S15, and S16 must not appear as equal-weight primary navigation items.
5. Supporting detail must remain reachable from the client report through a clearly subordinate `Supporting Evidence / Technical Detail` surface.
6. Moving a page to supporting detail must not delete governed evidence or weaken traceability.
7. Technical/evidence pages may remain individually addressable internally or through secondary navigation; they must not compete visually with the 8 primary client decision pages.
8. The Executive Scorecard and other primary pages may point into supporting detail where deeper evidence is useful.
9. The navigation migration must not change scoring, evidence collection, Client Truth, finding truth, lifecycle, storage, provider/model behaviour, or production data.
10. The viewer must remain deterministic and usable in browser/print modes after navigation migration.

## RSIP execution order

### Primary client lane

Improve and lock these first:

`S01 -> S02 -> S03 -> S05 -> S06 -> S07 -> S12 -> S13`

No later primary client section becomes ACTIVE until the preceding primary section is `PASS_LOCKED`.

### Supporting-detail lane

After the 8 primary client sections are locked, improve/audit supporting-detail pages in this order unless a later approved plan changes it:

`S04 -> S08 -> S09 -> S10 -> S11 -> S14 -> S15 -> S16`

Supporting pages remain governed and measurable; moving them out of primary navigation does not exempt them from evidence-integrity or quality review.

## Report-wide deterministic acceptance criteria

The repaired viewer/navigation must prove:

- primary navigation count = 8;
- primary navigation order = approved order;
- primary labels = approved client-facing labels;
- no supporting-detail section appears as a peer primary item;
- all retained supporting-detail sections remain reachable;
- stable underlying section IDs/content ownership remain traceable;
- primary-page links to deeper evidence resolve to the appropriate primary/supporting destination;
- viewer page switching remains deterministic;
- print/save behaviour remains functional;
- no evidence/scoring/client-truth semantics change solely because navigation placement changes.

## Human acceptance criteria

A non-technical client viewing the navigation should immediately understand that the report is organized around:

1. overall condition;
2. priorities;
3. conversion journey;
4. content opportunities;
5. competitor comparison;
6. trust/credibility;
7. speed/performance;
8. mobile/accessibility.

Technical and evidentiary material must clearly read as supporting detail rather than equal-weight client decisions.

## Measurement

Report-wide navigation quality is measured as a hard contract, not a subjective preference:

- 8/8 primary destinations present;
- 0 prohibited supporting pages in primary navigation;
- 8/8 approved labels correct;
- 8/8 approved order positions correct;
- all supporting-detail destinations reachable;
- 0 broken viewer/print navigation regressions.

Any failure above blocks navigation closure regardless of section score.

## Implementation boundary

This contract defines the required outcome but does not itself authorize application edits.

Exact implementation files/tests must be verified from the current intentional dirty local P1 worktree under the active S01 `REPAIR_PLAN` stage before BUILD.
