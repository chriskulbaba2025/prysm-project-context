# PDV5 Builder Recovery and Deterministic Replay — 2026-09-01

## Exact recovery

- Application candidate: `22d13a4899c968f403e9ef46e84049995968de4c`
- Audit: `aab3c6f9-0cfd-44fb-a263-5c02f6834d8d`
- Authoritative store: S3 bucket `vantage-reports-prod-814462560475`, prefix under the governed tenant/client/audit key.
- Read-only diagnostic copy: `C:\Users\kulba\Desktop\prysm-pdv5-evidence\aab3c6f9-0cfd-44fb-a263-5c02f6834d8d` (outside application repository).
- Recovered `report-v2/narrative-v2/writer-input.json` and parsed `live-usage/call-01-response.json`.
- `call-01-result.json` records the complete persisted validation errors:
  - `writerOutput.aiSearch.citationReadiness.text` converted PARTIAL evidence into an unqualified absence claim.
  - `writerOutput.limitations[0].whatThisDoesNotMean.text` converted PARTIAL evidence into an unqualified absence claim.

## Proof

The raw recovered response fails the pre-normalization validator on the duplicate PARTIAL reference present in the provider response and the two persisted semantic errors. After the governed `normalizeWriterModelOutput` boundary removes duplicate refs and canonicalizes structural IDs, the exact recovered response validates successfully on the current candidate. This proves the persisted failure is a Writer semantic-shaping mismatch, not an evidence/scoring failure. The candidate's permanent PDV5 regression covers bounded PARTIAL negations without weakening unsupported-claim rejection.

Verification on this exact SHA:

- Narrative v2 tests: 101/101 PASS.
- Whole-App Branch Coverage Gate: PASS; covered `P-B01` through `P-B15`.
- Closure Machine Gate: PASS.
- Application tree remained clean and application branch is synchronized 0/0 with origin.

PDV5 remains open because the required 5/5 primary real Writer generations, 3/3 additional persisted-input generations, 3/3 complete Writer/Judge runs, semantic quality scoring, and independent Auditor PASS have not yet been completed.
