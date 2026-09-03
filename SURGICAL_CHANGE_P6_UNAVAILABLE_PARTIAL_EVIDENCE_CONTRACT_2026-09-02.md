# Surgical Change Contract — P6 Unavailable / Partial Evidence Actionability

Date: 2026-09-02  
Application base: `89b1957b98ac5064527bc55cf7eb20caf2889051`  
Classification: `VERIFIED_DESIGN_GAP` (`P6_UNAVAILABLE_ACTIONABILITY_CONTRACT`)  
Change tier: `T2_BOUNDARY`  
Release intent: `CHANGE_ONLY`

## Causal boundary

Add a deterministic, client-safe roadmap projection for already-known unavailable/partial evidence. The projection is presentation metadata only and must not infer why a provider failed, change status, or manufacture a finding.

## Expected change surface

- A small shared roadmap catalog/projection for the governed P6 cases.
- The Deferred & Unavailable Analysis output and applicable Accessibility/Mobile and Performance/field-data output consume the projection.
- Contract/schema and deterministic tests for status preservation and roadmap fields.

## Protected surface

Provider adapters and acquisition; canonical evidence and capability status derivation; scores and assessed weight; Writer prompts/model inputs; n8n; persistence lifecycle; production configuration; consultant controls; live calls.

## Structural budget

Additive metadata/projection and rendering only. No new source of truth for evidence, no new provider boundary, no prompt change, no more than the affected report-contract fields and their direct tests.

## Frozen acceptance / proof plan

1. Direct proof: unavailable accessibility, unavailable CrUX field data, unavailable GA4/backlinks, and partial evidence each render all roadmap fields while retaining exact status semantics.
2. Negative proof: available control does not receive a fabricated roadmap item; unavailable evidence never renders as `FINDING`, `ABSENT`, or `0`.
3. Contract proof: schema validation and report consumer continuity pass for the additive projection.
4. Assembled proof: affected report pages, Narrative v2 parity, worker regression, and Whole-App branch-complete gate.
5. Causal necessity: every changed producer/consumer is traceable to `P6_UNAVAILABLE_ACTIONABILITY_CONTRACT`.

## Reopen conditions

Reopen diagnosis if the implementation requires acquisition/provider changes, changes status/scoring semantics, modifies prompts/model inputs, or requires a new external/live source.
