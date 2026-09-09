# PRYSM Betty Real-Progress Gate

Date: 2026-09-08
Status: MANDATORY GOVERNANCE RULE — ACTIVE

## Purpose

Prevent PRYSM governance from advancing on claimed, superficial, unexercised, or imagined progress.

Betty is a **different external LLM** used as an independent progress checkpoint. Betty is not Codex, not the Builder, and not the assistant running the implementation workflow.

This is a rule, not an optional review suggestion.

## Core evidence rule

**Betty must be able to inspect the actual implementation code in GitHub.**

A proof artifact by itself is not sufficient evidence for a Betty checkpoint when code changed.

For every code implementation tranche, the completed bounded change must be committed and pushed to a non-production review/feature branch before Betty is asked to judge progress. The exact application repository, branch, and commit SHA must be supplied to Betty.

This review push is evidence publication only. It does **not** authorize merge, deployment, production promotion, audit rerun, or any other release action.

## Mandatory sequence

For every implementation tranche:

1. Builder/Codex performs the authorized bounded implementation.
2. Builder/Codex runs the required focused and regression verification.
3. Builder/Codex produces the required proof artifact.
4. If code changed, Builder/Codex commits only the authorized bounded change and pushes it to the governed non-production review/feature branch.
5. Record the exact application repository, branch, ending commit SHA, changed files, and proof artifact.
6. Update the authoritative PRYSM project-context GitHub state/handoff for the checkpoint without advancing to the next implementation tranche.
7. Give Betty:
   - the authoritative project-context repository and exact governance/state files;
   - the application repository;
   - the exact review branch;
   - the exact commit SHA containing the tranche implementation;
   - the tranche-specific acceptance conditions and preservation rules;
   - the proof artifact or its full content.
8. Betty inspects the governed state **and the actual code at the supplied SHA**, compares it with the acceptance conditions/proof, and returns only a very small progress report.
9. Governance advances to the next implementation tranche only if Betty returns a positive real-progress verdict.

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

For any tranche that changes application code, Betty must also receive:

- application repository;
- exact review/feature branch;
- exact commit SHA containing the implementation;
- changed-file boundary;
- proof/test artifact.

If the implementation code is not yet committed and pushed to GitHub, the Betty checkpoint is **not ready to run**. Do not substitute a prose summary for missing code access.

## Required Betty input pattern

The Betty prompt must preserve the same acceptance logic used by the implementation tranche. It must include, as applicable:

- the authoritative GitHub project-context repository and exact files to read;
- the governed project goal;
- the exact current tranche;
- the application repository / review branch / exact SHA containing the actual implementation;
- the concrete behaviors that must now be true;
- the concrete behaviors that must remain unchanged;
- the explicit forbidden changes / preservation boundary;
- the full Builder/Codex proof content, or a proof artifact actually available to Betty.

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

Betty answers whether the authoritative GitHub project state, actual implementation code at the supplied SHA, and supplied verification evidence demonstrate **real, material progress toward the governed goal**, rather than progress merely being claimed or assumed.

At minimum, Betty should determine whether:

- the GitHub state/handoff matches the claimed tranche and governance boundary;
- the actual changed code exists at the supplied SHA;
- the expected tranche capability is materially implemented in that code;
- tranche-specific acceptance conditions are supported by implementation and tests;
- preserved behaviors remain intact according to code/test evidence;
- the implementation stayed within the authorized boundary;
- the tranche measurably advances the governed objective.

If the code, SHA, or supplied evidence is absent or insufficient, Betty must return `REAL PROGRESS — NO`.

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

Whenever an implementation proof is returned and the next step would normally be to advance governance, explicitly stop and verify that the actual bounded code is committed and pushed to a review/feature branch. If not, the next step is to publish that exact reviewed candidate to GitHub first. Then provide the complete Betty prompt in chat with repository, branch, SHA, governed files, tranche-specific acceptance conditions, and proof content.

## Preservation

Betty is verification-only. Betty does not repair, code, merge, deploy, or alter governance state.

A review-branch push for Betty does not authorize merge or production deployment.