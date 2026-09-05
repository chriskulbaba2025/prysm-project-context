# PRYSM Launcher Context Protocol

Date: 2026-09-04
Status: Active governing execution rule

## Purpose

Prevent PRYSM gate failures caused by invoking a launcher from the wrong shell/session context.

The PRYSM machine gate and the Codex handoff are related but not interchangeable operations. A launcher that is intended to start a new Codex process must never be invoked from inside an already-running Codex session.

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

The canonical Bash launcher may launch Codex after machine checks pass.

### Any ALREADY-RUNNING Codex session

Use ONLY:

```bash
bash tools/prysm/start-prysm-p-current-session.sh P1
```

This wrapper runs the same governed machine checks but supplies a local handoff shim so the final governed prompt is returned to the existing Codex session instead of nesting or rediscovering Codex.

## Prohibited combinations

- Do not run `start-prysm-p.sh` directly from an active Codex session.
- Do not launch Codex from inside Codex.
- Do not manually patch PATH to make a nested launch appear valid.
- Do not substitute ad-hoc `bash -c`, `bash -lc`, npm-prefix, or shell-profile workarounds for the governed context-specific entrypoint.

## Prompt-writing requirement

Any ChatGPT/Codex instruction that tells an already-running Codex session to run a PRYSM gate MUST name `start-prysm-p-current-session.sh`, not the canonical new-process launcher.

Any instruction to Chris from a normal Windows PowerShell prompt MUST name `start-prysm-p.ps1`.

Any instruction to Brad from a normal macOS terminal MUST name `start-prysm-p.sh`.

## Failure interpretation

A `Codex CLI ... not discoverable` error while already inside Codex is an invocation-context failure, not evidence that Codex is uninstalled. Do not reinstall Codex, edit application code, or patch PATH in response. Use the current-session launcher.
