# PRYSM P# Commit + Audit Execution Gate

Date: 2026-09-04
Status: ACTIVE HARD GOVERNANCE RULE
Applies to: P1-P10 and every material P# micro-tranche

## Purpose

Prevent PRYSM from advancing on claimed, stale, uncommitted, contradictory, or weak evidence while also preventing duplicate gate logic from creating false blockers and stop/start loops.

The governing sequence is:

`CREATE OUTCOME -> REQUIRED INDEPENDENT REVIEW/AUDIT -> COMMIT -> RESOLVE MATERIAL FINDINGS -> COMMIT -> BIND EXACT EVIDENCE -> DETERMINISTIC EXECUTION GATE -> ONE AUTHORIZED ACTOR/STAGE -> NEXT REQUIRED REVIEW`

This rule is additive to `PRYSM_OUTCOME_GATED_P_REVIEW_PROTOCOL_2026-09-04.md`.

## Single-authority gate rule

**The deterministic launcher is the sole authority for machine-verifiable gate facts.**

Machine-verifiable facts include:
- repository cleanliness;
- governance branch and synchronization with `origin/main`;
- active P# and authorized stage;
- manifest field presence;
- evidence commit existence and ancestry;
- evidence-file existence at the recorded commit;
- current evidence blob equality to the recorded bound blob;
- required literal verdict/approval/count lines;
- exact application branch and SHA;
- exact candidate SHA binding;
- required rendered-proof manifest/scenario bindings.

After the deterministic launcher reports `PRYSM PROCESS GATE PASS`, no ChatGPT/Codex/Brad/Betty prompt may run a second open-ended process-gate audit that re-decides those same Git/manifest facts.

If an agent later obtains **new direct evidence** that state changed after launch, it may report `PRYSM STAGE EVIDENCE CONFLICT` with that exact evidence. It may not invent or infer a stale-manifest failure contrary to the deterministic gate.

## Hard rule

No governed P# stage may start unless the launcher proves all prerequisites for the authorized stage are durably committed on `origin/main` and the exact application candidate is synchronized.

Local files, chat text, terminal output, uncommitted evidence, or a claimed PASS are insufficient.

Failure of a deterministic check is fail-closed and must identify the exact failing condition before any stage work begins.

## Bound-evidence immutability rule

Once a `FILE` / `COMMIT` pair is recorded in `P#_EXECUTION_GATE.env`, that evidence file is an immutable stage prerequisite.

Do not append later history, status, commentary, or process notes to that bound file merely because the program progressed. Put later state in `CURRENT_STATE.md` or a new versioned evidence file.

If the evidence itself materially needs correction:
1. create a new versioned evidence file or explicitly reopen the evidence stage;
2. perform any review/audit required by that semantic change;
3. commit and verify it;
4. rebind the manifest once to the new evidence;
5. do not silently mutate the old bound evidence in place.

This preserves the value of exact commit binding without creating routine self-inflicted staleness.

## Contract-to-execution launch gate

Before `DIAGNOSTIC_TRUTH`, require committed and bound:
1. Outcome Contract;
2. Brad review/preservation review as applicable;
3. Chris approval evidence;
4. independent pre-execution audit with exactly one `Verdict: PASS`, `Unresolved CRITICAL: 0`, and `Unresolved MAJOR: 0`;
5. exact application branch/SHA;
6. `CURRENT_STATE.md` authorizing `DIAGNOSTIC_TRUTH`.

The semantic quality challenge occurs **before manifest binding** through the independent committed review/audit artifacts. It is not re-run by a second AI gate at launcher startup.

## Before BOUNDED_BUILD

In addition to the contract gate, require committed and bound:
- Diagnostic Truth classified `VERIFIED_ROOT_CAUSE` or `VERIFIED_DESIGN_GAP`;
- Betty pre-repair audit PASS with zero unresolved CRITICAL/MAJOR;
- Chris bounded-repair authorization.

The Builder then performs only the authorized repair. The launcher does not ask the Builder to re-audit the process gate.

## Before OUTCOME_REVIEW

In addition to the build gate, require committed and bound:
- technical proof;
- system proof;
- exact candidate freeze;
- rendered/product proof;
- scenario-to-obligation matrix;
- rendered proof manifest;
- candidate application SHA exactly equal to the gate `APPLICATION_SHA`.

`OUTCOME_REVIEW` is owned by **Brad**. When this deterministic gate passes, Chris stops and hands the frozen candidate to Brad. The launcher must not route `OUTCOME_REVIEW` to Builder/Codex as a substitute for Brad.

## Before CLOSURE

In addition to the outcome-review gate, require committed and bound:
- Brad outcome review PASS;
- Betty final audit PASS with zero unresolved CRITICAL/MAJOR;
- Chris closure authorization `APPROVE AND ADVANCE`.

Closure then performs durable state recording only. It must not begin the next P# until the closure state commit is verified.

## Stage actor routing

The stage owner is deterministic:

- `DIAGNOSTIC_TRUTH` -> `BUILDER`
- `BOUNDED_BUILD` -> `BUILDER`
- `OUTCOME_REVIEW` -> `BRAD`
- `CLOSURE` -> `CHRIS` / durable state closure

The launcher must print the authorized actor. A stage may not be silently performed by a different role merely because that agent is already open.

## Codex requirement scope

Codex CLI is required only for Builder-owned stages that actually launch the Builder.

A Chris-to-Brad handoff, Brad review gate, or closure handoff must not fail because Codex is absent from PATH. The Windows PowerShell wrapper therefore may discover Codex opportunistically but must not pre-require it before the stage is known.

## P1 historical-approval transition rule

P1 entered this strengthened process after Betty/Chris approval had already occurred in chat but before standalone durable approval artifacts were required.

For P1 only, Chris may memorialize that historical fact through an explicit owner attestation that:
- states the prior approval occurred;
- does not fabricate a new Betty review;
- does not claim later audit-driven amendments were reviewed by Betty unless they actually were;
- is followed by Brad preservation review and a fresh independent pre-execution audit before diagnosis.

This is a one-time transition accommodation. P2 and later require durable review/approval evidence in the stage where it occurs.

## Continuous stage auditing

This is not a one-time gate. Before every material stage, bind the evidence produced by the previous completed stage and run the deterministic launcher again.

The pattern is:

`PREVIOUS STAGE EVIDENCE -> REQUIRED HUMAN/INDEPENDENT REVIEW -> COMMIT -> BIND -> DETERMINISTIC GATE -> ONE AUTHORIZED STAGE`

Do **not** add another free-form startup audit between deterministic PASS and the authorized stage.

## Required machine-readable execution gate

Each active P# has one root file:

`P#_EXECUTION_GATE.env`

The template is `tools/prysm/P_EXECUTION_GATE_TEMPLATE.env`.

Every stage-specific required field in the template is mandatory when that stage is authorized. The launcher fails closed on missing or placeholder values.

## Current-state rule

`CURRENT_STATE.md` must identify:
- the active P#;
- exact current stage;
- exact authorized execution stage;
- exact next actor/action.

The launcher verifies P# and stage identity. It does not require platform-specific command text to appear as a hidden proxy for stage authorization.

## Regression-test rule

Any change to the launcher, gate binding rules, stage routing, or Codex handoff must pass:

`bash tools/prysm/test-prysm-gate-contract.sh`

The permanent regression suite must prove at minimum:
- valid OUTCOME_REVIEW can pass without Codex;
- real bound-evidence mutation fails;
- required rendered-proof bindings are enforced;
- candidate identity mismatch fails;
- Builder receives a stage-only prompt after deterministic PASS;
- non-Builder stages do not pre-require Codex.

A launcher/process change is not complete until this test is green.

## Advancement rule

The only permitted transition is:

`REQUIRED EVIDENCE COMPLETE + REQUIRED REVIEW COMPLETE + REQUIRED HUMAN APPROVAL COMPLETE + GITHUB COMMIT VERIFIED + DETERMINISTIC PROCESS GATE PASS + CORRECT ACTOR`

No verbal approval, AI re-audit, technical PASS, or terminal text may bypass or contradict a deterministic gate result without new direct evidence.
