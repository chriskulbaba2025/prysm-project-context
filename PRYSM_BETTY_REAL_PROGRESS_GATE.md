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
3. The assistant updates the authoritative PRYSM project-context GitHub state/handoff for the checkpoint without advancing to the next implementation tranche.
4. The assistant prepares a Betty checkpoint prompt that gives Betty the authoritative GitHub repository and exact files to read, plus the tranche-specific acceptance conditions and the full implementation proof content or an actually attached proof artifact.
5. The user sends that prompt/proof to Betty, the separate external LLM.
6. Betty checks the authoritative GitHub project state and the supplied implementation evidence, then returns only a very small progress report.
7. Governance advances to the next implementation tranche only if Betty returns a positive real-progress verdict.

A Builder/Codex PASS is insufficient by itself.

## Required authoritative GitHub input

Every Betty checkpoint must identify the authoritative project-context repository:

`chriskulbaba2025/prysm-project-context`

Betty must be instructed to read at minimum:

1. `CURRENT_STATE.md`
2. the current tranche handoff, when one exists;
3. `PRYSM_BETTY_REAL_PROGRESS_GATE.md`;
4. the governing specification for the current tranche, such as `PRYSM_SOLUTION_DEPTH_GOVERNANCE_2026-09-08.md`.

GitHub is the source of truth for governed project state. The checkpoint prompt must not ask Betty to reconstruct current state from chat history.

If implementation code is committed and available in the application repository, Betty should also be given the exact repository, branch, and commit/SHA to inspect. If the implementation remains local/unpushed by design, the prompt must state that fact and provide the full proof/diff/test evidence needed for Betty to judge progress. Never imply Betty can inspect code on GitHub when that code has not been pushed there.

## Required Betty input pattern

The Betty prompt must preserve the same acceptance logic used by the implementation tranche. It must include, as applicable:

- the authoritative GitHub project-context repository and exact files to read;
- the governed project goal;
- the exact current tranche;
- the concrete behaviors that must now be true;
- the concrete behaviors that must remain unchanged;
- the explicit forbidden changes / preservation boundary;
- the full Builder/Codex proof content, or a proof artifact that is actually available to Betty in her chat;
- the application repository / branch / SHA when the implementation is actually available there.

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

Betty answers whether the authoritative GitHub project state plus the supplied implementation evidence demonstrate **real, material progress toward the governed goal**, rather than progress merely being claimed or assumed.

At minimum, Betty should determine whether:

- the GitHub state/handoff matches the claimed tranche and governance boundary;
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

Whenever an implementation proof is returned and the next step would normally be to advance governance, explicitly stop and remind the user that the Betty checkpoint is due. Provide the complete Betty prompt in chat, including the authoritative GitHub repo/files, tranche-specific acceptance conditions, and the proof content needed by Betty.

## Preservation

Betty is verification-only. Betty does not repair, code, deploy, or alter governance state.
