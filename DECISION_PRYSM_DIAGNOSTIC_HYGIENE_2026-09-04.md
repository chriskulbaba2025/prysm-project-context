# PRYSM Diagnostic Hygiene — Permanent Decision

Date: 2026-09-04
Status: Active

## Decision

Temporary diagnostic output must never be written inside governed Git working trees. PRYSM launchers must self-diagnose cleanliness failures, preserve narrowly recognized local diagnostic leftovers outside the repository, and continue to block on any real tracked or unknown untracked change.

This decision is also indexed in `PRYSM_PERMANENT_MEMORY.md`, which `PROJECT.md` requires every future substantive PRYSM chat/model/agent to read during startup.

## Permanent operating rules

- Chris on Windows uses the PowerShell launcher wrapper.
- Brad on macOS uses the public Bash launcher.
- Codex/agent shells use the public Bash launcher, which self-routes.
- Diagnostic upload files go under the OS temp diagnostics directory.
- Cleanliness failures print exact dirty paths.
- No `git clean`, destructive reset, checkout-overwrite, force push, or silent deletion is used to clear a gate.
- Do not send Chris through shell-specific launcher variants; the Windows PowerShell wrapper is his normal governed entrypoint.
- Do not allow a diagnostic command to create the dirty-tree condition it is investigating.

## Reason

A prior workflow instruction could create diagnostic `.txt` files inside `prysm-project-context`, allowing the diagnostic itself to trigger the governance clean-tree gate. Launcher-context ambiguity separately caused nested Codex discovery failures. Both failure classes are now treated as process defects and prevented by the launcher/governance design.

## Governing implementation

- `PRYSM_PERMANENT_MEMORY.md`
- `PROJECT.md`
- `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`
- `WORKFLOW_INSTRUCTIONS.md`
- `.gitignore`
- `tools/prysm/prysm-governance-preflight.sh`
- `tools/prysm/start-prysm-p.sh`
- `tools/prysm/start-prysm-p.ps1`
- `PRYSM_LAUNCHER_CONTEXT_PROTOCOL_2026-09-04.md`
