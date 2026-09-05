# Decision — PRYSM P-Scoped Continuous Builder Autorun

Date: 2026-09-05
Status: ACTIVE

## Problem

Interactive Codex was being used for Builder-owned P# `DIAGNOSTIC_TRUTH` / `BOUNDED_BUILD` work. A single Codex invocation naturally ended after a bounded chunk and returned control even when the next actor remained Builder. This created repeated manual continuation prompts, approval friction, and false stop boundaries.

The historical `tools/autorun/PRYSM-AUTORUN.ps1` contains a continuous external invocation loop, but it is coupled to the historical Production Closure workflow and its branch/state assumptions. It must not be reused as current P# routing authority.

## Decision

Builder-owned P# execution uses the isolated P-scoped controller:

- `tools/prysm/PRYSM-P-AUTORUN.ps1`
- `tools/prysm/PRYSM-P-BUILDER-AUTORUN-PROMPT.md`
- `tools/prysm/START-PRYSM-P-AUTORUN.ps1`

Chris launches a Builder-owned P# from the governance repo with:

`powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\prysm\START-PRYSM-P-AUTORUN.ps1 -P P#`

The wrapper runs the controller self-test, the permanent PRYSM gate-contract regression, controller preflight, and then the continuous Builder loop.

## Routing authority

For a P# run, routing authority is:

1. `PRYSM_PERMANENT_MEMORY.md`
2. `CURRENT_STATE.md`
3. `${P}_EXECUTION_GATE.env` for P identity, authorized Builder stage, branch, and referenced bounded evidence
4. the active current diagnostic/authorization/proof chain referenced by `CURRENT_STATE.md`

Stale completed `PRYSM_AUTORUN_STATE.json`, Production Closure roadmap state, old report-improvement tranches, and unrelated PDV state are not P# lifecycle authority.

Where old lifecycle verdict fields remain in a P execution gate after a reopen, current reopened `CURRENT_STATE.md` and the active P# evidence chain control lifecycle routing.

## Continuous loop rule

A normal Codex end-of-turn is never a Builder workflow stop.

- `CONTINUE + next_role=Builder` -> automatically launch another fresh Builder invocation.
- `STOP + next_role=Builder` -> controller treats it as CONTINUE, because Builder work still remains.
- `READY_FOR_BRAD` -> write final controller state, show desktop notification, stop.
- attempted `next_role=Auditor` from Builder -> stop as `READY_FOR_BRAD`; never auto-launch Betty/Auditor.
- true `BLOCKED` -> write state, show blocker notification, stop.
- usage limit -> stop without consuming repair escalation and notify.
- repeated controller/protocol failure -> controller-failure notification.

## Human boundary

Brad OUTCOME_REVIEW remains a human-owned stage. The P# controller must not automate Brad's judgment and must not automatically start Betty.

## Execution permissions

Fresh Codex Builder invocations use:

- `--ask-for-approval never`
- `--sandbox danger-full-access`
- structured result schema
- controller-owned Luna -> Terra -> Sol escalation

PRYSM governance remains the safety boundary; repetitive Codex command approvals are not a second governance gate.

## Dirty-work preservation

The controller adopts the already-authorized application branch named by the P# gate and preserves valid uncommitted governed repairs. It never switches a mismatched dirty branch automatically and never uses destructive reset/clean/force operations.

## Notifications

Terminal states show Windows desktop + audible notification:

- `PRYSM P# READY FOR BRAD`
- `PRYSM P# BLOCKED`
- `PRYSM P# CONTROLLER FAILURE`

Routine Builder iterations and heartbeat are silent.

## Non-negotiable operating rule

Do not return to repeated interactive "continue Builder" prompts for a Builder-owned P# when the P-scoped controller is available. Use the continuous controller and stop only at a genuine actor or blocker boundary.
