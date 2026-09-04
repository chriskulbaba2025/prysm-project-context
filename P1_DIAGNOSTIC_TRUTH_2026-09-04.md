# P1 Diagnostic Truth — Cross-Report Contradiction Integrity

Date: 2026-09-04
Stage: DIAGNOSTIC_TRUTH
Application: `chriskulbaba2025/vantage-platform`
Application branch/SHA diagnosed: `main` / `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec`
Classification: `VERIFIED_DESIGN_GAP`

## Process-gate result

`PRYSM PROCESS GATE PASS`

The governed read-only P1 diagnosis completed against the frozen application SHA. No application files, tests, providers, paid/live workflows, deployment state, or production state were changed.

## Diagnostic conclusion

The shared cross-report interpretation projection exists, is persisted, and some renderer paths fail closed when it is absent. The current application nevertheless does not yet satisfy the P1 client-visible coherence contract.

Four material gaps remain:

1. **CTA Clarity and Conversion Path Clarity are not independently meaningful constructs in the current projection.** They are generated from the identical path-status calculation.
2. **Point-of-reading explanation is missing.** The report renders labels but does not immediately explain what each construct measures or why a legitimate divergence exists.
3. **Mobile usability and indexability are not consistently consumed through the projection.** They are projected but are not consumed by the identified renderer paths; other consumers independently use raw score/band values.
4. **Legacy trust consumption bypasses the projection.** The legacy conversion consumer reads trust directly from `model.bands.trust`.

These are product/design gaps, not evidence-acquisition or scoring-policy authorization to broaden P1.

## Material lineage map

Canonical evidence (`site`, `performance`, path validation)

→ `scoreAudit()` builds scores, paths, bands, and `crossReportInterpretation`

→ canonical `scores.json` via scoring service

→ validated persisted inputs on current/replay paths

→ current-model hydration / v2 model construction

→ v2 narrative renderer or legacy approved-page renderer

→ persisted report HTML and approved/published read path.

Relevant diagnosed seams:

- `vantage-platform/services/worker/src/report-model/cross-report-interpretation.js:5`
- `vantage-platform/services/worker/src/scoring/vantage-score.js:1579`
- `vantage-platform/services/worker/src/report-model/current-model.js:7`
- `vantage-platform/services/worker/src/orchestration/audit-orchestrator.js:1245`
- `vantage-platform/services/worker/src/report/render-report-v2.js:719`
- `vantage-platform/services/worker/src/report/sections-conversion.js:103`

## Material branch / scenario inventory

| Branch | Current behavior | P1 proof required |
|---|---|---|
| Aligned | Shared values can render coherently | Exact rendered artifact |
| Legitimate divergence | Labels can differ, but no point-of-reading distinction is supplied | Each construct’s measure and reason for difference visible together |
| No path evidence | CTA/path become Not Assessed | Fail-closed rendered proof |
| Weak / partial / clear path | CTA and path receive the same state | Proof of meaningful independent construct behavior or documented redesign |
| Missing / malformed projection | Some consumers throw when absent | Current production/replay fail-closed proof |
| Replay / persisted | Current replay rehydrates canonical inputs | Provenance-bound replay artifact, not historical HTML alone |

## Later artifact provenance requirement

The exact client-visible proof must bind:

- frozen application SHA;
- canonical `scores.json` and evidence inputs;
- artifact keys/hashes;
- report design / renderer identity;
- lifecycle state;
- represented material branch/scenario.

Historical fixture reports cannot establish current renderer behavior without that provenance binding.

## Candidate bounded repair boundary — NOT YET AUTHORIZED

A later repair, if approved, should be limited to the four diagnosed gaps:

1. make CTA Clarity and Conversion Path Clarity independently meaningful constructs while preserving evidence integrity;
2. add point-of-reading client-visible explanation where materially different related conclusions can appear;
3. route material mobile-usability and indexability report consumption through the governed interpretation projection rather than independent raw score/band interpretation;
4. remove the identified legacy trust bypass so the material consumer uses the governed interpretation projection.

Do not broaden this repair into scoring-policy changes, provider acquisition, Writer/Judge redesign, unrelated presentation work, P2-P10, or exhaustive unrelated whole-app redesign.

## Required next gate

No production-code edit is authorized yet.

Exact next action:

1. independently review this diagnosis and the candidate bounded repair boundary for blind spots;
2. require Betty pre-repair result: `Verdict: PASS`, `Unresolved CRITICAL: 0`, `Unresolved MAJOR: 0`;
3. then obtain Chris’s explicit bounded-repair authorization;
4. only after both are durably committed may P1 advance to `BOUNDED_BUILD`.

Brad is not required at this point. Brad returns later for independent review of the frozen client-visible outcome/proof.
