# Surgical Change Contract — P5 Structured Data / Entity Evidence

Date: 2026-09-02  
Change tier: **Tier 2 — evidence/contract producer correction**  
Release intent: **CHANGE_ONLY**  
Root defect: `P5_SCHEMA_TYPE_ALIAS_LEAK`

## Problem and observable acceptance

The DataForSEO OnPage adapter admits provider category tokens such as `json_ld` into the canonical `schemaTypes` and microdata type collections. Site aggregation and report/scoring consumers interpret a non-empty collection as actual schema.org/entity evidence. A provider category alias must not be presented as a schema type; genuine schema.org types must remain available and unchanged.

## Bounded change

Correct the deterministic OnPage normalization boundary so schema and microdata type extraction accepts actual type values while filtering known provider category aliases, including `json_ld`. Preserve existing source-status, page coverage, and evidence-humility behavior. Do not add a typed location/entity field: the current acquisition path does not provide sufficient typed, provenance-bearing location/entity observations. Existing market input remains assessment context only.

## Explicit exclusions

No report-copy rewrite, scoring redesign, prompt/model change, live provider call, n8n change, production mutation, rendered/browser acquisition, or P8 consultant-control feature. No historical missed-location claim may be introduced.

## Affected surface and acceptance tests

Producer/normalizer: `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`.

Test areas:

1. Direct extraction: `json_ld` and other governed provider category aliases are excluded from both structured-data and microdata type collections.
2. Direct extraction: `Organization`, `LocalBusiness`, `Service`, and equivalent actual schema.org values are preserved, deduplicated, and sorted.
3. Adapter contract: a fixture containing only `json_ld` yields no actual schema types while retaining page/content/source-status behavior.
4. Regression: focused adapter tests, worker regression, Narrative v2, and exact-candidate Whole-App Branch Coverage Gate.

## Proof and determinacy

The direct defect is proven by a fixture with provider token `json_ld`; removing the filter must reproduce the false schema evidence and restoring it must remove the alias while preserving genuine types. Surgical determinacy requires no changes outside the producer normalization boundary and its deterministic tests. Location/entity evidence remains explicitly unavailable rather than inferred.

## Protected boundary

Deterministic local fixture proof is sufficient. No paid/live provider or model execution is authorized or required. Merge to `main`, deployment, production configuration changes, and a fresh production audit remain protected.
