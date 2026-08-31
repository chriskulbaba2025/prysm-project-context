# Decision: Controller-owned root-defect accounting for PRYSM autorun

Date: 2026-08-31
Status: Active

## Decision

The PRYSM autorun controller, not Codex, owns repair-escalation accounting.

Every structured Builder/Auditor result must carry:
- `root_defect_id`: a stable identifier for the active root-defect boundary, or `NONE` when no repair defect is active;
- `failure_class`: one of `NONE`, `REPAIR_PROOF_FAILED`, `NEW_ROOT_CAUSE`, `PROOF_SETUP_FAILURE`, or `EXTERNAL_OR_PROTOCOL`;
- `repair_attempt`: an echo of the controller-provided current repair index only. Codex must not calculate the next repair level.

The controller compares the returned `root_defect_id` with its current durable root-defect identity and computes the next repair level itself.

## Accounting rules

1. Same `root_defect_id` + `REPAIR_PROOF_FAILED` consumes exactly one escalation level.
2. Changed `root_defect_id` never consumes the previous defect chain's escalation budget. It resets to Luna / repair attempt 0.
3. `NEW_ROOT_CAUSE` requires a changed, non-`NONE` `root_defect_id` and resets to Luna / 0.
4. If Codex labels a failure `REPAIR_PROOF_FAILED` but changes the root-defect identity, identity wins: the controller defensively treats it as a newly exposed root boundary and resets to Luna / 0.
5. `PROOF_SETUP_FAILURE` does not consume an escalation level because the intended governed assertion was not reached. It preserves the same root identity and current model level so the corrected harness can rerun the intended proof.
6. `EXTERNAL_OR_PROTOCOL` does not consume an escalation level.
7. Independent Auditor PASS resets the active root defect to `NONE` and repair attempt to 0.
8. A third failed repair is BLOCKED only when three completed failed repair/proof attempts belong to the same root-defect identity.

## What counts as a completed repair/proof attempt

A repair attempt counts only when a materially distinct code/contract correction is followed by its required proof and that proof reaches the governed product/contract assertion far enough to return a verdict about the repaired boundary.

The following are proof-setup failures and do not consume the current level:
- missing temporary fixture directories/files;
- syntax/import/module-resolution failures in newly added proof code;
- malformed fixture construction that aborts before the target assertion executes;
- test-runner/harness setup failures that prevent the repaired product boundary from being exercised.

Once the governed assertion executes and rejects the repaired behavior, the result is `REPAIR_PROOF_FAILED` and consumes the same-root escalation level normally.

## Reason

The prior controller stored only an integer `repair_attempt`. The governing escalation policy required escalation only for the same root defect, but the machine had no durable identity with which to prove sameness. As deeper production proofs crossed new boundaries, newly exposed prerequisites could be incorrectly charged to the previous defect chain and trigger repeated manual BLOCKED resets.

A second accounting ambiguity was then exposed in T4: the third Sol proof for `T4.V2_PUBLICATION_RETRIEVAL_CONTRACT` aborted during divergent-draft fixture setup because the fixture directory did not exist. The intended publication/retrieval assertion never ran. Treating that setup abort as the third same-root repair failure would violate the definition of an evidence-based repair attempt.

## Current T4 disposition

The active boundary remains:

`T4.V2_PUBLICATION_RETRIEVAL_CONTRACT`

The failed fixture setup is reclassified as `PROOF_SETUP_FAILURE`. It does not create a new root defect and does not consume the final Sol level. T4 therefore resumes at repair attempt 2 / Sol with the already-corrected uncommitted proof fixture preserved for one actual rerun of the intended proof.

## Implementation requirements

- `tools/autorun/PRYSM-AUTORUN-RESULT.schema.json` requires `root_defect_id` and `failure_class`, including `PROOF_SETUP_FAILURE`.
- `tools/autorun/PRYSM-AUTORUN-ACCOUNTING.ps1` contains deterministic accounting logic and regression coverage proving a proof-setup failure at attempt 2 remains at attempt 2.
- Builder governance explicitly requires `PROOF_SETUP_FAILURE` when the proof harness aborts before the governed assertion.
- `tools/autorun/PRYSM-AUTORUN.ps1` ignores Codex attempts to choose the next escalation level and uses the accounting helper instead.
- The existing Luna -> Terra -> Sol maximum for one unchanged root defect remains intact.
- No gate, evidence-integrity rule, finalization rule, or three-attempt anti-thrash protection is weakened.
