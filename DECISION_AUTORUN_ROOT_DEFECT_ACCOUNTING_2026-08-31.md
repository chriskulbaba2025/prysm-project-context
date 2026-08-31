# Decision: Controller-owned root-defect accounting for PRYSM autorun

Date: 2026-08-31
Status: Active

## Decision

The PRYSM autorun controller, not Codex, owns repair-escalation accounting.

Every structured Builder/Auditor result must carry:
- `root_defect_id`: a stable identifier for the active root-defect boundary, or `NONE` when no repair defect is active;
- `failure_class`: one of `NONE`, `REPAIR_PROOF_FAILED`, `NEW_ROOT_CAUSE`, or `EXTERNAL_OR_PROTOCOL`;
- `repair_attempt`: an echo of the controller-provided current repair index only. Codex must not calculate the next repair level.

The controller compares the returned `root_defect_id` with its current durable root-defect identity and computes the next repair level itself.

## Accounting rules

1. Same `root_defect_id` + `REPAIR_PROOF_FAILED` consumes exactly one escalation level.
2. Changed `root_defect_id` never consumes the previous defect chain's escalation budget. It resets to Luna / repair attempt 0.
3. `NEW_ROOT_CAUSE` requires a changed, non-`NONE` `root_defect_id` and resets to Luna / 0.
4. If Codex labels a failure `REPAIR_PROOF_FAILED` but changes the root-defect identity, identity wins: the controller defensively treats it as a newly exposed root boundary and resets to Luna / 0.
5. `EXTERNAL_OR_PROTOCOL` does not consume an escalation level.
6. Independent Auditor PASS resets the active root defect to `NONE` and repair attempt to 0.
7. A third failed repair is BLOCKED only when three failed repair/proof attempts belong to the same root-defect identity.

## Reason

The prior controller stored only an integer `repair_attempt`. The governing escalation policy required escalation only for the same root defect, but the machine had no durable identity with which to prove sameness. As deeper production proofs crossed new boundaries, newly exposed prerequisites could be incorrectly charged to the previous defect chain and trigger repeated manual BLOCKED resets.

The T4 production-composition proof exposed this defect directly: after the current-replay artifact-source boundary was reset, the proof reached a materially different Narrative v2 AuditRequest requirement (`report.designVersion = 2.0.0`), but the controller still exhausted the prior chain.

## Current T4 reset

The newly proven active boundary is:

`T4.AUD-T4-002.AUDIT_REQUEST_DESIGN_VERSION`

It is materially different from the deterministic current-artifact-source boundary. T4 therefore resumes at Luna / repair attempt 0 while preserving all uncommitted application proof work.

## Implementation requirements

- `tools/autorun/PRYSM-AUTORUN-RESULT.schema.json` requires `root_defect_id` and `failure_class`.
- `tools/autorun/PRYSM-AUTORUN-ACCOUNTING.ps1` contains deterministic accounting logic.
- `tools/autorun/PRYSM-AUTORUN.ps1` must ignore Codex attempts to choose the next escalation level and use the accounting helper instead.
- Runtime prompts must state the current root-defect identity and explain that `repair_attempt` is echo-only.
- The existing Luna -> Terra -> Sol maximum for one unchanged root defect remains intact.
- No gate, evidence-integrity rule, finalization rule, or three-attempt anti-thrash protection is weakened.
