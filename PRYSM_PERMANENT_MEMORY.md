# PRYSM Permanent Operating Memory

**Status:** Active governing bootstrap memory
**Purpose:** Preserve high-value recurring operating rules across ChatGPT, Codex, Brad, Chris, new chats, and model changes.

This file is an index of durable operating memory. Detailed source-of-truth rules remain in the governing files named below. If any wording conflicts, the more specific current governing protocol/decision controls.

## Authoritative continuity

- GitHub repository `chriskulbaba2025/prysm-project-context` is the authoritative durable PRYSM memory.
- New chats and agents must read `PROJECT.md`, this file, `CURRENT_STATE.md`, `CONSTRAINTS.md`, `DECISIONS.md`, and the active governing protocols before substantive work.
- Do not reconstruct current PRYSM state from old chat memory when GitHub is available.

## Permanent launcher rule

- **Chris / Windows / VS Code PowerShell:** always use:
  `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\prysm\start-prysm-p.ps1 P#`
- **Brad / macOS / VS Code terminal:** use:
  `bash tools/prysm/start-prysm-p.sh P#`
- **Codex or agent shell:** use:
  `bash tools/prysm/start-prysm-p.sh P#`
- The public Bash launcher self-routes when already under Codex. Do not make Chris choose between Bash launcher variants.
- `start-prysm-p-current-session.sh` is an internal implementation detail and is not the normal command to give Chris.
- Never manually patch PATH to work around a governed launcher.
- Never nest Codex inside Codex.

## Permanent diagnostic hygiene rule

- Diagnostics must observe governed state; they must not contaminate governed state.
- Never write temporary diagnostic/upload `.txt` files inside `prysm-project-context` or `vantage-platform` by default.
- Windows diagnostic files go under `$env:TEMP\PRYSM-diagnostics\`.
- macOS/Linux diagnostic files go under `${TMPDIR:-/tmp}/PRYSM-diagnostics/`.
- If expected output is short, print it directly instead of creating a file.
- The launcher pre-flight may preserve/quarantine only narrowly recognized untracked local diagnostic leftovers outside the repo.
- Real tracked changes and unknown untracked files must still block the gate and the launcher must print their exact paths.
- Do not run a second generic diagnostic merely to discover paths the gate already knows.
- Never use `git clean`, destructive reset, checkout-overwrite, force push, silent deletion, or broad ignore patterns merely to satisfy a cleanliness gate.

## Anti-thrash rule

- Do not guess at launcher, repository, runtime, provider, or persistence causes.
- Use the shortest high-information diagnostic that resolves the uncertainty.
- Same observable failure: maximum three unsuccessful repair attempts before a deeper diagnostic reset with new evidence.
- Prefer designs that remove a repeat failure class instead of local patches that only hide one symptom.

## Required governing sources

- `GITHUB_PROJECT_MEMORY_PROTOCOL.md`
- `PROJECT.md`
- `CURRENT_STATE.md`
- `CONSTRAINTS.md`
- `DECISIONS.md`
- `DECISION_PRYSM_DIAGNOSTIC_HYGIENE_2026-09-04.md`
- `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`
- `WORKFLOW_INSTRUCTIONS.md`
- `PRYSM_LAUNCHER_CONTEXT_PROTOCOL_2026-09-04.md`
- `tools/prysm/prysm-governance-preflight.sh`
- `tools/prysm/start-prysm-p.ps1`
- `tools/prysm/start-prysm-p.sh`

## Non-negotiable intent

The user must not be sent through repetitive stop/start launcher loops caused by our own diagnostics, shell ambiguity, stale chat instructions, or hidden dirty-tree details. Future instructions must recover authoritative state first, expose the exact blocker, and give the single correct next action for the person whose turn it is.
