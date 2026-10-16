# Decision — PRYSM staging development controlled by Telegram / GACM

**Date:** 2026-10-16
**Status:** Active operating decision; implementation gaps explicitly OPEN
**Authority:** User decision of 2026-10-16, reconciled with GitHub PRYSM state. This is an operating instruction, **not** proof that the controller already implements every requirement.

## Outcome and separation

PRYSM is the product. GACM is the coding, evidence, and release-control mechanism. The daily goal is to improve the **existing** PRYSM isolated staging application, its six-page Executive Report, interface, data quality and report delivery. GACM defects are repaired **only if they obstruct PRYSM delivery**, after which work resumes on the same PRYSM objective. Do not run recurring standalone harness experiments or invent new workstreams.

- **Only existing isolated staging application:** `chriskulbaba2025/prysm-staging-isolated`. Verified working branch on 2026-10-16: `repair/prysm-evidence-accuracy-20261013`, SHA `0ad1f183d86a0f4b6c066a9ef8f3c96bb8350813`.
- **Existing staging Vercel:** project `prysm-staging-isolated`, ID `prj_ys6JNfnwyRow5G3BENFXliU3fIqs`, URL `https://prysm-staging-isolated.vercel.app`, deployed SHA `0ad1f183...`, READY at last verification.
- **Existing staging Railway:** project `prysm-staging-isolated.`, ID `07f1a0a3-a657-4a24-9ecb-56ba667cfc3f`, `prysm-worker` service ID `3343e2a8-0472-4780-8536-e8b9667fcc7a`, deployed SHA `0ad1f183...`, SUCCESS at last verification. Vercel's deployment target and Railway's environment are **internally** named `production` within staging; they are **not** actual PRYSM production.
- **Stable actual production:** `chriskulbaba2025/production-prysm` `main`, deployed SHA `c807a951e17cdaf9fb386c6f7374b66ae8fae487` at 2026-10-16 verification. This repository, its Vercel project and production backend remain outside staging-development mutations.
- **GACM controller GitHub:** `chriskulbaba2025/gacm-controller` `main`, SHA `af67fa77dfc9441b3f54b513e4689136609bcd07` at verification. That source is NOT proof the local Telegram process runs that source.
- Do **not** create another PRYSM staging project, replica application repository, staging database, deployment configuration or parallel permanent development environment. Temporary **bounded** worktrees needed for safe Codex execution are permitted only if their identity, dirty work and cleanup/reuse are controlled; they are not extra staging environments.

## Daily operating loop — intended contract

1. Read the latest GitHub project context and independently verify application and controller branch/SHA and executing environment, rather than relying on a past handoff.
2. Diagnose one PRYSM problem from real evidence: code path, logs, existing audit, exact input/output and expected behavior. Avoid re-running broad audits when the defect is known.
3. Send one authorized bounded task to **Telegram -> GACM -> GPT-5.6 Luna Codex**, including objective, repository authority, permitted side effects, tests and proof destination. The controller must refuse mismatched root, origin, branch/SHA or unexpected dirty state without erasing changes.
4. Preserve, reuse and finish an existing task workspace/patch before starting a replacement. At most three failed repair attempts for one root defect before a diagnostic reset.
5. Test the **affected path end-to-end**, not merely isolated unit functions: actual evidence -> status/qualification -> deterministic analysis/scoring -> supported narrative/report build -> HTML artifacts/routes -> UI/dashboard navigation and visible rendering. Include targeted negative controls (UNKNOWN/PARTIAL/UNAVAILABLE must not become fabricated AVAILABLE/PASS). No model/provider spend without explicit authorization. Where a real browser test or staging deployment is not authorized/capable, mark it HOLD, never PASS.
6. Report code test results, product acceptance, deployment status and real browser verification **separately**. A completed Codex child or READY deployment is not proof a usable client report exists.
7. After permitted staging release, user verifies actual pages/report; then update GitHub current state and move to the next PRYSM improvement. No automatic promotion to real production.

## Telegram controller — required behavior and current gaps

Telegram must act as an actual control plane, not just a message relay:

- **Single deterministic startup:** one launcher and one live controller process. Before accepting `run`, display and verify controller GitHub revision, executing local code path, staging repo root/origin, branch, pinned/accepted SHA, dirty state, worktree identity, environment target and persisted-run recovery state. `status prysm` must reveal the **executing** authority, not merely a configured or historical source.
- **Exact-authority continuity:** on each approved new PRYSM commit, advance the accepted SHA only through an explicit verified acceptance step. A hard-coded SHA left behind must not silently route new tasks to outdated code. Do not silently change the branch, reset a dirty checkout or mix frozen and newer changes.
- **Durable execution:** recover after controller restart; reuse the same preserved workspace; avoid duplicate child/model launches; release SQLite lock and terminalize ledger/status consistently; keep attempts, blockers and last next action in durable proof.
- **Error handling:** `BLOCKED` must specify if the cause is PRYSM code, dependency/preflight, controller, identity drift, provider evidence or permission. Missing test harness or required dependencies must be detected before a paid child launch. Fail closed on missing proof.
- **Workflow gate:** tests, regression, and authorized staging release must be explicitly tracked. As of controller GitHub `af67fa77...`, the README says PRYSM/GACM push and deploy are prohibited; full autonomous staging release is NOT implemented/authorized. Do not claim tip-to-tail live acceptance until the release and browser boundaries are explicitly approved and connected.
- **Controls and alerts:** responsive `status`, `run`, `stop`, `details`/tail and `continue`, clear PASS/HOLD/FAILED notifications, proof path and suggested next action; auto-detect disconnected Telegram polling where possible. Restart through one controlled launcher, not by randomly opening more terminals.
- **Preserve current local controller work:** user inspected `C:\Users\kulba\Desktop\prysm-gacm-mcp\src\config.ts` and found PRYSM root `C:\Users\kulba\Desktop\prysm-staging-isolated`, with no accepted ref/SHA; GitHub `gacm-controller/main` instead pins `C:\g\p001` and `0ad1f183...`. The user also saw Telegram report a DIRTY PRYSM checkout on another SHA. **Live executable identity mismatch is CONFIRMED, not repaired.** The local checkout and any C1 changes must be preserved.
- **Unpromoted harness candidate:** user-reported local commit `e627fcaba391661a6332eaa21cf99dbbbafb92a5` in `C:\Users\kulba\Downloads\GACM-HARNESS-RELIABILITY-001\controller-main-af67fa`. Tranche 005 reported restored ledger/status/lock/restart consistency but HOLD on a disposable fixture lacking acceptance harness. It is **not** proven deployed into the active Telegram process. Avoid losing that work or assuming it is the running version.

## PRYSM backlog and report truth

- First priority: accepted evidence quality (no false AVAILABLE or PASS), trustworthy classifications/recommendations, and continuity with previous unfinished local patches; then client-facing six-page Executive Report clarity, actionability, visual structure, UX/navigation and reliable report display.
- The existing audit `eea383a1-b3c9-4ee1-9da4-0466abf97c00`, target `https://www.joseph-rodrigues.com/`, had both `snapshot.html` and `executive.html` return worker HTTP 409 on staging. The user-reported `PRYSM-REPORT-RESTORE-001` diagnosis says the persisted `decision-evidence.json` is correctly addressed/readable but genuinely insufficient: DataForSEO `Domain Not Found`, zero inspected pages and no content. This report is **not currently accepted as rendered**. Do not bypass the sufficiency gate, invent evidence or label the incomplete audit a product failure. Any first-party evidence recovery or re-audit/provider call needs separate approval and must preserve accurate provenance.
- Prior local PRYSM-DATA-ACCURACY-001 recovery/patch was reported not yet committed/pushed or accepted; preserve and reconcile, do not overwrite. Current GitHub context may lag these user-reported executions: use actual `REPORT.md`, exact run state and existing workspace before acting.
- Historic report design/language approvals remain frozen until changed deliberately; preserve scores, evidence, approved writing and layout outside a small agreed edit.

## One exact immediate next action

**Run a bounded, read-only controller-and-PRYSM authority reconciliation with existing logs/workspaces; then perform one minimal in-place controller startup correction** so Telegram demonstrably reports the GitHub-approved single staging repository at its accepted SHA, preserves all pre-existing dirty/candidate work, and can run one bounded PRYSM task. Do not create another staging, fork, database or new controller installation. Do not change production. Do not launch a paid child during initial preflight. Validate status after controlled restart before issuing any PRYSM run. Then return to the preserved evidence-accuracy repair and report backlog.

## Every handoff/summary — mandatory GitHub refresh

Before every summary, new-chat handoff or next action: re-read GitHub `chriskulbaba2025/prysm-project-context` `PROJECT.md`, the top/current section of `CURRENT_STATE.md`, active `CONSTRAINTS.md`, `DECISIONS.md`, this decision, and relevant `gacm-controller`/staging application branch heads and touched source files. Compare that authority to supplied run proofs and actual deployed SHAs. Cite exact checked repo/branch/SHA/time; distinguish **GitHub verified**, **user-reported local**, **runtime observed**, and **HOLD/unknown**. Update context only when actual state changes, verify the write, and retain one precise next action. GitHub source state and live process identity must be independently verified; never assume syncing the former updated the latter.

**Existing constraints still apply unless explicitly reconciled:** the prior context reserves PRYSM interactive browser acceptance to Chris and forbids unauthorised pushes/deployments/model calls. A desire for tip-to-tail automation does not secretly repeal these gates. Propose a separately bounded authorization when the workflow is ready.
