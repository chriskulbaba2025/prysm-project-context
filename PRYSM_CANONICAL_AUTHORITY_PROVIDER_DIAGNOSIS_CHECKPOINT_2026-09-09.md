# PRYSM Canonical Authority Provider Diagnosis Checkpoint

Date: 2026-09-09
Status: READY_FOR_IMPLEMENTATION / BETTY DEFERRED FOR INTERMEDIATE DEVELOPMENT

## Application baseline

Repository: `chriskulbaba2025/vantage-platform`

Branch: `review/prysm-solution-directive-authority-betty`

Starting SHA: `7c0667ae0ad9c893bbc04363e8399e476ce473f0`

## Diagnosis result

Uploaded diagnosis: `PRYSM-CANONICAL-AUTHORITY-PROVIDER-DIAGNOSIS.txt`

Result: `READY_FOR_IMPLEMENTATION`

Verified blocker: the repaired Solution Directive Authority resolver and accepted canonical generator require complete governed `authorityRecords`, while the current Narrative v2 production composition loads findings, ScoreSet, DecisionEvidence, and CapabilityEvidence but provides no governed authority-record source/provider.

## Selected production-grade architecture

Create one new versioned static Solution Authority Registry/Provider:

`services/worker/src/solution/solution-authority-provider.js`

The provider is keyed by deterministic producing `ruleId` plus governed rule version and contains explicit reviewed solution-authority policy. It must be general across production audits and must not derive solution semantics from rejected legacy finding fields.

The provider must:

- expose an immutable registry version/source identifier;
- cover every current actionable score-bearing rule eligible for `decisionHierarchy`;
- fail closed for unsupported, stale, duplicate, missing, or version-mismatched authority entries;
- bind explicit authority semantics to current finding IDs and independently governed evidence references;
- preserve controlled capability, effort, disposition, prescription-mode, evidence-grade, implementation-check, prominence, dependency, and page-reference taxonomies;
- never create or self-certify evidence IDs;
- return complete authority records suitable for the repaired `buildSolutionDirectiveInput()` and accepted `generateCanonicalSolutions()`;
- remain a provider only, not a second generator/validator.

Current actionable rule coverage identified by diagnosis:

- `VAN-CONTENT-001`, `VAN-CONTENT-002`
- `VAN-GSC-001`, `VAN-GSC-002`, `VAN-GSC-003`
- `VAN-PATH-001`, `VAN-PERF-001`
- `VAN-SCHEMA-001`
- `VAN-TECH-001` through `VAN-TECH-005`
- `VAN-TRUST-001`, `VAN-TRUST-002`

Rendering diagnostics remain `scoreBearing:false` and do not receive invented canonical authority.

## Required change boundary

Expected application files:

1. `services/worker/src/solution/solution-authority-provider.js` — new registry/provider.
2. `services/worker/src/narrative-v2/production-path.js` — bounded provider binding into canonical production preparation.
3. `services/worker/src/application/production-runtime.js` — compose default governed provider, with test injection only if required by existing composition pattern.

Expected tests:

1. `services/worker/src/solution/solution-authority-provider.test.js` — new direct provider coverage.
2. `services/worker/src/application/narrative-v2-production-path.test.js` — production binding and fail-closed integration coverage.
3. `services/worker/src/application/production-startup-regression.test.js` — only if required to prove default provider composition/startup wiring.

`solution-directive-authority.js`, contract, validator, generator, sequence, scoring, evidence production, Writer/Judge, lifecycle, persistence, renderer/report architecture, and production configuration remain preserved.

## Persistence / contract determination

Persistence change required: **NO**.

Contract change required: **NO**.

The smallest architecture consumes the existing persisted findings, ScoreSet, DecisionEvidence, and CapabilityEvidence artifacts and produces authority/canonical solutions in memory. Do not introduce a new persistence lifecycle in this tranche.

## Required proving behavior

Implementation must prove:

- one exact registry entry per supported current actionable rule/version;
- unsupported actionable rules fail closed;
- complete 20 required authority fields are supplied where applicable; optional `outcomeSignal` remains absent unless explicitly governed;
- changing/removing legacy `recommendation`, `businessImpact`, `implementationEffort`, `verificationMethod`, `affectedUrls`, `confidence`, `module`, `dimension`, or `finalPriority` does not author solution semantics;
- evidence references resolve only from finding evidence or DecisionEvidence; unresolved IDs fail closed; `persisted:true` remains irrelevant to trust;
- CONFIRMED/PARTIAL/UNKNOWN and PRESCRIPTIVE/CONDITIONAL/INVESTIGATIVE/NON_REMEDIATION governance is preserved;
- no job-title/person ownership assumptions are introduced;
- deterministic repeatability and input immutability hold;
- scored and pending-recovery paths use the same provider/version and current governed deterministic inputs;
- non-v2 delegation remains unchanged;
- no provider/model calls are required to construct authority.

## Verification

Run focused Solution/provider tests first, then the same comparable suites used by the repaired authority tranche:

- focused Solution suite;
- existing report suite;
- report-finalization suite;
- WriterOutput suite;
- Narrative production-path suite;
- `git diff --check`.

Produce a Downloads proof artifact with exact pass/fail counts, durations, starting/ending SHA, branch, changed files, preservation confirmations, and no deployment/provider/model/audit execution.

## Governance effect

User has temporarily deferred Betty only for intermediate development.

Implementation may proceed and may be committed/pushed to a non-production review branch.

Do not merge to application `main`, deploy, promote to production, run providers/models, rerun an audit, or begin renderer/cross-page work.

Deferred Betty review remains required before release governance can advance.

## Exact next action

Starting from application SHA `7c0667ae0ad9c893bbc04363e8399e476ce473f0`, implement only the selected versioned static Solution Authority Registry/Provider and bounded canonical production binding within the expected file/test boundary; run required verification; create the proof artifact; commit and push the exact non-production candidate; record its ending SHA; then stop before renderer/cross-page work.