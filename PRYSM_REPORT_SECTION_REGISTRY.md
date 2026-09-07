# PRYSM Report Section Registry

Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md`
Report-wide IA contract: `PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md`
Viewer source contract: `REPORT_V2_VIEWER_PAGES` in `services/worker/src/report/render-report-v2.js`
Current viewer version: `2.3.0`
Current active section: `S02 — Priority Fixes`

| Stable ID | Current source section | Final client-facing label | Navigation tier | RSIP status | Score | Notes |
|---|---|---|---|---|---:|---|
| S01 | Executive Scorecard | Executive Scorecard | PRIMARY 01 | **PASS_LOCKED** | **98** | Human review PASS; zero hard gates. Locked real TBK artifact: `C:\Users\kulba\Downloads\PRYSM-S01-TBK-CURRENT-REVIEW.html`, SHA-256 `857CC9CAFF4127EE3A721BB72E3122FA0953FA946C362AE1E0111DD867E72BE8`. Final presentation repair, focused tests, deterministic closure, offline replay, HTML verification, and canonical immutability all PASS. Closure: `proof/report-sections/S01-executive-scorecard/S01_CLOSURE.md`. |
| S02 | Priority Fixes | Priority Fixes | PRIMARY 02 | **ACTIVE — CONTRACT** | **67** | Baseline complete: FAIL, 2 hard gates. Root cause: audit machinery and client actions are presented as equal-weight content, producing duplication, dense tables, and a competing priority hierarchy. Contract draft: `proof/report-sections/S02-priority-fixes/S02_CONTRACT.md`. No application edit authorized. |
| S03 | Conversion Path Architecture | Conversion Journey | PRIMARY 03 | NOT_STARTED | — | Rename/retain in client navigation. |
| S04 | Conversion Readiness Map | Conversion Readiness Detail | SUPPORTING DETAIL | NOT_STARTED | — | Retain behind Supporting Detail. |
| S05 | Topical Map & Qualified Content Opportunities | Content Opportunities | PRIMARY 04 | NOT_STARTED | — | Rename/retain in client navigation. |
| S06 | Competitor Benchmarking | Competitor Comparison | PRIMARY 05 | NOT_STARTED | — | Rename/retain in client navigation. |
| S07 | Trust & E-E-A-T Readiness | Trust & Credibility | PRIMARY 06 | NOT_STARTED | — | Rename/retain in client navigation. |
| S08 | CMS & Platform Constraints | CMS & Platform Detail | SUPPORTING DETAIL | NOT_STARTED | — | Retain behind Supporting Detail. |
| S09 | Technical SEO Hygiene | Technical SEO Detail | SUPPORTING DETAIL | NOT_STARTED | — | Retain behind Supporting Detail. |
| S10 | Heading & Semantic Structure | Heading & Structure Detail | SUPPORTING DETAIL | NOT_STARTED | — | Retain behind Supporting Detail. |
| S11 | Schema & Entity Clarity | Schema & Entity Detail | SUPPORTING DETAIL | NOT_STARTED | — | Retain behind Supporting Detail. |
| S12 | Performance | Website Speed & Performance | SUPPORTING DETAIL | NOT_STARTED | — | Moved from peer navigation to Supporting Detail under IA contract v1.1.0; evidence retained. |
| S13 | Accessibility & Mobile Usability Readiness | Mobile & Accessibility | SUPPORTING DETAIL | NOT_STARTED | — | Moved from peer navigation to Supporting Detail under IA contract v1.1.0; evidence retained. |
| S14 | Internal-Link Opportunities | Internal-Link Detail | SUPPORTING DETAIL | NOT_STARTED | — | Retain behind Supporting Detail. |
| S15 | Evidence Appendix | Supporting Evidence | SUPPORTING DETAIL | NOT_STARTED | — | Retain behind Supporting Detail. |
| S16 | Deferred & Unavailable Analysis | Assessment Limitations | SUPPORTING DETAIL | NOT_STARTED | — | Retain behind Supporting Detail. |

## RSIP execution order

Primary client lane first:

`S01 -> S02 -> S03 -> S05 -> S06 -> S07`

Supporting-detail lane second:

`S12 -> S13 -> S04 -> S08 -> S09 -> S10 -> S11 -> S14 -> S15 -> S16`

## Registry rules

- Exactly one section may be ACTIVE.
- A section advances to `PASS_LOCKED` only under RSIP closure rules.
- The next section may not activate until the current section is `PASS_LOCKED`.
- The primary client lane is completed before the supporting-detail lane unless Chris explicitly approves a versioned change.
- A locked section may reopen only under the RSIP evidence-based reopen rule.
- Stable S## IDs are governance identifiers and are not renumbered when client navigation changes.
- Peer client navigation must expose exactly the 6 PRIMARY rows, in PRIMARY order, using the approved client-facing labels.
- One visibly subordinate `Supporting Detail` destination contains all SUPPORTING DETAIL rows.
- Supporting detail must remain reachable and evidence-preserving.
