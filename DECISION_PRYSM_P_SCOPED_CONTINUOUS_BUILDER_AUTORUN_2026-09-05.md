# Decision — PRYSM P-Scoped Continuous Builder Autorun

Date: 2026-09-05
Status: ACTIVE

## Problem

Interactive Codex was being used for Builder-owned P# `DIAGNOSTIC_TRUTH` / `BOUNDED_BUILD` work. A single Codex invocation naturally ended after a bounded chunk and returned control even when the next actor remained Builder. This created repeated manual continuation prompts, approval friction, and false stop boundaries.

The historical `tools/autorun/PRYSM-AUTORUN.ps1` is coupled to the historical Production Closure workflow and its branch/state assumptions. It is not current P# routing authority.

## Decision

Builder-owned P# execution uses the isolated P-scoped system:

- `tools/prysm/PRYSM-P-AUTORUN.ps1`
- `tools/prysm/PRYSM-P-BUILDER-AUTORUN-PROMPT.md`
- `tools/prysm/START-PRYSM-P-AUTORUN.ps1`
- `tools/prysm/test-prysm-p-autorun-contract.ps1`

The bootstrap verifies the control plane, runs the P# autorun regression and permanent PRYSM gate regression, performs read-only recovery/preflight, then enters the continuous Builder loop.

## Routing authority

For a P# run, lifecycle routing authority is:

1. `PRYSM_PERMANENT_MEMORY.md`
2. `CURRENT_STATE.md`
3. `${P}_EXECUTION_GATE.env` for P identity, authorized stage, branch/SHA anchor, and bounded references
4. the active diagnostic/authorization/proof chain referenced by `CURRENT_STATE.md`

Stale `PRYSM_AUTORUN_STATE.json`, Production Closure roadmap state, old report-improvement tranches, and unrelated PDV state are not current P# lifecycle authority.

## Transaction journal and no-crumb rule

Every Codex Builder invocation is a journaled transaction outside both repositories under `%LOCALAPPDATA%\PRYSM-P-Autorun\<P#>` (temp fallback):

1. record exact pre-run application/governance branch, HEAD, status and content fingerprint;
2. mark transaction `RUNNING` before invoking Codex;
3. after Codex exits, record exit status plus exact post-run fingerprints and mark `CODEX_EXITED_UNRECONCILED`;
4. validate control-plane immutability and P# scope before accepting the result;
5. reconcile structured result, repair accounting and routing;
6. mark the transaction `RECONCILED` only after those checks succeed.

A restart may continue only from the recorded P# entry lineage, the exact entry fingerprint, the exact latest journaled post-state, or a transaction that was recorded `RUNNING` when interrupted. Arbitrary local drift is not adopted merely because it is on the same branch.

The bootstrap never resets/cleans local work. It fast-forwards only a clean repository when the relationship is unambiguous. Dirty/ahead state is handed to transaction recovery and must prove lineage.

## Initial P1 dirty adoption

The reopened P1 repair already existed as valid uncommitted Builder work before this controller was introduced. One initial adoption is permitted only when:

- P1 is still Builder-owned in `CURRENT_STATE.md` and `P1_EXECUTION_GATE.env`;
- the application is on the exact governed P1 branch;
- local HEAD and `origin/<branch>` still descend from the gated P1 base;
- the dirty paths are restricted to the explicit reopened P1 report-projection/test seam enforced by the controller.

The controller records that exact entry fingerprint. Later restart recovery must match the anchor or journal; it does not repeatedly re-adopt arbitrary dirty trees.

## Continuous loop rule

A normal Codex end-of-turn is never a Builder workflow stop.

- `CONTINUE + next_role=Builder` -> another fresh Builder invocation.
- routine `STOP + next_role=Builder` -> continuation because Builder remains the next actor.
- `next_role=Auditor` -> contract violation; Brad owns `OUTCOME_REVIEW`.
- true `BLOCKED` -> durable state + notification + stop.
- usage limit -> stop without consuming repair escalation.
- repeated controller/protocol failure -> controller-failure notification.
- third evidence-based failure against the same stable root -> block; no fourth attempt.
- repeated identical no-repository-progress continuations -> anti-thrash controller failure instead of an infinite loop.

## Scope and control-plane integrity

The active Builder may not modify the controller, wrapper, Builder contract, result schema, permanent autorun decision, or permanent memory that governs the current run. The controller verifies both working-tree cleanliness of those files and their committed control-plane fingerprint.

For current reopened P1, every Codex transaction is checked across committed and uncommitted paths. Application changes must remain within the approved report projection / renderer / directly related deterministic test seam. Governance changes must remain P1-scoped. A transaction that escapes the authorized seam is rejected before its result is accepted.

Existing frozen human evidence must remain unchanged. New proof/evidence is versioned and rebound deliberately rather than silently rewriting prior candidate evidence.

## Repair accounting

The controller owns Luna -> Terra -> Sol repair escalation. Codex only echoes the current repair index.

A root identity cannot be changed to reset escalation. A different root is accepted only when the result explicitly declares `NEW_ROOT_CAUSE` with a non-`NONE`, materially different stable `root_defect_id`. Same-root product/proof rejection is `REPAIR_PROOF_FAILED`; setup/harness failure and external/protocol failure do not consume a repair level.

## Deterministic READY_FOR_BRAD rule

A Builder claim alone can never make the controller READY.

`READY_FOR_BRAD` requires:

- `loop_action=STOP`, `next_role=NONE`, `checkpoint=READY_FOR_BRAD`;
- `whole_app_gate=PASS`;
- `material_defects=0`;
- `github_state_synced=true`;
- clean application and governance worktrees;
- exact application candidate pushed and synchronized;
- exact returned application/governance SHAs matching local authoritative state;
- `${P}_EXECUTION_GATE.env` intentionally advanced/rebound to `AUTHORIZED_STAGE=OUTCOME_REVIEW`;
- `CURRENT_STATE.md` authorizing `OUTCOME_REVIEW` and Brad;
- the **official deterministic PRYSM P# gate independently passing** for that exact state and printing `Authorized actor: BRAD`.

The controller also re-checks the stage before every fresh Codex invocation. If a prior invocation already advanced the durable state to `OUTCOME_REVIEW`, no further Builder run begins; the official Brad gate must pass instead.

## Human boundary

Brad OUTCOME_REVIEW remains human-owned. The controller never automates Brad's judgment and never automatically starts Betty/Auditor.

## Execution permissions

Fresh Builder invocations use non-interactive Codex with:

- `--ask-for-approval never`
- `--sandbox danger-full-access`
- governance directory access
- structured output schema and final-message file
- controller-owned model escalation

PRYSM governance, transaction lineage, bounded scope and final deterministic gates are the safety boundary; repetitive shell approval prompts are not a second governance gate.

## Mutual exclusion, heartbeat and notifications

The controller uses local application/governance resource locks. Live locks block concurrent controllers; stale locks are reclaimed only when their recorded PID is no longer running.

P# accounting, transaction journal, entry anchor, controller state, heartbeat and logs remain outside both repositories.

Terminal states show Windows desktop + audible notification:

- `PRYSM P# READY FOR BRAD`
- `PRYSM P# BLOCKED`
- `PRYSM P# CONTROLLER FAILURE`

Terminal state is written before notification. Notification failure is non-fatal. Routine iterations and heartbeat are silent.

## Required regression

Before the continuous loop begins, the bootstrap must pass:

- `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\prysm\test-prysm-p-autorun-contract.ps1 -P P#`
- `bash tools/prysm/test-prysm-gate-contract.sh`

The first regression parses the PowerShell controller, runs its pure self-test, and verifies the journal, routing, scope, accounting, immutable-control-plane and Brad-boundary contracts are present.

## Non-negotiable operating rule

Do not return to repeated interactive "continue Builder" prompts for a Builder-owned P# when the P-scoped controller is available. Do not treat a convenient Codex summary as a workflow boundary. Preserve exact transaction lineage, prove the real product outcome, and stop only at a genuine human/protected boundary or a proven blocker.
