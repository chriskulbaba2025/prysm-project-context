# PRYSM P# Commit + Audit Execution Gate

Date: 2026-09-04
Status: ACTIVE HARD GOVERNANCE RULE
Applies to: P1-P10 and every material P# micro-tranche

## Purpose

Prevent PRYSM from executing a P# stage merely because someone says the preceding review happened.

Every material stage transition must be backed by committed, auditable evidence in the authoritative governance repository before the next governed execution command may run.

The operating rule is:

`CREATE OUTCOME -> BRAD REVIEW -> BETTY PROCESS/BLIND-SPOT AUDIT -> IMPROVE -> CHRIS APPROVAL -> COMMIT -> VERIFY COMMIT + AUDITS -> RUN AUTHORIZED P# STAGE`

This rule is additive to `PRYSM_OUTCOME_GATED_P_REVIEW_PROTOCOL_2026-09-04.md`.

## Hard rule

No governed P# execution may start unless the launcher proves all prerequisites for the authorized stage are durably committed on `origin/main`.

Local files, chat text, terminal output, an uncommitted audit, or a claimed PASS are not sufficient.

A required review/audit counts only when:

1. its evidence file exists in the governance repository;
2. the evidence file records its required verdict;
3. the commit containing that evidence is recorded in the P# execution gate manifest;
4. that commit is an ancestor of current `origin/main`;
5. the file exists at that recorded commit;
6. `CURRENT_STATE.md` agrees on the active P# and authorized stage;
7. the local governance tree is clean and exactly synchronized with `origin/main` before execution.

Failure of any check is fail-closed: the launcher must stop before Codex execution.

## Contract-to-execution launch gate

Before the first P# execution stage (`DIAGNOSTIC_TRUTH`) may run, the following sequence is mandatory:

1. Chris creates the P# Outcome Contract.
2. Brad independently reviews the contract.
3. Any material Brad finding is dispositioned and the contract is revised.
4. Betty performs an adversarial contract/process audit focused on false-PASS seams, narrowed acceptance criteria, hidden dependencies, and missing client-visible proof.
5. Zero unresolved CRITICAL/MAJOR contract-stage findings remain.
6. Chris explicitly approves the frozen contract.
7. The approved contract, Brad review, Betty audit, Chris approval state, and `CURRENT_STATE.md` are committed to GitHub.
8. The write is verified.
9. A P# execution-gate manifest records the exact evidence files, exact evidence commits, authorized stage, and application baseline.
10. Only then may the generic governed launcher enter `DIAGNOSTIC_TRUTH`.

## Continuous stage auditing

This is not a one-time launch check.

Before every later material P# stage, the same pattern repeats:

`PREVIOUS STAGE EVIDENCE -> REQUIRED INDEPENDENT REVIEW/AUDIT -> CHRIS AUTHORIZATION WHEN REQUIRED -> COMMIT -> VERIFY -> UPDATE EXECUTION GATE -> RUN NEXT STAGE`

The generic launcher must be used again for each authorized material stage. The execution-gate manifest is updated only after the previous stage has been audibly closed and committed.

Examples:

- before `DIAGNOSTIC_TRUTH`: approved outcome contract + Brad contract review + Betty contract/process audit;
- before `BOUNDED_BUILD`: committed diagnosis + Betty pre-repair audit + Chris bounded-repair authorization;
- before final closure review: committed technical/system proof + exact-candidate freeze + product/render artifact provenance;
- before P# -> next P#: committed Brad outcome review + Betty final audit + Chris closure + verified `CURRENT_STATE.md`.

## Required machine-readable execution gate

Each active P# must have one gate file:

`P#_EXECUTION_GATE.env`

For example:

`P1_EXECUTION_GATE.env`

Minimum fields:

```text
P_ID=P1
AUTHORIZED_STAGE=DIAGNOSTIC_TRUTH
APPLICATION_BASELINE=<exact application SHA>
CONTRACT_FILE=P1_OUTCOME_CONTRACT_2026-09-04.md
CONTRACT_COMMIT=<governance commit containing approved contract>
BRAD_REVIEW_FILE=P1_BRAD_OUTCOME_CONTRACT_REVIEW_2026-09-04.md
BRAD_REVIEW_COMMIT=<governance commit containing review>
BRAD_VERDICT=APPROVE_CONTRACT
BETTY_AUDIT_FILE=P1_BETTY_OUTCOME_CONTRACT_AUDIT_2026-09-04.md
BETTY_AUDIT_COMMIT=<governance commit containing audit>
BETTY_VERDICT=PASS
CHRIS_APPROVAL=APPROVED
APPROVAL_COMMIT=<governance commit containing Chris approval/current state>
```

Later stages may add stage-specific evidence fields. The launcher and Codex must fail closed if the manifest does not prove the prerequisites for the requested stage.

## Audit-of-the-process requirement

At startup Codex must not merely trust the gate manifest. It must read the committed prerequisite evidence and independently confirm that:

- the required reviews actually address their mandated questions;
- the recorded verdict matches the evidence content;
- no unresolved CRITICAL/MAJOR issue is hidden by the manifest;
- `CURRENT_STATE.md` and the manifest do not contradict each other;
- the stage being launched is the exact next authorized stage.

If that process audit fails, Codex must STOP and report `PRYSM PROCESS GATE FAIL` without diagnosis, coding, or advancement.

## Commit-first rule

No uncommitted artifact may satisfy a P# stage gate.

If work is complete but not committed and verified, the stage remains incomplete.

If an evidence file changes after its recorded gate commit, the gate is stale and must be regenerated from newly committed evidence.

## Advancement rule

The only permitted stage transition is:

`REQUIRED EVIDENCE COMPLETE + REQUIRED AUDIT COMPLETE + REQUIRED HUMAN APPROVAL COMPLETE + GITHUB COMMIT VERIFIED + PROCESS GATE VERIFIED`

No terminal command, Codex result, technical PASS, or verbal approval can bypass this rule.
