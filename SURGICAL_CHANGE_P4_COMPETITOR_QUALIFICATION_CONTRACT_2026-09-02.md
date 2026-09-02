# Surgical Change Contract — P4 Competitor Qualification

Date: 2026-09-02  
Change tier: **Tier 2 — evidence/contract producer change**  
Release intent: **CHANGE_ONLY**  
Root defect: `P4_COMPETITOR_QUALIFICATION_UNGROUNDED`

## Problem and observable acceptance

The competitor opportunity producer can mark a candidate qualified from page-type and text proxies while lacking evidence of service/business similarity, geographic relevance, audience similarity, and commercial overlap. Supplied URLs are assigned the first client topic and `landing` page class. A known non-competitor must not enter the qualified competitor path merely because its crawl is available.

## Bounded change

Update the competitor opportunity producer and its deterministic contracts/tests so each candidate carries explicit evidence-backed results for the four P4 factors plus page comparability. Candidates with insufficient or failed evidence remain in a bounded comparator/confirmation state and cannot produce qualified competitor gaps. Preserve source-status semantics, existing approved-review integrity, report rendering compatibility, and all P0–P3 behavior.

## Explicit exclusions

No benchmark prose rewrite, prompt/model change, live provider/model call, n8n change, production mutation, or P8 consultant confirm/reject product control. Existing approval workflow remains the later human decision boundary; this contract does not silently auto-approve candidates.

## Affected surface and acceptance tests

Producer: `services/worker/src/evidence/competitor-opportunity-layer.js`  
Contracts/consumers: decision evidence normalization, report model/rendering, review gate as required by parity proof.

Test areas:

1. Direct qualification proof: service mismatch, geographic mismatch, audience mismatch, non-commercial/unsupported page, and complete evidence-backed overlap.
2. Supplied and SERP candidate mapping: observed evidence is used; missing evidence yields bounded confirmation state.
3. Consumer proof: only qualified/approved candidates can produce client-facing competitor gaps; bounded comparators are not rendered as asserted competitors.
4. Regression: focused worker tests, full worker regression, Narrative v2, and Whole-App Branch Coverage Gate.

## Proof and determinacy

The direct defect must be proven once with deterministic fixtures before broad verification. Causal necessity: removing the qualification boundary must reproduce the known non-competitor promotion; restoring it must prevent it. Surgical determinacy: no unrelated scoring, prose, provider policy, or model-bearing path changes.

## Protected boundary

Deterministic fixture proof is sufficient for this change-only candidate. No paid/live provider or model execution is authorized or required. Merge to `main`, deployment, and fresh production audit remain protected.

## Same-root repair addendum — 2026-09-02

The first candidate grounded supplied service and geographic fields but left audience/commercial relevance inferred from its default `landing` page type. Independent audit `P4-MAJOR-01` proved that a service-matching supplied URL with no observed geography, audience, or commercial evidence could still qualify. This is the same root defect, not a new workstream.

The bounded repair requires observed supplied-candidate geography when client geography is stated, and observed supplied audience/commercial context. It retains the existing qualified/excluded shape; uncertainty is represented by exclusion with explicit failed checks, not by P8 controls. A fixture-only consumer update is necessary to preserve the approval-contract tests for candidates that are explicitly complete. Exact candidate proof is `cc4f0c3a8800f568a8e5949288feeadf494790a5`.
