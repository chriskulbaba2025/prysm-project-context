# PRYSM Launcher Context Protocol

Date: 2026-09-04
Status: Active governing execution rule

## Purpose

Prevent PRYSM gate failures caused by invoking a launcher from the wrong shell/session context.

The PRYSM machine gate and the Codex handoff are related but not interchangeable operations. The public Bash launcher now self-routes when it detects an already-running Codex command context, so nested Codex discovery/spawn is avoided automatically.

## Mandatory context rule

### Chris — Windows — normal VS Code PowerShell, OUTSIDE Codex

Use:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\prysm\start-prysm-p.ps1 P1
```

The PowerShell wrapper is responsible for Windows/Git-Bash/Codex path bridging.

### Brad — macOS — normal VS Code terminal, OUTSIDE Codex

Use:

```bash
bash tools/prysm/start-prysm-p.sh P1
```

The public Bash launcher delegates to the governed base launcher and may launch Codex after machine checks pass.

### Any ALREADY-RUNNING Codex session

Preferred explicit command:

```bash
bash tools/prysm/start-prysm-p-current-session.sh P1
```

The public command `bash tools/prysm/start-prysm-p.sh P1` also detects `CODEX_THREAD_ID` and automatically routes to the current-session wrapper. The current-session wrapper runs the same governed base machine gate with a local Codex handoff shim so no nested Codex process is required.

## Prohibited combinations

- Do not manually launch a second Codex process from inside Codex.
- Do not manually patch PATH to make a nested launch appear valid.
- Do not substitute ad-hoc `bash -c`, `bash -lc`, npm-prefix, or shell-profile workarounds for the governed entrypoints.

## Prompt-writing requirement

Any ChatGPT/Codex instruction that knows it is addressing an already-running Codex session should name `start-prysm-p-current-session.sh` explicitly.

Any instruction to Chris from a normal Windows PowerShell prompt should name `start-prysm-p.ps1`.

Any instruction to Brad from a normal macOS terminal should name `start-prysm-p.sh`.

The public Bash launcher has a defensive self-route so an accidental direct invocation from an active Codex command context does not recreate the prior Codex-discovery failure.

## Failure interpretation

A `Codex CLI ... not discoverable` error while already inside Codex is an invocation-context failure, not evidence that Codex is uninstalled. Do not reinstall Codex, edit application code, or patch PATH in response.
