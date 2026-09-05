# PRYSM Launcher Context Protocol

Date: 2026-09-04
Status: Active governing execution rule

## Purpose

Prevent PRYSM gate failures caused by shell/session ambiguity and ensure that the same public launcher behavior is used consistently.

The launcher must decide execution context itself wherever possible. The user should not have to reason about whether Codex is already active before choosing a command.

## Mandatory execution rule

### Chris — Windows — VS Code PowerShell

Always use the PowerShell wrapper:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\prysm\start-prysm-p.ps1 P1
```

This is the user-facing Windows entrypoint whether or not a Codex window is also open. The PowerShell wrapper performs Windows/Git-Bash/Codex path bridging and delegates into the public Bash launcher.

**Do not instruct Chris to manually choose `start-prysm-p-current-session.sh`.** That file is an internal routing implementation detail, not a normal user command.

### Brad — macOS — VS Code terminal

Use:

```bash
bash tools/prysm/start-prysm-p.sh P1
```

### Codex/agent shell execution

Use the public Bash launcher:

```bash
bash tools/prysm/start-prysm-p.sh P1
```

The public Bash launcher detects `CODEX_THREAD_ID` and automatically routes to the current-session handoff when already executing under Codex. Otherwise it delegates to the governed base launcher and may start Codex only after machine checks pass.

## Permanent pre-flight behavior

Before choosing an execution route, the public launcher must run `tools/prysm/prysm-governance-preflight.sh`.

The pre-flight must:

- preserve the clean-governance-tree gate;
- ensure narrowly recognized local diagnostic leftovers cannot manufacture a false governance blocker;
- preserve/quarantine those recognized untracked diagnostics outside the repository rather than deleting them;
- print exact real dirty entries when any tracked or unknown untracked change remains;
- never run `git clean`, destructive reset, checkout-overwrite, force operations, or silent deletion.

## Prohibited combinations

- Do not manually launch a second Codex process from inside Codex.
- Do not manually patch PATH to make a nested launch appear valid.
- Do not make Chris decide between Bash launcher variants from a Windows PowerShell prompt.
- Do not create diagnostic output files inside governed repositories.
- Do not substitute ad-hoc `bash -c`, `bash -lc`, npm-prefix, or shell-profile workarounds for the governed entrypoints.

## Prompt-writing requirement

Future ChatGPT/Codex instructions must use these user-facing commands:

- Chris / Windows PowerShell: `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\prysm\start-prysm-p.ps1 P1`
- Brad / macOS: `bash tools/prysm/start-prysm-p.sh P1`
- Codex/agent shell: `bash tools/prysm/start-prysm-p.sh P1`

Do not expose internal routing complexity to the user unless diagnosing the launcher itself.

## Failure interpretation

- A `Codex CLI ... not discoverable` message from an already-running Codex context is a launcher/context defect, not proof that Codex is uninstalled.
- A governance-dirty failure must include the exact dirty paths after the permanent pre-flight is installed.
- A local diagnostic artifact is not governance evidence and must not be allowed to block a P-gate merely because an assistant created it in the wrong place.
