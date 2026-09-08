# PRYSM Betty Real-Progress Gate

Date: 2026-09-08
Status: MANDATORY GOVERNANCE RULE — ACTIVE

## Purpose

Prevent PRYSM governance from advancing on claimed, superficial, unexercised, or imagined progress.

The Betty checkpoint is a required independent verification gate after every implementation tranche and before governance may advance to the next tranche.

This is a rule, not an optional review suggestion.

## Mandatory sequence

For every implementation tranche:

1. Builder/Codex performs the authorized implementation.
2. Builder/Codex produces the required proof artifact.
3. Betty independently verifies the proof against actual changed files, git diff, test execution, and governed requirements.
4. Governance advances only if Betty returns:

`REAL PROGRESS VERIFIED — READY TO ADVANCE`

If Betty returns any other disposition, the tranche remains open and governance must not advance.

## Betty verification standard

Betty must not trust the implementation proof by itself.

Betty must independently verify, as applicable:

- claimed capability exists in executable code, not only prose, constants, comments, or placeholders;
- required rules are enforced, not merely named;
- tests exercise behavior, including invalid and boundary cases;
- tests fail for the intended governed reason;
- the implemented path is reachable/exercised and not dead scaffolding;
- actual changed files match the authorized tranche boundary;
- no unauthorized generator, renderer, Writer/Judge, evidence, scoring, lifecycle, persistence, or deployment changes were introduced;
- regression suites claimed in proof were actually run;
- proof claims match observable code/test/artifact evidence;
- no bypass weakens evidence-governance or fail-closed behavior.

## Anti-imagined-progress fail conditions

Betty must return `PROGRESS NOT VERIFIED — [exact reason]` if any of the following is true:

- proof claims functionality that is not present in code;
- a governed rule exists only as a label/constant with no enforcement;
- tests exercise only happy paths when failure gates are required;
- tests assert strings/fixtures without proving behavior;
- validators or gates can trivially always pass;
- fixtures are too artificial to exercise the governed boundary;
- code exists but is not invoked/exercised by tests;
- implementation weakens evidence-grade constraints;
- sequence/dependency logic is nominal rather than behaviorally enforced;
- regression tests were not actually run as claimed;
- changed files exceed the authorized boundary without explicit governed justification;
- proof and actual git diff/test evidence disagree.

## Required Betty artifact

Each checkpoint must produce a non-empty Downloads artifact named for the tranche, for example:

`PRYSM-BETTY-<TRANCHE>-REAL-PROGRESS-CHECK.txt`

The artifact must include:

- claimed progress;
- independently observed progress;
- evidence for each material claim;
- test-quality assessment;
- boundary assessment;
- missing/shallow/unexercised areas;
- exact blockers, if any;
- final disposition.

## Allowed dispositions

Only these are allowed:

- `REAL PROGRESS VERIFIED — READY TO ADVANCE`
- `PROGRESS NOT VERIFIED — [exact reason]`

## Governance lock

No project-context state may advance from one implementation tranche to the next until the required Betty artifact exists and its disposition is `REAL PROGRESS VERIFIED — READY TO ADVANCE`.

A Builder/Codex proof marked PASS is insufficient by itself.

If a future handoff, chat, agent, or automation attempts to advance without the Betty checkpoint, stop and require Betty verification first.

## Required checkpoints for current Solution Depth tranche

Betty is mandatory after each of these stages:

1. Validator implementation
2. Generator implementation
3. Canonical solution integration
4. Renderer / cross-page reference implementation
5. Supporting Detail implementation changes
6. Full regression / fireproofing tranche
7. Final human-review candidate before production promotion

Additional implementation tranches inherit the same rule automatically.

## Reminder duty

Whenever an implementation proof is returned and the next step would normally be to advance governance, explicitly remind the user that the Betty checkpoint is now mandatory and provide/run the Betty verification step before any governance update.

## Preservation

Betty is verification-only unless a separate governed repair authorization is granted. Betty must not silently repair implementation defects while acting as verifier.
