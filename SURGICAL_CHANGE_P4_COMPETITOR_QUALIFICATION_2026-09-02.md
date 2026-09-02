# Surgical Change Contract — P4 Competitor Qualification

**Change ID:** `P4_COMPETITOR_QUALIFICATION`
**Repository/workspace:** `chriskulbaba2025/vantage-platform`
**Starting SHA:** `34f47cb35dd7dba39aa488408d1da1242b66dc25`
**Change Tier:** `T2_BOUNDARY`
**Release Intent:** `CHANGE_ONLY`

## 1. Requirement Preservation

**Original requested outcome**

Competitor benchmarking must qualify candidates using service/business similarity, geographic relevance, customer/audience similarity, and actual commercial overlap. Insufficiently supported candidates must not be silently promoted. P8 consultant confirm/reject controls are excluded.

**Faithful governed interpretation**

Preserve candidate uncertainty and use competitor-observed evidence where available. A candidate may be qualified only when the evidence-backed checks pass; otherwise retain it as excluded/bounded evidence with explicit failed checks.

**Explicit exclusions / non-goals**

No consultant controls, no live provider calls, no prompt/model changes, no scoring-semantic redesign, no n8n changes, no production deployment, and no merge to `main`.

**Observable acceptance condition**

Conflicting supplied competitor evidence cannot qualify as a client competitor; missing or non-comparable audience/commercial evidence fails closed; valid service/geography/commercial candidates preserve the existing approval workflow and downstream evidence contract.

## 2. Diagnostic Evidence

**Classification:** `VERIFIED_DESIGN_GAP`

**Executing boundary / production path**

Audit input → `collectCompetitorOpportunities()` → candidate qualification → `competitorOpportunities` evidence envelope → normalization/ScoreSet/ViewModel/report consumers → auditor approval gate.

**Direct supporting evidence**

`DIAGNOSTIC_P4_COMPETITOR_QUALIFICATION_2026-09-02.md`, D4-01 through D4-04, at starting SHA.

**Same-root repair attempt count:** `0`

## 3. Change hypothesis

**Hypothesis**

If supplied candidate construction preserves observed competitor service/geographic/audience/commercial signals and qualification requires evidence-backed matches instead of client-context/page-type proxies, conflicting or unsupported candidates will remain excluded while valid candidates retain the current qualified/pending/approved lifecycle.

**Predicted effect**

The Accounting-for-Physiotherapy counterexample is excluded, and missing competitor evidence cannot become a qualified competitor merely because its page type is `landing`.

**Status:** `PROVEN` as a repair hypothesis; implementation and proof pending.

## 4. Causal boundary

The competitor evidence producer and its qualification contract in `services/worker/src/evidence/competitor-opportunity-layer.js`, plus only the focused deterministic tests needed to prove the corrected boundary. Existing persistence and consumers remain unchanged unless contract mapping proves a necessary additive field.

## 5. Expected change surface

### REQUIRED

- `services/worker/src/evidence/competitor-opportunity-layer.js`
- focused `competitor-opportunity-layer` tests for conflicting supplied evidence, missing signals, valid candidates, and uncertainty preservation

### EXPECTED

- `qualifyCandidate()`
- supplied candidate construction in `collectCompetitorOpportunities()`
- qualification result fields only if required to expose bounded uncertainty deterministically

### PROHIBITED / protected

- P8 consultant review/override controls
- report rendering, prompts, Writer/Judge/model inputs, n8n, scoring semantics, persistence schema, authentication, deployment, and production artifacts

## 6. Material production branch impact

Branch Coverage Matrix applicable: `YES`

Known branches: SERP candidates; supplied available candidate; supplied blocked/unavailable candidate; excluded page types; valid qualified candidate; failed qualification; pending/rejected/approved downstream approval states; no-provider/no-candidate unavailable path.

Inventory method: reconcile the existing P4 whole-app branch matrix and focused production-path tests before terminal proof; any newly discovered material producer/consumer branch reopens this contract.

## 7. Structural Change Budget

| Dimension | Authorized surface |
|---|---|
| Production modules | 1 existing evidence producer module |
| Public contracts/schemas | additive qualification evidence only if necessary; no breaking change |
| Persistence boundaries | 0 |
| Dependencies | 0 |
| External integrations | 0; controlled fixtures only |
| Configuration/model/prompt surfaces | 0 |
| Abstractions | 0 new |
| Migrations | 0 |
| Bounded test/verification surfaces | focused producer tests plus existing affected suites |

## 8. Acceptance proof

**Direct root-defect/design-gap proof:** conflicting supplied observed service is excluded; supplied candidate does not inherit client geography as competitor evidence; missing audience/commercial signals fail closed.

**Positive real-path proof:** valid supplied and controlled SERP candidates preserve qualified candidate shape, approval status, gap behavior, and canonical evidence status.

**Negative/fail-closed proof:** unrelated service, wrong geography, directory/social/reference/support, and missing audience/commercial evidence cannot qualify or produce client-facing gaps.

**Branch-complete assembled-system proof:** existing Whole-App gate plus affected P4 production-path branches and no-provider/supplied/failure paths.

**Contract-at-every-handoff proof:** producer qualification results → evidence normalization → approval gate/model parity → report consumer; no re-derivation.

**Full exact-candidate terminal verification:** worker regression, Narrative v2, Whole-App 87/87 branch gate, clean exact-head proof.

**Model-Bearing Release Gate when applicable:** `N/A` unless implementation changes prompts/model inputs; if that boundary becomes necessary, reopen scope and stop at the protected paid/live gate.

## 9. Scope-expansion / reopen conditions

Reopen before modifying any persistence, report, model, review-control, or consumer boundary; if competitor evidence cannot support a deterministic fail-closed contract; if an affected branch is omitted; or if a new public field is required beyond an additive evidence field.

## 10. Causal Necessity Audit

To be completed after implementation and direct proof; every changed boundary must trace to the P4 acceptance condition.

## 11. Surgical Determinacy Audit

To be completed after exact-candidate proof and independent audit.

## 12. Gate result

`PASS` — application implementation authorized within this bounded contract.
