# PRYSM Handoff — VAN-SCHEMA-001 Mixed-Status Repair

Date: 2026-09-03

## Authoritative repositories

Application: `chriskulbaba2025/vantage-platform`

Governance/context: `chriskulbaba2025/prysm-project-context`

Treat GitHub as authoritative. Do not reconstruct current state from the previous chat.

## Production / release checkpoint

The report-improvement program P0–P10 was independently audited PASS and merged to `main`.

Production/main SHA after merge:

`08734785c0a0fc415e331ac216e22e64545a533e`

A fresh controlled production validation was then started for TBK Creative.

Fresh production audit ID:

`d79f5003-5ab8-4618-8c1c-acd75e7c34be`

Target:

`https://www.tbkcreative.com/`

Business:

`Tbkcreative`

## Production validation result before the new defect

The audit reached Narrative v2 human review after the Judge returned a bounded `eeatTrust` defect. The owner used the governed final-pass flow. No evidence recollection or rescoring was authorized by that final-pass action.

The final pass then failed at the report finalization safety gate with:

`Finding VAN-SCHEMA-001 converts PARTIAL evidence into an unqualified absence claim.`

This is a real production defect. The finalization gate correctly blocked release rather than allowing an evidence-integrity violation into the client-facing report.

## Proven root cause

A read-only diagnostic was captured from the exact production-derived repair branch and proved the fault in:

`services/worker/src/scoring/score-components.js`

Inside `buildFindings()` the shared `add()` helper currently computes DataForSEO evidence status using:

- `PARTIAL` when one of the finding's required capabilities is PARTIAL;
- otherwise the broader `site.sourceStatus`.

For `VAN-SCHEMA-001` this creates an invalid mixed-status state:

- overall `site.sourceStatus` = `PARTIAL`;
- governed capability `schema.structured_data` = `AVAILABLE`;
- `VAN-SCHEMA-001` requires `schema.structured_data`;
- therefore the finding correctly uses the full confirmed-absence wording `No structured data detected`;
- but the shared helper incorrectly stamps its DataForSEO evidence record as `PARTIAL` from the broader site status;
- `report-finalization-gate.js` then correctly rejects the mismatch because PARTIAL evidence cannot support an unqualified absence claim.

Do **not** weaken or bypass the finalization gate. It is behaving correctly.

## Local repair branch

The owner created a dedicated branch from the exact production/main SHA:

`repair/prysm-van-schema-mixed-status`

Branch starting SHA:

`08734785c0a0fc415e331ac216e22e64545a533e`

The worktree was clean before the branch was created.

## RED regression proof already added

File:

`services/worker/src/scoring/score-components.test.js`

Test name:

`VAN-SCHEMA mixed-status: AVAILABLE schema capability must not inherit PARTIAL site status`

The RED test was run and failed exactly as expected:

- tests: 1
- pass: 0
- fail: 1
- actual: `PARTIAL`
- expected: `AVAILABLE`

Assertion:

`schema finding evidence must use schema capability status, not broader PARTIAL site status`

This establishes the defect before production code changes.

## Exact repair requirement

Make the smallest causal repair in the finding evidence provenance logic so that a finding with governed required capability evidence uses the governed capability status rather than incorrectly inheriting the broader site status.

Required behavior:

1. Required capability `AVAILABLE` + overall site `PARTIAL` -> capability-specific finding evidence remains `AVAILABLE`.
2. Required capability `PARTIAL` -> finding evidence remains `PARTIAL` and bounded partial wording remains mandatory.
3. Required capability unavailable -> finding remains suppressed.
4. Findings without a capability-specific requirement -> preserve existing appropriate site-level behavior.

Primary repair file:

`services/worker/src/scoring/score-components.js`

Regression test file:

`services/worker/src/scoring/score-components.test.js`

Do not weaken the existing RED test merely to obtain PASS.

## Verification required after repair

Run, in order:

1. exact `VAN-SCHEMA mixed-status` regression test;
2. complete `score-components.test.js` suite;
3. relevant report-finalization gate tests;
4. normal worker regression suite if it requires no paid/live/provider/model calls;
5. review `git diff` for scope and unrelated changes.

Do not call the repair complete until the focused test is GREEN and the broader governed regression remains green.

## Protected boundaries

Current work is local governed repair only.

Do not:

- commit unless explicitly authorized by the governed workflow;
- push unless explicitly authorized;
- merge to `main` without separate explicit authority;
- deploy without separate explicit authority;
- change production configuration;
- run another fresh production audit;
- make paid/live provider or model calls;
- recollect production evidence;
- bypass or weaken `report-finalization-gate.js`.

## Workflow requirement for the next chat

The owner uses the established PRYSM PowerShell/PS1 governed Codex controller workflow from the VS Code integrated PowerShell terminal. Do **not** replace that with ad-hoc Codex CLI commands or giant freeform prompts.

Read the governing project files and existing PS1/controller instructions first, then continue using the established script-driven workflow exactly as documented.

The previous chat drifted away from this workflow; the next chat must recover the exact controller/PS1 entry point from the authoritative repo/instructions before issuing commands.

## Exact next action

1. Read `CURRENT_STATE.md` and the governing workflow/controller instructions in `chriskulbaba2025/prysm-project-context`.
2. Recover the exact existing PRYSM PS1/Codex controller invocation from the authoritative governed state.
3. Continue the already-proven `VAN-SCHEMA-001` repair through that script-driven workflow.
4. Do not redo diagnosis and do not replace the established controller workflow with a different Codex interaction model.
