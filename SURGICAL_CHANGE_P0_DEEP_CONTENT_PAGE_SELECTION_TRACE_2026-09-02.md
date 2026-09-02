# Surgical Change Contract — P0 deep-content/page-selection trace

**Protocol version:** 2.4.0  
**Change ID:** `P0_DEEP_CONTENT_PAGE_SELECTION_TRACE`  
**Repository/workspace:** `chriskulbaba2025/vantage-platform`  
**Starting SHA:** `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`  
**Candidate SHA:** `acfc5c1393261bb7733837289bc3adc1062e64d5`  
**Change Tier:** `T2_BOUNDARY`  
**Release Intent:** `CHANGE_ONLY`

## Requirement Preservation

Preserve complete page identity from deterministic selection to deep-body result and direct content-analysis consumers, without asserting a historical selection defect that the frozen artifact cannot prove. Non-goals: report copy, prompts, Writer/Judge behavior, n8n, selection scoring, provider invocation policy, production deployment, or backfilling immutable historical evidence.

Observable acceptance: every URL in the governed deep-selection set has a stable trace row with selection reason, page class, request flag, returned/unavailable status, and direct downstream modules; a failed, empty, or budget-unassessed URL remains distinct from a returned body.

## Diagnostic Evidence

Classification: `VERIFIED_DESIGN_GAP`. Direct evidence: `DIAGNOSTIC_P0_DEEP_CONTENT_PAGE_SELECTION_TRACE_2026-09-02.md` P0-D01 through P0-D04. Same-root repair attempt count: `1`.

## Change hypothesis

Adding a trace alongside the existing content-parsing acquisition ledger, populated after the URL-keyed provider response is classified, makes page-selection/deep-content provenance inspectable without changing selection or evidence semantics. Status: `PROVEN` by direct deterministic and assembled-system proof.

## Causal boundary

`selectImportantPages` + merged governed selection -> bounded `cpUrls` request -> URL-keyed response classification -> `acquisition.contentParsing.trace` -> direct content-body/programmatic-SEO consumers.

## Expected change surface

### Required

- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-representative-evidence.test.js`

### Prohibited / protected

- Selection ranking/role rules; canonical historical evidence; schemas/persistence; scoring and report rendering; prompts/models; n8n; provider credentials/calls; deployment.

## Branch impact and budget

Relevant matrix branches are P-B01 (viable collection/lifecycle) and P-B02 (partial/unknown evidence preservation). No new report-production branch is created: the new field is an adapter acquisition ledger for auditability, and existing consumers remain unchanged.

| Dimension | Authorized surface |
|---|---|
| Production modules | One adapter |
| Public contracts/schemas | Additive internal acquisition-ledger field only |
| Persistence/dependencies/config/model/prompt/migrations | None |
| Tests | One representative adapter regression; selector and aggregate analysis proof |

## Acceptance proof

- Direct: trace rows distinguish `RETURNED`, `EMPTY_RETURNED`, `FAILED`, and `UNASSESSED` and preserve selection metadata.
- Positive: governed must-have commercial pages receive trace rows and returned-body statuses.
- Negative: budget overflow remains `UNASSESSED`; failed retrieval remains false/failed, never substituted.
- Branch-complete/full candidate: `npm run verify:prysm-whole-app` PASS, 87/87, P-B01–P-B15 at `acfc5c1`.
- Model-bearing gate: N/A; no prompt/model input or semantic orchestration changed.

## Causal Necessity and Surgical Determinacy

| Requirement ID | Changed boundary | Why required | Evidence | Result |
|---|---|---|---|---|
| P0-R01 | Adapter trace ledger | Without it, an audit cannot establish selection-to-body provenance | P0-D01 | PASS |
| P0-R02 | Adapter regression | Without it, trace meanings could regress or conflate statuses | P0-D03 | PASS |

Requirement preserved, diagnosis supported, hypothesis validated, protected surface preserved, and budget respected: `PASS`. Unauthorized scope expansion, unjustified architectural/contract/dependency change: `0`.

## Reopen conditions

Reopen if a future consumer needs the trace persisted across a new boundary, if a selection/ranking change is proposed, or if a live controlled audit produces trace evidence that contradicts current selection semantics.

## Gate result

`PASS`
