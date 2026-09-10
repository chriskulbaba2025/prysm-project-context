# PRYSM TBK Current Finalization Input Compatibility Diagnosis Checkpoint

Date: 2026-09-09
Application candidate: `c6c814613bb403705b9711466ebc223e3a4837e2`
Branch: `review/prysm-solution-directive-authority-betty`

## Result
`CURRENT_DECISION_EVIDENCE_RECONSTRUCTION_SAFE`

## Root cause
The special browser-preflight reconstruction reused historical DecisionEvidence instead of rebuilding the current governed projection from persisted normalized SourceResults. That historical projection omitted both the AuditRequest-derived competitor allowlist and the current DataForSEO image-denominator availability marker.

The frozen normalized evidence deterministically supports both current fields. After current DecisionEvidence was reconstructed through the governed path and all downstream deterministic inputs were regenerated, the complete pre-model finalization gate passed with zero errors.

## Writer/Judge authorization
The previously authorized single bounded current TBK Writer/Judge run remains `UNUSED`.

No Writer or Judge call occurred during this diagnosis.

## Competitor trace
The frozen AuditRequest uses `auditRequest.competitors` with exactly:
- `https://red-rhino.com`
- `https://www.northern.co`
- `https://www.zoomedia.ca`

Current `audit-orchestrator.js` passes `auditRequest.competitors || []` to `buildDecisionEvidence()` as `suppliedCompetitors`, and current `decision-evidence.js` serializes that exact array as `DecisionEvidence.suppliedCompetitors`.

The regenerated client-facing comparison URLs were:
- `https://red-rhino.com`
- `https://www.zoomedia.ca`

Every rendered comparison is inside the exact supplied allowlist. No competitor application defect was proven.

## Image trace
The frozen normalized DataForSEO SourceResult contains 250 normalized pages. Every persisted page `images` array is empty. Provider/page metadata contains positive image counts on some pages, but no normalized image records were collected.

Persisted aggregate state includes:
- `imageCount: null`
- `imagesMissingAlt: 222`
- `imagesMissingDimensions: null`
- `_metaCountersAvailable: false`
- historical `_metaFieldAvailability` without an `images` member

Current DataForSEO semantics derive:
- `allImages = pages.flatMap((p) => p.images)`
- `hasPageImageData = allImages.length > 0`
- `imageCount = hasPageImageData ? allImages.length : null`
- `imagesMissingAlt = hasPageImageData ? ... : metricChecks.no_image_alt ?? null`
- `_metaFieldAvailability.images = hasPageImageData`

Because all persisted page image arrays are empty, the current availability marker is deterministically `false`.

At DecisionEvidence hydration the frozen v1 integer schema converts unavailable `imageCount` to `0`, while `_metaFieldAvailability.images = false` preserves the fact that the denominator is unavailable. Current `report-finalization-gate.js` therefore does not interpret `imagesMissingAlt = 222` over schema-coerced `imageCount = 0` as a real impossible ratio.

## Reconstruction boundary
Current DecisionEvidence can be safely reconstructed outside the repositories from:
- frozen AuditRequest;
- frozen normalized DataForSEO, PageSpeed, SERP, and backlinks SourceResults;
- current deterministic compatibility derivation of the missing image availability marker;
- current `buildDecisionEvidence()` semantics.

No underlying evidence observation is changed. The semantic additions versus historical DecisionEvidence are only:
1. the exact AuditRequest-derived `suppliedCompetitors` allowlist;
2. the current image availability marker.

CapabilityEvidence regeneration was checked and remained schema-valid and deep-equal to the frozen CapabilityEvidence.

For complete current consistency, findings, ScoreSet 2.0.0, WriterInput, and canonical solutions must be regenerated downstream of the reconstructed DecisionEvidence before Writer/Judge execution.

## Full pre-model finalization
PASS

Finalization errors: `NONE`

Retained warning:
- Performance score 71 and technical hygiene score 6 diverge by more than 60 points.

This is an existing warning, not a finalization failure.

## Required changes
Application change required: `NO`
Provider rerun required: `NO`
Repository changes to application: `NONE`
Model / Writer / Judge calls during diagnosis: `NONE`

## Preservation
Application HEAD remained `c6c814613bb403705b9711466ebc223e3a4837e2`.
Application branch remained `review/prysm-solution-directive-authority-betty`.
Application worktree remained clean.
No application source, tests, fixtures, production artifacts, providers, Playwright acquisition, deployment, commit, push, merge, or production state was changed.

## Exact next action
Run exactly one already-authorized current TBK Writer/Judge release-candidate execution against the corrected temporary deterministic packet. If it validates, generate canonical solutions through the current production authority path, render the report locally, and serve it for Chris's browser review. Stop immediately on any Writer/Judge/release validation failure without repair, additional model calls, deployment, provider rerun, production mutation, or main merge.
