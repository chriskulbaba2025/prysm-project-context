# PRYSM Report Section Registry

Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md`
Report-wide IA contract: `PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md`
Viewer source contract: `REPORT_V2_VIEWER_PAGES` in `services/worker/src/report/render-report-v2.js`
Current viewer version: `2.3.0`
Current active surface: `Supporting Detail`

| Stable ID | Current source section | Final client-facing label | Navigation tier | RSIP status | Score | Notes |
|---|---|---|---|---|---:|---|
| S01 | Executive Scorecard | Executive Scorecard | PRIMARY 01 | **PASS_LOCKED** | **98** | Human review PASS; zero hard gates. |
| S02 | Priority Fixes | Priority Fixes | PRIMARY 02 | **PASS_LOCKED** | **97** | Human review PASS; zero hard gates. |
| S03 | Conversion Path Architecture | Conversion Journey | PRIMARY 03 | **PASS_LOCKED** | **97** | Human review PASS; locked narrative pattern: **Primary pages interpret. Deeper pages explain.** |
| S04 | Conversion Readiness Map | Conversion Readiness Detail | SUPPORTING DETAIL | INCLUDED IN ACTIVE SUPPORTING DETAIL | — | Readiness spider chart retained and prominent. |
| S05 | Topical Map & Qualified Content Opportunities | Content Opportunities | PRIMARY 04 | **PASS_LOCKED** | **97** | Bounded client redesign complete; governed opportunity order preserved. |
| S06 | Competitor Benchmarking | Competitor Comparison | PRIMARY 05 | **PASS_LOCKED** | **97** | Human review PASS; no unsupported comparative gap introduced. |
| S07 | Trust & E-E-A-T Readiness | Trust & Credibility | PRIMARY 06 | **PASS_LOCKED** | **98** | Human review PASS; no manufactured trust gap. |
| S08 | CMS & Platform Constraints | CMS & Platform Detail | SUPPORTING DETAIL | INCLUDED IN ACTIVE SUPPORTING DETAIL | — | Secondary/detail treatment retained. |
| S09 | Technical SEO Hygiene | Technical SEO Detail | SUPPORTING DETAIL | INCLUDED IN ACTIVE SUPPORTING DETAIL | — | Progressive disclosure and client-facing summaries applied. |
| S10 | Heading & Semantic Structure | Heading & Structure Detail | SUPPORTING DETAIL | INCLUDED IN ACTIVE SUPPORTING DETAIL | — | Detailed evaluated-page evidence behind disclosure. |
| S11 | Schema & Entity Clarity | Schema & Entity Detail | SUPPORTING DETAIL | INCLUDED IN ACTIVE SUPPORTING DETAIL | — | Entity relationship visual retained. |
| S12 | Performance | Website Speed & Performance | SUPPORTING DETAIL | INCLUDED IN ACTIVE SUPPORTING DETAIL | — | Lab/field distinction preserved; raw diagnostics moved behind disclosure. |
| S13 | Accessibility & Mobile Usability Readiness | Mobile & Accessibility | SUPPORTING DETAIL | INCLUDED IN ACTIVE SUPPORTING DETAIL | — | Material unavailable evidence remains visible. |
| S14 | Internal-Link Opportunities | Internal-Link Detail | SUPPORTING DETAIL | INCLUDED IN ACTIVE SUPPORTING DETAIL | — | Representative sampling used; long URL dump removed from default view. |
| S15 | Evidence Appendix | Supporting Evidence | SUPPORTING DETAIL | INCLUDED IN ACTIVE SUPPORTING DETAIL | — | Raw mechanics remain deeper/collapsed. |
| S16 | Deferred & Unavailable Analysis | Assessment Limitations | SUPPORTING DETAIL | INCLUDED IN ACTIVE SUPPORTING DETAIL | — | Evidence & Limitations group begins at `#phase2`. |

## Primary client lane

All six primary client pages are closed:

`Executive Scorecard -> Priority Fixes -> Conversion Journey -> Content Opportunities -> Competitor Comparison -> Trust & Credibility`

Scores:

`98 -> 97 -> 97 -> 97 -> 97 -> 98`

## Supporting Detail current status

Supporting Detail remains one subordinate destination and is **not Page 7**.

Verified current behaviour:
- separate `Evidence & Detail` menu treatment;
- no primary number;
- eight-part local jump navigation `8/8 PASS`;
- Pages 1–6 do not display the Supporting Detail narrative disclosure `6/6 PASS`;
- readiness spider chart retained;
- entity relationship diagram retained;
- progressive disclosure and representative sampling implemented;
- full report suite last verified `129 PASS / 0 FAIL`;
- `git diff --check` PASS.

Governing principle:

**Supporting Detail must support consulting decisions, not expose raw audit volume merely because the evidence exists.**

The narrative content-worthiness audit scored the prior disclosure `54/100 — MAJOR REDUCTION REQUIRED`.

The subsequent bounded build reduced the client-facing disclosure to three compact blocks under:

`Additional interpretation and evidence context`

Current compact-disclosure review score: **96/100**.

Remaining blocker before Supporting Detail can PASS_LOCK:

The nested visible control `Show deeper diagnostic interpretation` still gives ordinary client access to the audit-heavy Writer/Judge narrative. The full governed narrative must remain preserved, but ordinary client access to that deeper diagnostic material must be removed.

## Registry rules

- All six PRIMARY rows are PASS_LOCKED and must not reopen without new evidence or explicit governed authorization.
- One visibly subordinate `Supporting Detail` destination contains all Supporting Detail rows.
- Supporting Detail is not a seventh primary page.
- Supporting Detail must remain evidence-preserving and consulting-focused.
- Full Writer/Judge narrative may remain available for auditability, but internal mechanics must not be exposed as ordinary client report content.
- Every Codex run must create and verify a non-empty result/proof artifact under `C:\Users\kulbaba\Downloads` unless Chris explicitly says otherwise.

## Exact next action

Perform the **final Supporting Detail narrative client-boundary repair only**:
- keep the three compact client blocks;
- remove normal client access to `Show deeper diagnostic interpretation`;
- preserve all governed Writer/Judge narrative unchanged in audit-only / diagnostic output;
- rerender the same persisted TBK fixture offline;
- require full report tests `0 FAIL` and `git diff --check` PASS;
- target render: `C:\Users\kulbaba\Downloads\PRYSM-SUPPORTING-DETAIL-TBK-CURRENT-REVIEW-8.html`;
- target proof: `C:\Users\kulbaba\Downloads\PRYSM-SUPPORTING-DETAIL-FINAL-NARRATIVE-BOUNDARY-PROOF.txt`;
- do not PASS_LOCK until human review confirms the actual rendered client boundary.
