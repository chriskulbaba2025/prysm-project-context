# P0 Deep Content/Page-Selection Trace — Diagnostic Evidence

**GCU protocol:** 2.4.0  
**Change ID:** P0-DEEP-CONTENT-TRACE  
**Candidate/base SHA:** `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`  
**Owner:** Builder

## Protected outcome

Client-facing report conclusions must be grounded in the intended decision-bearing pages, with unavailable or partial deep evidence remaining explicit.

## Observed condition

The P0 acceptance artifact requires `Selected URL | selection reason | page class | body requested | body returned/status | downstream modules`. The current deep-acquisition ledger exposes URL lists and aggregate counts/statuses, but not a durable per-URL selection reason/page class trace or explicit downstream-module mapping.

## Executing boundary

`crawlWithDataforseo()` → `selectImportantPages()` → `mergeDeepPageUrls()` → `contentParsing` request budget → URL-normalized result merge → `DecisionEvidence` hydration → `deriveCapabilities()` and `analyzeProgrammaticSeo()`.

## Evidence

| Evidence ID | Source/artifact | Exact identity/SHA/hash | What it proves |
|---|---|---|---|
| D-01 | `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js` | baseline SHA above; selector at lines 1876–1921, parsing at 1985–2082 | Selection and request boundaries exist; ledger records selected/requested/completed/failed/unassessed URL arrays and aggregate status. |
| D-02 | `services/worker/src/evidence/important-page-selector.js` | baseline SHA above | Selection returns role, URL, score, and matchedBy, but adapter discards this metadata when merging must-have and family representatives. |
| D-03 | `services/worker/src/evidence/capability-evidence.js` and `programmatic-seo-analysis.js` | baseline SHA above | Downstream consumers read content parsing and acquisition, but no consumer-visible per-URL selection/page-class trace is present. |
| D-04 | focused baseline test run | SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`; 964 passed | Existing selection/deep-acquisition behavior is green, so the gap is observability/trace completeness rather than a demonstrated transport failure. |

## Facts versus unresolved questions

### Observed facts

- The adapter requests deep content only for the merged `keyPageUrls` prefix within the configured budget.
- URL identity is normalized when matching provider results back to requested URLs.
- Completed provider requests with no usable body are distinguished downstream from usable content.
- Existing tests cover selection order, budget overflow, URL completion, and deep normalization.

### Unresolved

- The controlled TBK production evidence set is not available locally, so no claim is made about the exact production page mix.
- The required client-facing trace is not yet proven through persistence/reload or report publication; that is part of the bounded repair proof.

## Highest-information diagnostic

Inspect the adapter producer, selector metadata, hydration boundary, and all consumers, then run the existing deep-acquisition fixture at the exact baseline SHA. This was completed above.

## Cause classification

- [x] `VERIFIED_DESIGN_GAP`

Verified design gap: the frozen P0 trace contract is not represented in the adapter's durable acquisition evidence even though the producer already computes most of the required facts.

Direct evidence IDs: D-01, D-02, D-03, D-04.

## Ownership

Correction owner/boundary: application DataForSEO On-Page adapter and its deterministic contract tests; downstream consumers must preserve the additive trace without re-deriving selection.

## Repair-attempt accounting

Same-root evidence-based repair attempts before this checkpoint: `0 / 1 / 2 / 3`

## Gate result

`PASS`
