# PRYSM Plane 3 Writer Robustness Design Gate

Date: 2026-09-10
Status: `CONTRACT_READY_FOR_BUILD / HIGH`

## Decision

Selected primary path:

`WRITERINPUT_AUTHORITY_CHANGE_REQUIRED`

## Root system condition

`finding.businessImpact` currently reaches WriterInput as an untyped required string.

Example source wording:

`Slow first impressions increase mobile abandonment.`

That field can express contextual or inferred business significance. It is not, by itself, evidence that a downstream commercial outcome was directly measured.

Because WriterInput does not type that distinction, the Writer must infer whether assertive wording is evidence authority or contextual significance. Reboot Run 1 correctly bounded the claim; Reboot Run 2 copied it as causal authority.

This is the shaping weakness to repair.

## Selected architecture

Use a **source-preserved, typed, derived Writer-facing representation**.

The original governed source `finding.businessImpact` remains unchanged in the FindingSet and historical records.

WriterInput receives a separate deterministic typed representation that distinguishes observed outcome evidence from inferred business significance and carries the evidence authority needed to keep generated wording within the measured scope.

## Required semantics

The derived Writer-facing representation must carry, using repository-conventional field names:

- bounded Writer-facing significance text;
- basis: `OBSERVED` or `INFERRED`;
- outcome-evidence status;
- exact evidence references;
- source finding ID;
- deterministic provenance/version where required by existing contracts.

Do not adopt these conceptual field names mechanically if repository conventions require different names. Preserve the semantics.

## Critical rule

AVAILABLE evidence for a proxy condition does **not** make a downstream commercial outcome AVAILABLE.

Example:

- AVAILABLE LCP evidence may prove slow LCP;
- it does **not** prove abandonment.

A commercial outcome can be treated as directly observed only when all of the following are true:

1. the exact outcome is directly measured;
2. outcome evidence status is AVAILABLE;
3. an exact evidence reference exists;
4. wording remains within the measured scope;
5. the evidence is not merely a proxy condition.

Otherwise the business significance is `INFERRED` and must remain bounded.

## Reboot target behavior

Preserved source finding:

`Slow first impressions increase mobile abandonment.`

Observed evidence:

- LCP approximately 6962 ms;
- field performance: UNAVAILABLE.

Required Writer-facing semantics:

- basis: `INFERRED`;
- downstream outcome status: `UNAVAILABLE`;
- bounded authority equivalent to: slow first impressions may create friction or affect mobile experience/evaluation; abandonment was not measured.

The Writer must not receive authority to claim:

`Slow first impressions increase mobile abandonment.`

## Explicit non-solutions

Do not:

- weaken the existing WriterOutput validator;
- add a phrase blacklist as the primary repair;
- switch Writer models without separate routing evidence/governance;
- alter scoring weights, priorities, canonical evidence, canonical solution authority, lifecycle, provider collection, storage, authentication, or unrelated orchestration.

Only modify upstream scoring/business-impact producer code if direct source inspection proves an active producer violates the existing bounded-impact policy.

## Prompt impact

Only the minimum field-specific prompt change is justified.

The Writer prompt should consume the new basis/status metadata so the model is told the authority level of business-impact context.

Do not duplicate the existing general causal-certainty rule unnecessarily.

## Validator impact

Expected WriterOutput validator changes: **NONE**.

The existing validator correctly rejected the escaped causal claim and remains the defensive last gate.
