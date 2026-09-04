# P1 Betty Pre-Repair Finding Disposition

Date: 2026-09-04 15:02 America/Toronto
Application: `chriskulbaba2025/vantage-platform`
Frozen application branch/SHA: `main` / `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec`
Governance: `chriskulbaba2025/prysm-project-context`

## Owner disposition

Finding: `P1-BETTY-M01`
Severity: MAJOR
Disposition: **ACCEPT**

Chris explicitly accepted the finding and directed that it be fixed so P1 can move ahead.

This acceptance does not bypass the required Betty PASS gate. No application edit is authorized until the amended boundary is independently re-reviewed and returns `Verdict: PASS`, `Unresolved CRITICAL: 0`, and `Unresolved MAJOR: 0`.

## Accepted material risk

Narrative v2 is injected into the same client-visible report as the deterministic report, but the Writer input does not currently receive the governed `crossReportInterpretation` projection. The deterministic P1 repair could therefore be correct while Writer-generated client-visible prose independently interprets the same P1 areas from raw score/band or deterministic-analysis inputs and creates a materially contradictory conclusion.

## Amended bounded repair boundary — candidate for Betty rerun

The P1 candidate repair boundary is amended from four to five tightly related repair obligations:

1. Make CTA Clarity and Conversion Path Clarity independently meaningful constructs while preserving evidence integrity.
2. Add point-of-reading client-visible explanation where materially different related conclusions can appear.
3. Route material mobile-usability and indexability deterministic report consumption through the governed cross-report interpretation projection rather than independent raw score/band interpretation.
4. Remove the identified legacy trust bypass so the material deterministic consumer uses the governed cross-report interpretation projection.
5. Route the material client-visible Narrative v2 conclusion path through the same governed cross-report interpretation authority so Writer-generated P1 interpretation cannot independently contradict the deterministic report. Prove coherence between deterministic and Narrative layers in the same rendered artifact for the material P1 scenarios.

## Boundary protection

The fifth obligation is limited to the P1 semantic authority handoff required for client-visible coherence. It does **not** authorize:

- general Writer/Judge redesign;
- new narrative objectives or style work;
- scoring-policy or scoring-weight changes;
- provider acquisition or canonical evidence changes;
- paid Writer/Judge/model reruns;
- unrelated report presentation changes;
- P2-P10 work;
- exhaustive unrelated whole-app redesign.

If the smallest implementation requires a Writer-input/schema/prompt/validation contract update solely to carry and enforce the governed P1 projection, that update is within the candidate boundary. Any broader model-bearing behavior change remains out of scope.

## Required proof consequence

P1 proof must demonstrate, from the same provenance-bound candidate:

- the governed projection is the authority used by deterministic P1 consumers;
- the material Narrative v2 path receives and is constrained by that same authority;
- aligned conclusions remain coherent;
- legitimate divergent constructs remain explicitly understandable at point of reading;
- unavailable/partial/malformed/replay conditions remain fail-closed;
- the final client-visible HTML contains no material contradiction between deterministic and Narrative layers for the covered P1 scenarios.

## Next gate

Rerun Betty only against:

- `P1-BETTY-M01`;
- this accepted amendment;
- the committed P1 diagnosis and Outcome Contract.

Required result before `BOUNDED_BUILD` authorization:

- `Verdict: PASS`
- `Unresolved CRITICAL: 0`
- `Unresolved MAJOR: 0`
