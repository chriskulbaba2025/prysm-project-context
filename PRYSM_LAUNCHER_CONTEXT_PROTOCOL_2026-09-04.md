# PRYSM Launcher Context Protocol

Date: 2026-09-04
Status: Active governing execution rule

## Purpose

Provide one stable launcher contract across Windows, macOS, and active Codex sessions while preserving correct stage ownership and preventing nested/duplicate execution.

## User-facing commands

### Chris — Windows — VS Code PowerShell

Always use:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\prysm\start-prysm-p.ps1 P1
```

The wrapper finds Git Bash and delegates to the public Bash launcher. It may expose Codex on PATH when available, but Codex is **not pre-required** until the deterministic gate proves a Builder-owned stage actually needs it.

### Brad — macOS — VS Code terminal

Use:

```bash
bash tools/prysm/start-prysm-p.sh P1
```

### Codex / agent shell

Use:

```bash
bash tools/prysm/start-prysm-p.sh P1
```

The public launcher detects an already-running Codex command context and routes internally without nesting Codex.

`start-prysm-p-current-session.sh` is an internal routing implementation detail. Do not give it to Chris as the normal Windows command.

## Deterministic gate authority

The launcher performs the machine-verifiable process gate once.

After `PRYSM PROCESS GATE PASS`:
- Builder stages receive a stage-only prompt;
- no prompt may perform a second free-form process-gate audit of Git/manifest facts;
- `OUTCOME_REVIEW` hands off to Brad;
- `CLOSURE` hands off to Chris/durable state closure.

## Stage routing

- `DIAGNOSTIC_TRUTH` -> Builder; Codex required only here if this stage is active.
- `BOUNDED_BUILD` -> Builder; Codex required only here if this stage is active.
- `OUTCOME_REVIEW` -> Brad; Chris stops after PASS.
- `CLOSURE` -> Chris / durable state closure.

## Permanent pre-flight behavior

Before stage routing, the public launcher runs `tools/prysm/prysm-governance-preflight.sh`.

The pre-flight:
- preserves the clean-governance-tree gate;
- quarantines only narrowly recognized untracked local diagnostic leftovers outside the repo;
- prints exact real dirty entries;
- never runs `git clean`, destructive reset, checkout-overwrite, force operations, or silent deletion.

## Prohibited combinations

- Do not manually launch a second Codex process from inside Codex.
- Do not manually patch PATH to make a nested launch appear valid.
- Do not make Chris choose between Bash launcher variants from Windows PowerShell.
- Do not create temporary diagnostics inside governed repositories.
- Do not route Brad-owned OUTCOME_REVIEW to Builder/Codex.
- Do not perform a second AI process-gate audit after deterministic PASS.

## Process regression requirement

Any launcher/routing change must pass:

```bash
bash tools/prysm/test-prysm-gate-contract.sh
```

before governance may call the repair complete.
