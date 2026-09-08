# PRYSM Betty Real-Progress Gate

Date: 2026-09-08
Status: MANDATORY GOVERNANCE RULE — ACTIVE

## Purpose

Prevent PRYSM governance from advancing on claimed, superficial, unexercised, or imagined progress.

Betty is a **different external LLM** used as a lightweight independent checkpoint. Betty is not Codex, not the Builder, and not the assistant running the implementation workflow.

This is a rule, not an optional review suggestion.

## Mandatory sequence

For every implementation tranche:

1. Builder/Codex performs the authorized implementation.
2. Builder/Codex produces the required proof artifact.
3. The user gives Betty a short checkpoint prompt plus the proof/result summary or artifact.
4. Betty returns a very short independent judgment on whether the project shows real, material progress rather than claimed or assumed progress.
5. Governance advances only if Betty returns a positive progress verdict.

A Builder/Codex PASS is insufficient by itself.

## Betty checkpoint standard

Betty is intentionally lightweight. The purpose is not a second full audit.

Betty should answer only whether the evidence presented demonstrates real progress toward the governed goal.

Betty should look for these minimum signals:

- something materially changed, not just wording or planning;
- the claimed capability is actually evidenced by implementation/test/proof results;
- tests or verification demonstrate the new behavior rather than merely claiming it;
- the work moved the project measurably closer to the governed objective;
- there is no obvious contradiction between the claimed progress and the evidence supplied.

If the evidence is insufficient, Betty must say that progress is not yet verified.

## Standard Betty prompt

Use this short prompt after each implementation tranche:

> We are improving PRYSM so the report gives clients stronger, evidence-governed guidance on how to solve identified problems, not just what the problems are. Review the attached/latest implementation proof or summary. Based only on the evidence provided, is this **real, material progress toward that goal**, or are we mostly claiming progress without proving it? Reply with only:
> 
> **REAL PROGRESS — YES**
> or
> **REAL PROGRESS — NO: [one short reason]**

## Governance lock

No project-context state may advance from one implementation tranche to the next until Betty has returned:

`REAL PROGRESS — YES`

If Betty returns `REAL PROGRESS — NO`, or if no Betty response exists, the tranche remains open.

## Required checkpoints for current Solution Depth tranche

Betty is mandatory after:

1. Validator implementation
2. Generator implementation
3. Canonical solution integration
4. Renderer / cross-page reference implementation
5. Supporting Detail implementation changes
6. Full regression / fireproofing tranche
7. Final human-review candidate before production promotion

Additional implementation tranches inherit the same rule automatically.

## Reminder duty

Whenever an implementation proof is returned and the next step would normally be to advance governance, explicitly remind the user that the Betty checkpoint is due and provide the short standard Betty prompt.

## Preservation

Betty is verification-only. Betty does not repair, code, deploy, or alter governance state.
