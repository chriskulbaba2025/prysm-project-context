# Decision: Accelerated Solo Development with Terra Preflight

Date: 2026-09-09
Status: ACTIVE TEMPORARY OPERATING DECISION

## Decision

Chris explicitly authorized PRYSM development to continue without waiting for external Betty on every micro-tranche and asked the assistant to act critically in a Betty-like manner while moving materially faster.

The operating method changes immediately from repeated narrow defect review to whole-system invariant closure.

## Model strategy

For the active Solution Depth authority-closure phase:
- Terra High is the default model for diagnosis, semantic audits, boundary selection, and consolidated governance-sensitive implementation.
- Luna Medium is restricted to mechanical work after architecture, file boundary, acceptance criteria, and tests are already frozen.
- Sol High should be used when available for the final adversarial preflight before returning to external Betty or for unresolved high-risk architecture questions.

This is a development-routing decision. It does not authorize model/provider calls inside the PRYSM application itself.

## Review cadence

External Betty remains an independent release-governance gate, but during this temporary solo phase she is not required after every micro-repair in one shared defect class.

Instead:
1. diagnose the complete invariant with Terra High;
2. inventory all affected surfaces;
3. implement one consolidated bounded repair;
4. add permanent invariant tests;
5. run full regressions;
6. run an independent adversarial internal preflight (Sol High preferred; fresh Terra High acceptable if Sol unavailable);
7. return to external Betty at the next material architecture checkpoint and before release-governance advancement.

The existing temporary Betty-deferred decision remains compatible with this decision, but this file governs the current cadence and model routing while the solo phase is active.

## Current invariant

Canonical solutions must be the sole source of client remediation anywhere in the final client artifact.

The current candidate is:
- repository: `chriskulbaba2025/vantage-platform`
- branch: `review/prysm-solution-directive-authority-betty`
- SHA: `ed671bbd50ef836b10c77917e3a78b95963188fc`

Writer-derived remediation has been removed from client HTML, but deterministic report detail still contains at least one independent Trust action list. The next step is therefore a whole-system remediation-authority closure diagnosis, not another narrow Trust-only repair.

## External Betty remains mandatory before

- merge to application `main`;
- deployment;
- production promotion;
- provider/model execution for release;
- production audit rerun;
- production data/artifact mutation;
- release-governance advancement.

## Production boundary

No production mutation is authorized by this decision.

## Related governing files

- `PRYSM_MODEL_ROUTING_AND_WHOLE_SYSTEM_PREFLIGHT_PROTOCOL_2026-09-09.md`
- `PRYSM_CANONICAL_REMEDIATION_AUTHORITY_CLOSURE_GATE_2026-09-09.md`
- `PRYSM_BETTY_REAL_PROGRESS_GATE.md`
- `DECISION_PRYSM_TEMPORARY_BETTY_DEFERRED_DEVELOPMENT_2026-09-09.md`
