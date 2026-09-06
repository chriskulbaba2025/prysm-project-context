# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

Last verified:
2026-09-06

## Current governed boundary

- Active P#: `P1 — Cross-Report Contradiction Integrity`.
- Current stage: BOUNDED_BUILD
- Authorized execution stage: BOUNDED_BUILD
- Authorized actor: `BUILDER/Codex`.
- Chris decision: `APPROVED` — continuous R2 bounded repair envelope, recorded in `proof/P1/reopen/P1_BOUNDED_REPAIR_AUTHORIZATION_R2_2026-09-06.md` at governance commit `94f63144a34eb4d513193b54251a9778832c36fc`.
- Binding R2 diagnosis: `proof/P1/reopen/P1_DIAGNOSTIC_TRUTH_R2_2026-09-06.md` at governance commit `9d73146e4a8a79797a19e13bd7d5d8a5c2b44e8d`.
- Diagnostic classification: `VERIFIED_DESIGN_GAP`.
- Stable root-defect identity: `P1-CROSS-REPORT-PROJECTION-RECONCILIATION`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Governance repository: `chriskulbaba2025/prysm-project-context`.
- Application branch: `p1/bounded-build-cross-report-integrity`.
- Exact frozen failed application candidate entering R2 repair: `8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c`.
- `P1_EXECUTION_GATE.env` now routes P1 to `BOUNDED_BUILD` and binds the R2 diagnosis + authorization.

## Exact current repair scope

The R2 repair is restricted to the three remaining material client-visible families established by the binding diagnosis:

1. CTA / path coherence — distinguish mechanism/invitation presence from usable conversion-path completion at the point of reading.
2. Trust evidence attribution — positive trust language must name only reassurance signals actually observed and must not imply pricing when pricing evidence is absent.
3. Fail-closed performance/readiness reconciliation — reconcile numeric lab performance, unavailable/incomplete field evidence, and client-facing readiness without turning incomplete evidence into a broad PASS/no-blocker conclusion.

Robots/indexability is not an authorized R2 repair family. A materially new robots/indexability defect, new root cause, new application seam, or protected dependency is a stop condition rather than permission to broaden the work.

## Exact authorized application paths

Only these application files may be modified during R2 `BOUNDED_BUILD`:

- `services/worker/src/report-model/cross-report-interpretation.js`
- `services/worker/src/report-model/cross-report-interpretation.test.js`
- `services/worker/src/report/foundation-readiness.js`
- `services/worker/src/report/report-detail-sections.js`
- `services/worker/src/report/v2-pillars.js`
- `services/worker/src/report/render-report-v2.js`
- `services/worker/src/report/render-report-v2-conversion.test.js`
- `services/worker/src/report/render-report-v2.test.js`
- `services/worker/src/report/render-report-v2-sections.test.js`

Any required application path outside this list is a genuine scope-boundary event. Builder must stop rather than drift.

## Exact next action

Brad's macOS environment must pull authoritative governance `main`, run the audit-only Mac certification, and only on PASS start the continuous P1 controller:

1. `git switch main`
2. `git pull --ff-only origin main`
3. `bash tools/prysm/audit-prysm-p-macos.sh`
4. only if the audit returns `PRYSM MACOS CONTINUOUS BUILDER AUTORUN CERTIFICATION PASS`, run `bash tools/prysm/PRYSM-P-AUTORUN-MAC.sh P1`.

The controller is designed to continue Builder-owned work rather than stop at convenient model-turn boundaries. It may autonomously perform the authorized R2 implementation, focused proof, broader required P1 verification, rendered proof generation, exact-candidate commit/push, and governance rebinding to Brad `OUTCOME_REVIEW`.

The successful terminal state is `READY_FOR_BRAD`, not P1 closure.

## macOS continuous Builder controls

`tools/prysm/PRYSM-P-AUTORUN-MAC.sh` is P1-only and currently enforces:

- default 45-minute (`2700` second) safety window;
- maximum 12 fresh Codex invocations;
- 60-second heartbeat;
- native macOS completion/blocker notifications;
- exact stable-root binding: `P1-CROSS-REPORT-PROJECTION-RECONCILIATION`;
- exact R2 application-path allowlist;
- governance writes limited to new `proof/P1/reopen/*`, intentional `P1_EXECUTION_GATE.env`, and intentional `CURRENT_STATE.md` synchronization;
- frozen-history verification after every Builder invocation;
- clean/pushed GitHub synchronization before continuation and terminal handoff;
- no-progress anti-thrash stop;
- same-root escalation Luna -> Terra -> Sol only on evidence-based `REPAIR_PROOF_FAILED`;
- no fourth same-root repair attempt;
- `NEW_ROOT_CAUSE` stops for owner review instead of silently expanding scope;
- independent official deterministic gate verification before `READY_FOR_BRAD` notification;
- Brad `OUTCOME_REVIEW` remains human-owned and cannot be automated by this controller.

## Required proof before Brad

Builder must not advance the gate to `OUTCOME_REVIEW` until all required Builder-owned obligations are complete and durable:

- focused positive and negative/fail-closed deterministic tests for the three families;
- focused report suites used by the R2 diagnosis plus any causally required in-scope tests;
- full required P1 deterministic verification and broader required regression/Whole-App verification;
- regenerated affected rendered scenarios under new versioned `proof/P1/reopen/` paths;
- exact manifest/hash/provenance and scenario-to-obligation mapping;
- clean pushed exact application candidate;
- new versioned technical/system/render proof under `proof/P1/reopen/`;
- `P1_EXECUTION_GATE.env` rebound to the exact repaired application SHA and new proof with `AUTHORIZED_STAGE=OUTCOME_REVIEW`;
- `CURRENT_STATE.md` synchronized to `OUTCOME_REVIEW` with Brad as next actor;
- official deterministic P1 gate PASS for that exact state with `Authorized actor: BRAD`.

## R2 diagnostic facts now frozen as input

The completed R2 diagnosis established:

- CTA invitation/mechanism and conversion-path completion are separately correct inputs but not fully reconciled at the point of reading;
- Trust positive wording can group policies/pricing/guarantees even when the exact observed signal does not include pricing;
- numeric performance/lab output can coexist with unavailable field/readiness evidence without one universal client-facing reconciliation;
- the defect remains in interpretation/projection and presentation composition rather than evidence acquisition, scoring policy, providers, storage, deployment, or Writer/Judge behavior;
- no material unresolved diagnostic question remains before bounded repair.

The R2 diagnostic was read-only: `77` focused tests passed, `0` failed, and application code remained unchanged.

## Pre-repair blind-spot continuity

The deterministic `BOUNDED_BUILD` gate continues to require the existing committed Betty pre-repair PASS. No new Betty pre-repair review is being claimed after the R2 diagnostic.

Chris's R2 authorization permits continuity only because the binding diagnosis narrows work to the remaining portion of the already governed P1 report-projection repair surface. If implementation evidence expands the root, dependency set, or product boundary, this continuity ends and the controller must stop.

## P1 history that remains frozen

- Original failed candidate SHA: `85bbeda3cb4bb2fefb47b5e551f9edc0432feea2`.
- First Brad failed-candidate outcome review: `P1_BRAD_OUTCOME_REVIEW_2026-09-05.md` — preserve unchanged.
- Prior reopened diagnosis: `P1_DIAGNOSTIC_TRUTH_REOPEN_2026-09-05.md` — preserve unchanged.
- Prior reopened repair authorization: `P1_BOUNDED_REPAIR_AUTHORIZATION_REOPEN_2026-09-05.md` — preserve unchanged.
- Prior reopened candidate SHA reviewed by Brad: `8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c`.
- Reopened-candidate Brad FAIL: `P1_BRAD_OUTCOME_REVIEW_REOPEN_2026-09-05.md` at governance commit `d73c57be0a15291855fc771326d6b181ff281c54` — preserve unchanged.
- Second owner decision: `REOPEN SAME P#`, recorded in `DECISION_P1_REOPEN_SAME_P_R2_2026-09-05.md`.
- R2 diagnostic: `proof/P1/reopen/P1_DIAGNOSTIC_TRUTH_R2_2026-09-06.md` at `9d73146e4a8a79797a19e13bd7d5d8a5c2b44e8d` — now a bound prerequisite and must not be edited in place.
- R2 bounded repair authorization: `proof/P1/reopen/P1_BOUNDED_REPAIR_AUTHORIZATION_R2_2026-09-06.md` at `94f63144a34eb4d513193b54251a9778832c36fc` — now a bound prerequisite and must not be edited in place.
- Exhaustive historical-freeze baseline: `0756e4db3746be0c2279c2083ccf83b3ec5c89f5`.
- Frozen-history guard: `tools/prysm/assert-p1-frozen-history.sh`.
- `proof/P1/rendered/*` remains historical/frozen; all new R2 proof belongs under `proof/P1/reopen/`.

## Protected boundaries

No current authorization exists for:

- evidence acquisition/adapters;
- scoring policy/weights or scoring-service redesign;
- Writer/Judge/model behavior;
- page-selection/search-data redesign;
- lifecycle, storage, auth, or deployment behavior;
- paid/live application provider/model calls;
- application `main` merge;
- deploy/production changes;
- P2;
- Betty Final Audit;
- P1 closure.

No destructive reset/clean/discard or force push is permitted.

## Windows unattended-controller status

Chris's Windows P1 continuous controller remains certified for the Windows / VS Code PowerShell environment under its existing audit path. The Windows controller engine was not modified by this macOS R2 controller upgrade.

The shared authoritative P1 governance stage has changed to `BOUNDED_BUILD`; Chris must still use the supported Windows bootstrap/audit path before any later Windows execution so the deterministic gate and current state are revalidated for the then-current exact candidate.

## macOS certification history

Brad's macOS host previously passed the notification-enabled thin-wrapper certification:

- macOS 14.6.1;
- x86_64;
- Codex CLI `0.153.0` at `/usr/local/bin/codex`;
- `osascript` notification runtime available.

A later macOS Bash 3.2 incompatibility in `assert-p1-frozen-history.sh` (`mapfile`) was discovered fail-closed before Builder execution and repaired. Mac certification now executes the real frozen-history guard and the full official deterministic gate with Builder shimmed out, so runtime incompatibilities are tested before product work starts.

Because the continuous controller has now changed from diagnostic-only to R2 Builder-to-Brad execution, Brad must run the current audit again after pulling the final authoritative `main` before starting it.

## Permanent operating sequence

`DETERMINISTIC GATE -> CORRECT ACTOR -> BOUNDED TASK -> CONTINUOUS SAME-ACTOR EXECUTION -> DURABLE PROOF -> EXACT CANDIDATE -> HUMAN OUTCOME REVIEW`

An agent turn ending is not a workflow boundary. Human intervention is reserved for genuine owner/scope decisions, protected actions, new material roots/boundaries, anti-thrash limits, or the Brad product-quality gate.

## Related process/GCU continuation

- GCU repository: `chriskulbaba2025/governed-coding-upgrade-skill`.
- Candidate upgrade: GCU v2.5 — Execution Continuity and Cross-Platform Runtime Certification.
- Draft PR: #12, branch `upgrade/v2.5-execution-continuity`.
- Current PRYSM macOS R2 work is an environment-scoped implementation/certification of those continuity principles; it does not by itself certify every future P# or every platform.
