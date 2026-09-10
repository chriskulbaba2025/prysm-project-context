# PRYSM WriterInput Business-Impact Authority Contract Design

Date: 2026-09-10
Status: `CONTRACT_READY_FOR_BUILD / HIGH`

## Purpose

Define the frozen contract for preventing unmeasured downstream business outcomes from reaching the Writer as if they were directly observed evidence, while preserving the original governed finding record.

## Source preservation

The governed finding source remains authoritative and unchanged:

`finding.businessImpact`

Historical and persisted finding records must not be rewritten merely to make Writer generation safer.

The repair occurs at the WriterInput authority boundary through a deterministic derived representation.

## Derived Writer-facing contract

For each Writer-facing finding that carries business-impact context, derive a typed authority object using existing repository naming/version conventions.

The object must semantically contain:

- `text`: bounded Writer-facing business significance;
- `basis`: `OBSERVED` or `INFERRED`;
- `outcomeStatus`: governed outcome evidence status;
- `evidenceRefs`: exact references supporting the claimed measured outcome, if any;
- source finding identity;
- deterministic provenance/version if existing WriterInput contracts require it.

These names are conceptual. The Builder must inspect current repository contracts and use the smallest repository-consistent naming shape that preserves these semantics.

## Classification rule

Classify business-impact authority as `OBSERVED` only when the exact downstream outcome itself is directly measured and all of the following are true:

1. the exact outcome is directly measured;
2. its evidence status is AVAILABLE;
3. at least one exact evidence reference supports that exact outcome;
4. the Writer-facing wording does not exceed the measured scope;
5. the cited evidence is not merely a proxy condition or upstream technical signal.

If any condition is false or unproven, classify the business significance as `INFERRED`.

For `INFERRED` business significance:

- the Writer-facing text must use bounded possibility/significance language;
- it must not convert a proxy condition into a measured commercial outcome;
- any unmeasured downstream outcome must remain explicitly unmeasured/unavailable where material to the Writer's interpretation;
- exact evidence references may support the observed proxy condition, but must not be mislabeled as direct evidence of the downstream outcome.

## Reboot acceptance fixture

Source finding remains:

`Slow first impressions increase mobile abandonment.`

Observed evidence includes:

- LCP approximately 6962 ms;
- field performance evidence: UNAVAILABLE.

Required derived authority:

- basis: `INFERRED`;
- downstream outcome status: `UNAVAILABLE`;
- Writer-facing significance equivalent to: slow first impressions may create friction or affect mobile experience/evaluation; abandonment was not measured.

Forbidden Writer authority:

`Slow first impressions increase mobile abandonment.`

## Producer -> Contract -> Consumer boundary

Producer:

- existing governed FindingSet / Writer-finding projection.

Contract transformation:

- deterministic WriterInput builder derives typed business-impact authority without mutating the source finding.

Consumer:

- Writer prompt consumes the typed authority and its basis/status metadata.

Defensive last gate:

- existing WriterOutput validator remains unchanged unless implementation inspection proves a separate contract mismatch. The known Reboot failure is not evidence for weakening that validator.

## Expected implementation boundary

Required or likely required after direct source verification:

- `services/worker/src/narrative-v2/writer-input.js`
- `services/worker/src/narrative-v2/writer-findings.js`
- `services/worker/src/narrative-v2/writer-input.test.js`
- the active Writer prompt source that serializes/instructs this WriterInput field;
- focused Writer prompt/contract tests for the new typed semantics.

Conditionally required only if proven by direct dependency inspection:

- `services/worker/src/scoring/business-impact-policy.js`;
- active scoring producer/tests;
- WriterInput schema/version/migration compatibility tests;
- sanitized frozen fixtures required to preserve exact contract compatibility.

A materially broader dependency is a stop condition requiring governance reconciliation before editing outside this boundary.

## Protected invariants

Do not alter:

- numeric scoring or scoring weights;
- finding priority/order authority;
- canonical evidence;
- canonical solution authority;
- UNKNOWN/PARTIAL/UNAVAILABLE semantics;
- audit lifecycle/state;
- provider collection/adapters;
- persistence of original governed findings;
- authentication;
- unrelated orchestration;
- WriterOutput validator strictness;
- configured Writer/Judge model routing.

## Prompt requirement

Make the minimum field-specific prompt change needed so the Writer consumes `basis` and outcome evidence status rather than treating source wording as unrestricted claim authority.

Do not solve the defect through repeated generic warnings, phrase blacklists, or validator relaxation.

## Deterministic acceptance requirements

The implementation must prove at minimum:

- source `finding.businessImpact` remains byte/semantic-equivalent in the governed finding object;
- Reboot-style proxy evidence produces `INFERRED` Writer authority and an unavailable/unmeasured downstream outcome;
- an actual directly measured downstream outcome with AVAILABLE status and exact evidence reference can produce `OBSERVED` authority within measured scope;
- AVAILABLE proxy evidence alone cannot upgrade a downstream commercial outcome to `OBSERVED`;
- missing/partial/unavailable outcome evidence fails bounded rather than becoming assertive;
- prompt serialization exposes the typed basis/status metadata to the Writer;
- existing WriterOutput validator remains active and unchanged for the known causal-certainty boundary;
- no live/model/provider calls occur during deterministic Builder or verification work.

## Post-build governance

A successful implementation creates a new semantic application candidate. It does not inherit Plane 3 PASS.

Required sequence before any new model-bearing baseline:

1. Builder PASS;
2. independent GPT-5.6 Sol / High PASS;
3. semantic candidate publication;
4. authoritative context synchronization;
5. fresh explicit Chris authorization for the new Plane 3 baseline.

Do not retry the exact failed Reboot Run 2 execution and do not resume the historically abandoned Judge call.
