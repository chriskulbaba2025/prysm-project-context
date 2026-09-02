# PRYSM Local Safety Backup Checkpoint

Date: 2026-09-02
Purpose: preserve a trusted local rollback baseline before Codex/GCU report-improvement work begins.

## Verified rollback identity

Application repository:
`chriskulbaba2025/vantage-platform`

Local repository root used for the backup:
`C:\Users\kulba\Desktop\vantage-platform`

Verified starting SHA stored in the local backup's `STARTING-SHA.txt`:
`9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`

This SHA matches the independently audited and successfully deployed PRYSM production candidate.

## What is known from the owner confirmation

The owner ran the governed local safety-backup procedure before Codex/GCU code changes and then directly verified:

`Get-Content "$backup\STARTING-SHA.txt"`

returned:

`9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`

The backup procedure was designed to create a timestamped Desktop directory named `PRYSM-SAFETY-BACKUP-<timestamp>` containing the Git identity/status evidence, a complete Git bundle, and a working-copy snapshot excluding disposable dependency/build outputs.

The exact timestamped backup directory name was not supplied back into project memory, so do not invent it. Recover it locally by locating the Desktop directory matching `PRYSM-SAFETY-BACKUP-*` whose `STARTING-SHA.txt` contains the verified SHA above.

## Governance use

Treat this as the pre-GCU trusted rollback baseline for the report-improvement program.

Before any destructive recovery action:
- diagnose the problem first;
- preserve current work/evidence;
- prefer Git/GCU correction over rollback when the current state is recoverable;
- use this backup only when deliberate restoration is required;
- never overwrite newer valid work without explicit owner authorization.

This checkpoint does not itself authorize resets, force pushes, production rollback, deployment, or data mutation.
