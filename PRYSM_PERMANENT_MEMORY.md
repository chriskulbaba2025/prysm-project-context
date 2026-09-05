# PRYSM Permanent Operating Memory

**Status:** Active governing bootstrap memory
**Purpose:** Preserve high-value recurring operating rules across ChatGPT, Codex, Brad, Chris, new chats, and model changes.

This file is an index of durable operating memory. Detailed source-of-truth rules remain in the governing files named below. If wording conflicts, the more specific current governing protocol/decision controls.

## Authoritative continuity

- GitHub repository `chriskulbaba2025/prysm-project-context` is the authoritative durable PRYSM memory.
- New chats and agents must read `PROJECT.md`, this file, `CURRENT_STATE.md`, `CONSTRAINTS.md`, `DECISIONS.md`, and the active governing protocols before substantive work.
- Do not reconstruct current PRYSM state from old chat memory when GitHub is available.

## Permanent single-authority gate rule

- The deterministic PRYSM launcher is the sole authority for machine-verifiable Git/manifest/current-state/candidate facts.
- After `PRYSM PROCESS GATE PASS`, do **not** ask ChatGPT/Codex/Brad/Betty to perform another open-ended process-gate audit of the same commit bindings or Git freshness.
- Semantic review happens in the explicit committed review/audit stage **before** the manifest is bound.
- If new direct evidence proves state changed after launch, report `PRYSM STAGE EVIDENCE CONFLICT` with the exact evidence. Do not infer a stale gate contrary to deterministic results.
- Governing decision: `DECISION_PRYSM_SINGLE_AUTHORITY_STAGE_ROUTING_2026-09-04.md`.

## Permanent stage ownership

- `DIAGNOSTIC_TRUTH` -> Builder/Codex.
- `BOUNDED_BUILD` -> Builder/Codex.
- `OUTCOME_REVIEW` -> Brad. Chris stops after deterministic PASS and hands the candidate to Brad.
- `CLOSURE` -> Chris / durable closure-state recording.
- Never substitute an already-open agent for the role that owns the stage.

## Permanent bound-evidence rule

- A file referenced by `P#_EXECUTION_GATE.env` is frozen for that stage.
- Do not append later status/history to bound evidence files.
- Put later status in `CURRENT_STATE.md` or create a new versioned evidence file.
- If bound evidence truly needs semantic correction, create/version/review/commit/rebind intentionally once.
- Exact commit binding remains strict; routine governance must not mutate bound evidence and create artificial staleness.

## Permanent launcher rule

- **Chris / Windows / VS Code PowerShell:** always use:
  `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\prysm\start-prysm-p.ps1 P#`
- **Brad / macOS / VS Code terminal:** use:
  `bash tools/prysm/start-prysm-p.sh P#`
- **Codex or agent shell:** use:
  `bash tools/prysm/start-prysm-p.sh P#`
- The public Bash launcher self-routes when already under Codex.
- `start-prysm-p-current-session.sh` is an internal implementation detail and is not the normal command to give Chris.
- Codex CLI is required only when the authorized stage is Builder-owned. A Brad/Chris handoff must not fail because Codex is missing.
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
- Never use `git clean`, destructive reset, checkout-overwrite, force push, silent deletion, or broad ignore patterns merely to satisfy a cleanliness gate.

## Anti-thrash rule

- Do not guess at launcher, repository, runtime, provider, or persistence causes.
- Use the shortest high-information diagnostic that resolves the uncertainty.
- Same observable failure: maximum three unsuccessful repair attempts before a deeper diagnostic reset with new evidence.
- Prefer designs that remove a repeat failure class instead of local patches that only hide one symptom.

## Permanent process regression rule

Any change to PRYSM launchers, gate binding, stage routing, or Codex handoff must pass:

`bash tools/prysm/test-prysm-gate-contract.sh`

Do not declare a process repair complete without that deterministic regression suite.

## Required governing sources

- `GITHUB_PROJECT_MEMORY_PROTOCOL.md`
- `PROJECT.md`
- `CURRENT_STATE.md`
- `CONSTRAINTS.md`
- `DECISIONS.md`
- `DECISION_PRYSM_DIAGNOSTIC_HYGIENE_2026-09-04.md`
- `DECISION_PRYSM_SINGLE_AUTHORITY_STAGE_ROUTING_2026-09-04.md`
- `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`
- `WORKFLOW_INSTRUCTIONS.md`
- `PRYSM_P_STAGE_COMMIT_AUDIT_GATE_2026-09-04.md`
- `PRYSM_LAUNCHER_CONTEXT_PROTOCOL_2026-09-04.md`
- `tools/prysm/prysm-governance-preflight.sh`
- `tools/prysm/start-prysm-p.ps1`
- `tools/prysm/start-prysm-p.sh`
- `tools/prysm/start-prysm-p-base.sh`
- `tools/prysm/test-prysm-gate-contract.sh`

## Non-negotiable intent

The user must not be sent through repetitive stop/start launcher loops caused by our own diagnostics, shell ambiguity, duplicate AI gates, stale chat instructions, hidden dirty-tree details, or wrong-actor routing. Future instructions must recover authoritative state first, expose the exact deterministic blocker if one exists, and give the single correct next action for the person whose turn it is.
