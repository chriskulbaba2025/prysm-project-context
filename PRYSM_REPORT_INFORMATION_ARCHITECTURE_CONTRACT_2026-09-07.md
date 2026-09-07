# PRYSM Report Information Architecture Contract

Version: 1.1.0
Date: 2026-09-07
Status: APPROVED
Owner: Chris
Applies to: PRYSM Report Viewer / RSIP section-improvement program

## Revision note

Version 1.1.0 supersedes the earlier 8-peer-menu layout from this same date.

During S01 human review, Chris determined that the left navigation was still too long and that Website Speed & Performance and Mobile & Accessibility should not compete as peer decision pages. Chris explicitly approved the bounded client-simplification repair that reduced the visible peer client navigation to six destinations and placed all deeper diagnostic/evidence material behind one subordinate **Supporting Detail** destination.

This is a presentation/information-architecture change only. It does not alter canonical evidence, scores, findings, Client Truth, scoring logic, evidence collection, lifecycle, provider/model behavior, or production data.

## Governing outcome

The primary PRYSM report navigation must contain only sections that help a non-technical client quickly understand:

- overall conversion readiness;
- what should be fixed first;
- whether the conversion journey is clear;
- content opportunities;
- competitor context;
- trust and credibility.

Audit mechanics, implementation diagnostics, evidence provenance, performance detail, accessibility/mobile diagnostics, and technical detail must not compete with these client decision pages in the primary navigation.

## Root cause

The earlier navigation still exposed too many peer destinations. Even when technical/evidence pages were grouped into primary versus supporting tiers, the visible menu remained too long for a client decision report.

The corrected design keeps the client decision lane intentionally short and makes all deeper material reachable from one subordinate destination.

## Primary client navigation — required final state

The visible peer client menu must contain exactly these 6 destinations, in this order:

| Primary menu # | Stable source section ID | Current source title | Client-facing title | Decision |
|---:|---|---|---|---|
| 01 | S01 | Executive Scorecard | **Executive Scorecard** | KEEP |
| 02 | S02 | Priority Fixes | **Priority Fixes** | KEEP |
| 03 | S03 | Conversion Path Architecture | **Conversion Journey** | KEEP + RENAME |
| 04 | S05 | Topical Map & Qualified Content Opportunities | **Content Opportunities** | KEEP + RENAME |
| 05 | S06 | Competitor Benchmarking | **Competitor Comparison** | KEEP + RENAME |
| 06 | S07 | Trust & E-E-A-T Readiness | **Trust & Credibility** | KEEP + RENAME |

Stable source IDs are retained for governance/history. Primary-menu numbering is a presentation order and does not renumber historical S## identifiers.

## Supporting Detail destination

All remaining report sections remain governed and reachable but must not appear as peer client destinations. The visible navigation exposes one subordinate destination:

**Supporting Detail**

The Supporting Detail page/surface contains the governed sections below:

| Stable source section ID | Current source title | Supporting label / role |
|---|---|---|
| S12 | Performance | Website Speed & Performance |
| S13 | Accessibility & Mobile Usability Readiness | Mobile & Accessibility |
| S04 | Conversion Readiness Map | Conversion Readiness Detail |
| S08 | CMS & Platform Constraints | CMS & Platform Detail |
| S09 | Technical SEO Hygiene | Technical SEO Detail |
| S10 | Heading & Semantic Structure | Heading & Structure Detail |
| S11 | Schema & Entity Clarity | Schema & Entity Detail |
| S14 | Internal-Link Opportunities | Internal-Link Detail |
| S15 | Evidence Appendix | Supporting Evidence |
| S16 | Deferred & Unavailable Analysis | Assessment Limitations |

These sections remain individually governed and may remain internally addressable, but they do not compete visually with the six client decision pages.

## Navigation hard rules

1. Exactly 6 peer client destinations must be visible in the main navigation.
2. Primary menu order must match the six-item table above.
3. Client-facing primary labels must match the approved names above unless Chris explicitly approves a later versioned change.
4. Exactly one visibly subordinate **Supporting Detail** navigation destination must expose deeper material.
5. S04, S08, S09, S10, S11, S12, S13, S14, S15, and S16 must not appear as equal-weight peer primary navigation items.
6. Supporting detail must remain reachable from the client report.
7. Moving a page to Supporting Detail must not delete governed evidence or weaken traceability.
8. Primary pages may point into Supporting Detail where deeper evidence is useful.
9. The navigation migration must not change scoring, evidence collection, Client Truth, finding truth, lifecycle, storage, provider/model behaviour, or production data.
10. The viewer must remain deterministic and usable in browser/print modes after navigation migration.

## RSIP execution order

### Primary client lane

Improve and lock these first:

`S01 -> S02 -> S03 -> S05 -> S06 -> S07`

No later primary client section becomes ACTIVE until the preceding primary section is `PASS_LOCKED`.

### Supporting-detail lane

After the six primary client sections are locked, improve/audit retained supporting detail in this order unless Chris explicitly approves a later versioned change:

`S12 -> S13 -> S04 -> S08 -> S09 -> S10 -> S11 -> S14 -> S15 -> S16`

Supporting pages remain governed and measurable; moving them out of peer navigation does not exempt them from evidence-integrity or quality review.

## Report-wide deterministic acceptance criteria

The repaired viewer/navigation must prove:

- peer primary navigation count = 6;
- primary navigation order = approved order;
- primary labels = approved client-facing labels;
- one subordinate Supporting Detail navigation destination exists;
- no supporting-detail section appears as a peer primary item;
- all retained supporting-detail content remains reachable;
- stable underlying section IDs/content ownership remain traceable;
- primary-page links to deeper evidence resolve appropriately;
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
6. trust/credibility.

Speed, accessibility/mobile, technical, and evidentiary material must clearly read as deeper Supporting Detail rather than equal-weight client decisions.

## Measurement

Report-wide navigation quality is measured as a hard contract:

- 6/6 peer client destinations present;
- 0 prohibited supporting sections exposed as peer primary items;
- 6/6 approved labels correct;
- 6/6 approved order positions correct;
- exactly one subordinate Supporting Detail entry present;
- all supporting-detail content reachable;
- 0 broken viewer/print navigation regressions.

Any failure above blocks navigation closure regardless of section score.

## Implementation boundary

This contract defines the required outcome but does not itself authorize application edits.

The S01 human-review repair was separately authorized by Chris and verified against the existing intentional dirty P1/S01 worktree. Future application changes require their own governed RSIP boundary.
