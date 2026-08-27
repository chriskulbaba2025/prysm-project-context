# PRYSM Efficiency Metrics

Purpose: maintain a persistent, editable record of development-workflow efficiency so improvements from project memory and governed handoffs can be measured rather than estimated.

## Measurement rule

Record one row when a governed work package closes or reaches a verified checkpoint.

Track these four primary measures:

1. **Elapsed time** — wall-clock time from the first substantive action on the work package to the verified completion checkpoint. If the session contains a long unrelated pause, record both total elapsed time and known active elapsed time when available. Never invent missing timing data.
2. **Number of edits** — count each completed source-file replacement/change applied by the user or assistant as one edit event. If the same file is changed again after testing, that is another edit event.
3. **Failed iterations** — count each test/run cycle that fails and requires another code/test-contract change before the package becomes green. Re-running the same unchanged failing state for diagnosis may be noted separately but is not counted as a new edit iteration.
4. **Context-recovery turns** — count turns spent reconstructing already-known project state, re-establishing scope, locating the authoritative file/version, or repeating prior decisions because context was not carried forward. Normal clarification of a genuinely new requirement does not count.

## Secondary measures

Where practical also record:
- files touched
- verification tests and final pass counts
- regressions introduced outside scope
- repeated edits to the same file
- whether a new chat/handoff occurred
- whether authoritative memory was read successfully at start

## Efficiency comparison

Do not claim a measured percentage until at least one comparable pre-memory baseline and one memory-governed work package have sufficient data.

For comparable work packages, calculate normalized burden using:

`Burden = elapsed_minutes + (10 × edit_events) + (15 × failed_iterations) + (10 × context_recovery_turns)`

Then:

`Efficiency improvement % = ((baseline_burden - current_burden) / baseline_burden) × 100`

This weighted burden score is a project-management heuristic, not a software-performance benchmark. Keep the raw measures alongside it so the weighting can be changed later without losing source data.

## Current baseline statement

As of 2026-08-22, the previously stated **~55% improvement in practical development efficiency** is an informed estimate based on observed reductions in context reconstruction, scope drift, repeated governance explanation, wrong-file work, and rework. It is **not yet a measured benchmark** and must remain labelled as an estimate.

Prospective measurement starts now.

## Work-package log

| ID | Date | Work package | Elapsed | Active elapsed | Edit events | Failed iterations | Context-recovery turns | Files touched | Verification | Memory used at start | Burden | Notes |
|---|---|---|---:|---:|---:|---:|---:|---|---|---|---:|---|
| BASELINE-ESTIMATE-2026-08-22 | 2026-08-22 | Pre-measurement comparison | Not reliably measured | Not reliably measured | Not reliably measured | Not reliably measured | Not reliably measured | — | — | Mixed / pre-protocol | — | ~55% improvement is estimate only; not valid as measured benchmark. |
| PRYSM-V2-SECTION-VIEWER-02 | 2026-08-22 | 15→16 page Viewer v2.2.0 migration and regression freeze | Not reliably measured retrospectively | Not reliably measured retrospectively | 3 verified file units | Not reliably counted retrospectively | 0 observed during final governed handoff sequence | `render-report-v2.js`; `render-report-v2-section-viewer.test.js`; `render-report-v2-conversion.test.js` | Viewer 9/9; conversion 46/46; core Report v2 10/10 | Yes | — | First recorded package. Timing/failure counts intentionally left unmeasured rather than reconstructed inaccurately. |
| PRYSM-V2-REPO-INTEGRATION-01 | 2026-08-22 | Transfer verified Report v2 work into real Git repo, re-test, PR, CI, merge, sync local `main` | Full package start not reliably timestamped; PR lifecycle exactly 7m41s | Known PR lifecycle 7m41s; earlier transfer/test activity not fully timestamped | 4 file replacement events | 1 | 0 | `render-report-v2.js`; `report-detail-sections.js`; `render-report-v2-section-viewer.test.js`; `render-report-v2-conversion.test.js` | Syntax 4/4; viewer 9/9; conversion 46/46; core 10/10; GitHub CI PASS; PR #78 merged; local `main` clean at merge commit | Yes | — | One integration defect was caught immediately: `report-detail-sections.js` had not initially been copied, causing the missing `accessibilityMobileSection` export. One additional file replacement resolved it; all suites then passed. PR #78 created 2026-08-22T21:16:46Z and merged 2026-08-22T21:24:27Z. No context-recovery turn was required. |
| DQV-001-TRACK-A-2026-08-23 | 2026-08-23 | SERP cancellation, partial-evidence preservation, and governed whole-source policy | Not reliably measured across the multi-chat package | Not reliably measured | Not reliably counted across the full package | 1 known final-boundary failure; full-package total not reliably counted | Not reliably counted; two wrong-repository recovery incidents are documented in state | `dataforseo-serp-client.js`; `serp-adapter.js`; `production-runtime.js`; focused SERP/policy regression files | Client boundary 31/31; adapter boundary 34/34; final SERP + policy boundary 102/102; `git diff --check` PASS; local HEAD `b8d3ae404cbea75207d7a75bd2011ea62b122dd5` | Yes | — | Track A is complete locally and not pushed/deployed. The final 101/102 run exposed only a stale v1.1.0 test assertion after the governed adapter had already advanced to v1.2.0; updating that explicit version contract produced 102/102. Wrong-workspace incidents were detected before commit and the final staged diff was clean. |
| DQV-001-TRACK-B-DQV005-2026-08-25 | 2026-08-25 | Representative large-site acquisition, DecisionEvidence propagation, competitor-status downstream repair, and integrated regression closure | Not reliably measured across the multi-chat package | Not reliably measured | Not reliably counted across the full package | At least 3 known late-stage failures; full-package total not reliably counted | Not reliably counted | `sitemap-footprint.js`; On-Page client/adapter and policy tests; `production-runtime.js`; `decision-evidence.js`; `build-package.js`; `render-report-v2.js`; `production-path.js`; focused regression files | Representative integration 92/92; report-content 25/25; Viewer conversion 46/46; Narrative v2 7/7; DE-16 1/1; final integrated DQV/Track B boundary **185/185**; `git diff --check` PASS | Yes | — | Completed locally with scoring v4.1.1 and Viewer v2.2.0 unchanged. Known late-stage failures were bounded: Viewer golden hash re-freeze after intentional status rendering change; stale Narrative test-helper limitation assumption; stale On-Page adapter-version literal in DE-16. Final governed working tree was clean except two known unrelated untracked artifacts. No paid provider call, push, deploy, or production audit rerun occurred during closure. |
| NARRATIVE-V2-HUMAN-REVIEW-CONTINUATION-2026-08-25 | 2026-08-25 | Governed Narrative v2 human-review continuation from `narrative_failed` through explicit final-pass authorization | Not reliably measured across the multi-chat package | Not reliably measured | 9 verified committed file units in the completed repair stack | 0 known failing final regression iterations in the closing sequence | 1 observed workflow-recovery turn when the next file path/directory instruction had to be corrected | Orchestrator; live binding; production path; production runtime; worker server; worker client; Next.js narrative-review route; `AuditReviewActions.tsx`; HTTP regression test | Root TypeScript PASS; targeted Narrative/HTTP suite **28/28 PASS**, 0 fail, 0 cancelled; `git diff --check` clean; working tree clean; local HEAD `6a142d75936d01c9741c9d52bc0fe74754f86ca2` | Yes | — | Repair complete locally. Existing Narrative v2 quality gate preserved; third round remains explicit human authorization only; no provider recollection/rescoring, push, deployment, paid continuation, or production mutation occurred. Elapsed time was not reconstructed from chat history. |
| NARRATIVE-V2-PRODUCTION-CLOSURE-2026-08-25 | 2026-08-25 | Production authorization binding repair, one final Writer 3→Judge 3 execution, deterministic Pass 3 render repair, deployment verification, and stranded-audit recovery to `draft_rendered` | Not reliably measured | Not reliably measured | 2 verified repair edit events after production validation began | 2 observable production/test failures before final closure | 0 observed context-recovery turns in the closing sequence | `production-runtime.js`; `narrative-v2-production-path.test.js`; `render-narrative-v2.js`; `render-narrative-v2.test.js` | Runtime repair targeted suite **20/20 PASS**; render regression **7/7 PASS**; exact Railway SHA verified for `b50bee4` then `f375530`; final audit state `draft_rendered` | Yes | — | First production failure proved missing runtime `authorizeFinalPass` binding before any Writer 3 provider call. After repair and explicit reauthorization, Writer 3→Judge 3 succeeded. Deterministic render then failed because Pass 3 revalidation lacked persisted Pass 2 context; render-only repair fixed this without another paid model call. Concise command output was adopted during this closure to reduce unnecessary JSON/log volume. |
| REPRESENTATIVE-CRAWL-ENFORCEMENT-2026-08-25 | 2026-08-25 | Close bounded representative acquisition with deterministic footprint priority plan and hard 250-page On-Page ceiling | Not reliably measured | Not reliably measured | Not reliably counted; 10 final files changed | 2 known syntax/runtime failures during adapter-test replacement plus formatting corrections before final review; full edit-iteration count not reliably reconstructed | Multiple workflow-protocol correction turns occurred because edit-order/line-number instructions were not consistently followed; exact count not reconstructed | 10 files: sitemap footprint + tests; On-Page adapter/client + policy tests; production OnPage policy test; config; DecisionEvidence provenance tests | Footprint 8/8; adapter 71/71; client+adapter 76/76; focused boundary 100/100 PASS; final 100/100 PASS, 0 fail, 0 cancelled; `git diff --check` PASS; local commit `e77832e1aab5e9b1621e31e761e865ff86c795cc` | Yes | — | Product contract closed locally: max provider crawl 250, max priority URLs 20, broad footprint kept distinct from assessed sample. No paid provider calls, push, deploy, production audit rerun, rescoring, Writer/Judge call, or persisted production mutation. The package exposed a workflow weakness: exact line numbers and mandatory bottom-up edit ordering were repeatedly omitted. Durable `WORKFLOW_INSTRUCTIONS.md` was added at handoff to make this model-independent and prevent recurrence. |
| AUDIT-INTEGRITY-CLOSURE-2026-08-26 | 2026-08-26 | Interpretation Integrity 1–7 + Evidence Integrity 1–6 closure, offline replay harness, saved audit fixture, final adapter versioning and aggregate regression | Not reliably measured across the multi-chat package | Not reliably measured | Not reliably counted; final commit changed 60 files | At least 1 known final aggregate failure; full-package total not reliably counted | Not reliably counted | 60 committed files including On-Page adapter/tests, evidence/scoring/narrative repairs, replay harness, and required saved fixture artifacts | Adapter/representative **76/76**; Narrative v2 **96/96**; source identity **12/12**; focused DE-16 **1/1**; final worker aggregate **945/945 PASS**, 0 fail; cached diff check clean; local commit `dfa5650fa1486b07b34ecc0f61d7747db44c1cc9` | Yes | — | Audit Integrity is closed locally. Final aggregate initially exposed one stale registered On-Page adapter version (`1.4.0` vs repaired `1.4.1`); direct coupling repair produced green DE-16 and 945/945 aggregate. Two optional generated HTML comparison snapshots were deliberately left untracked because their stored bytes contain trailing whitespace and the replay harness treats them as optional. No provider/model calls, production rerun, persisted rescore, production mutation, or deployment occurred during closure. Application commit remained unpushed at handoff. |

## Update discipline

- Update this file at every materially completed governed work package.
- Preserve prior rows; correct a prior row only when better evidence exists.
- Label estimates as estimates.
- Never convert missing data into zero.
- At meaningful milestones, compare the latest comparable packages and report both raw metrics and the calculated efficiency improvement.
