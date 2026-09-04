# PRYSM Handoff — P1 Verified Design Gap / Pre-Repair Review

Date: 2026-09-04

## Authoritative repositories

Governance:
`chriskulbaba2025/prysm-project-context`

Application:
`chriskulbaba2025/vantage-platform`

Treat GitHub as authoritative. Do not reconstruct state from prior chat history when GitHub contains newer evidence.

## Current application checkpoint

Application branch:
`main`

Frozen application SHA:
`6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec`

No application source change is authorized yet.

## Active outcome

P1 — Cross-Report Contradiction Integrity.

Client/business outcome:
A client must not receive materially opposing conclusions from different sections unless the report clearly explains, at the point of reading, that the sections measure different constructs.

## Governance checkpoint

- P1 Outcome Contract approved and preserved.
- Brad preservation review: PASS.
- Final independent pre-execution audit: PASS / 0 CRITICAL / 0 MAJOR.
- P1 `DIAGNOSTIC_TRUTH` execution gate was committed and passed.
- Read-only diagnosis completed.
- Diagnosis artifact: `P1_DIAGNOSTIC_TRUTH_2026-09-04.md`.
- Diagnosis commit: `061fb47656f56c0c4e1c0ec57784d75b2d2256af`.
- Classification: `VERIFIED_DESIGN_GAP`.

## Diagnosed product gaps

1. CTA Clarity and Conversion Path Clarity currently derive from the same path-status calculation, so they are not separately meaningful constructs.
2. The client-visible report lacks immediate point-of-reading explanation of what each related construct measures and why legitimate divergence exists.
3. Mobile usability and indexability are projected but identified renderer/consumer paths still independently consume raw score/band values instead of the governed projection.
4. The legacy conversion consumer reads trust directly from `model.bands.trust`, bypassing the projection.

These are real P1 product/design gaps. They are not authorization to broaden scope.

## Bounded candidate repair — not yet authorized

Only the following repair direction is in scope for pre-repair review:

- make CTA Clarity and Conversion Path Clarity independently meaningful while preserving evidence integrity;
- add point-of-reading explanation for materially different related conclusions;
- route material mobile/indexability consumption through the governed interpretation projection;
- remove the identified legacy trust bypass.

Do not broaden into provider acquisition, scoring-policy redesign, Writer/Judge redesign, unrelated report presentation, P2-P10, or exhaustive unrelated whole-app work.

## Operating principle

The project must keep moving toward a client-ready MVP. Governance expansion is not the goal.

From this point, governance should only stop work for a material false-PASS, evidence-integrity, or foreseeable rework risk. Do not redesign the governance process again unless a concrete material defect requires it.

## Exact next action

Run one independent Betty pre-repair blind-spot review against:

1. `CURRENT_STATE.md`
2. `P1_OUTCOME_CONTRACT_2026-09-04.md`
3. `P1_DIAGNOSTIC_TRUTH_2026-09-04.md`
4. this handoff

Betty must evaluate whether:

- the diagnosis supports `VERIFIED_DESIGN_GAP`;
- the four-gap repair boundary is sufficient to satisfy P1 without unnecessary expansion;
- any material consumer/renderer/lineage branch is missing;
- the repair could create evidence-integrity or client-facing false-PASS risk.

Required pre-repair result:

`Verdict: PASS`

`Unresolved CRITICAL: 0`

`Unresolved MAJOR: 0`

If Betty PASSes, Chris explicitly authorizes the bounded repair. Then create/update the P1 execution gate for `BOUNDED_BUILD` and run the governed launcher.

Brad is not the next step. Brad returns later for independent review of the frozen client-visible report/proof.

## Hard boundaries

- No application edit before Betty PASS + Chris repair authorization.
- No paid/live provider/model audit.
- No deploy, application-main merge, production config change, destructive Git operation, or force push.
- No P2 before P1 closes.
- Diagnose-before-code remains satisfied; do not reopen diagnosis unless new material evidence contradicts the committed diagnostic truth.

## New-chat continuation prompt

Continue PRYSM from the authoritative GitHub state in `chriskulbaba2025/prysm-project-context`.

Read first:

- `CURRENT_STATE.md`
- `P1_OUTCOME_CONTRACT_2026-09-04.md`
- `P1_DIAGNOSTIC_TRUTH_2026-09-04.md`
- `HANDOFF_PRYSM_P1_VERIFIED_DESIGN_GAP_PRE_REPAIR_REVIEW_2026-09-04.md`
- `PRYSM_OUTCOME_GATED_P_REVIEW_PROTOCOL_2026-09-04.md`
- `PRYSM_P_STAGE_COMMIT_AUDIT_GATE_2026-09-04.md`

Treat GitHub as authoritative. Do not reconstruct state from the previous chat.

P1 read-only diagnosis is complete at application `main` SHA `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec` with classification `VERIFIED_DESIGN_GAP`.

Do not redo diagnosis.

The exact next action is one bounded Betty pre-repair blind-spot review of the committed diagnosis and four-gap candidate repair boundary. Do not expand governance unless a concrete material false-PASS/evidence-integrity/rework risk is identified. No application code edits are authorized until Betty returns PASS with 0 unresolved CRITICAL/MAJOR findings and Chris explicitly authorizes the bounded repair.
