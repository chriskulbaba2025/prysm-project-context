# PRYSM Report Section Registry

Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md`
Report-wide IA contract: `PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md`
Viewer source contract: `REPORT_V2_VIEWER_PAGES` in `services/worker/src/report/render-report-v2.js`
Viewer version: `2.2.0`
Current active section: `S01 — Executive Scorecard`

| Stable ID | Current source section | Final client-facing label | Navigation tier | RSIP status | Score | Notes |
|---|---|---|---|---|---:|---|
| S01 | Executive Scorecard | Executive Scorecard | PRIMARY 01 | ACTIVE — REPAIR_PLAN | 63 | Baseline direct-render audit complete: FAIL, 2 hard gates. S01 repair now also carries the approved primary/supporting navigation migration if exact local seam confirms viewer ownership. |
| S02 | Priority Fixes | Priority Fixes | PRIMARY 02 | NOT_STARTED | — | Begins only after S01 PASS_LOCKED. |
| S03 | Conversion Path Architecture | Conversion Journey | PRIMARY 03 | NOT_STARTED | — | Rename in client navigation. |
| S04 | Conversion Readiness Map | Conversion Readiness Detail | SUPPORTING | NOT_STARTED | — | Remove from main menu; retain as supporting detail unless later governed decision removes it entirely. |
| S05 | Topical Map & Qualified Content Opportunities | Content Opportunities | PRIMARY 04 | NOT_STARTED | — | Rename in client navigation. |
| S06 | Competitor Benchmarking | Competitor Comparison | PRIMARY 05 | NOT_STARTED | — | Rename in client navigation. |
| S07 | Trust & E-E-A-T Readiness | Trust & Credibility | PRIMARY 06 | NOT_STARTED | — | Rename in client navigation. |
| S08 | CMS & Platform Constraints | CMS & Platform Detail | SUPPORTING | NOT_STARTED | — | Remove from peer primary navigation. |
| S09 | Technical SEO Hygiene | Technical SEO Detail | SUPPORTING | NOT_STARTED | — | Remove from peer primary navigation. |
| S10 | Heading & Semantic Structure | Heading & Structure Detail | SUPPORTING | NOT_STARTED | — | Remove from peer primary navigation. |
| S11 | Schema & Entity Clarity | Schema & Entity Detail | SUPPORTING | NOT_STARTED | — | Remove from peer primary navigation. |
| S12 | Performance | Website Speed & Performance | PRIMARY 07 | NOT_STARTED | — | Rename in client navigation. |
| S13 | Accessibility & Mobile Usability Readiness | Mobile & Accessibility | PRIMARY 08 | NOT_STARTED | — | Rename in client navigation. |
| S14 | Internal-Link Opportunities | Internal-Link Detail | SUPPORTING | NOT_STARTED | — | Remove from peer primary navigation. |
| S15 | Evidence Appendix | Supporting Evidence | SUPPORTING | NOT_STARTED | — | Subordinate evidence destination. |
| S16 | Deferred & Unavailable Analysis | Assessment Limitations | SUPPORTING | NOT_STARTED | — | Subordinate limitations destination. |

## RSIP execution order

Primary client lane first:

`S01 -> S02 -> S03 -> S05 -> S06 -> S07 -> S12 -> S13`

Supporting-detail lane second:

`S04 -> S08 -> S09 -> S10 -> S11 -> S14 -> S15 -> S16`

## Registry rules

- Exactly one section may be ACTIVE.
- A section advances to `PASS_LOCKED` only under RSIP closure rules.
- The next section may not activate until the current section is `PASS_LOCKED`.
- The primary client lane is completed before the supporting-detail lane unless Chris explicitly approves a versioned change.
- A locked section may reopen only under the RSIP evidence-based reopen rule.
- Stable S## IDs are governance identifiers and are not renumbered when client navigation changes.
- Primary client navigation must expose exactly the 8 PRIMARY rows, in PRIMARY order, using the approved client-facing labels.
- SUPPORTING rows must remain reachable but may not appear as equal-weight primary navigation items.
