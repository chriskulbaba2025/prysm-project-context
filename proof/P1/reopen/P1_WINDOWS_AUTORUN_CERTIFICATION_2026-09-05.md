# P1 Windows Autorun Certification — 2026-09-05

Status: PASS
Scope: process/runtime certification only; no Codex Builder invocation and no application/product execution occurred during certification.

## Certified environment

- OS/runtime: Chris Windows workstation, VS Code integrated PowerShell
- Governance repo: `chriskulbaba2025/prysm-project-context`
- Application repo: `chriskulbaba2025/vantage-platform`
- P#: `P1`
- Application branch: `p1/bounded-build-cross-report-integrity`
- Authorized stage at certification: `BOUNDED_BUILD`

## Command

`powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\prysm\START-PRYSM-P-AUTORUN.ps1 -P P1 -AuditOnly`

## Runtime evidence

### P# autorun contract regression

- `PRYSM P1 AUTORUN SELFTEST PASS`
- `PRYSM P# AUTORUN CONTRACT REGRESSION PASS`

### Permanent PRYSM gate-contract regression

- OUTCOME_REVIEW frozen-history routing: PASS
- historical P1 mutation rejection: PASS
- change-then-revert breadcrumb rejection: PASS
- new root P1 evidence rejection: PASS
- stale bound-evidence rejection: PASS
- missing rendered-proof binding rejection: PASS
- candidate identity mismatch rejection: PASS
- Builder single-authority handoff: PASS
- non-Builder Codex independence: PASS
- diagnostic quarantine path: PASS
- unknown dirty-file protection: PASS

Final: `PRYSM GATE CONTRACT: 11 PASS / 0 FAIL`

### Transaction/recovery preflight

- governance fetch: PASS
- application fetch: PASS
- branch: `p1/bounded-build-cross-report-integrity`
- stage: `BOUNDED_BUILD`
- recovery mode: `GOV_SYNCED/APP_P1_INITIAL_DIRTY_ADOPTION`
- Codex shim resolved: `C:\Users\kulba\AppData\Roaming\npm\codex.cmd`
- approval mode: `never`
- sandbox: `danger-full-access`
- `PREFLIGHT PASS`

### Audit terminal

- `PRYSM P# AUTORUN AUDIT PASS`
- `No Codex Builder invocation was started. No application/product execution occurred.`

## Certification conclusion

The Windows P1 unattended Builder process is certified for the current reopened P1 state. The process may now be launched through the supported public wrapper without `-AuditOnly`.

This certification does not certify the repaired PRYSM product outcome. It certifies the process that will continue the governed P1 repair. Product readiness still requires the Builder-owned repair/proof sequence, deterministic READY_FOR_BRAD gate, Brad OUTCOME_REVIEW, and later Betty Final Audit if Brad passes.
