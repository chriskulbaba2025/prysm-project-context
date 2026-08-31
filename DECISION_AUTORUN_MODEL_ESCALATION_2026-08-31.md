# Decision: Cheap-first Codex model escalation for PRYSM autorun

Date: 2026-08-31
Status: Active for Production Closure autorun

## Decision

The PRYSM autonomous Production Closure controller must use the lowest current GPT-5.6 Codex tier for initial work and escalate only after a governed repair/proof failure of the same root defect.

Model ladder:

1. `gpt-5.6-luna` — Level 1 / `repair_attempt = 0` — all initial Builder and Auditor work.
2. `gpt-5.6-terra` — Level 2 / `repair_attempt = 1` — only after the same root defect has failed one evidence-based repair/proof attempt.
3. `gpt-5.6-sol` — Level 3 / `repair_attempt = 2` — only after the same root defect has failed two evidence-based repair/proof attempts.
4. A third governed repair failure sets `repair_attempt = 3`, stops the controller, and produces the normal Windows BLOCKED alert. No fourth autonomous repair attempt is permitted until the user intervenes and establishes a materially new root-cause boundary.

After an independent Auditor PASS closes a tranche, the next governed work resets to Level 1 / Luna.

## Failure accounting

The following consume an escalation level only when they prove that the same root defect survived an actual repair/proof attempt:
- targeted proof failure after a repair;
- Whole-App Tranche Gate failure attributable to the same repaired defect;
- independent Auditor FAIL/PASS_WITH_MINOR that rejects the same tranche candidate on a material repair issue.

The following do **not** consume an escalation level:
- initial defect discovery;
- ordinary `CONTINUE` between work steps;
- Builder/Auditor role switching;
- Codex usage-limit exhaustion;
- CLI/process/protocol failure;
- network/GitHub infrastructure failure;
- a newly proven materially different root cause.

## Usage-limit efficiency rule

When Codex reports a usage-limit exhaustion, the controller stops on the first detected usage-limit failure and alerts the user. It must not perform the previous repeated three-call retry pattern and must not consume Terra/Sol escalation levels.

After usage resets, rerunning the controller recovers durable state and resumes at the same governed repair level.

## Reason

The Production Closure loop is long-running and the user wants maximum useful work per included/paid Codex allowance. Current OpenAI model guidance positions Luna for cost-sensitive high-volume work, Terra as the balance tier, and Sol as flagship capability. Escalating only when evidence proves the cheaper tier could not close the same root defect preserves higher-cost capacity for the cases that require it.

## Implementation

`tools/autorun/PRYSM-AUTORUN.ps1` owns model selection. Builder/Auditor prompts may not independently choose or request a different model.

The controller passes `--model <model-id>` to each fresh `codex exec` invocation, records the selected model/level in terminal output and per-run prompt context, and uses `repair_attempt` as the durable escalation index.

This decision does not weaken any PRYSM gate or allow a lower-capability result to bypass deterministic verification or independent audit.
