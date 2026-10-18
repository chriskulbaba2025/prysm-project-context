# GACM / Telegram activation — authoritative next-chat handoff

> **2026-10-18 supersession notice:** This October 17 handoff is preserved as historical evidence, not current activation status or next-action authority. Telegram/controller activation subsequently passed its local safety and user-visible status gates. Controller GitHub feature branch is now 070336bcae754bcde414aacfd896b29cedc79737; PRYSM staging remains e863e35c47c62c883d54d7a62f038e559de27cd0. See the newest top ACTIVE section of CURRENT_STATE.md for one exact next action and REFERENCE/GACM_TELEGRAM_ACTIVATION_INCIDENT_REGISTER_20261018.md for complete errors, repairs, and limits. Do not resurrect this file's old HOLD, old PID, model restrictions as extra authorization, or unexecuted restart instructions.


**Date:** 2026-10-17 (local, Ontario)
**Status:** PRYSM staging RELEASED and aligned; GACM source/GitHub aligned; live Telegram activation **HOLD**.
**Authority:** `PROJECT.md` + top of `CURRENT_STATE.md` + active `CONSTRAINTS.md` / `DECISIONS.md` + October 16 single-staging decision. This file is the detailed verified handoff; old headings and next actions lower in `CURRENT_STATE.md` are history, NOT current commands.
**User objective:** Resume reliable PRYSM coding improvements through existing Telegram -> GACM -> Codex, not another round of broad controller rewriting. Keep replies short, step-by-step, executable PowerShell. User does browser tests only. Do not use Desktop Commander, subagents or start live Codex/provider/model runs until activation PASS.

## 1. Verified code and hosted runtime (latest GitHub + Vercel + Railway direct readback)

| Role | Repo, checkout and branch | Exact accepted SHA / deployment |
| --- | --- | --- |
| PRYSM isolated-staging app | `chriskulbaba2025/prysm-staging-isolated`; `C:\g\p001`; `repair/prysm-evidence-accuracy-20261013` | `e863e35c47c62c883d54d7a62f038e559de27cd0`; GitHub feature branch verified and operator local tree CLEAN |
| GACM controller | `chriskulbaba2025/gacm-controller`; `C:\Users\kulba\Desktop\prysm-gacm-mcp`; `c1/status-integrity-20261014` | `fbe9f1d04205cdaaf76cddadbea700fd07b0508b`; GitHub feature branch verified and operator local tree CLEAN |
| Controller remote `main` | `chriskulbaba2025/gacm-controller` | `6132c1a22ad3d7b88c2ed36bea3ff5d4e37cfc58`; intentionally unchanged; NOT substitute for live local controller |
| Staging frontend | Vercel project `prj_ys6JNfnwyRow5G3BENFXliU3fIqs`; `https://prysm-staging-isolated.vercel.app` | `dpl_J2CoLnsBFvxbayARbHPprW8TZcYw` READY, target `production` *only within isolated staging project*, alias directly read back at correct deployment; Git SHA `e863e35...` |
| Staging worker | Railway project `07f1a0a3-a657-4a24-9ecb-56ba667cfc3f`, env `b67677ba-4ac1-458f-a6d3-412de5ad9ea8`, service `3343e2a8-0472-4780-8536-e8b9667fcc7a` | `39d24ab6-82fa-4c26-a8e4-fe1ad18b0adc` SUCCESS, exact pinned Git SHA `e863e35...`, worker ONLINE (1/1 replica) and no active warnings; old deployment `d352874b-c058-4942-820f-0df38cf13849` remains rollback candidate |

The Railway staging environment and Vercel staging deploy target are each named `production` inside their own isolated staging project. Neither is actual PRYSM production. Actual PRYSM production Vercel project `prysm` is connected to **different repository** `chriskulbaba2025/production-prysm`; it was not changed by this tranche. Authenticated browser acceptance of report pages has not been performed by assistant; user is the browser tester.

## 2. Verified repairs, tests and durability

### PRYSM product repair — accepted exact SHA and deployed
- Four-file targeted change: `services/worker/src/audit/site-classification.js`, `src/audit/audit-intelligence.test.js`, `src/report/v13/business-recommendation-detail.js`, `src/report/v13/business-recommendation-detail.test.js`. Local commit `e863e35...`, 138 insertions / 5 deletions.
- Avoid false PROGRAMMATIC_SEO_DIRECTORY / ESTABLISHED classification from repeated location URLs alone: require corroborated title/body/schema, keeping first-party service businesses `SERVICE_LEAD_GEN / PARTIAL` where appropriate.
- Page-family guidance in recommendations is limited to explicit programmatic page-family findings instead of sweeping all `SEO` / `TECH` findings.
- 27/27 targeted tests PASS and zero failures; `npm.cmd run verify:prysm-whole-app` PASS P-B01 through P-B17 and offline replay 1/1 against committed exact SHA; final operator report `RESULT: PASS; TARGETED: True; WHOLE_APP: True; CLEAN: True; UNCHANGED_SHA: True`. No new paid audits/provider calls. No independent authenticated browser acceptance.

### GACM persistence, controller and authority — code/GitHub verified, runtime activation still HOLD
- Local baseline SHA `e2a1520846f2bbf1c5a69ce6e68ddee847dedb4a` -> local commit `437e75c6ce727be3df29cb6e3b1f0bf7e13f5a2a` (3 files: `src/core.ts`, `src/status-contract.ts`, `src/status-contract-selftest.ts`) -> SHA pin advancement `fbe9f1d...` (only `src/config.ts`). Both local commits pushed to existing GACM **feature branch only**, no remote main mutation.
- `status-contract.ts`: strict workspace authority schema now accepts optional `existingWorkspaceOnly` (fixes observed `unrecognized_keys` status persistence failure, which had previously been reported as run failure AFTER a Codex child already started).
- `core.ts`: prior to spawn, validates proposed status/authority; Codex task prompt now passed as stdin argument `-` and `stdio: ["pipe",...]`; only releases prompt through `child.stdin.end(prompt)` after successful SQLite `writeRunStatus` and registering terminal handler. Failed SQLite write withholds prompt and attempts `taskkill /PID /T /F` for that child. On failure branch, maps/streams cleared.
- `src/config.ts`: accepted PRYSM branch `repair/prysm-evidence-accuracy-20261013`, authorized checkout `C:\g\p001`, SHA advanced from old `5381eca7...` to **current** `e863e35...`. Controller source SHA `fbe9f1d...` verified by direct GitHub readback; local repo clean.
- Local `npm.cmd run typecheck`, status-contract SQLite selftest, `workspace:selftest` 23/23, `result:selftest`, `telegram:selftest` PASS; `git diff --check` PASS (nonfatal LF->CRLF warnings). Status selftest reported provider calls 0 and production writes 0.
- Bounded inert Node-child negative test against **extracted actual production failure-handling source block** with an injected SQLite persistence exception: `RESULT: PASS`, no prompt delivered to inert child, child terminated, active run map cleared. Proof at `C:\Users\kulba\Downloads\GACM-LAUNCH-NEGATIVE-20261017-01\RESULT.json`. This is **NOT** full integrated `startCodexRun` proof, NOT exhaustive real Windows child-tree cleanup under all races, and NOT live Telegram acceptance.
- Installed Codex CLI (`C:\Users\kulba\AppData\Roaming\npm\node_modules\@openai\codex\bin\codex.js`) returned `codex exec [OPTIONS] [PROMPT]` and help describing stdin, without actually executing a Codex run.
- Known backup evidence: `C:\Users\kulba\Downloads\GACM-LAUNCH-REPAIR-20261017-214605`, `GACM-STDIN-GATE-20261017-220921`, `GACM-LAUNCH-NEGATIVE-20261017-01`; local PRYSM exact-SHA test proof under Downloads `PRYSM-EXACT-SHA-e863e35c47c6`.

## 3. Error / omission register — do not repeat

| Problem / omission | Status and safeguard |
| --- | --- |
| SQLite status schema rejected `workspaceAuthority.existingWorkspaceOnly` while Codex had ALREADY spawned | Fixed schema and pre-spawn validation; stdin-gated launch keeps prompt withheld until persistence; tests PASS but integrated launch acceptance outstanding |
| Codex child could keep running if post-spawn status write failed | Bounded negative PASS using extracted production handler; **full integrated no-Codex failure test still HOLD** |
| Extracted-handler negative did not prove startup-to-teardown orchestration or orphaned descendants | Do not label GACM live-safe until process-tree/integrated simulation and terminal cleanup/ledger checks are proven |
| Early child exit, destroyed stdin, promise rejection and fallback `child.kill()` may have races | Inspect/verify before activation; no speculative broad rewrite, no live provider testing |
| Previous Codex child blocked by MCP approval, consumed ~74K tokens without useful proof; managed `spawn EPERM` could prevent child tests | Offline local shell tests and evidence used; do not launch broad Codex batch to debug controller |
| Old controller authority pinned PRYSM `5381eca7...` after app moved to `e863e35...` | Corrected `src/config.ts` only; code SHA `fbe9f1d...` pushed to feature branch |
| Vercel preview from app Git push was READY but not public; preview promotion API HTTP 422 | Created Git-source **production-target inside isolated staging Vercel project only**, exact `e863e35...`, READY; confirmed public alias points there |
| Railway worker was deliberately pinned to old SHA after PRYSM Git push | Explicit source pin advanced to `e863e35...`, new deployment SUCCESS; no config/secrets changed |
| PowerShell `finally` entered alone produced `CommandNotFoundException` after PRYSM commit | Commit remained intact; reran standalone exact-SHA tests; PASS and clean |
| Windows Git line-ending `LF will be replaced by CRLF` | Informational warning; `git diff --check` had no errors; do not churn formatting |
| Historic `CURRENT_STATE.md` contains multiple obsolete `ONE NEXT ACTION` sections | Only newest explicit ACTIVE checkpoint at top is operative; do not resurrect old decisions or rebuild/clean worktrees; archive cleanup requires a separate bounded task |
| Telegram `status prysm` shows current **application checkout**, not executing controller source SHA / accepted config SHA | **Critical omission confirmed by inspection of `src/telegram-controller.ts` status handler.** Do not use `status prysm` response *alone* to certify controller runtime. Verify exact PID/launcher/cwd/executable/source SHA independently before and after restart. |
| Telegram singleton child process remains present | **CURRENT HOLD:** operator read-only PowerShell verified one lock owner and **ChildProcesses: 1**. This child is NOT YET classified as launcher/runtime helper vs active Codex. Do not stop or kill PID until inspected. |
| Telegram status/notifications might report failed status persistence as a run failure despite meaningful work already completed | Distinguish child execution artifacts from status publication failure; use run ID + proof directory; never infer no child from a status error |
| No proper browser acceptance of PRYSM client report | User conducts browser UAT, separate from deterministic tests and host READY indicators; no new live audits without approval |

## 4. Precise current Telegram facts and remaining uncertainties

**User's latest read-only preflight result (2026-10-17):**
- `LockOwnerCorrect: True`: exactly one expected `127.0.0.1:49831` TCP singleton listener owned by **PID 30892**, process `C:\Program Files\nodejs\node.exe`, command contains `telegram-main`.
- `TelegramProcess: True`; `ChildProcesses: 1` (UNKNOWN identity and activity; **do not assume no active Codex job**).
- Previous process report: `PARENT_PID: 28464`. Launcher identity and process cwd cannot be established from these fields alone.
- `ControllerSHA: fbe9f1d04205cdaaf76cddadbea700fd07b0508b` and `ControllerClean: True`, **checkout on disk only** — not proof PID 30892's running module image equals that commit.
- `PrysmSHA: e863e35c47c62c883d54d7a62f038e559de27cd0`, `PrysmClean: True`.
- Codex CLI help supports prompt via stdin, but no Codex was launched.
- Telegram restart: **NOT PERFORMED**. Existing persisted `runtime/telegram-controller-state.json` and SQLite run statuses must NOT be reset/overwritten. Whether a run is still active, pending bot polling messages, and the exact child process identity are unresolved. Could be expected Node helper or an active job; inspect first.

**ONE NEXT ACTION:** Single **read-only** PowerShell process-and-ledger inventory for PID 30892 and its child(ren), parent 28464 and any descendants; inspect sanitized command line, creation time, parent chain, exact lock owner, presence of any active Codex child, latest GACM run ledger/state without exposing tokens or changing anything. Capture outputs in a named Downloads proof subfolder; do not kill/start/restart processes, invoke Codex or change source. Branch/SHA and other verified identities remain fixed. If child is active coding work, preserve and reconcile that work first.

**After the read-only inventory:** If process tree and ledger safely idle, perform bounded **integrated inert no-Codex launch negative** against real `startCodexRun` entrypoint using only explicit test dependencies/injection and no model/provider calls; do not run `telegram:locktest` while live port 49831 is occupied (would conflict). If PASS, plan controlled stop/start of **only** the verified controller launcher/PID using the exact existing working-directory command, keeping Telegram offset and proof files; confirm one singleton, new PID/creation time, clean live project SHA, current controller source identity through independent inspection or trusted startup proof, and read-only `status prysm`. Do not automatically start PRYSM work just because Telegram replies. If safe restart requires modifying code or no secure in-place launcher, HOLD and seek bounded authorization; no blind `Stop-Process`/taskkill. When accepted, ask for the next **bounded PRYSM task** and run only on user approval.

## 5. Next chat bootstrap

Paste:
> Continue PRYSM/GACM from `chriskulbaba2025/prysm-project-context`. Read `PROJECT.md`, the **top active** `CURRENT_STATE.md`, `CONSTRAINTS.md`, `DECISIONS.md`, October 16 single-staging decision, and `SPECS/GACM_TELEGRAM_ACTIVATION_HANDOFF_20261017.md`. PRYSM isolated staging GitHub/Vercel/Railway all match `e863e35c47c62c883d54d7a62f038e559de27cd0`. GACM local/GitHub feature controller matches `fbe9f1d04205cdaaf76cddadbea700fd07b0508b`. Both checkouts clean. Telegram singleton PID 30892 owns port 49831; **one child process is unidentified**. Controller not restarted and full no-Codex integrated launch not accepted. Start with ONE read-only PowerShell process-tree and persisted-run inventory for that exact PID, then the minimum safe acceptance/restart. No Desktop Commander, uncontrolled stops, new worktrees, audits, model/provider calls, pushes, deploys or actual production changes. Give concise one-step-at-a-time commands.

The next chat must prioritize restoring useful GACM PRYSM delivery, not reopening already-PASSed code/release gates or starting unrelated harness projects.
