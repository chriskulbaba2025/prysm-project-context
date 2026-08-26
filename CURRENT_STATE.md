# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Run the PRYSM audit-integrity investigation as two coordinated forensic workstreams before any repair is implemented:
1. Evidence Integrity — owned by Brad in the private sandbox repository `chriskulbaba2025/betty-prysm-audit`.
2. Interpretation Integrity — owned by Chris with the primary PRYSM workflow in `chriskulbaba2025/vantage-platform` and `chriskulbaba2025/prysm-project-context`.

The goal is to determine whether PRYSM is correctly using the evidence it already collects. Do not assume the current problem is insufficient acquisition volume. Prove whether evidence is preserved, dropped, overwritten, misclassified, ignored, misweighted, or incorrectly interpreted.

Verified checkpoint:
- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Evidence-review sandbox: `chriskulbaba2025/betty-prysm-audit` — PRIVATE.
- Brad GitHub account: `Omni-BG`.
- Governed application branch: `main`.
- Current verified application HEAD/remote `main`: `46d92a346763a8e3ab252d1c32fe79632e7110a4` — `test(onpage): align representative crawl ceiling`.
- Prior Representative Crawl Enforcement application commit: `e77832e1aab5e9b1621e31e761e865ff86c795cc` — `feat(onpage): enforce representative crawl ceilings`.
- Correction verification: targeted representative-evidence regression 3/3 PASS; full worker suite 925/925 PASS, 0 fail, 0 cancelled; `git diff --check` PASS.
- GitHub remote status checks for `46d92a3...` all reached SUCCESS.
- Current governed acquisition contract: broad discovered footprint separate from assessed sample; deterministic must-have/representative priority plan; maximum 20 DataForSEO priority URLs; hard 250-page provider crawl ceiling; DataForSEO On-Page adapter v1.4.0; production config default/max 250.
- Viewer remains v2.2.0 / 16 governed pages.
- Scoring remains v4.1.1 unchanged.
- Controlled production Narrative v2 audit `5d22dcef-7d98-422f-8415-933e7b02003e` remains `draft_rendered`; no fourth Writer/Judge pass is permitted.

Evidence Integrity workstream — Brad:
- Brad is reviewing the private sandbox only.
- Sandbox contains review rules, forensic checklist, source references/snapshot, review prompt/output templates, and the audit package for audit `97d6b2c7-03b9-4530-8ea7-16557502c638`.
- Brad's task is forensic/read-only with respect to production PRYSM: trace RAW → NORMALIZED → CANONICAL → CAPABILITY/DECISION → SCORES/FINDINGS.
- Brad must classify evidence as PRESERVED, DROPPED, CHANGED, OVERWRITTEN, MISCLASSIFIED, INSUFFICIENT, or UNKNOWN.
- Brad must not redesign PRYSM, change production code, deploy, rerun audits, make provider calls, rescore, or mutate production artifacts.
- Brad's output will be a verified Evidence Integrity report containing defect classes, exact artifact evidence, failure boundaries, unknowns, severity, and repair order.

Interpretation Integrity workstream — Chris + primary assistant:
- This is the active workstream for the next chat.
- Objective: determine whether correct canonical/decision evidence is interpreted correctly by scoring, findings, recommendations, narrative inputs, Writer/Judge handling, and final report conclusions.
- Focus on evidence use, not merely evidence presence.
- Verify that findings and recommendations are materially supported by evidence, correctly weighted, correctly scoped to important pages, and do not convert unknown/unavailable/partial evidence into negative conclusions.
- Verify that site-level conclusions do not overgeneralize from utility pages, thin samples, missing deep-content evidence, or unassessed page families.
- Verify consistency between canonical evidence, capability evidence, scoring inputs, scores, findings, Writer inputs, Judge decisions, and final report language.
- Distinguish VERIFIED FACT, INFERENCE, and UNKNOWN throughout.
- No source-code repair is permitted until the exact interpretation failure boundary is proven and Brad's Evidence Integrity findings can be reconciled with it.

Known evidence concern requiring explicit inspection:
- Earlier forensic review identified a design inconsistency between governed sitemap priority selection and later deep-content page selection. This is not yet the assumed root cause of report-quality issues.
- The historical audit package for `97d6b2c7-03b9-4530-8ea7-16557502c638` shows DataForSEO On-Page `PARTIAL`, including content/body evidence limitations in that older run.
- Current adapter is v1.4.0; the older audit artifact may reflect an earlier adapter version. Do not confuse historical artifact behavior with the current runtime without direct proof.
- A central semantic risk to test is whether PRYSM treats `unknown`, `unavailable`, `not deeply parsed`, or `partial` as if it means `absent`, `false`, `zero`, or `fully assessed`.

Current environment / branch / version:
- Governed manual VS Code workflow on Desktop application repository.
- Application path: `C:\Users\kulba\Desktop\vantage-platform`.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Branch: `main`.
- Verified local/remote application HEAD: `46d92a346763a8e3ab252d1c32fe79632e7110a4`.
- On-Page adapter: v1.4.0.
- Governed provider crawl ceiling: 250 pages.
- Governed provider priority URL cap: 20.
- Viewer: v2.2.0 / 16 governed pages.
- Scoring: v4.1.1.

Completed:
- Representative Crawl Enforcement implementation is complete, pushed, and remotely green.
- Sitemap-footprint priority contract is implemented and tested.
- Adapter hard ceiling, client defense-in-depth ceiling, and production config ceiling are implemented and tested.
- Post-push stale 500-page regression assertion was diagnosed, corrected to 250, fully regression-tested, committed, pushed, and remotely green.
- Private Evidence Integrity sandbox has been created and populated for Brad.
- Audit `97d6b2c7-03b9-4530-8ea7-16557502c638` has been staged in the sandbox for forensic review.

In progress:
- Brad: Evidence Integrity forensic audit.
- Chris + primary assistant: Interpretation Integrity forensic audit.
- Both streams must be reconciled before a repair plan is approved.

Blocked:
- No known technical blocker.
- No interpretation root cause is yet proven.
- Do not infer a repair until direct artifact/code evidence proves the failure boundary.

Important constraints:
- GitHub context is authoritative durable memory.
- `WORKFLOW_INSTRUCTIONS.md` remains mandatory for manual application edits.
- Before any source edit, satisfy `REPAIR_BOUNDARY_PROTOCOL.md`.
- `DIAGNOSTIC_EVIDENCE_PROTOCOL.md` remains mandatory: no guessing; verify direct evidence before stating root cause or repair.
- Same observable failure remains capped at three unsuccessful repair attempts before a deeper diagnostic reset.
- Do not ask the user to scroll back for prior code/instructions; restate required code in the current response.
- Preserve discovered-footprint evidence separately from assessed-page evidence.
- Never imply a 250-page assessment is exhaustive coverage of a larger site.
- Do not raise the 250-page provider crawl ceiling merely because a site is larger.
- Preserve scoring v4.1.1 and Viewer v2.2.0 / 16 pages unless separately approved.
- Do not push, deploy, rerun production audits, recollect paid provider evidence, rescore, invoke paid Writer/Judge calls, or mutate persisted production artifacts without explicit approval at the applicable step.
- Brad's sandbox review and Chris's Interpretation Integrity review are independent diagnostic streams. Neither stream may silently modify production behavior.
- One unified repair plan must reconcile both streams before implementation.

Exact next action:
Start a fresh chat. Read `PROJECT.md`, `GITHUB_PROJECT_MEMORY_PROTOCOL.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`, `WORKFLOW_INSTRUCTIONS.md`, `TERMINOLOGY.md`, `CURRENT_STATE.md`, active `CONSTRAINTS.md`, active `DECISIONS.md`, and `EFFICIENCY_METRICS.md`. Treat GitHub as authoritative. Verify local `vantage-platform` `main` HEAD is exactly `46d92a346763a8e3ab252d1c32fe79632e7110a4` and the working tree is clean. Then begin the Interpretation Integrity forensic review. Trace canonical/decision evidence through scoring → findings → recommendations → Writer input → Judge handling → final report. Prove where correct evidence is used correctly, ignored, misweighted, overgeneralized, contradicted, or converted from UNKNOWN/PARTIAL/UNAVAILABLE into a false conclusion. Do not edit code. Build the failure-boundary map first. Brad is independently auditing Evidence Integrity in `chriskulbaba2025/betty-prysm-audit`; his findings will be reconciled later.

Last verified:
2026-08-26 America/Toronto
