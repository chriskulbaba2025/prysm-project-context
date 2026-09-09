# PRYSM Canonical Integration — Solution Directive Authority Blocker

Date: 2026-09-08
Status: VERIFIED BLOCKER — DIAGNOSIS REQUIRED BEFORE INTEGRATION CODE

## Accepted foundation

Application repository: `chriskulbaba2025/vantage-platform`

Accepted generator SHA: `8f3896fed40f7825a6f2a1d6a17a47a25d397cd2`

The validator and deterministic canonical solution generator are Betty-approved.

## Verified production seam

Source inspection at the accepted generator SHA confirms:

- `services/worker/src/narrative-v2/production-path.js` loads canonical findings, ScoreSet, DecisionEvidence, and CapabilityEvidence, hydrates the current report model, runs the report-finalization gate, and then proceeds into the existing narrative/render lifecycle.
- `services/worker/src/report-model/current-model.js` projects scores, decision hierarchy, findings, DecisionEvidence, CapabilityEvidence, and existing deterministic report analysis; it does not contain governed canonical solution directives.
- `services/worker/src/report-content/build-package.js` projects existing findings and report facts; it does not contain the governed solution-directive fields required by the accepted generator.
- `services/worker/src/evidence/decision-evidence.js` hydrates persisted source evidence. It does not define remediation authority such as prescription mode, capability, effort, disposition, binary implementation checks, dependencies, or governed solution wording.
- `services/worker/src/solution/solution-generator.js` deliberately requires explicit `solutionDirectives`/`directives` for every governed finding and fails closed when they are absent.

## Root blocker

The current canonical production inputs do not contain one authoritative source for the complete governed solution directive required by the accepted generator.

Existing findings contain useful legacy fields such as recommendation, business impact, implementation effort, verification method, affected URLs, and evidence. Those fields are not equivalent to the accepted solution contract and do not establish all required governed facts.

At minimum the accepted generator requires explicit governed authority for fields including:

- `failureMode`;
- `evidenceGrade`;
- `prescriptionMode`;
- `siteAnchor`;
- `whatToChange` / `howToFix` at the allowed evidence strength;
- `capabilityRequired`;
- canonical `effortBand`;
- dependencies;
- binary `implementationCheck`;
- `disposition`;
- `clientProminence`;
- cross-page references where supplied;
- resolvable finding/evidence references.

Silently deriving these from generic recommendation prose, confidence values, source availability, job-title assumptions, or historical S/M/L display values would violate the accepted fail-closed generator design and Solution Depth governance.

## Governance effect

Do not wire `generateCanonicalSolutions()` into the production/report-model path until the source of each required directive field is explicitly identified and proven governed.

This is not a renderer problem and must not be bypassed by creating placeholder directives.

No evidence, scoring, Writer/Judge, lifecycle, persistence, renderer, or production changes are authorized by this diagnostic.

## Exact next action

Run a bounded Solution Directive Authority Diagnosis at accepted SHA `8f3896fed40f7825a6f2a1d6a17a47a25d397cd2`.

For every generator-required directive field, identify the exact existing authoritative source if one exists, prove whether the source semantics are sufficient, and classify the field as:

- DIRECT — safely copied without reinterpretation;
- DETERMINISTIC_DERIVATION — derivable only by an explicit governed rule with no semantic invention;
- NEW_AUTHORITY_REQUIRED — no sufficient current source exists.

The diagnosis must then define the smallest non-renderer, non-scoring, non-persistence authority seam needed to supply complete directives to the accepted generator. Do not implement that seam in the diagnostic run.
