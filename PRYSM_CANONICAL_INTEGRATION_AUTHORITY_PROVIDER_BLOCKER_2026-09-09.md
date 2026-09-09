# PRYSM Canonical Integration — Authority Provider Blocker

Date: 2026-09-09
Status: VERIFIED BLOCKER — AUTHORITY PROVIDER DIAGNOSIS REQUIRED BEFORE INTEGRATION CODE

## Provisional development baseline

Application repository: `chriskulbaba2025/vantage-platform`

Branch: `review/prysm-solution-directive-authority-betty`

Repaired authority SHA: `7c0667ae0ad9c893bbc04363e8399e476ce473f0`

Betty review is temporarily deferred for intermediate development under `DECISION_PRYSM_TEMPORARY_BETTY_DEFERRED_DEVELOPMENT_2026-09-09.md`. Release remains blocked pending deferred Betty review.

## Verified current production seam

Exact-source inspection at repaired SHA confirms:

- `services/worker/src/narrative-v2/production-path.js` loads canonical findings, ScoreSet, DecisionEvidence, and CapabilityEvidence through `loadScoredInputs()`.
- `runNarrativeV2FromScored()` builds WriterInput directly from those loaded inputs.
- `createNarrativeV2ProductionPath()` currently receives base orchestrator, lifecycle/artifact/validation bindings, Narrative v2 writer/judge executors, final-pass authorization, and clock. It has no solution-directive authority-record source/provider parameter.
- `services/worker/src/application/production-runtime.js` composes the Narrative v2 production path from `narrativeV2Deps`, but no authority-record provider or resolver is currently composed there.
- The `services/worker/src/solution/` directory contains the accepted contract, validator, sequence, generator, and repaired authority resolver, but no governed production authority-record provider/source.
- `buildSolutionDirectiveInput()` still correctly requires explicit `authorityRecords`; it does not invent them.

## Root blocker

The canonical generator and repaired authority resolver are ready to consume explicit governed authority records, but the current production composition has no governed source that supplies those records.

Simply importing `buildSolutionDirectiveInput()` and `generateCanonicalSolutions()` into `production-path.js` would not constitute a valid integration: the path would have no authoritative `authorityRecords` input and would fail closed or require invented data.

This is the same governance principle that originally blocked direct canonical integration, narrowed now to the missing production authority-provider boundary.

## Required next diagnosis

Before canonical integration code, determine the smallest production-grade authority-provider architecture that can supply complete explicit `authorityRecords` without:

- deriving solution semantics from rejected legacy fields;
- weakening the repaired evidence-reference boundary;
- changing scoring, evidence collection, Writer/Judge facts/contracts, lifecycle, persistence, renderer, or production configuration unless separately proven necessary;
- embedding TBK-only report content into a general production path;
- creating an ungoverned manual data injection path.

The diagnosis must inspect the current finding/rule generation and production composition boundaries and classify each feasible authority source against:

1. general production applicability;
2. deterministic/fail-closed behavior;
3. source/version governance;
4. evidence-reference resolution;
5. testability;
6. whether persistence or contract migration would be required;
7. whether it preserves current production behavior when no governed authority exists.

The diagnosis must select one smallest robust architecture and identify exact source/test files before any implementation.

## Governance effect

No canonical integration code is authorized until the authority-provider source is identified and its full boundary is mapped.

Renderer/cross-page work remains blocked.

No merge to application `main`, deployment, production promotion, provider/model call, audit rerun, or production mutation is authorized.

## Exact next action

Run a read-only bounded Canonical Solution Authority Provider Diagnosis at application SHA `7c0667ae0ad9c893bbc04363e8399e476ce473f0`. Inspect the finding/rule producers, production composition, existing configuration/static-registry patterns, and solution contracts; identify one general governed source for complete authority records; map the smallest exact file/test boundary; produce a diagnosis proof; do not edit application code in that diagnostic run.