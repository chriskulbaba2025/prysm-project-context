# P4 Diagnostic Evidence — Competitor Qualification

**Change ID:** `P4_COMPETITOR_QUALIFICATION`
**Candidate/base SHA:** `34f47cb35dd7dba39aa488408d1da1242b66dc25`
**Owner:** Builder

## Protected outcome

Only evidence-supported, materially comparable competitors may enter client-facing competitor benchmarking. When service, geographic, audience, or commercial relevance is not established, the candidate must remain excluded or bounded as uncertain; P4 must not implement consultant confirmation controls reserved for P8.

## Observed condition

The current comparator qualification path can promote a supplied competitor as qualified without using the supplied competitor's observed service evidence. The collector assigns every supplied candidate the first client topic and the qualification checks use page type as a proxy for audience and commercial overlap. This creates an evidence-grounding gap even though the existing five-check unit tests pass.

## Executing boundary

`collectCompetitorOpportunities()` in `services/worker/src/evidence/competitor-opportunity-layer.js` builds supplied candidates, then calls `qualifyCandidate(candidate, clientContext)`. The resulting qualified/excluded candidate and qualification results flow into `competitorOpportunities`, evidence normalization, scoring/report-model consumers, and the auditor approval gate.

## Evidence

| Evidence ID | Source/artifact | Exact identity/SHA | What it proves |
|---|---|---|---|
| D4-01 | `competitor-opportunity-layer.js` supplied-candidate construction | `34f47cb35dd7dba39aa488408d1da1242b66dc25` | Supplied candidates receive `topic: topics[0]?.topic` and `geographicContext: input.location`, regardless of their own evidence. |
| D4-02 | `competitor-opportunity-layer.js` `qualifyCandidate()` | `34f47cb35dd7dba39aa488408d1da1242b66dc25` | Service relevance compares candidate topic to client topics; audience relevance is only a reference/community page-type exclusion; commercial relevance is only an allowlist of page types. |
| D4-03 | Read-only Node diagnostic counterexample | `34f47cb35dd7dba39aa488408d1da1242b66dc25` | A supplied candidate whose evidence services are `Accounting` is qualified for a client whose service is `Physiotherapy`; output shows `qualificationPassed: true` and all five checks true. |
| D4-04 | Read-only Node diagnostic counterexamples | `34f47cb35dd7dba39aa488408d1da1242b66dc25` | An explicit unrelated topic and explicit wrong geography are rejected when those fields are present, demonstrating the gap is specifically the supplied-evidence-to-candidate mapping and proxy qualification, not a blanket failure of all checks. |

## Facts versus unresolved questions

### Observed facts

- The supplied competitor evidence contains `services: ["Accounting"]`, but the constructed candidate topic is the client's first topic, `"Physiotherapy"`.
- The candidate therefore passes `service_relevance` without a comparison to the supplied competitor's observed services.
- The collector copies the client's location into `geographicContext`; this is not independently observed competitor geography.
- `audience_relevance` and `commercial_intent_relevance` are derived from page type, not observed audience or commercial evidence.
- Existing tests prove the current five-check contract and approval workflow, but do not falsify promotion when supplied evidence conflicts with the client topic.

### Unresolved

- The minimum evidence fields and confidence states needed to establish audience similarity and commercial overlap across all SERP/supplied candidate shapes require contract design before implementation.
- Whether any downstream consumer requires a new qualification status versus the existing qualified/excluded representation must be mapped in the Surgical Change Contract.

## Highest-information diagnostic

Run the qualification function and collector with controlled candidates: unrelated topic, wrong geography, excluded directory, and supplied evidence whose service conflicts with the client service. Inspect candidate construction and the exact `qualified`/`excluded` output.

## Cause classification

**`VERIFIED_DESIGN_GAP`**

The current P4 qualification contract does not preserve the distinction between client context and competitor-observed evidence for supplied candidates, and it treats audience/commercial relevance as page-type proxies. This is sufficient direct evidence to design a bounded repair, but not yet to edit: the minimum contract and consumer impact must be frozen first.

## Ownership

Application evidence boundary: `services/worker/src/evidence/competitor-opportunity-layer.js`, with any required evidence-contract/consumer updates identified only after contract mapping. P8 consultant controls remain out of scope.

## Repair-attempt accounting

Same-root evidence-based repair attempts before this checkpoint: `0`

## Gate result

`PASS` for diagnostic classification; Surgical Change Contract required before application implementation.
