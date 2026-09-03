# Independent Audit — P4 Competitor Qualification Repair 3

Date: 2026-09-02  
Verdict: **PASS — zero material findings**

## Exact target

| Field | Verified value |
|---|---|
| Application branch | `repair/prysm-report-improvement` |
| Candidate SHA | `28b25f64e3140968842cfdec265b9583e1c995d9` |
| Remote / local identity | `origin/repair/prysm-report-improvement` and local `HEAD` both resolve to the candidate SHA |
| Application working tree | Clean before and after audit; Auditor made no application writes |
| Governance SHA at audit start | `7b903e5f9521639a480dc0d8c15e8ffeecb38c41` |
| Frozen requirement | P4 requires evidence-backed service/business similarity, geography, audience, commercial overlap, and page comparability for every candidate source; insufficient evidence remains excluded/bounded. |
| Diagnostic classification | `VERIFIED_ROOT_CAUSE` within `P4_COMPETITOR_QUALIFICATION_UNGROUNDED` |
| Surgical contract | `SURGICAL_CHANGE_P4_COMPETITOR_QUALIFICATION_CONTRACT_2026-09-02.md`, including same-root repair 3 addendum |
| Model-bearing gate | N/A; no prompt/model change and no live provider/model call |

## Independent challenge result

The candidate closes `P4-MAJOR-03`. The DataForSEO producer preserves the client query topic only as discovery metadata and separately retains the returned organic title as `observedServiceContext` with `serviceEvidenceSource: serp-title`. The common qualification predicate no longer reads `candidate.topic` for service relevance. Supplied candidates derive the same qualified field from supplied services/title with explicit provenance.

The direct P-B16 counterexample begins at the mocked production SERP response: query topic `Physiotherapy`, returned title `Accounting & Tax Services`. Normalization preserves both identities and qualification fails `service_relevance`; query locale and inferred page type cannot override the failure. The positive sibling begins with a returned physiotherapy title, carries observed service provenance plus explicit geography/audience/commercial observations, qualifies, and remains compatible with the existing approved-gap consumer. Missing observed evidence continues to fail closed into the existing excluded representation. No P8 control or protected surface was added.

No CRITICAL or MAJOR finding remains open.

## Independent exact-candidate verification

- Focused producer/qualification suites: **44/44 PASS**.
- Direct P-B16 assembled producer → qualification → approved-gap gate: **PASS**.
- Worker regression: **975/975 PASS**.
- Narrative v2 regression: **114/114 PASS**.
- Whole-App Tranche Gate: **PASS**, base acceptance **87/87**, P-B01 through P-B16 covered.
- Candidate identity after verification: local and remote remain `28b25f64e3140968842cfdec265b9583e1c995d9`; application tree remains clean.
- Live provider/model calls: **0**.

## Disposition

P4 passes and its repair accounting resets. The next required workstream is **P5 — Structured Data / Entity Evidence Verification**, beginning diagnostic-first. Merge, deployment, production mutation, fresh production audit, and paid/live calls remain protected.
