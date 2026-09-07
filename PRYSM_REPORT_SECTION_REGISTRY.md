# PRYSM Report Section Registry

Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md`
Viewer contract source: `REPORT_V2_VIEWER_PAGES` in `services/worker/src/report/render-report-v2.js`
Viewer version: `2.2.0`
Current active section: `S01 — Executive Scorecard`

| ID | Report section | Status | Score | Notes |
|---|---|---|---:|---|
| S01 | Executive Scorecard | ACTIVE — REPAIR_PLAN | 63 | Baseline direct-render audit complete: FAIL, 2 hard-gate failures. Exact local source/test boundary verification is next; no code edits yet. |
| S02 | Priority Fixes | NOT_STARTED | — | Begins only after S01 PASS_LOCKED. |
| S03 | Conversion Path Architecture | NOT_STARTED | — |  |
| S04 | Conversion Readiness Map | NOT_STARTED | — |  |
| S05 | Topical Map & Qualified Content Opportunities | NOT_STARTED | — |  |
| S06 | Competitor Benchmarking | NOT_STARTED | — |  |
| S07 | Trust & E-E-A-T Readiness | NOT_STARTED | — |  |
| S08 | CMS & Platform Constraints | NOT_STARTED | — |  |
| S09 | Technical SEO Hygiene | NOT_STARTED | — |  |
| S10 | Heading & Semantic Structure | NOT_STARTED | — |  |
| S11 | Schema & Entity Clarity | NOT_STARTED | — |  |
| S12 | Performance | NOT_STARTED | — |  |
| S13 | Accessibility & Mobile Usability Readiness | NOT_STARTED | — |  |
| S14 | Internal-Link Opportunities | NOT_STARTED | — |  |
| S15 | Evidence Appendix | NOT_STARTED | — |  |
| S16 | Deferred & Unavailable Analysis | NOT_STARTED | — |  |

## Registry rules

- Exactly one section may be ACTIVE.
- A section advances to `PASS_LOCKED` only under RSIP closure rules.
- The next section may not activate until the current section is `PASS_LOCKED`.
- A locked section may reopen only under the RSIP evidence-based reopen rule.
- Section names/order must not be changed here independently of an approved viewer-contract migration.