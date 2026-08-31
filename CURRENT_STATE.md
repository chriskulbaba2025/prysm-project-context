# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

Current objective:
Execute the governed autonomous PRYSM Production Closure roadmap T0-T7 using the external Codex Builder/Auditor loop. Close the systemic contract-propagation, duplicated-model, stale replay/versioning, semantic-default, false-PASS verification, and release-control defects before another production audit is started.

Verified checkpoint:
- Application repository: `chriskulbaba2025/vantage-platform`.
- Remote application `main` is verified at `e7e8477819f8bff0a7e3f0c5969637df9fb787a3` — `fix(prysm): close governed report integrity repairs`.
- Remote `main` is currently unprotected and required status checks are not enforced; `main` alone is therefore not release-proof authority.
- Local application path remains `C:\Users\kulba\Desktop\vantage-platform`; worker path remains `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- The local application working tree is intentionally dirty with governed PF/Narrative/Conversion-First repairs. Exact local branch/HEAD/diff is not yet reconciled into durable state. Preserve it exactly; T0 must recover it locally before further product edits.
- Known local repairs that must be preserved include DecisionEvidence propagation into production WriterInput, production-shaped Writer action rank/effort/reference fixture repair, current Judge hierarchy/version fixture repair, and `rootCauseRuleId` propagation through ScoreSet/base/V2 projections.
- Focused `NV2-PROD-02` passed 1/1 after the root-cause identity propagation repair.
- Focused `NV2-PROD-06` passed 1/1 for invalid persisted terminal Narrative state fail-closed/no-extra-spend behavior.
- `npm test` passed 959/959, 0 failures, but this command is explicitly NOT accepted as a full worker/release regression because release-relevant test families such as `src/application` are outside that command.
- A deep systemic production-closure audit is persisted in `AUDIT_PRYSM_SYSTEMIC_PRODUCTION_CLOSURE_2026-08-31.md`.
- New direct evidence invalidated dependent global closure assumptions from the prior state. Historical PF/CF/CONTRACT-CLOSURE PASS records remain valid evidence for the exact boundaries they proved, but they are not current whole-system release proof where contradicted by the systemic audit.
- The autonomous closure roadmap, exact-SHA Whole-App Tranche Gate, independent audit protocol, Builder/Auditor prompts, structured result schema, durable autorun states, Windows PowerShell controller, and launch README have been created in the governance repository.
- The autonomous workflow pattern was ported from the prior COMPAS2 VS Code Codex loop, including fresh-run `CONTINUE` relaunch, `-MaxRuns 0`, recovery-first state, Windows `codex.cmd` invocation, exact-SHA gating, GitHub synchronization, and independent post-run auditing. PRYSM adds automatic Builder -> Auditor -> Builder switching per application-changing tranche.

Current environment / branch / version:
- Application remote baseline: `main` at `e7e8477819f8bff0a7e3f0c5969637df9fb787a3`.
- Intended autonomous repair branch: `repair/prysm-production-closure`; safe local creation/recovery is T0 work and has not yet been verified from GitHub.
- Governed viewer remains Viewer v2.2.0.
- Scoring version remains `4.1.1`; do not change scoring weights/version merely to alter results.
- Current Narrative WriterOutput version: `1.0.0`.
- Current Writer prompt version: `2.1.0`.
- Current Judge contract version: `1.1.0`.
- Current Judge prompt version: `2.1.0`.
- WriterInput version/compatibility is an explicit T3 closure item because historical/current `1.0.0` semantics are not trustworthy as one compatibility identity.

Completed:
- Deep systemic diagnosis of the repeated one-more-test failure cycle is complete and durable.
- The common root cause is established as incomplete semantic contract migration/proof coverage across Producer -> Contract/Persistence -> Loader -> Consumer -> Gate -> Renderer -> Replay/Recovery boundaries.
- `AUDIT_PRYSM_SYSTEMIC_PRODUCTION_CLOSURE_2026-08-31.md` records SYS-01 through SYS-22 and the known local repair checkpoint.
- `PRYSM_PRODUCTION_CLOSURE_ROADMAP_2026-08-31.md` governs T0-T7.
- `PRYSM_WHOLE_APP_TRANCHE_GATE.md` is the mandatory exact-SHA whole-system proof for every application-changing tranche.
- `PRYSM_POSTRUN_AUDIT_PROTOCOL.md` governs independent fresh-context tranche review.
- `DECISION_AUTONOMOUS_PRODUCTION_CLOSURE_2026-08-31.md` authorizes direct autonomous local repair work, deterministic verification, coherent commits, normal repair-branch pushes, and governance synchronization for this closure package while preserving external production authorization boundaries.
- `tools/autorun/PRYSM-AUTORUN.ps1` and its Builder/Auditor contracts are installed in governance.
- Durable state files `PRYSM_AUTORUN_STATE.json` and `PRYSM_POSTRUN_AUDIT_STATE.json` are initialized.

In progress:
- T0 — recover exact local application/governance Git state, preserve the dirty repair package, safely establish/recover `repair/prysm-production-closure`, and freeze the complete closure dependency/proof map before further application edits.
- After T0, the controller advances T1-T7 only through exact-SHA Builder gate -> push/sync -> independent Auditor PASS cycles.

Blocked:
- Exact local dirty application branch/HEAD/diff is not yet durably reconciled; this is intentionally assigned to autonomous T0 recovery rather than another manual diagnostic sequence.
- Application merge to `main`, deployment/production configuration mutation, live/paid provider calls, live/paid Writer/Judge calls, and starting a fresh production audit are not authorized by the autonomous closure decision itself.
- A future repository-controlled COMPLETE state will normally stop at `READY_FOR_AUTHORIZED_PRODUCTION_PROMOTION` unless a later explicit durable authorization expands that boundary.

Important constraints:
- GitHub governance is authoritative durable project memory, but valid uncommitted local application work must be preserved and reconciled before GitHub can supersede it.
- Never reset hard, clean, checkout-overwrite, discard, or force-push the local application repair work.
- Autonomous application work is confined to `repair/prysm-production-closure`; do not push closure commits directly to application `main`.
- For this Production Closure package, `DECISION_AUTONOMOUS_PRODUCTION_CLOSURE_2026-08-31.md` supersedes older manual-chat-only source-edit mechanics where they conflict with autonomous execution. Evidence integrity, no-guess, repair-boundary, no-destructive-worktree, Narrative quality, and production authorization constraints remain active.
- Maximum three evidence-based repair attempts against the same root defect. A repeated third failure triggers root-cause/process reset or BLOCKED; no thrashing.
- Every escaped production defect requires a permanent regression when feasible; every false-PASS escape requires a proof-system correction.
- No application-changing tranche advances on targeted tests, `npm test`, replay, or build alone. Exact-SHA `PRYSM_WHOLE_APP_TRANCHE_GATE.md` evidence plus independent Auditor PASS is mandatory.
- UNKNOWN / UNAVAILABLE / PARTIAL / not-deeply-parsed must never become absence, false, zero, empty, Complete, AVAILABLE, or fully assessed unless governed evidence establishes that state.
- Historical compatibility replay is not current release proof.
- For material diagnostics/test output intended for later review, write a named `.txt` evidence file rather than depending on terminal scrollback.
- No paid provider/model call, production audit, deployment, production configuration mutation, or production persistence mutation without explicit authorization.

Exact next action:
From a local clone of `chriskulbaba2025/prysm-project-context`, pull governance `main`, then run `tools\autorun\PRYSM-AUTORUN.ps1` with `-AppRepo "C:\Users\kulba\Desktop\vantage-platform" -GovernanceRepo <local governance path> -StartRole Builder -PreflightOnly`. If and only if the final line is `PREFLIGHT PASS`, immediately run the same controller with `-MaxRuns 0`. Do not manually alter the application first; T0 must recover the exact dirty local state.

Last verified:
2026-08-31 America/Toronto
