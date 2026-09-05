# Decision — PRYSM P-Scoped Continuous Builder Autorun

Date: 2026-09-05
Status: ACTIVE

## Problem

Interactive Codex was being used for Builder-owned P# `DIAGNOSTIC_TRUTH` / `BOUNDED_BUILD` work. A single Codex invocation naturally ended after a bounded chunk and returned control even when the next actor remained Builder. This created repeated manual continuation prompts, approval friction, and false stop boundaries.

The historical `tools/autorun/PRYSM-AUTORUN.ps1` contains a continuous external invocation loop, but it is coupled to the historical Production Closure workflow and its branch/state assumptions. It is not current P# routing authority.

## Decision

Builder-owned P# execution uses the isolated P-scoped controller:

- `tools/prysm/PRYSM-P-AUTORUN.ps1`
- `tools/prysm/PRYSM-P-BUILDER-AUTORUN-PROMPT.md`
- `tools/prysm/START-PRYSM-P-AUTORUN.ps1`
- `tools/prysm/test-prysm-p-autorun-contract.ps1`

Chris starts/resumes a Builder-owned P# from the governance repo with the P-scoped bootstrap after local governance contains this controller version.

The bootstrap:

1. requires a clean governance worktree;
2. fast-forwards governance from authoritative `origin/main`;
3. runs the dedicated P# autorun contract regression;
4. runs the permanent PRYSM gate-contract regression;
5. runs P# recovery/preflight verification;
6. starts the continuous Builder loop.

## Routing authority

For a P# run, lifecycle routing authority is:

1. `PRYSM_PERMANENT_MEMORY.md`
2. `CURRENT_STATE.md`
3. `${P}_EXECUTION_GATE.env` for P identity, authorized stage, branch/SHA anchor, and bounded references
4. the active current diagnostic/authorization/proof chain referenced by `CURRENT_STATE.md`

Stale completed `PRYSM_AUTORUN_STATE.json`, Production Closure roadmap state, old report-improvement tranches, and unrelated PDV state are not P# lifecycle authority.

## Initial safety boundary

A clean application candidate must pass the official deterministic P# gate before Builder execution.

An already-dirty application tree may be resumed without rerunning the clean-tree gate only when all of the following hold:

- governance main is clean and synchronized with `origin/main`;
- `CURRENT_STATE.md` and the P# gate both authorize the same Builder-owned stage;
- the current application branch equals the P# gate branch;
- current application HEAD equals the exact P# gate `APPLICATION_SHA`;
- `origin/<application-branch>` still equals that exact gate SHA.

This dirty-continuation exception exists only to preserve authorized uncommitted work created after a prior deterministic gate PASS. A mismatched dirty tree is a hard stop; the controller never switches, resets, cleans, or overwrites it.

## Continuous loop rule

A normal Codex end-of-turn is never a Builder workflow stop.

- `CONTINUE + next_role=Builder` -> automatically launch another fresh Builder invocation.
- routine `STOP + next_role=Builder` -> controller treats it as continuation because Builder remains the next actor.
- true `BLOCKED` -> write state, notify, stop.
- usage limit -> stop without consuming repair escalation and notify.
- repeated controller/protocol failure -> controller-failure notification.
- third same-root evidence-based repair failure -> block; no fourth attempt.

A Builder result with `next_role=Auditor` is **not** READY. It is a contract violation because Brad owns `OUTCOME_REVIEW`.

## Deterministic READY_FOR_BRAD rule

A Builder claim alone can never make the controller READY.

A `READY_FOR_BRAD` claim is accepted only when:

- `loop_action=STOP`, `next_role=NONE`, `checkpoint=READY_FOR_BRAD`;
- `whole_app_gate=PASS`;
- `material_defects=0`;
- `github_state_synced=true`;
- application and governance worktrees are clean;
- application local HEAD equals pushed `origin/<branch>`;
- returned application/governance SHAs equal the exact local authoritative SHAs;
- `${P}_EXECUTION_GATE.env` has been intentionally rebound to the repaired candidate with `AUTHORIZED_STAGE=OUTCOME_REVIEW`;
- `CURRENT_STATE.md` authorizes `OUTCOME_REVIEW` and Brad;
- the **official deterministic PRYSM P# gate independently passes** for that exact state and prints `Authorized actor: BRAD`.

If any readiness condition fails, the controller rejects the claim and relaunches Builder without consuming a product repair escalation. Repeated false/incomplete readiness claims eventually stop as controller failure rather than handing an unproven candidate to Brad.

## Human boundary

Brad OUTCOME_REVIEW remains human-owned. The P# controller never automates Brad's judgment and never automatically starts Betty/Auditor.

## Execution permissions

Fresh Codex Builder invocations use supported non-interactive Codex CLI execution with:

- `--ask-for-approval never`
- `--sandbox danger-full-access`
- additional governance directory access
- structured output schema and final-message file
- controller-owned Luna -> Terra -> Sol escalation

PRYSM governance remains the safety boundary; repetitive Codex command approvals are not a second governance gate.

## Mutual exclusion and local state

The controller uses external local resource locks for both the application and governance repository paths. A live controller holding either resource blocks another controller. Stale lock files are reclaimed only when their recorded PID is no longer running.

P# repair accounting, controller state, heartbeat, and logs live outside both repositories under `%LOCALAPPDATA%\PRYSM-P-Autorun\<P#>` (or temp fallback). Historical global autorun state does not control the active P#.

## Notifications

Terminal states show Windows desktop + audible notification:

- `PRYSM P# READY FOR BRAD`
- `PRYSM P# BLOCKED`
- `PRYSM P# CONTROLLER FAILURE`

The terminal state is written before notification. Notification failure is non-fatal. Routine Builder iterations and heartbeat are silent.

## Required regression

The P-scoped bootstrap must pass both:

- `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\prysm\test-prysm-p-autorun-contract.ps1 -P P#`
- `bash tools/prysm/test-prysm-gate-contract.sh`

before starting the continuous loop.

## Non-negotiable operating rule

Do not return to repeated interactive "continue Builder" prompts for a Builder-owned P# when the P-scoped controller is available. Use the continuous controller and stop only at a genuine human or blocker boundary.
