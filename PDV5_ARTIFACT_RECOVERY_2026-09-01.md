# PDV5 Artifact Recovery — 2026-09-01

Read-only recovery from the authoritative production S3 store succeeded for audit `aab3c6f9-0cfd-44fb-a263-5c02f6834d8d` (TBK Creative). No production object was mutated.

Store prefix:
`vantage/reports/tenants/omnipressence/clients/www.tbkcreative.com-tbkcreative/audits/aab3c6f9-0cfd-44fb-a263-5c02f6834d8d/report-v2/narrative-v2/`

Recovered diagnostic copies are outside the application repository at `C:\Users\kulba\Desktop\prysm-pdv5-evidence-aab3c6f9`.

| Artifact | SHA-256 |
|---|---|
| writer-input.json | `8cf32209bff79b526be33f71c59a7a19345fed8befdab4a68c2a512cc0a295ef` |
| live-usage/call-01-response.json | `9ab8d8cd764b9e1cf8d3060a92c236355470614ca1a993ec582fadae70b794c3` |
| live-usage/call-01-result.json | `e1c2a1fa6d107ad2adb9209c44f854e2315e07d9f88db7f86f469930ac3465ea` |

The persisted result records model `gpt-5.6-terra`, prompt `2.1.0`, pass 1, and validation failure for two PARTIAL-evidence unqualified-absence claims in `aiSearch.citationReadiness.text` and `limitations[0].whatThisDoesNotMean.text`. The exact parsed response is therefore available for Plane 2 replay. Deterministic repair candidate `db337201bd60c6fb7154684888e3407a721e901c` passes the 103-test Narrative v2 family and the composite closure/Whole-App gate. Required real stress and complete Writer/Judge runs remain pending.
