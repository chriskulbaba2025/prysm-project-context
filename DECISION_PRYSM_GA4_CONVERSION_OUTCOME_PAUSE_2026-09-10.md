# PRYSM Decision — Pause GA4 Conversion Outcome Authority

Date: 2026-09-10
Status: APPROVED BY CHRIS
Project: PRYSM

## Decision

For the current PRYSM release candidate, GA4-based downstream commercial-outcome authority is paused.

PRYSM will NOT treat GA4 data as direct `OBSERVED` authority for conversion, enquiry, lead, revenue, abandonment, or other downstream commercial outcomes in this release.

GA4 may continue to be used only within its existing governed contextual/analytics evidence role. Existing GA4 collection, scoring, provider semantics, and production request structure are not to be expanded for conversion-event authority as part of the current repair.

## Reason

Independent design work proved that the current system does not have a governed mapping from specific GA4 event identities to exact business outcomes, and no current production path can safely establish direct downstream commercial-outcome authority without a larger product/authority expansion.

That future expansion would require, at minimum, a governed conversion-event mapping, typed provider outcome evidence, exact property/event/scope binding, transport through the evidence/scoring graph, and a non-scoring authority attachment seam.

Those capabilities are deferred rather than fabricated or inferred.

## Current release boundary

1. Raw `finding.businessImpact` remains source/history provenance and must not be used as unrestricted Writer authority.
2. Writer-facing commercial/business significance is fail-closed to `INFERRED` and must be deterministically bounded.
3. No current GA4 evidence may produce `MEASURED_OUTCOME` authority for downstream commercial outcomes.
4. No positive `OBSERVED` downstream commercial-outcome path is required for the current release candidate.
5. Existing directly observed technical, accessibility, search, rendering, and other governed condition evidence remains available according to its current contracts; this decision does not downgrade those condition observations.
6. WriterOutput validation remains unchanged and continues as the defensive downstream gate.
7. Do not solve this release by lexical phrase blacklists.
8. Do not expand audit-request GA4 configuration, GA4 event semantics, GA4 provider collection, scoring transport, numeric scoring, priority, lifecycle, storage, authentication, Judge, or model routing to create conversion authority.

## Deferred feature

A future separately governed feature may add GA4 downstream-outcome authority. That work must begin with an explicit authority design for conversion-event semantics and a real end-to-end producer → contract → consumer path. It is outside the current launch/test boundary.

## Implementation consequence

The current WriterInput repair should now be implemented within a narrower fail-closed release boundary:

- remove lexical sanitization as the safety mechanism;
- never expose arbitrary source `businessImpact` prose as Writer authority;
- deterministically derive bounded `INFERRED` Writer-facing significance from structured governed finding/evidence context;
- preserve source findings unchanged;
- treat any legacy/untyped or downstream-commercial outcome authority as `INFERRED` for this release;
- retain exact evidence references for observed conditions without promoting them to downstream commercial outcomes;
- make no GA4 conversion-authority architecture changes.

## Model routing

- Semantic Builder: GPT-5.6 Terra / High
- Bounded mechanical follow-up after semantics are frozen: GPT-5.6 Luna / Medium
- Independent adversarial verifier: GPT-5.6 Sol / High

Long governed runs are preferred when safe: diagnosis confirmation → implementation → focused adversarial firetests → broader deterministic regressions → exact-head verification → local commit → proof file. Stop early only for a real governance boundary expansion, protected-invariant failure, or unauthorized model/provider/deployment action.

## Authorization state

Chris explicitly approved pausing GA4 conversion outcome authority and moving ahead under this release boundary.

This approval authorizes deterministic implementation of the bounded WriterInput repair only. It does NOT authorize Writer/Judge/provider/model-bearing PRYSM calls, provider recollection, rescore, push, deployment, merge, or production mutation.
