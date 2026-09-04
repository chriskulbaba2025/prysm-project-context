# Decision — PRYSM P# Commit/Audit Gate Before Execution

Date: 2026-09-04
Status: ACTIVE

## Decision

Every PRYSM P# and material P# micro-tranche must pass a committed audit gate before any governed execution stage may run.

The required pre-execution pattern is:

`CREATE P# OUTCOME -> BRAD REVIEW -> BETTY AUDIT -> IMPROVE -> CHRIS APPROVAL -> COMMIT -> VERIFY COMMIT + AUDITS -> RUN AUTHORIZED STAGE`

The rule then repeats before each later material stage.

The generic launcher is:

`bash tools/prysm/start-prysm-p.sh P#`

The launcher must fail closed unless the stage prerequisites are represented in committed evidence on authoritative `origin/main`, the evidence commits are verified, the exact application candidate is verified, and the semantic process-gate audit passes before substantive work begins.

## Reason

PRYSM previously demonstrated that technical PASS can be valid while the intended client/business outcome remains only partially achieved. A further false-PASS seam exists if reviews or audits are discussed in chat or terminal output but are not durably committed and checked before execution.

The project therefore treats the governance process itself as a continuously audited system.

## Implication

- No uncommitted review, audit, approval, proof, or local file can satisfy a stage gate.
- A claimed audit is insufficient; the launcher verifies committed evidence and Codex semantically checks that the audit actually addressed its mandated questions.
- A changed evidence artifact makes the recorded gate stale.
- `CURRENT_STATE.md` must identify the active P# and exact next authorized stage.
- No P# can advance because a person, model, or script merely reports PASS.
- The hard mechanics are governed by `PRYSM_P_STAGE_COMMIT_AUDIT_GATE_2026-09-04.md`.
