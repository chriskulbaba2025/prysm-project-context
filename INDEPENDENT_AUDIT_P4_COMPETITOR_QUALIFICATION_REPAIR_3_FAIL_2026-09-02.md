# Independent Audit — P4 Competitor Qualification Repair 3

Date: 2026-09-02  
Verdict: **FAIL — one MAJOR material finding**

## Exact target

| Field | Verified value |
|---|---|
| Application branch | `repair/prysm-report-improvement` |
| Candidate SHA | `de94a30426c3fd4c81e8fda0753bf12e6cc09535` |
| Remote / local identity | `origin/repair/prysm-report-improvement` and local `HEAD` both resolve to the candidate SHA |
| Application working tree | Clean before and after audit; Auditor made no application writes |
| Governance SHA at audit start | `68e083f9b4e214854fdbb1db2b4cc7ee31d58fb8` |
| Frozen requirement | P4 Diagnostic and Surgical Change Contract require evidence-backed service/business similarity, geography, audience, commercial overlap, and page comparability for every candidate source. Insufficient evidence must remain excluded/bounded. |
| Model-bearing gate | N/A; no model/prompt change and no live provider/model call |

## Finding P4-MAJOR-03 — SERP service similarity is still query-derived, not competitor-observed

The repair correctly distinguishes `queryGeographicContext` from competitor geography and fail-closes missing geography, audience, and commercial context. It does not make the SERP candidate's service/business similarity evidence-backed.

`normalizeSerpItem()` in `services/worker/src/adapters/dataforseo-serp/dataforseo-serp-client.js` continues to assign `topic` from the **client's query topic**. `qualifyCandidate()` in `services/worker/src/evidence/competitor-opportunity-layer.js` accepts that field as `service_relevance`; it does not require competitor-observed services, title/content-derived service evidence with provenance, or another competitor-originated service signal.

Independent deterministic exact-SHA counterexample:

```text
candidate = {
  title: "Accounting & Tax Services",              // incompatible competitor business evidence
  topic: "Physiotherapy",                          // copied from the client SERP query
  discoverySource: "dataforseo-serp",
  queryGeographicContext: "Toronto, Canada",
  geographicContext: "Toronto, Canada",
  audienceContext: "Toronto business owners",
  commercialContext: "Tax accounting appointments offered",
  pageType: "service"
}
client = { location: "Toronto, Canada", services: ["Physiotherapy"], topicKeywords: [] }

result = { passed: true,
  geographic_relevance: true,
  service_relevance: true,
  audience_relevance: true,
  commercial_intent_relevance: true,
  page_type_comparability: true }
```

Thus, a non-physiotherapy business can be qualified and flow into the existing approval/gap path merely because the client queried “Physiotherapy.” This violates the frozen service/business-similarity requirement and preserves the same causal boundary: client/discovery metadata is still treated as competitor evidence.

The P-B16 positive branch does not close this seam. Its `observed` candidate sets `topic: "Physiotherapy"` from the test fixture but provides no observed service/business field or provenance. It consequently proves only geography/audience/commercial field acceptance, not service-evidence continuity. The focused suite, worker regression, and Whole-App gate all pass, but cannot substitute for this direct counterexample.

## Required repair disposition

Same root: `P4_COMPETITOR_QUALIFICATION_UNGROUNDED`.

Freeze a bounded contract that distinguishes SERP query topic from competitor-observed service/business evidence for every source. A SERP candidate without a competitor-originated service signal must fail `service_relevance` into the existing excluded/bounded representation. Add a permanent direct and P-B16 negative branch covering query-topic-only service promotion, and a positive producer-to-qualification-to-approved-gap branch whose service evidence has explicit observed provenance. Re-run exact-SHA focused, adapter, worker, Narrative, and branch-complete Whole-App proof. Do not add P8 controls, make live calls, merge, deploy, or repair production.

## Independent verification record

- Read-only direct counterexample: **FAIL** — false qualification reproduced on the exact candidate.
- Focused qualification suite: **24/24 PASS** — insufficient because it does not falsify query-derived service relevance.
- SERP adapter suite: **20/20 PASS** (the candidate evidence reports 101 adapter tests in the broader worker invocation).
- Worker regression: **975/975 PASS** — retained as regression evidence, not accepted as direct defect proof.
- Narrative v2 and Whole-App gate: **PASS**; P-B01 through P-B16 executed. P-B16 is materially incomplete for the service-evidence branch, so the Whole-App claim is not accepted as P4 PASS proof.
- Live provider/model calls: **0**.

No application code or tests were edited by the Auditor.
