# PRYSM Solution Directive Authority Diagnosis Checkpoint

Date: 2026-09-08
Status: READY FOR AUTHORITY IMPLEMENTATION

## Accepted foundation

Application repository: `chriskulbaba2025/vantage-platform`

Accepted generator SHA: `8f3896fed40f7825a6f2a1d6a17a47a25d397cd2`

The validator and deterministic canonical solution generator are Betty-approved.

## Diagnosis result

Codex completed the bounded diagnostic with no application changes.

Result: `READY_FOR_AUTHORITY_IMPLEMENTATION`

Root cause: the deterministic pipeline has authoritative findings, evidence, and priority order, but no single governed source for the complete solution directive required by the fail-closed generator.

Classification summary:

- DIRECT: 5 fields / authorities.
- DETERMINISTIC_DERIVATION: 7 fields / operations.
- NEW_AUTHORITY_REQUIRED: 27 fields.

The diagnosis explicitly rejected unsafe automatic mappings from legacy recommendation prose, businessImpact, historical effort, verificationMethod, affectedUrls, sourceStatus, confidence, rule/module/dimension, finalPriority, and sequence order into the accepted solution-authority semantics.

## Selected authority seam

Next bounded implementation tranche is a pure authority-resolution boundary:

- `services/worker/src/solution/solution-directive-authority.js`
- `services/worker/src/solution/solution-directive-authority.test.js`

Primary contract:

`buildSolutionDirectiveInput({ findings, scoreSet, decisionEvidence, authorityRecords, pageRegistry })`

The module must:

- accept validated read-only findings, ScoreSet, DecisionEvidence, resolver context, registered page IDs, and explicit governed authority records;
- require one explicit authority record for every actionable governed finding;
- resolve all finding/evidence/page references;
- refuse to synthesize missing solution semantics from legacy diagnostic fields;
- return `{ findings, decisionHierarchy, solutionDirectives, validationContext }` suitable for the accepted generator;
- fail closed with structured authority errors when authority is missing, stale, contradictory, ambiguous, or unverifiable;
- call/use the accepted generator only after authority completeness/resolution checks;
- preserve scoring, evidence, Client Truth, Writer/Judge, lifecycle, persistence, renderer, production configuration, and provider/model behavior.

## Fields that remain new governed authority

At minimum:

- failureMode;
- evidenceRefs / solution evidence resolver mapping;
- evidenceGrade;
- prescriptionMode;
- problem;
- whyItMatters;
- siteAnchor type/locator/scope/exact/evidenceRefIds;
- whatToChange;
- howToFix;
- capabilityRequired;
- canonical effortBand;
- dependencies;
- binary implementationCheck;
- optional outcomeSignal;
- disposition;
- clientProminence;
- crossPageReferences.

## Explicit non-equivalences

Do not automatically map:

- `finding.recommendation` -> `whatToChange` / `howToFix`;
- `finding.businessImpact` -> `whyItMatters`;
- legacy `implementationEffort` -> canonical effort band;
- `verificationMethod` -> binary implementation check;
- `affectedUrls` / first evidence record -> site anchor;
- source AVAILABLE/PARTIAL -> CONFIRMED/PARTIAL/UNKNOWN;
- finding confidence -> evidenceGrade;
- rule/module/dimension -> capabilityRequired;
- governed rank/priority -> disposition;
- priority/order/effort -> dependencies.

## Governance effect

The diagnosis clears only the bounded authority-definition implementation tranche.

Canonical production-path integration remains blocked until the authority boundary is implemented, tested, published to a non-production review branch, and passes the mandatory Betty checkpoint.

No renderer integration, merge, deployment, provider/model call, audit rerun, scoring change, evidence change, persistence change, lifecycle change, or Writer/Judge change is authorized.

## Exact next action

Implement only `solution-directive-authority.js` and its focused test file from accepted generator SHA `8f3896fed40f7825a6f2a1d6a17a47a25d397cd2`; run focused plus required regressions; produce proof; commit/push only the two authorized files to a non-production review branch; record exact SHA; then stop for Betty before any production-path integration.
