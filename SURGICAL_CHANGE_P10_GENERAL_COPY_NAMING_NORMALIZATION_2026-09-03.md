# Surgical Change Contract — P10 General Copy and Naming Normalization

**Protocol version:** 2.4.0  
**Change ID:** `P10_GENERAL_COPY_NAMING_NORMALIZATION`  
**Repository:** `chriskulbaba2025/vantage-platform`  
**Starting SHA:** `13921d7d6c1364a57adc8a27b9f8607ff2e322d4`  
**Change Tier:** `T1_LOCAL`  
**Release Intent:** `CHANGE_ONLY`

## Requirement Preservation

**Original requested outcome:** Remove client-unhelpful internal/system language and normalize report naming.

**Faithful interpretation:** Change only the directly evidenced client-facing labels to title-case, plain-language forms: `What Is Already Working`, `Competitor Benchmarking`, and synchronized page-title/test expectations.

**Exclusions:** No evidence, scoring, persistence, contracts, prompts/models, provider calls, n8n, deployment, or P8 controls.

**Acceptance:** Exact report output and viewer-page contract contain the normalized labels; no governed semantic values change.

## Diagnostic Evidence

Classification: `VERIFIED_DESIGN_GAP`; direct evidence: `DIAGNOSTIC_P10_GENERAL_COPY_NAMING_NORMALIZATION_2026-09-03.md` D10-01 through D10-03; repair attempt `0`.

## Change hypothesis

Updating the deterministic renderer labels and corresponding contract expectations will remove the observed naming inconsistency without changing report meaning. Status: `PROVEN` by direct string-to-renderer trace.

## Causal boundary and expected surface

**Required:** `services/worker/src/report/render-report-v2.js`, `services/worker/src/report/render-approved-report.js`, and the directly affected renderer contract tests.

**Protected/prohibited:** all producer, evidence, score, persistence, model/prompt, provider, n8n, deployment, and unrelated copy surfaces.

## Structural Change Budget

| Dimension | Authorized surface |
|---|---|
| Production modules | two deterministic report renderer modules |
| Public contracts/schemas | none; test expectation only |
| Persistence/dependencies/external/config/model | none |
| Bounded tests | renderer/page-title assertions only |

## Acceptance proof

- Direct proof: normalized strings emitted by both renderer paths.
- Negative proof: existing evidence/status/score assertions remain unchanged; no model/provider calls.
- Assembled proof: applicable Whole-App branch gate and exact-candidate regression.
- Model-bearing gate: `N/A`.

## Gate result

`PASS`
