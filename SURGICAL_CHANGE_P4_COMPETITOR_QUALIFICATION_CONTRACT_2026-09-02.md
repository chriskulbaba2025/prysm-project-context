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

## Same-root repair 2 addendum — 2026-09-02 (frozen before implementation)

### Verified cause and hypothesis

`P4-MAJOR-02` proves the same design gap remains on the alternate `dataforseo-serp` producer: `normalizeSerpItem()` writes the requested query locale into `geographicContext`, while `qualifyCandidate()` accepts that value plus inferred page type as geography, audience, and commercial qualification. The hypothesis is **PROVEN** by the Auditor's deterministic counterexample at `cc4f0c3a8800f568a8e5949288feeadf494790a5`.

### Required bounded correction

1. Preserve SERP query locale as query evidence only (`queryGeographicContext`), not competitor-observed geography.
2. Require observed competitor geography whenever client geography is stated, and observed audience and commercial context, for **every** candidate source.
3. Keep the existing `qualified` / `excluded` representation and explicit failed-check reporting. A candidate with only query locale and inferred page type must be excluded; a candidate that genuinely supplies all observed fields may qualify through the existing approval path.
4. Add permanent deterministic P-B16 coverage to the Whole-App gate for the negative SERP producer-to-qualification path and a supported positive qualification path.

### Change boundary

Required application surfaces: `dataforseo-serp-client.js` (producer provenance), `competitor-opportunity-layer.js` (qualification contract), focused tests, and the deterministic Whole-App gate plus a P-B16 assembled proof script. Expected governance surfaces: this contract, branch matrix, candidate evidence, and current state. Protected: report prose/rendering, approval-control behavior, scoring, prompts/models, provider request policy, n8n, deployment, and P8 product controls.

### Acceptance / branch proof

- Direct negative: service-matching SERP candidate carrying only query locale/page type is excluded with geography, audience, and commercial checks failed.
- Direct positive: SERP-shaped candidate with explicitly observed geography, audience, and commercial context can proceed only through existing approval behavior.
- P-B16: deterministic producer -> qualification -> approved-gap consumer proof is executed and named by the Whole-App gate on the exact candidate.
- Re-run focused direct tests, worker regression, Narrative v2, and exact-candidate Whole-App coverage.

Change tier remains **T2_BOUNDARY** and release intent remains **CHANGE_ONLY**. No external call or model-bearing proof is required.
