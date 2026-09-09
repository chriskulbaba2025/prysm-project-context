# PRYSM Betty Real-Progress Gate

Date: 2026-09-08
Status: MANDATORY GOVERNANCE RULE — ACTIVE

## Purpose

Prevent PRYSM governance from advancing on claimed, superficial, unexercised, or imagined progress.

Betty is a **different external LLM** used as an independent progress checkpoint. Betty is not Codex, not the Builder, and not the assistant running the implementation workflow.

This is a rule, not an optional review suggestion.

## Mandatory sequence

For every implementation tranche:

1. Builder/Codex performs the authorized bounded implementation.
2. Builder/Codex produces the required proof artifact.
3. The assistant prepares a Betty checkpoint prompt that mirrors the bounded implementation contract: project goal, current tranche, tranche-specific acceptance conditions / invariants, explicit preservation constraints, and the full implementation proof content or an actually attached proof artifact.
4. The user sends that prompt/proof to Betty, the separate external LLM.
5. Betty returns only a very small progress report.
6. Governance advances only if Betty returns a positive real-progress verdict.

A Builder/Codex PASS is insufficient by itself.

## Required Betty input pattern

The Betty prompt must preserve the same acceptance logic used by the implementation tranche. It must include, as applicable:

- the governed project goal;
- the exact current tranche;
- the concrete behaviors that must now be true;
- the concrete behaviors that must remain unchanged;
- the explicit forbidden changes / preservation boundary;
- the full Builder/Codex proof content, or a proof artifact that is actually available to Betty in her chat.

Do not merely name a local file path that Betty cannot access. If Betty cannot see the proof, the checkpoint is invalid and must fail.

The acceptance conditions should be concrete and bounded, like the COMPAS2 pattern: specific expected behaviors, specific preserved behaviors, and specific non-regressions. Do not replace them with a vague request asking whether work 'looks good.'

## Betty response contract

Betty's response must stay very small.

Preferred format:

`RESULT: REAL PROGRESS — YES`

or

`RESULT: REAL PROGRESS — NO`

followed by:

`REASON: <one short sentence>`

`CONFIDENCE: HIGH / MEDIUM / LOW`

Do not ask Betty for a second implementation audit, redesign, repair plan, or long report unless a separate governed review explicitly authorizes it.

## Betty decision standard

Betty answers whether the supplied proof demonstrates **real, material progress toward the governed goal**, rather than progress merely being claimed or assumed.

At minimum, Betty should determine whether:

- the expected tranche capability is evidenced as implemented;
- tranche-specific acceptance conditions are evidenced as true;
- required tests/verification support the claim;
- preserved behaviors remain intact according to the supplied proof;
- the implementation stayed within the authorized boundary;
- the tranche measurably advances the governed objective.

If the supplied evidence is absent or insufficient, Betty must return `REAL PROGRESS — NO`.

## Governance lock

No project-context state may advance from one implementation tranche to the next until Betty has returned:

`RESULT: REAL PROGRESS — YES`

If Betty returns `RESULT: REAL PROGRESS — NO`, or if no valid Betty response exists, the tranche remains open.

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

Whenever an implementation proof is returned and the next step would normally be to advance governance, explicitly stop and remind the user that the Betty checkpoint is due. Provide the complete Betty prompt in chat, including the tranche-specific acceptance conditions and the proof content needed by Betty.

## Preservation

Betty is verification-only. Betty does not repair, code, deploy, or alter governance state.
