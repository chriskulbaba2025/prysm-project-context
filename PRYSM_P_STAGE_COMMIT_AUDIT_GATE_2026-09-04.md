# PRYSM P# Commit + Audit Execution Gate

Date: 2026-09-04
Status: ACTIVE HARD GOVERNANCE RULE
Applies to: P1-P10 and every material P# micro-tranche

## Purpose

Prevent PRYSM from executing a P# stage merely because someone says the preceding review happened.

Every material stage transition must be backed by committed, auditable evidence in the authoritative governance repository before the next governed execution command may run.

The operating rule is:

`CREATE OUTCOME -> INDEPENDENT REVIEW/APPROVAL -> COMMIT -> PRE-EXECUTION AUDIT -> DISPOSITION MATERIAL FINDINGS -> INDEPENDENT PRESERVATION REVIEW -> RERUN AUDIT UNTIL ZERO MATERIAL BLOCKERS -> EXECUTION GATE -> RUN AUTHORIZED P# STAGE`

This rule is additive to `PRYSM_OUTCOME_GATED_P_REVIEW_PROTOCOL_2026-09-04.md`.

## Hard rule

No governed P# execution may start unless the launcher proves all prerequisites for the authorized stage are durably committed on `origin/main`.

Local files, chat text, terminal output, an uncommitted audit, or a claimed PASS are not sufficient for a new stage transition.

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
3. Any material review finding is dispositioned and the contract is revised.
4. Required human/adversarial approval occurs.
5. The contract, review, and approval evidence are committed and verified.
6. A separate independent pre-execution process audit challenges the committed package for false-PASS seams, narrowed acceptance criteria, hidden dependencies, missing client-visible proof, provenance gaps, and contradictory governance state.
7. Every CRITICAL/MAJOR finding is explicitly dispositioned as `ACCEPT`, `REJECT WITH EVIDENCE`, or `DEFER AS NON-MATERIAL`.
8. Accepted findings are actually resolved in the governed package.
9. Brad checks that the dispositions/amendments still preserve the approved P# outcome and do not create unnecessary scope expansion.
10. The independent pre-execution audit is rerun against the new exact governance HEAD.
11. The rerun must report `Verdict: PASS`, `Unresolved CRITICAL: 0`, and `Unresolved MAJOR: 0`.
12. All evidence is committed and verified on authoritative `origin/main`.
13. A P# execution-gate manifest records the exact evidence files, exact evidence commits, authorized stage, exact application branch, and exact application SHA.
14. Only then may the generic governed launcher enter `DIAGNOSTIC_TRUTH`.

## P1 historical-approval transition rule

P1 entered this strengthened process after Betty/Chris approval had already occurred in chat but before standalone durable approval artifacts were required.

For P1 only, Chris may memorialize that historical fact through an explicit owner attestation that:
- states the prior approval occurred;
- does not fabricate a new Betty review;
- does not claim later audit-driven amendments were reviewed by Betty unless they actually were;
- is followed by Brad preservation review and a fresh independent pre-execution audit before diagnosis.

This is a one-time transition accommodation for truthful historical state. It is not a precedent for future P# approvals.

For P2 and later, required approval/review evidence must be durably recorded as part of the stage in which it occurs. Chat-only approval cannot satisfy a future stage gate.

## Continuous stage auditing

This is not a one-time launch check.

Before every later material P# stage, the same pattern repeats:

`PREVIOUS STAGE EVIDENCE -> REQUIRED INDEPENDENT REVIEW/AUDIT -> CHRIS AUTHORIZATION WHEN REQUIRED -> COMMIT -> VERIFY -> UPDATE EXECUTION GATE -> RUN NEXT STAGE`

The generic launcher must be used again for each authorized material stage. The execution-gate manifest is updated only after the previous stage has been audibly closed and committed.

Examples:

- before `DIAGNOSTIC_TRUTH`: approved outcome contract + Brad review/preservation review + durable approval evidence + independent pre-execution audit PASS with zero unresolved CRITICAL/MAJOR;
- before `BOUNDED_BUILD`: committed diagnosis + Betty pre-repair audit + Chris bounded-repair authorization;
- before final closure review: committed technical/system proof + exact-candidate freeze + product/render artifact provenance;
- before P# -> next P#: committed Brad outcome review + Betty final audit + Chris closure + verified `CURRENT_STATE.md`.

## Required machine-readable execution gate

Each active P# must have one gate file:

`P#_EXECUTION_GATE.env`

For example:

`P1_EXECUTION_GATE.env`

Minimum fields before `DIAGNOSTIC_TRUTH`:

```text
P_ID=P1
AUTHORIZED_STAGE=DIAGNOSTIC_TRUTH
APPLICATION_BRANCH=main
APPLICATION_SHA=<exact 40-character application SHA>
CONTRACT_FILE=P1_OUTCOME_CONTRACT_2026-09-04.md
CONTRACT_COMMIT=<governance commit containing current contract>
BRAD_REVIEW_FILE=P1_BRAD_DISPOSITION_REVIEW_2026-09-04_HHMMSS.md
BRAD_REVIEW_COMMIT=<governance commit containing current Brad review>
BRAD_VERDICT=PASS
APPROVAL_FILE=P1_APPROVAL_ATTESTATION_2026-09-04.md
APPROVAL_COMMIT=<governance commit containing valid approval evidence>
CHRIS_APPROVAL=APPROVED
PRE_EXECUTION_AUDIT_FILE=P1_PRE_EXECUTION_PROCESS_AUDIT_2026-09-04_HHMMSS.md
PRE_EXECUTION_AUDIT_COMMIT=<governance commit containing fresh independent audit>
PRE_EXECUTION_AUDIT_VERDICT=PASS
```

Later stages add the stage-specific evidence fields defined by `tools/prysm/P_EXECUTION_GATE_TEMPLATE.env`. The launcher and Codex must fail closed if the manifest does not prove the prerequisites for the requested stage.

## Audit-of-the-process requirement

At startup Codex must not merely trust the gate manifest. It must read the committed prerequisite evidence and independently confirm that:

- the required reviews actually address their mandated questions;
- the recorded verdict matches the evidence content;
- no unresolved CRITICAL/MAJOR issue is hidden by the manifest;
- accepted findings were actually resolved rather than relabeled;
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
