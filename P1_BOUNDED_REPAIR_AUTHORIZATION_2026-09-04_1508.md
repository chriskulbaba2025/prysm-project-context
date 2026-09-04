# P1 Bounded Repair Authorization

Date: 2026-09-04 15:08 America/Toronto
Owner: Chris
Application: `chriskulbaba2025/vantage-platform`
Frozen application baseline: `main` / `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec`
Governance: `chriskulbaba2025/prysm-project-context`

## Owner authorization

Chris accepted `P1-BETTY-M01` and explicitly directed that it be fixed so P1 can move ahead.

After Betty Round 2 returned `Verdict: PASS`, `Unresolved CRITICAL: 0`, `Unresolved MAJOR: 0`, that owner instruction is bound here as explicit authorization for the exact bounded repair below.

Authorization: **APPROVED**

## Exact authorized repair boundary

The Builder is authorized to repair only these five causally linked P1 obligations:

1. Make CTA Clarity and Conversion Path Clarity independently meaningful constructs while preserving evidence integrity.
2. Add point-of-reading client-visible explanation where materially different related conclusions can appear.
3. Route material mobile-usability and indexability deterministic report consumption through the governed cross-report interpretation projection rather than independent raw score/band interpretation.
4. Remove the identified legacy trust bypass so the material deterministic consumer uses the governed cross-report interpretation projection.
5. Route the material client-visible Narrative v2 conclusion path through the same governed cross-report interpretation authority so Writer-generated P1 interpretation cannot independently contradict the deterministic report, with same-rendered-artifact coherence proof for material P1 scenarios.

## Authorized implementation surfaces

Only files causally required to implement or prove the five obligations may be changed. The expected material surfaces include, as applicable:

- `services/worker/src/report-model/cross-report-interpretation.js`
- `services/worker/src/scoring/vantage-score.js`
- `services/worker/src/report-model/current-model.js`
- `services/worker/src/report/render-report-v2.js`
- `services/worker/src/report/sections-conversion.js`
- material detail/foundation report consumers that currently independently interpret mobile/indexability
- `services/worker/src/narrative-v2/writer-input.js`
- Writer input/reference/schema/prompt/validation surfaces only as strictly required to carry and enforce the governed P1 projection
- corresponding focused tests, branch/scenario proof, replay proof, and rendered proof

If implementation discovers a materially broader source or behavior boundary, stop and reopen the bounded authorization rather than silently expanding scope.

## Protected surfaces / non-goals

This authorization does not permit:

- provider acquisition or provider/adaptor changes;
- canonical evidence mutation;
- scoring weights or scoring-policy redesign;
- general Writer/Judge redesign;
- unrelated Narrative style/content improvements;
- paid Writer/Judge/model calls without separate authorization;
- fresh live/paid production audits;
- deployment or production configuration changes;
- merge to application `main`;
- P2-P10 work;
- destructive Git operations or force push.

## Required proof

The candidate must prove the five obligations across the committed P1 branch/scenario requirements, including aligned, legitimate divergence, unavailable/partial/malformed, replay/persisted, and legacy/fail-closed behavior where applicable.

The final P1 artifact must be provenance-bound and show deterministic and Narrative layers remaining coherent in the same client-visible report.

Because this authorization can touch model-bearing WriterInput/prompt/validation or Narrative semantics, `PRYSM_MODEL_BEARING_RELEASE_GATE.md` applies to later release closure. Paid/live model proof remains separately authorization-gated and is not granted here.

## Build gate

Chris repair authorization: **APPROVED**

Betty pre-repair gate: **PASS / 0 / 0**

`BOUNDED_BUILD` may be authorized in `P1_EXECUTION_GATE.env` after this file is committed and referenced there.
