# Independent Audit — P4 Competitor Qualification

Date: 2026-09-02  
Verdict: **FAIL — one MAJOR material finding**

## Exact candidate

- Application: `repair/prysm-report-improvement`
- SHA: `ce94e9ad833e72b8bfd10cf7ae1fe7f27d45b440`
- Remote branch: same SHA
- Working tree: clean
- Governance state at audit: P4 candidate awaiting audit
- Whole-App gate: **87/87 PASS**, P-B01 through P-B15; this is exact-candidate evidence but does not cover the defect below.
- Model-Bearing Release Gate: N/A; no live provider/model calls.

## Finding P4-MAJOR-01 — unsupported supplied candidate still false-PASSES qualification

The frozen P4 acceptance requires missing or non-comparable audience/commercial evidence to fail closed or remain bounded as uncertain. The candidate's supplied-candidate mapping sets `pageType: "landing"` for every available supplied URL. `qualifyCandidate()` then derives `audience_relevance` and `commercial_intent_relevance` from page type rather than observed competitor evidence; missing geography also defaults to true.

Independent deterministic counterexample at the exact SHA:

```text
client: services=["Physiotherapy"], location="Toronto, Canada"
supplied: https://accounting.example,
          evidence={services:["Physiotherapy"], pageCount:4}
observed: qualified candidate; service=true, geography=true,
          audience=true, commercial=true, page comparability=true
```

No competitor geography, audience, or commercial signal is supplied. Nevertheless the candidate enters the qualified path and is eligible for the existing approval workflow. This is a false-PASS seam against the Surgical Change Contract's explicit negative acceptance and the diagnostic evidence's unresolved audience/commercial limitation.

The existing `P4-DIRECT-01` only proves conflicting service evidence is excluded. Existing focused tests and the 87/87 Whole-App gate do not falsify promotion of a service-matching but otherwise unsupported supplied candidate.

## Disposition

Same root defect: `P4_COMPETITOR_QUALIFICATION_UNGROUNDED`. Repairable under the current authorized P4 contract. Builder must preserve observed evidence, add deterministic fail-closed/bounded uncertainty behavior for missing geography/audience/commercial evidence, prove valid supplied and SERP candidates retain approval/consumer contracts, and rerun exact-candidate direct and assembled proof. No application repair was performed by the Auditor.

Repair attempt echoed from controller: `0`.
