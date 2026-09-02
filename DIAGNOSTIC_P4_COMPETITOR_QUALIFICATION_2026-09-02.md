# P4 Diagnostic Evidence — Competitor Qualification

Date: 2026-09-02
Application candidate: `repair/prysm-report-improvement` @ `34f47cb35dd7dba39aa488408d1da1242b66dc25`
Classification: **VERIFIED_DESIGN_GAP**

## Requirement preserved

Improve comparator quality before benchmark interpretation. A candidate must be supported as a plausible competitor by service/business similarity, geographic relevance, customer/audience similarity, and actual commercial overlap. When confidence is insufficient, retain a bounded comparator/confirmation state rather than silently asserting competitor status. P8 consultant confirm/reject controls remain out of scope.

## Executing boundary traced

`collectCompetitorOpportunities()` in `services/worker/src/evidence/competitor-opportunity-layer.js` receives SERP and supplied candidates, maps supplied candidates, calls `qualifyCandidate()`, persists the resulting opportunity envelope through the existing audit/scoring/storage path, and is consumed by competitor benchmark rendering and review/approval logic.

The five-check gate currently evaluates:

- geography from `candidate.geographicContext`, but supplied candidates are assigned `input.location`;
- service relevance from `candidate.topic`, but supplied candidates are assigned the first client topic;
- audience relevance from page type, not audience evidence;
- commercial relevance from a broad page-type allowlist;
- comparability from page type and excluded-type categories.

Therefore supplied-candidate metadata can make the candidate pass without evidence that the supplied site serves the same business, audience, market, or commercial offer.

## Direct diagnostic proof

Using the current production module with a supplied-style candidate:

```js
{
  candidateUrl: "https://yellowpages.example/biz/x",
  domain: "yellowpages.example",
  topic: "Consulting",
  pageType: "landing",
  geographicContext: "Toronto",
  evidence: { services: [] }
}
```

against client context `{ location: "Toronto", services: ["Consulting"] }` returns `passed: true` for all five checks. The candidate is a directory-like non-competitor but is silently promoted to `candidates.qualified` when supplied evidence has `AVAILABLE` status. This is a deterministic false qualification seam, not a claim about any historical production candidate.

## Existing verification

From `services/worker`:

- focused existing T9 competitor qualification/review coverage: **970/970 PASS** in the invoked worker suite;
- no live provider or model calls occurred;
- the passing tests verify excluded page types, happy-path qualification, approval filtering, source failures, determinism, and review integrity, but do not require service/audience/commercial evidence for supplied candidates.

## Finding

**VERIFIED_DESIGN_GAP:** supplied competitor candidates inherit client context and a generic landing-page classification, allowing unrelated or directory-like URLs to pass the qualification gate. The current approval workflow prevents pending candidates from generating client-facing gaps, but approval is not a substitute for upstream qualification evidence and P4 requires known non-competitors not to be silently promoted under the verified qualification contract.

## Required acceptance artifact

| Candidate URL | discovery/source | service/business evidence | geographic evidence | audience evidence | commercial-overlap evidence | qualification state | downstream modules |
|---|---|---|---|---|---|---|---|
| supplied or SERP candidate | user-supplied / DataForSEO SERP | explicit observed services/topic or `UNKNOWN` | explicit observed market or `UNKNOWN` | explicit page/business evidence or `UNKNOWN` | commercial page/offer evidence or `UNKNOWN` | `QUALIFIED`, `COMPARATOR_CONFIRMATION_REQUIRED`, or `EXCLUDED` with reasons | competitor opportunity envelope → persistence/reload → approval gate → benchmark renderer/Narrative references |

## Scope boundary

No application files were edited during diagnosis. No consultant confirm/reject UI or P8 override controls are authorized. No prompt/model, n8n, provider policy, deployment, or production artifact changes are justified by this diagnostic.
