# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

Last verified:
2026-09-05

## Current governed boundary

- Active P#: `P1 — Cross-Report Contradiction Integrity`.
- Current stage: DIAGNOSTIC_TRUTH
- Authorized execution stage: DIAGNOSTIC_TRUTH
- Authorized actor: `BUILDER/Codex`.
- Chris decision: `REOPEN SAME P#`, accepted at governance commit `d73c57be0a15291855fc771326d6b181ff281c54` for reviewed application candidate `8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Governance repository: `chriskulbaba2025/prysm-project-context`.
- Application branch: `p1/bounded-build-cross-report-integrity`.
- Exact frozen failed application candidate: `8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c`.
- `P1_EXECUTION_GATE.env` binds that exact failed candidate and routes P1 to Builder/Codex `DIAGNOSTIC_TRUTH`.
- No application repair is authorized by this transition.

## Exact next action

Builder/Codex performs read-only `DIAGNOSTIC_TRUTH` against the complete remaining material P1 set recorded in `P1_BRAD_OUTCOME_REVIEW_REOPEN_2026-09-05.md`:

1. CTA/path coherence;
2. trust evidence overstatement;
3. fail-closed projection/performance-state reconciliation.

Robots/indexability is not a decisive P1 blocker unless new diagnostic evidence establishes one. Diagnosis must complete and be durably governed before any repair is authorized or performed.

On Brad's macOS environment, the published sustained diagnostic path is:

1. pull authoritative governance `main`;
2. run `bash tools/prysm/audit-prysm-p-macos.sh`;
3. only if that audit returns `PRYSM MACOS SUSTAINED AUTORUN CERTIFICATION PASS`, run `bash tools/prysm/PRYSM-P-AUTORUN-MAC.sh P1`.

The sustained macOS controller is intentionally bounded to `DIAGNOSTIC_TRUTH`. It may continue same-actor diagnostic work across fresh Codex invocations, but it must stop at repair authorization and cannot cross into `BOUNDED_BUILD`.

Read:

- `DECISION_P1_REOPEN_SAME_P_R2_2026-09-05.md`
- `P1_BRAD_OUTCOME_REVIEW_REOPEN_2026-09-05.md`
- `P1_OUTCOME_CONTRACT_2026-09-04.md`
- `PRYSM_OUTCOME_GATED_P_REVIEW_PROTOCOL_2026-09-04.md`
- `P1_EXECUTION_GATE.env`

Builder/Codex must not edit application code or frozen prerequisite evidence during `DIAGNOSTIC_TRUTH`.

## P1 history that remains frozen

- Failed candidate SHA: `85bbeda3cb4bb2fefb47b5e551f9edc0432feea2`.
- Brad failed-candidate outcome review: `P1_BRAD_OUTCOME_REVIEW_2026-09-05.md` — preserve unchanged.
- Chris decision: `REOPEN SAME P#`.
- Reopened diagnostic: `P1_DIAGNOSTIC_TRUTH_REOPEN_2026-09-05.md`.
- Diagnostic classification: `VERIFIED_DESIGN_GAP`.
- Reopened repair authorization: `P1_BOUNDED_REPAIR_AUTHORIZATION_REOPEN_2026-09-05.md`.
- Exhaustive historical-freeze baseline: `0756e4db3746be0c2279c2083ccf83b3ec5c89f5`.
- Frozen-history guard: `tools/prysm/assert-p1-frozen-history.sh`.
- All new reopened P1 proof/evidence belongs under `proof/P1/reopen/`, except intentional `P1_EXECUTION_GATE.env` and `CURRENT_STATE.md` updates.
- Reopened candidate SHA: `8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c`.
- Reopened-candidate Brad FAIL: `P1_BRAD_OUTCOME_REVIEW_REOPEN_2026-09-05.md` at governance commit `d73c57be0a15291855fc771326d6b181ff281c54` — preserve unchanged.
- Chris second decision: `REOPEN SAME P#`, recorded in `DECISION_P1_REOPEN_SAME_P_R2_2026-09-05.md`.

## Prior reopened repair scope — historical

The reopened bounded repair addressed the complete confirmed set:

1. CTA/path coherence;
2. trust evidence overstatement;
3. robots/indexability overstatement;
4. fail-closed projection for blocked/failed/unavailable evidence, including performance consistency;
5. client-facing machine/internal-language exposure inside the authorized report-projection seam.

The repair remained bounded to report projection/renderer/foundation-readiness and directly related deterministic tests/fixtures. Evidence acquisition, providers, scoring, Writer/Judge/model behavior, page-selection/search-data policy, lifecycle/storage, deployment, and application `main` remained protected.

## Windows unattended-controller certification

Windows P1 controller certification is PASS for Chris's Windows / VS Code PowerShell environment.

Evidence:

- `PRYSM P1 AUTORUN SELFTEST PASS`.
- `PRYSM P# AUTORUN CONTRACT REGRESSION PASS`.
- Permanent gate-contract regression: `11 PASS / 0 FAIL`.
- Transaction/recovery preflight: PASS.
- Certified recovery mode: `GOV_SYNCED/APP_P1_INITIAL_DIRTY_ADOPTION`.
- Audit terminal: `PRYSM P# AUTORUN AUDIT PASS`.
- No Codex Builder invocation and no application/product execution occurred during certification.
- Certification record: `proof/P1/reopen/P1_WINDOWS_AUTORUN_CERTIFICATION_2026-09-05.md`.

The Windows wrapper/controller remains unchanged by the macOS adapter and sustained diagnostic work.

## macOS unattended-controller status

Brad's macOS host passed the notification-enabled thin-wrapper certification on exact process head `55b808391ee67d095a9851af9c89adbc179da740`:

- macOS 14.6.1;
- x86_64;
- Codex CLI `0.153.0` at `/usr/local/bin/codex`;
- `osascript` notification runtime available;
- audit-only certification exit code `0`.

The certified thin macOS adapter was promoted to authoritative `main` through merge commit `e913270f58ffc83b0facd45f033ff5d67a0e719f`.

A Mac-only sustained `DIAGNOSTIC_TRUTH` controller is now published at `tools/prysm/PRYSM-P-AUTORUN-MAC.sh`. It adds:

- non-interactive Codex execution;
- same-actor continuation rather than 30–60 second convenience stops;
- default 20-minute safety window;
- maximum 6 fresh Codex invocations;
- 60-second heartbeat state;
- no-progress anti-thrash stop;
- fail-closed read-only application protection;
- governance-path restriction to new `proof/P1/reopen/*` diagnostic evidence;
- frozen-history verification;
- authoritative GitHub synchronization check at continuation/handoff;
- native macOS READY FOR CHRIS / NEEDS ATTENTION notifications.

This sustained controller must pass `audit-prysm-p-macos.sh` on Brad's actual host after pulling the current authoritative `main` before first execution. The audit is audit-only and must not invoke Builder or application/product work.

## Post-success controller reconciliation defect

After the Builder had completed, committed, and pushed the repaired candidate and reopened rendered proof, the unattended controller threw:

`P1 application transaction escaped the authorized seam`

Diagnosis established a controller allowlist/reconciliation defect rather than a product repair failure.

The disputed valid categories were:

- generated reopened render proof under `proof/P1/reopen/...`;
- `services/worker/src/report/p6-unavailable-roadmap.test.js`, whose assertions directly exercise unavailable/partial evidence semantics inside the active P1 fail-closed defect family.

The candidate was preserved. No destructive rollback and no unnecessary product rerun were performed. The normal deterministic P1 gate independently passed for the exact pushed candidate and routed P1 to Brad.

This controller defect is a process/control-plane issue and must be repaired/recertified separately. It does not consume a P1 same-root product repair attempt.

The generalized lesson is being carried into the GCU v2.5 Execution Continuity candidate, including post-success reconciliation, path-class separation, fail-closed recovery, and no blind rerun after an independently provable successful candidate.

## Permanent operating sequence

`DETERMINISTIC GATE -> CORRECT ACTOR -> BOUNDED TASK -> COLLECT OBSERVATIONS -> WRITE EVIDENCE ONCE -> BIND ONCE -> NEXT ACTOR`

An agent turn ending is not a workflow boundary. Human approval is required only at genuine governed actor/material-decision boundaries.

## Current constraints

- Read-only diagnosis only during `DIAGNOSTIC_TRUTH`; no application code changes until a later governed repair authorization.
- No P2.
- No Betty Final Audit until a later repaired candidate receives Brad PASS.
- No deploy.
- No application `main` merge.
- No paid/live application provider/model calls.
- Do not modify frozen historical P1 evidence.
- Do not treat robots/indexability as a decisive P1 blocker unless new evidence establishes one.

## Related process/GCU continuation

- GCU repository: `chriskulbaba2025/governed-coding-upgrade-skill`.
- Candidate upgrade: GCU v2.5 — Execution Continuity and Cross-Platform Runtime Certification.
- Draft PR: #12, branch `upgrade/v2.5-execution-continuity`.
- Brad's thin macOS runtime adapter is certified and merged to PRYSM governance `main`.
- The new sustained macOS `DIAGNOSTIC_TRUTH` controller is published on PRYSM governance `main` and awaits target-host audit certification before its first Builder execution.