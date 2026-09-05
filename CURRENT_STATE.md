# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

Current objective:
Run the canonical P1 process gate against the final refrozen proof-export candidate, then stop at Brad OUTCOME_REVIEW if and only if the semantic gate passes.

Verified checkpoint:
- Governance repository: `chriskulbaba2025/prysm-project-context`
- Application repository: `chriskulbaba2025/vantage-platform`
- Mandatory permanent operating-memory bootstrap: `PRYSM_PERMANENT_MEMORY.md`; `PROJECT.md` now requires it during every substantive PRYSM startup.
- Active P#: `P1 — Cross-Report Contradiction Integrity`
- P1 product repair: COMPLETE.
- Parent application candidate branch: `p1/bounded-build-cross-report-integrity`
- Parent application candidate SHA: `de509c30c808115f22fda3688a18dfaa85e9db50`
- Final frozen application candidate SHA: `85bbeda3cb4bb2fefb47b5e551f9edc0432feea2`
- Final candidate is published on the remote P1 branch.
- Proof-export change is test-harness only; no production/runtime product code changed.
- Deterministic verification: 77/77 PASS.
- Viewer v2 rendered freeze matrix: 48/48 PASS.
- Persisted rendered proof: 27 HTML scenarios plus SHA-256 manifest and scenario-to-obligation matrix.
- Governance proof package was rebound in commit `22a1346223d9159f5c0229d7ae1b1b3adbe12ce8`.
- Brad final independent OUTCOME_REVIEW has NOT begun.
- The prior nested-Codex discovery failure has been structurally removed by public-launcher self-routing.
- The repeated governance-dirty loop exposed a second process defect: older diagnostic instructions could write temporary `.txt` evidence inside the governed repository and thereby manufacture the cleanliness failure being diagnosed.
- Diagnostic artifact hygiene is now governed by `DIAGNOSTIC_EVIDENCE_PROTOCOL.md` v1.2.0: temporary diagnostics must live outside Git working trees, under the OS temp diagnostics directory.
- The public launcher now runs a permanent governance pre-flight before context routing. Narrowly recognized untracked local diagnostic leftovers are preserved outside the repo; real tracked or unknown untracked changes are printed exactly and still block.
- Permanent decision: `DECISION_PRYSM_DIAGNOSTIC_HYGIENE_2026-09-04.md`.
- Current stage: OUTCOME_REVIEW
- Authorized execution stage: OUTCOME_REVIEW
- Governing launcher-context rule: `PRYSM_LAUNCHER_CONTEXT_PROTOCOL_2026-09-04.md`.

Current stage:
OUTCOME_REVIEW

Authorized execution stage:
OUTCOME_REVIEW

Current blocker:
No P1 product blocker remains. The next local run must first synchronize the newly hardened governance launcher. After that, the P1 gate should either proceed or print the exact real dirty paths; no separate generic dirty-tree diagnostic should be required.

Resolved proof-boundary work:
- persisted exact rendered HTML for the material P1 render matrix;
- generated deterministic SHA-256 provenance manifest;
- generated scenario-to-P1-obligation matrix;
- reran exact deterministic verification/render matrix;
- proved the application change is test-harness only;
- committed and published the final candidate `85bbeda3cb4bb2fefb47b5e551f9edc0432feea2`;
- rebound candidate/proof governance to the final SHA.

Permanent execution/diagnostic rules:
- Chris / Windows PowerShell user-facing command: `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\prysm\start-prysm-p.ps1 P1`.
- Brad / macOS user-facing command: `bash tools/prysm/start-prysm-p.sh P1`.
- Codex/agent shell command: `bash tools/prysm/start-prysm-p.sh P1`; the public launcher self-routes when `CODEX_THREAD_ID` is present.
- `start-prysm-p-current-session.sh` is an internal routing implementation detail and should not be given to Chris as the normal Windows command.
- Diagnostic files must never be created inside `prysm-project-context` or `vantage-platform` merely for chat upload. On Windows use `$env:TEMP\PRYSM-diagnostics\`; on macOS/Linux use `${TMPDIR:-/tmp}/PRYSM-diagnostics/`.
- Do not manually patch PATH.
- Do not nest Codex inside Codex.
- Do not use `git clean`, destructive reset, checkout-overwrite, force push, or automatic deletion to satisfy a gate.

Not authorized:
- production/runtime report changes;
- scoring/evidence acquisition changes;
- Writer/Judge or Narrative semantic changes;
- unrelated refactors;
- provider/model calls;
- deployment;
- application `main` merge;
- P2;
- destructive Git operations or force push/history rewrite.

Autonomous execution rule:
Routine authorized investigation, Git synchronization, gate execution, evidence review, and OUTCOME_REVIEW preparation should continue without Chris babysitting. Stop only for destructive Git/history operations, secrets/auth/security changes, paid/provider/model execution, production deployment/application-main merge, production/runtime P1 semantic change, scope expansion, genuine security/data-loss risk, or authoritative evidence that cannot be reconciled deterministically.

Exact next action:
On Chris's Windows machine, from the normal VS Code PowerShell terminal:

```powershell
cd C:\Users\kulba\Desktop\prysm-project-context
git pull --ff-only origin main
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\prysm\start-prysm-p.ps1 P1
```

The first pull installs the permanent diagnostic-hygiene/pre-flight hardening and permanent-memory bootstrap. Thereafter the Windows PowerShell wrapper is the normal Chris entrypoint. If the P1 machine and semantic gates PASS, stop at the legitimate Brad OUTCOME_REVIEW boundary. Do not start P2.

Last verified:
2026-09-04
