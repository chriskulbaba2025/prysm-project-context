# PRYSM Autonomous Production Closure Loop

This folder contains the governed external Codex controller used to run PRYSM Production Closure across repeated fresh Codex invocations.

The design is adapted from the proven COMPAS2 VS Code autorun pattern, with one additional control: PRYSM automatically switches between a write-authorized Builder and a no-application-write independent Auditor at every application-changing tranche.

## Why an external loop exists

A single Codex invocation can stop while governed work remains. Conversation context is also not a safe durable project state.

The PowerShell controller therefore:
- launches a fresh Codex process;
- requires a machine-readable result;
- launches another process whenever `loop_action=CONTINUE`;
- switches Builder/Auditor roles using `next_role`;
- rereads Git/GitHub state on every invocation;
- stores run logs outside the repositories;
- stops only on `STOP`, `BLOCKED`, `COMPLETE`, controller failure, Ctrl+C, or an optional finite MaxRuns limit.

`-MaxRuns 0` means unlimited iterations.

## Files

- `PRYSM-AUTORUN.ps1` - external Builder/Auditor loop controller.
- `PRYSM-AUTORUN-RESULT.schema.json` - strict structured result contract.
- `PRYSM-BUILDER-AUTORUN-PROMPT.md` - Builder authority, recovery, repair, gate, GitHub, and terminal rules.
- `PRYSM-AUDITOR-AUTORUN-PROMPT.md` - independent no-application-write tranche audit contract.

Governing root files:
- `PRYSM_PRODUCTION_CLOSURE_ROADMAP_2026-08-31.md`
- `PRYSM_WHOLE_APP_TRANCHE_GATE.md`
- `PRYSM_POSTRUN_AUDIT_PROTOCOL.md`
- `PRYSM_AUTORUN_STATE.json`
- `PRYSM_POSTRUN_AUDIT_STATE.json`
- `HANDOFF_PRYSM_AUTONOMOUS_PRODUCTION_CLOSURE_2026-08-31.md`

## Safety model

Codex is launched with `danger-full-access` because the earlier COMPAS2 Windows controller proved that normal workspace-write can block required `.git` metadata writes. The controller uses the Windows `codex.cmd` shim rather than piping through `codex.ps1`, which failed in the initial COMPAS2 autorun attempts.

This is intentionally high local capability with narrow governed authority.

The prompts prohibit:
- destructive reset/clean/checkout-overwrite;
- force push;
- application repair commits directly to `main`;
- merge to `main`;
- deployment;
- Railway/Vercel/AWS production mutation;
- live/paid provider calls;
- live/paid Writer/Judge calls;
- starting a fresh production audit;
- weakening evidence/scoring/Judge/finalization gates.

Autonomous application writes are confined by governance to `repair/prysm-production-closure`.

## Local prerequisites

- Git installed and authenticated for GitHub pushes.
- Codex CLI installed and authenticated.
- local `vantage-platform` repository at the user's existing application path.
- local clone of `prysm-project-context`.

If the governance repository is not already cloned, from an appropriate parent directory:

```powershell
git clone https://github.com/chriskulbaba2025/prysm-project-context.git
cd prysm-project-context
```

If it already exists:

```powershell
cd <local-prysm-project-context-path>
git pull --ff-only
```

Do not pull/reset the application working tree blindly: it is intentionally known to contain governed dirty repair work. The Builder recovers it under T0.

## Preflight

From the local `prysm-project-context` root:

```powershell
$App = "C:\Users\kulba\Desktop\vantage-platform"
$Gov = (Get-Location).Path

.\tools\autorun\PRYSM-AUTORUN.ps1 `
  -AppRepo $App `
  -GovernanceRepo $Gov `
  -StartRole Builder `
  -PreflightOnly
```

Do not start the long loop unless the last line is:

`PREFLIGHT PASS`

Dirty application status during initial preflight is expected. The purpose is visibility, not a clean-tree requirement before T0 recovery.

## Start the unlimited closure loop

```powershell
$App = "C:\Users\kulba\Desktop\vantage-platform"
$Gov = (Get-Location).Path

.\tools\autorun\PRYSM-AUTORUN.ps1 `
  -AppRepo $App `
  -GovernanceRepo $Gov `
  -StartRole Builder `
  -MaxRuns 0
```

The controller can be left running. Each Codex invocation writes its own prompt, stdout, stderr, combined transcript, command shim, and structured final result under:

`%LOCALAPPDATA%\PRYSM-Autorun-Production-Closure\run-####-timestamp-role`

These logs are intentionally outside Git.

## Role loop

Normal application-changing tranche lifecycle:

`Builder -> targeted proof -> exact-SHA Whole-App Gate -> applicable composite verification -> commit/push/sync -> Auditor -> PASS -> Builder advances`

If Auditor returns FAIL or PASS_WITH_MINOR:

`Auditor -> durable bounded findings -> Builder repairs same tranche -> exact-SHA gates -> Auditor again`

The controller performs the role switch automatically.

## Run-state meanings

`CONTINUE`
More repository-controlled closure work remains. Controller launches another fresh run, using `next_role`.

`STOP`
A genuine external human/production authorization boundary prevents further autonomous repository-controlled work.

`BLOCKED`
A material integrity/synchronization/three-attempt condition cannot safely continue autonomously.

`COMPLETE`
T0-T7 repository-controlled Production Closure is exhausted, final independent audit passed, application repair branch and governance are synchronized, and the exact next production action is durably recorded.

COMPLETE does not itself mean the repair branch was merged/deployed or that a fresh paid audit was run.

## Terminal target

The intended unattended terminal checkpoint is normally:

`READY_FOR_AUTHORIZED_PRODUCTION_PROMOTION`

At that point the user can return to one explicit external decision: authorize merge/deploy/fresh audit, unless that authorization was separately granted through a later durable instruction.

The loop must not claim `READY_FOR_FRESH_AUDIT` merely because local tests are green.

## Automatic notification

On STOP, BLOCKED, COMPLETE, or controller failure, Windows attempts to show a desktop dialog and play a system sound. If Windows Forms is unavailable, it attempts `msg.exe`.

## Manual stop

Press Ctrl+C.

## PowerShell execution policy

If Windows blocks the script, use process-only scope:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
```

Do not change machine-wide policy solely for this tool.

## Recovery after interruption

Simply run the same unlimited command again.

Every fresh Builder/Auditor invocation must recover:
- uncommitted work;
- unpushed commits;
- pushed application checkpoint not yet reflected in governance;
- unpushed governance state;
- pending independent audit;
- branch divergence.

Do not manually restart a tranche unless durable state is wrong and has first been reconciled.
