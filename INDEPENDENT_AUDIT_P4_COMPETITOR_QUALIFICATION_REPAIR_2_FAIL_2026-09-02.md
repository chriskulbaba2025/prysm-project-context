# Independent Audit — P4 Competitor Qualification Repair 2

Date: 2026-09-02  
Verdict: **FAIL — one MAJOR material finding**

## Exact target

| Field | Verified value |
|---|---|
| Application branch | `repair/prysm-report-improvement` |
| Candidate SHA | `cc4f0c3a8800f568a8e5949288feeadf494790a5` |
| Remote / local identity | `origin/repair/prysm-report-improvement` and local `HEAD` both resolve to the candidate SHA |
| Application working tree | Clean before audit; Auditor made no application writes |
| Governance SHA at audit start | `b7e76f25255a5cf783482e1bccef58422e960f4d` |
| Frozen requirement | P4 Diagnostic and Surgical Change Contract require evidence-backed service, geography, audience, commercial, and page-comparability qualification; insufficient evidence must remain excluded/bounded. |
| Builder proof challenged | Direct producer/approval-consumer 35/35, worker regression 973/973, Narrative v2 114/114, Whole-App 87/87 P-B01–P-B15; model-bearing gate N/A. |

## What the repair closes

The candidate correctly closes the prior supplied-URL false-pass seam: a supplied candidate with missing geography, audience, or commercial context is excluded, while a complete supplied candidate can enter the existing approval flow.

## Finding P4-MAJOR-02 — SERP candidates still use search locale and page type as competitor qualification evidence

`normalizeSerpItem()` in `services/worker/src/adapters/dataforseo-serp/dataforseo-serp-client.js` assigns every organic result the **requested client search location** as `geographicContext`. It records no observed competitor geography, audience, or commercial context. In `qualifyCandidate()` (`services/worker/src/evidence/competitor-opportunity-layer.js`), only `user-supplied` candidates use the new fail-closed checks. A `dataforseo-serp` candidate still passes geography from that requested location and passes both audience and commercial relevance solely from an inferred URL/page type.

Independent deterministic exact-SHA proof:

```text
candidate = {
  discoverySource: "dataforseo-serp",
  topic: "Physiotherapy",
  geographicContext: "Toronto, Canada",  // supplied by query locale, not competitor observation
  pageType: "service"                    // inferred from URL, no audience/commercial observation
}
client = { location: "Toronto, Canada", services: ["Physiotherapy"], topicKeywords: [] }

result = { passed: true,
  geographic_relevance: true,
  service_relevance: true,
  audience_relevance: true,
  commercial_intent_relevance: true,
  page_type_comparability: true }
```

The candidate can therefore become a qualified, approvable competitor and later a client-facing gap despite no observed competitor geography, audience, or actual commercial-overlap evidence. This violates the P4 frozen requirement and Surgical Change Contract, which applies evidence-backed results to **each candidate**, including the explicitly required supplied and SERP mappings. The successful 87/87 Whole-App evidence does not traverse this negative qualification branch, so it cannot substitute for direct proof.

## Required repair disposition

Same root: `P4_COMPETITOR_QUALIFICATION_UNGROUNDED`.

Keep SERP query locale distinct from competitor-observed geography. For every candidate source, either preserve sufficient observed evidence for the four qualification factors or fail closed into the existing excluded/bounded representation with explicit failed checks. Add direct deterministic negative proof for a service-matching SERP result with only query-locale/page-type data, positive proof only where the evidence contract genuinely supports qualification, then rerun exact-SHA direct, regression, Narrative, and branch-complete Whole-App evidence. Do not add P8 controls, make live calls, or repair production from the audit.

## Independent verification record

- Read-only exact-SHA direct counterexample: **FAIL** (false qualification reproduced).
- Current full deterministic worker suite: **973/973 PASS**. This is retained as scope/regression evidence but is insufficient because it does not falsify P4-MAJOR-02.
- Model-bearing gate: **N/A**; no model/prompt changes or live calls.
- Whole-App gate claim: **not accepted as P4 PASS proof**, because its branch matrix does not map the required SERP no-observed-evidence qualification negative branch.

No application code or tests were edited by the Auditor.
