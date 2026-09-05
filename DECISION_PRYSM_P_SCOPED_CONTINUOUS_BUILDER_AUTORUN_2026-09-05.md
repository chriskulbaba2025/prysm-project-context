# Decision — PRYSM P-Scoped Continuous Builder Autorun

Date: 2026-09-05
Status: ACTIVE

## Problem

Interactive Codex was being used for Builder-owned P# `DIAGNOSTIC_TRUTH` / `BOUNDED_BUILD` work. A single Codex invocation naturally ended after a bounded chunk and returned control even when the next actor remained Builder. This created repeated manual continuation prompts, approval friction, false stop boundaries, and risk of leaving unreconciled local crumbs between turns.

The historical `tools/autorun/PRYSM-AUTORUN.ps1` is coupled to the historical Production Closure workflow and its branch/state assumptions. It is not current P# routing authority.

## Decision

Builder-owned P# execution uses the isolated P-scoped system:

- `tools/prysm/PRYSM-P-AUTORUN.ps1`
- `tools/prysm/PRYSM-P-BUILDER-AUTORUN-PROMPT.md`
- `tools/prysm/START-PRYSM-P-AUTORUN.ps1`
- `tools/prysm/test-prysm-p-autorun-contract.ps1`

The **supported public entrypoint for Chris is `tools/prysm/START-PRYSM-P-AUTORUN.ps1` only**. `PRYSM-P-AUTORUN.ps1` is the lower-level controller engine and must not be invoked directly in normal operation because the public bootstrap performs the fail-closed interrupted-transaction checks before the engine starts.

The bootstrap verifies the control plane, runs the P# autorun regression and permanent PRYSM gate regression, performs read-only recovery/preflight, then either exits in `-AuditOnly` mode or enters the continuous Builder loop.

## Current scope of the controller

This audited controller version is **P1-only** for product execution because P1 has an explicit transaction path allowlist, frozen-evidence set, and tested recovery boundary.

Any attempt to use this version for another P# must fail closed until that P# receives its own explicit scope/frozen-evidence contract and regression coverage. Do not generalize the P1 allowlist by assumption.

## Routing authority

For P1 lifecycle routing authority is:

1. `PRYSM_PERMANENT_MEMORY.md`
2. `CURRENT_STATE.md`
3. `P1_EXECUTION_GATE.env` for P identity, authorized stage, branch/SHA anchor, and bounded references
4. the active diagnostic/authorization/proof chain referenced by `CURRENT_STATE.md`

Stale `PRYSM_AUTORUN_STATE.json`, Production Closure roadmap state, old report-improvement tranches, and unrelated PDV state are not current P1 lifecycle authority.

## Transaction journal and no-crumb rule

Every Codex Builder invocation is a journaled transaction outside both repositories under `%LOCALAPPDATA%\PRYSM-P-Autorun\P1` (temp fallback):

1. record exact pre-run application/governance branch, HEAD, status and content fingerprint;
2. mark transaction `RUNNING` before invoking Codex;
3. after Codex exits, record exit status plus exact post-run fingerprints and mark `CODEX_EXITED_UNRECONCILED`;
4. validate control-plane immutability, cumulative lineage and P1 transaction scope before accepting the result;
5. reconcile structured result, repair accounting and routing;
6. mark the transaction `RECONCILED` only after those checks succeed.

A normal restart may continue only from the recorded P1 entry lineage, the exact entry fingerprint, or an exact latest journaled state that was already reconciled.

A journal still marked `RUNNING` has no durable post-run fingerprint. Automatic recovery from that state is intentionally blocked rather than assuming that current local edits were produced by Codex.

A journal marked `CODEX_EXITED_UNRECONCILED` has a durable post-run fingerprint but no accepted controller result. The public bootstrap also blocks automatic relaunch from this state so another Builder turn cannot overwrite the recorded transaction before it is deliberately reconciled.

Both are fail-closed recovery boundaries, not product repair failures. Arbitrary local drift is never adopted merely because it is on the same branch.

The bootstrap never resets/cleans local work. It fast-forwards only clean state when the ancestor relationship is unambiguous. Dirty/ahead state is handed to transaction recovery and must prove lineage.

Local JSON accounting/journal files are written atomically. Corrupt local P-scoped state fails closed rather than silently resetting repair accounting or accepting an unknown recovery state.

## Initial P1 dirty adoption

The reopened P1 repair existed as valid uncommitted Builder work before this controller was introduced. One initial adoption is permitted only when:

- P1 is still Builder-owned in `CURRENT_STATE.md` and `P1_EXECUTION_GATE.env`;
- the application is on the exact governed P1 branch;
- local HEAD and `origin/<branch>` remain on the gated P1 lineage;
- every dirty application path is inside the explicit reopened P1 report-projection/test seam enforced by the controller.

The controller records that exact entry fingerprint. Later restart recovery must match the entry anchor or reconciled transaction journal; it does not repeatedly re-adopt arbitrary dirty trees.

## Continuous loop rule

A normal Codex end-of-turn is never a Builder workflow stop.

- `CONTINUE + next_role=Builder` -> another fresh Builder invocation.
- routine `STOP + next_role=Builder` -> continuation because Builder remains the next actor.
- `next_role=Auditor` -> contract violation; Brad owns `OUTCOME_REVIEW`.
- true `BLOCKED` -> durable state + notification + stop.
- usage limit -> stop without consuming repair escalation.
- a Codex execution/structured-result protocol failure stops fail closed on the first occurrence; the exact post-run journal is preserved instead of being overwritten by automatic retries.
- third evidence-based failure against the same stable root -> block; no fourth attempt.
- repeated identical no-repository-progress continuations -> anti-thrash controller failure instead of an infinite loop.

There is no arbitrary fixed run-count limit in the supported bootstrap. The loop is bounded by governed product-repair escalation, no-progress anti-thrash, protocol failure, usage limit, true blockers, or the deterministic Brad transition.

## Scope and control-plane integrity

The active Builder may not modify the controller, wrapper, Builder contract, result schema, permanent autorun decision, or permanent memory governing the run. The controller verifies both working-tree integrity and a committed control-plane fingerprint.

For reopened P1, every Codex transaction is checked across both committed and uncommitted touched paths. The check uses the union of every path touched by commits created during that transaction plus the final dirty paths; an out-of-scope change cannot be hidden by changing and later reverting the file.

Application changes are restricted to the approved report projection / renderer / directly related deterministic test seam encoded in the controller. Governance changes are restricted to P1 current-state/gate/new-versioned-evidence paths.

## Frozen P1 history

The failed candidate, Brad FAIL review, prior technical/system/candidate/render proof, reopen diagnostic and repair authorization remain historical evidence and must not be edited in place.

Existing `proof/P1/rendered/*` is frozen. Reopened rendered proof must be created under `proof/P1/reopen/*` and bound deliberately as new proof. New technical/system/candidate/render evidence must use new versioned P1 filenames. The controller rejects transactions that touch the frozen historical set before accepting the Builder result.

## Repair accounting

The controller owns Luna -> Terra -> Sol repair escalation. Codex only echoes the current repair index.

A root identity cannot be changed to reset escalation. A different root is accepted only when the result explicitly declares `NEW_ROOT_CAUSE` with a non-`NONE`, materially different stable `root_defect_id`. Same-root product/proof rejection is `REPAIR_PROOF_FAILED`; proof setup/harness failure and external/protocol failure do not consume a repair level.

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
- `P1_EXECUTION_GATE.env` intentionally advanced/rebound to `AUTHORIZED_STAGE=OUTCOME_REVIEW`;
- `CURRENT_STATE.md` authorizing `OUTCOME_REVIEW` and Brad;
- the **official deterministic PRYSM P1 gate independently passing** for that exact state and printing `Authorized actor: BRAD`.

The controller re-checks the stage before every fresh Codex invocation. If a prior invocation already advanced durable state to `OUTCOME_REVIEW`, no further Builder run begins; the official Brad gate must pass instead.

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

P1 accounting, transaction journal, entry anchor, controller state, heartbeat and logs remain outside both repositories.

Terminal states show Windows desktop + audible notification:

- `PRYSM P1 READY FOR BRAD`
- `PRYSM P1 BLOCKED`
- `PRYSM P1 CONTROLLER FAILURE`

Terminal state is written before notification. Notification failure is non-fatal. Routine iterations and heartbeat are silent.

## Audit-only runtime verification

`START-PRYSM-P-AUTORUN.ps1 -P P1 -AuditOnly` is the non-product runtime verification path.

Audit-only mode performs interrupted-transaction safety checks, control-plane checks, parses/runs the controller self-test, runs the P1 autorun contract regression, runs the permanent PRYSM gate-contract regression, and runs transaction/recovery preflight. It then exits before any Codex Builder invocation. It may fetch/fast-forward clean governance where safe, but it performs no application/product execution.

A stale `RUNNING` or `CODEX_EXITED_UNRECONCILED` journal causes audit-only mode to fail closed. That is intentional: runtime certification must not certify or overwrite an incompletely reconciled transaction.

This mode exists so the Windows runtime can verify the PowerShell/controller assumptions independently before the product loop is permitted to start.

## Required regression

Before the continuous loop begins, the bootstrap must pass:

- `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\prysm\test-prysm-p-autorun-contract.ps1 -P P1`
- `bash tools/prysm/test-prysm-gate-contract.sh`
- controller `-PreflightOnly`

The first regression parses the PowerShell controller, runs its pure self-test, and verifies journal, routing, frozen-history, scope, accounting, immutable-control-plane and Brad-boundary contracts.

## Non-negotiable operating rule

Do not return to repeated interactive "continue Builder" prompts for P1. Do not invoke the lower-level controller directly in normal operation. Do not treat a convenient Codex summary as a workflow boundary. Preserve exact transaction lineage, preserve historical evidence, prove the real product outcome, and stop only at a genuine human/protected boundary or a proven blocker.
