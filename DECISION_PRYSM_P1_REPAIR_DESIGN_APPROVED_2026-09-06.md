# Decision — PRYSM P1 Repair Design Approved

Date: 2026-09-06
Status: ACTIVE

## Decision

Chris approves the governed repair design in:

`P1_GOVERNED_REPAIR_DESIGN_2026-09-06.md`

Approved architecture:

**Deterministic Client Truth Contract + existing governed Writer/Judge, with n8n outside the core truth path for now.**

## Approval basis

The design has been critically reviewed against the seven confirmed P1 material roots and the exact failed candidate architecture.

No materially better architecture was identified. Remaining uncertainty is implementation detail, not an unresolved design gap.

The repair must eliminate the repeat evidence-to-client interpretation/classification/projection failure class, not patch isolated report wording.

## Approved boundaries

Implementation may proceed through the file/system boundary mapped in `P1_GOVERNED_REPAIR_DESIGN_2026-09-06.md`, subject to exact current-source verification before each governed edit.

The repair may modify the deterministic Client Truth / cross-report interpretation contract, report projection, recommendation qualification, action-priority client rationale, WriterInput, Writer/Judge governance, and deterministic validation as required by the approved design.

n8n remains permitted later for orchestration, alerts, replay, or review routing, but is not part of the core truth path for this P1 repair.

## Still not authorized

This approval does not authorize:

- evidence recollection or provider/adaptor changes without direct proof of a separate defect;
- scoring-weight/version changes merely to change report outcomes;
- paid/live provider or model calls;
- merge to application `main`;
- deployment;
- starting P2;
- Betty Final Audit before Brad passes the repaired candidate;
- destructive reset or cleanup of user work.

## Required implementation start

Before the first application edit:

1. verify the exact local application branch, HEAD, and working-tree state;
2. preserve any existing local work;
3. reconcile the approved expected file/test boundary against the exact current source;
4. begin implementation in the order defined by `P1_GOVERNED_REPAIR_DESIGN_2026-09-06.md`.
