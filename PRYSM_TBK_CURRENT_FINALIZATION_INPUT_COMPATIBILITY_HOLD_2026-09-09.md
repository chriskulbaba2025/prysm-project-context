# PRYSM TBK Current Finalization Input Compatibility Hold — 2026-09-09

Application candidate: `c6c814613bb403705b9711466ebc223e3a4837e2`
Branch: `review/prysm-solution-directive-authority-betty`

## Bounded run result
The authorized browser-render preparation stopped before any Writer/Judge execution. Deterministic preflight reached current scoring, current WriterInput, canonical solution preparation, and current model hydration, then finalization failed on two inputs:

1. client-facing competitor comparisons lacked the supplied competitor allowlist in the DecisionEvidence used by the preflight;
2. `imagesMissingAlt = 222` was paired with schema-placeholder `imageCount = 0` without the current unavailable-image-denominator marker.

No Writer/Judge run was initiated, so Chris's one bounded Writer/Judge authorization remains unused. No render/server/deployment/production mutation/main merge occurred. Application worktree and remote review branch remained clean at the exact candidate SHA.

## Verified current-code facts
- The exact frozen TBK AuditRequest stores the authoritative client competitor list under `auditRequest.competitors`.
- Current `audit-orchestrator.js` passes `auditRequest.competitors || []` to `buildDecisionEvidence()` as `suppliedCompetitors`.
- Current `buildDecisionEvidence()` serializes that list into governed DecisionEvidence for independent finalization enforcement.
- Current DataForSEO normalized TBK evidence contains page-level image arrays that are empty even where provider page metadata contains image counts; the current adapter therefore treats the aggregate image denominator as unavailable while allowing a bounded `no_image_alt` numerator.
- Current DataForSEO adapter explicitly emits `_metaFieldAvailability.images = hasPageImageData`; when page image arrays are unavailable, that value is `false`.
- Current DecisionEvidence v1 hydration may schema-coerce unavailable `imageCount` to `0`, while preserving `_metaFieldAvailability` to distinguish an unavailable denominator from a true zero.
- Current finalization gate explicitly skips numerator/denominator ratio rejection when `site._metaFieldAvailability.images === false`; it rejects the same `222 / 0` state only when denominator evidence is treated as available.

## Classification
These failures are not presently evidence of a canonical-remediation-authority defect. They are isolated to whether the historical frozen normalized/current DecisionEvidence reconstruction used by the special browser preflight correctly reproduces the current governed DecisionEvidence semantics.

## Hold
Do not edit code, tests, fixtures, current validation guards, or production artifacts yet. Do not consume the authorized Writer/Judge run.

## Exact next action
Run a Terra High READ-ONLY diagnosis of the two finalization failures. Prove whether a legitimate current DecisionEvidence can be deterministically rebuilt/currentized from the frozen AuditRequest plus persisted normalized SourceResults, without provider/model calls or fabricated fields; prove the exact image-availability derivation and competitor-allowlist mapping; and identify whether any application source change is actually required before resuming the already-authorized bounded run.
