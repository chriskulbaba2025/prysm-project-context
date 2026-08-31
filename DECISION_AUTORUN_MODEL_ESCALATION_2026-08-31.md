# Decision: Cheap-first Codex model escalation for PRYSM autorun

Date: 2026-08-31
Status: Active for Production Closure autorun

## Decision

The PRYSM autonomous Production Closure controller must use the lowest current GPT-5.6 Codex tier for initial work and escalate only after a governed repair/proof failure of the same stable root defect.

Model ladder:

1. `gpt-5.6-luna` — Level 1 / `repair_attempt = 0` — all initial work for a root-defect identity.
2. `gpt-5.6-terra` — Level 2 / `repair_attempt = 1` — only after the same `root_defect_id` has failed one evidence-based repair/proof attempt.
3. `gpt-5.6-sol` — Level 3 / `repair_attempt = 2` — only after the same `root_defect_id` has failed two evidence-based repair/proof attempts.
4. A third governed repair failure against that same unchanged `root_defect_id` sets the controller repair level to 3, stops the controller, and produces the normal Windows BLOCKED alert. No fourth autonomous same-root repair attempt is permitted until the user intervenes or a materially new root-cause boundary is proven.

After an independent Auditor PASS closes a tranche, the next governed work resets to Level 1 / Luna, `repair_attempt = 0`, and `root_defect_id = NONE`.

## Controller-owned root-defect accounting

`DECISION_AUTORUN_ROOT_DEFECT_ACCOUNTING_2026-08-31.md` governs failure identity and supersedes any earlier implication that Codex may choose or increment the next repair level.

Every structured Builder/Auditor result includes:
- `root_defect_id` — stable active root identity or `NONE`;
- `failure_class` — `NONE`, `REPAIR_PROOF_FAILED`, `NEW_ROOT_CAUSE`, or `EXTERNAL_OR_PROTOCOL`;
- `repair_attempt` — echo of the controller-provided current index only.

The controller computes the next repair level deterministically:
- same root + `REPAIR_PROOF_FAILED` -> increment exactly one level;
- changed root -> reset to Luna / 0;
- `NEW_ROOT_CAUSE` -> changed non-`NONE` root, reset to Luna / 0;
- external/protocol failure -> no escalation;
- Auditor PASS -> root `NONE`, Luna / 0.

If the returned root identity changes while Codex mistakenly labels the event `REPAIR_PROOF_FAILED`, root identity wins defensively and the controller resets to Luna / 0. This prevents a newly exposed prerequisite from consuming the previous defect chain.

## Failure accounting

The following consume an escalation level only when they prove that the same stable root defect survived an actual repair/proof attempt:
- targeted proof failure after a repair;
- Whole-App Tranche Gate failure attributable to the same repaired defect;
- independent Auditor FAIL/PASS_WITH_MINOR that rejects the same root-defect candidate on a material repair issue.

The following do **not** consume an escalation level:
- initial defect discovery;
- a newly proven materially different root cause;
- ordinary `CONTINUE` between work steps;
- Builder/Auditor role switching;
- Codex usage-limit exhaustion;
- CLI/process/protocol failure;
- network/GitHub infrastructure failure.

## Usage-limit efficiency rule

When Codex reports a usage-limit exhaustion, the controller stops on the first detected usage-limit failure and alerts the user. It must not perform the previous repeated three-call retry pattern and must not consume Terra/Sol escalation levels.

After usage resets, rerunning the controller recovers durable state and resumes at the same governed root identity and repair level.

## Reason

The Production Closure loop is long-running and the user wants maximum useful work per included/paid Codex allowance. Current OpenAI model guidance positions Luna for cost-sensitive high-volume work, Terra as the balance tier, and Sol as flagship capability. Escalating only when evidence proves the cheaper tier could not close the same root defect preserves higher-cost capacity for the cases that require it.

A controller defect discovered during T4 showed that an integer attempt counter was insufficient: deeper production proofs exposed new prerequisites, but without a durable root identity those new boundaries could be incorrectly charged to the previous repair chain and trigger repeated manual BLOCKED stops. Root-aware accounting closes that process defect without weakening the three-attempt anti-thrash rule.

## Implementation

`tools/autorun/PRYSM-AUTORUN.ps1` owns model selection and next-level accounting.

`tools/autorun/PRYSM-AUTORUN-ACCOUNTING.ps1` owns the deterministic root-identity transition function.

`tools/autorun/PRYSM-AUTORUN-RESULT.schema.json` requires `root_defect_id` and `failure_class`.

Builder/Auditor prompts may not independently choose or request a different model and may not calculate the next `repair_attempt`.

The controller passes `--model <model-id>` to each fresh `codex exec` invocation, records the selected model/level and active root identity in terminal output and per-run prompt context, and uses root identity plus failure class as the durable escalation basis.

This decision does not weaken any PRYSM gate or allow a lower-capability result to bypass deterministic verification or independent audit.
