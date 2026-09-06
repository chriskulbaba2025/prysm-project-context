# Constraint Exception — PRYSM P1 Repair Implementation

Date: 2026-09-06
Status: ACTIVE
Applies only to: `P1 — Cross-Report Contradiction Integrity`

## Purpose

Reconcile the approved P1 systemic repair with older generic report-rebuild constraints that still describe the work as presentation-only.

## Authorized exception

For this P1 repair package only, the approved design in:

`P1_GOVERNED_REPAIR_DESIGN_2026-09-06.md`

and the approval decision in:

`DECISION_PRYSM_P1_REPAIR_DESIGN_APPROVED_2026-09-06.md`

supersede older generic constraints that would otherwise prohibit:

- deterministic cross-report/client-truth contract changes;
- report-model interpretation changes;
- recommendation qualification changes;
- action-priority client-rationale changes;
- deterministic renderer consumer changes;
- WriterInput changes;
- Writer prompt/Judge governance changes required to enforce the approved Client Truth Contract;
- the new deterministic Client Truth integrity gate.

This exception exists because the completed P1 audit proved the dominant defect is systemic evidence-to-client interpretation/classification/projection, not isolated page styling.

## Approved architecture

**Deterministic Client Truth Contract + existing governed Writer/Judge.**

The existing `cross-report-interpretation` boundary is expanded into the authoritative client-facing truth contract. Client-facing consumers must not independently reinterpret raw evidence, findings, scores, or statuses where the contract owns that meaning.

## Still prohibited

This exception does not authorize:

- evidence recollection;
- provider/adaptor changes without direct proof of a separate defect;
- canonical evidence mutation;
- scoring-weight or scoring-version changes merely to change outcomes;
- lifecycle/state-transition changes;
- authentication changes;
- storage architecture changes;
- production configuration changes;
- n8n in the core P1 truth path;
- paid/live provider or model calls;
- merge to application `main`;
- deployment;
- starting P2;
- Betty Final Audit before Brad passes the repaired candidate;
- destructive reset, clean, or discard of existing user work.

## Implementation control

The governed repair design remains the full expected file/test boundary. Exact current source must be verified before edits. Existing manual source-file / pre-edit / Whole-App / model-bearing gates remain active.

The first implementation action is local branch/HEAD/worktree verification. No application edit may begin until that state is known and preserved.
