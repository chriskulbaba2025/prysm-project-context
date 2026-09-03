# P4 Competitor Qualification Repair 2 — Candidate Evidence

Date: 2026-09-02  
Root defect: `P4_COMPETITOR_QUALIFICATION_UNGROUNDED`  
Candidate: `chriskulbaba2025/vantage-platform` `repair/prysm-report-improvement` at `de94a30426c3fd4c81e8fda0753bf12e6cc09535`  
Release intent: `CHANGE_ONLY`; model-bearing gate: `N/A`

## Requirement preservation

Only evidence-supported, materially comparable competitors may be qualified. Search query locale and inferred URL/page class are query/discovery metadata, not observed competitor geography, audience, or commercial-overlap evidence. Insufficient evidence remains explicitly excluded. P8 controls, report prose, prompts/models, provider policy, deployment, and production state are unchanged.

## Bounded correction

- The SERP producer preserves its requested location as `queryGeographicContext`; it no longer writes it into candidate `geographicContext`.
- The common qualification contract now requires observed geography when client geography is present, plus observed audience and commercial context for every source.
- The existing qualified/excluded and approval/gap-consumer representations remain intact.
- P-B16 is a permanent Whole-App gate branch: query-locale/page-type-only SERP candidates fail closed, while a candidate with explicit observed evidence remains compatible with the existing approval-gap consumer.

## Exact-candidate proof

| Proof | Result |
|---|---|
| Focused competitor qualification suite | 24/24 PASS |
| P-B16 assembled SERP qualification gate | PASS |
| DataForSEO SERP adapter suite | 101/101 PASS |
| Worker regression | 975/975 PASS |
| Narrative v2 regression | 114/114 PASS |
| Whole-App Tranche Gate | PASS; P-B01 through P-B16 named and covered; base assembled acceptance 87/87 PASS |
| Live provider/model calls | 0 |

## Causal necessity / determinacy

The original counterexample is permanently represented by P4-DIRECT-04 and P-B16: a service-matching SERP result with only query locale and inferred `service` page type fails geography, audience, and commercial checks. P4-DIRECT-05/P-B16 demonstrate the bounded positive path only when explicit observed evidence is supplied. No unrelated score, renderer, prompt/model, provider request, or approval-control behavior changed.

## Handoff

Application tree is clean and `origin/repair/prysm-report-improvement` equals the candidate SHA. Independent Auditor must challenge the exact candidate, including P-B16 and any alternate producer into the qualification contract.
