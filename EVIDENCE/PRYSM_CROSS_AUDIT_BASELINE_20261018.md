# PRYSM cross-audit fidelity baseline — 2026-10-18

**Result:** Cross-audit baseline COMPLETE; app repair NOT STARTED; no audits/providers/model calls/pushes/deploys.

**Application authority:** `chriskulbaba2025/prysm-staging-isolated` branch `repair/prysm-evidence-accuracy-20261013` at `bda9578029fda428e227bae774defb2e6c9a9809`. **Primary:** City Media audit `77b14b11-e034-456a-be77-6650cc37cf4a`, 44/44 original stored objects SHA-256 verified (8,209,547 bytes). **Independent witness:** 10/10 Python tests PASS for benchmark rules (NOT application fix acceptance). Use the existing source-level diagnosis `EVIDENCE/PRYSM_CITYMEDIA_FIDELITY_20261018.md` for exact source owner boundaries.

## Comparison results

| Audit | Evidence available | Scoped output status | Details / limitations |
|---|---|---|---|
| City Media Collective | Full exported canonical and persisted report | **FAIL** | 10 of 12 `NO_ACTION` topics lack `buyerNeedCoverageState=COVERED`; five of those are `ABSENT_CONFIRMED`, four PARTIAL, one UNKNOWN. Four discovered case-study pages have empty normalized body; siteFootprint incomplete; false homepage CTA affected URL; FAQ CREATE/VERIFY conflict. Only 7/72 pages have nonempty body text. |
| Hepburn Plumbing | Oct. 9 rendered HTML; canonical evidence absent | **PASS (internal action/status only)** | 2 CREATE, 5 CONSOLIDATE, 4 VERIFY, 1 NO_ACTION, all 12 action/coverage pairs internally coherent. **No source-accuracy conclusion.** |
| Gluckstein Lawyers | Oct. 9 rendered HTML; canonical evidence absent | **PASS (internal action/status only)** | 6 CONSOLIDATE, 4 VERIFY, 2 NO_ACTION, all 12 internally coherent. **No source-accuracy conclusion.** |
| Addictive Tattoo | Oct. 9 rendered HTML; canonical evidence absent | **PASS (internal action/status only)** | 3 CREATE, 2 CONSOLIDATE, 5 VERIFY, 2 NO_ACTION, all 12 internally coherent. **No source-accuracy conclusion.** |
| Reboot Business Coaching | Older full canonical audit; old report contract | **NOT_COMPARABLE for modern content** | 7/500 requested pages crawled, 493 uncollected, 0/7 normalized body texts, site source PARTIAL; cannot prove trust/content absence. Valuable negative control. |

## What is and is not systemic

A specific **NO_ACTION falsely labelled “Already covered”** contradiction is present in City Media and absent in the three Oct. 9 reports' persisted rendered outputs; this proves the *symptom* is conditional, not that the shared classifier is correct elsewhere. Content-acquisition/coverage insufficiency could affect other sites but cannot be established from report-only archives. Differences between older report and current application versions prohibit using historical output parity as a current-code acceptance. City Media source/canonical failures are proven; **corrected scores and current live HTML have not been verified.**

## Reusable benchmark and negative-control conditions

In the current chat's local runtime (NOT the application repo): one read-only cross-audit extractor emits a machine-readable benchmark from the five original uploaded archives, plus 10 independent witness tests PASS. They specifically test invalid NO_ACTION+ABSENT_CONFIRMED/PARTIAL/UNKNOWN, valid NO_ACTION+COVERED, CREATE without an established buyer-need gap, mixed coherent actions, exact 44-object hash/identity, City Media's 5 gaps and 10 mislabels, incorrect homepage obstruction, older Reboot body/coverage limitation, and report-only-vs-source distinction. These prove the witness behaves as expected, **not** that PRYSM repairs are working.

**Release acceptance demands a NEW candidate produced by the real application from frozen persisted source data.** A separate candidate gate built in chat deliberately FAILs City Media's original stored HTML on 2 semantic checks and HOLDs missing candidate decision/CTA/provenance/live parity evidence; never count static witness tests as PRYSM regression PASS. Before any release, real app's negative/positive tests, canonical rerender/output comparison, affected URL/site-type/scores and authorized staging UAT must pass.

## First bounded next tranche — PRYSM-FIDELITY-REPAIR-01

**Approved scope from current conversation:** Local governed GACM/Codex repair of shared evidence and classification correctness, from exact accepted SHA, frozen City Media objects at `C:\g\p001\.governance\evidence\city-media-77b14b11-e034-456a-be77-6650cc37cf4a`, and existing TBK test fixture; no provider, Writer, new crawl, push/deploy, production mutation, extra worktree or overwrite of original data.

Repair order:
1. Reproduce and test authority of content scope completion and tenant/client/audit ID join in `src/report-intelligence/semantic-ledger.js` and trusted caller, with wrong-tenant/unretrieved-body/incomplete-sitemap controls; prohibit confirmed absence from incomplete content.
2. Separate **project page discovered** from **substantiated case study/outcome** at OnPage normalizer and trust evidence boundary; do not turn missing body into proof of no projects or fabricated proof.
3. Repair `VAN-PATH-001` tested affected URL identity and hidden-vs-truly-occluded CTA evidence; homepage positive/hidden negative controls.
4. Require consistent FAQ VERIFY vs CREATE between canonical action and narrative/report; old Writer output is test fixture only, no model call.
5. Generate a **new local candidate** from the same frozen evidence, preserve original scores and report, compare evidence-to-claim, candidate six pages and score provenance, and run dissimilar fixtures.
6. Stop HOLD on missing replay capability, evidence identity, unproven output, or three failed repair iterations. Report actual tests and proof under named Downloads folder. No application Git push/deploy.

**Current next action:** Execute the bounded local Codex tranche in the *already running* governed PRYSM controller. If Telegram delivery fails, do NOT resend without checking the SQLite run ledger and proof folder; delivery is not the same as execution state. This is a coding step, and PRYSM's project-wide rule forbids distributing code/patch/script files by downloads. GitHub documentation may contain the work order; the Builder edits actual local app source and proves candidate tests locally.

**Preexisting holds:** Claude writing benchmark, style/pagination edits, fresh staging audit, external deployment/production, and any claim of 100% accuracy.
