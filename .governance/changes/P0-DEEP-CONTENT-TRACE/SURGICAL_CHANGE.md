# P0 Deep Content/Page-Selection Trace — Surgical Change Contract

**Protocol version:** 2.4.0  
**Change ID:** P0-DEEP-CONTENT-TRACE  
**Repository:** `chriskulbaba2025/vantage-platform`  
**Starting SHA:** `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`  
**Change Tier:** `T2_BOUNDARY`  
**Release Intent:** `CHANGE_ONLY`

## Requirement Preservation

**Original requested outcome:** Trace deep-content/page selection so report improvement work can distinguish intended page evidence from weak or partial samples.

**Faithful interpretation:** Additive, deterministic, per-URL trace evidence at the adapter boundary covering selected URL, reason/class, request state, body return/status, and downstream modules.

**Exclusions:** No prompt tuning, no scoring-policy rewrite, no n8n change, no provider/live call, no production deployment, no merge to `main`, and no mutation of canonical raw evidence.

**Acceptance:** Exact candidate emits a durable trace for every selected URL, preserves unavailable/partial status, and proves producer → hydration → capability/programmatic consumers with positive and negative fixtures.

## Diagnostic Evidence

**Classification:** `VERIFIED_DESIGN_GAP`  
**Direct evidence:** `DIAGNOSTIC.md` D-01 through D-04  
**Same-root repair attempt count:** `0`

## Change hypothesis

If the adapter carries selector metadata and request/result status into an additive acquisition trace, downstream consumers can inspect the exact page-selection/deep-content boundary without guessing or re-deriving it. **Status:** `PROVEN` as a bounded design hypothesis; implementation proof remains required.

## Causal boundary

DataForSEO adapter selection/merge/request ledger → DecisionEvidence hydration → capability and programmatic SEO consumers.

## Expected change surface

### REQUIRED

- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`
- `services/worker/src/evidence/decision-evidence.js` only if additive trace hydration is otherwise dropped
- focused adapter/contract tests

### EXPECTED

- `selectImportantPages()` metadata preservation and deterministic page-class/reason mapping
- additive `acquisition.contentParsing.trace` (or equivalent named field)

### PROHIBITED / protected

- scoring formulas, Writer/Judge prompts, report copy, n8n, schemas requiring breaking changes, persistence lifecycle, provider configuration, live credentials, production branches outside P0.

## Material production branch impact

Branch Coverage Matrix applicable: `YES`.

- `P0-B01` normal available crawl with selected pages and usable body
- `P0-B02` budget overflow/unassessed selected pages
- `P0-B03` provider success with empty body / partial deep evidence
- `P0-B04` content parsing disabled or failed
- `P0-B05` unavailable footprint / no selected pages

## Structural Change Budget

| Dimension | Authorized surface |
|---|---|
| Production modules | 1 adapter; hydration only if required |
| Public contracts/schemas | additive evidence field only |
| Persistence boundaries | none; existing artifact envelope only |
| Dependencies | none |
| External integrations | none beyond existing fixture seam |
| Configuration/model/prompt | none |
| Abstractions | no new abstraction unless required for deterministic trace |
| Migrations | none |
| Bounded test/verification | adapter + evidence contract tests |

## Acceptance proof

- Direct: exact trace rows for selected, requested, completed, failed, and unassessed URLs.
- Positive: usable parsed body maps to the same normalized selected URL.
- Negative: empty/failed/disabled parsing remains unavailable/partial and never becomes a negative finding or fabricated body.
- Branch-complete: execute P0-B01 through P0-B05 with branch IDs.
- Handoff: adapter output survives DecisionEvidence hydration and is consumable by capability/programmatic analysis.
- Terminal: exact SHA, clean tree, focused suite, full applicable worker regression; no model-bearing or protected release gate.

## Scope expansion / reopen conditions

Reopen before editing if trace requires a breaking schema, persistence migration, a new consumer contract, prompt/model change, or any branch not listed above.

## Gate result

`PASS — application edit authorized within this contract`
