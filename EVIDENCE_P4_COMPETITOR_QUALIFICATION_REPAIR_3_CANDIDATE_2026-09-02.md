# P4 Competitor Qualification Repair 3 — Candidate Evidence

Date: 2026-09-02  
Root defect: `P4_COMPETITOR_QUALIFICATION_UNGROUNDED`  
Candidate: `chriskulbaba2025/vantage-platform` `repair/prysm-report-improvement` at `28b25f64e3140968842cfdec265b9583e1c995d9`  
Release intent: `CHANGE_ONLY`; model-bearing gate: `N/A`

## Requirement preservation and verified cause

Only competitor-observed service/business evidence may satisfy service relevance. The SERP query topic remains useful discovery metadata but cannot qualify the returned business. Independent audit deterministically proved that an accounting result could qualify for a physiotherapy client because query topic crossed that boundary. Classification remains `VERIFIED_ROOT_CAUSE` at the same root.

## Bounded correction

- The DataForSEO SERP producer retains the returned organic title as `observedServiceContext` with `serviceEvidenceSource: serp-title`, separately from query `topic`.
- Supplied candidates map their observed services/title into the same qualification input with explicit supplied provenance.
- The common qualification gate evaluates service relevance only from the observed field when provenance is present. Query-topic-only and conflicting observed-service candidates fail closed.
- Existing discovery topic, qualified/excluded shape, approval workflow, gap behavior, provider request policy, persistence, rendering, prompts/models, and P8 controls remain unchanged.

## Exact-candidate proof

| Proof | Result |
|---|---|
| Focused qualification + SERP production-path suites | 44/44 PASS |
| P-B16 producer -> qualification -> approved-gap gate | PASS |
| Worker regression | 975/975 PASS |
| Narrative v2 regression | 114/114 PASS |
| Whole-App Tranche Gate | PASS; P-B01 through P-B16 covered |
| Live provider/model calls | 0 |

P-B16 starts with a mocked real DataForSEO response whose returned title is `Accounting & Tax Services` while the query topic is `Physiotherapy`; normalization preserves both identities and qualification fails `service_relevance`. Its positive sibling carries an observed physiotherapy title/provenance and remains compatible with the approved-gap consumer.

## Causal necessity / surgical determinacy

The producer field and common qualification predicate are the smallest boundary that prevents client query metadata from masquerading as competitor evidence. Focused fixture updates declare the previously implicit observed-service precondition. No protected application surface changed. The branch is clean, pushed, and remote-equal at the candidate SHA. Independent Auditor challenge is required.
