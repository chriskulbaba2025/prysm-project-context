# P0 Deep Content/Page-Selection Trace — Branch Matrix

**Candidate/base SHA:** `acfc5c1393261bb7733837289bc3adc1062e64d5`

| Branch ID | Production condition/path | Material handoff | Scenario/test | Status before repair |
|---|---|---|---|---|
| P0-B01 | Available crawl; selected URLs; usable parsed body | adapter → hydration → content capability | existing deep normalization + EVIDENCE-01 trace test | MAPPED_AND_PASS |
| P0-B02 | Selected URLs exceed content-parsing budget | acquisition ledger → programmatic analysis | EVIDENCE-01 | MAPPED_AND_PASS |
| P0-B03 | Provider completes but returns empty body | provider result → capability evidence | existing empty content-parsing test | MAPPED_AND_PASS |
| P0-B04 | Parsing disabled or endpoint failure | acquisition status → fail-closed consumer | existing disabled/failure coverage | MAPPED_AND_PASS |
| P0-B05 | No usable footprint/key pages | adapter skip path → limitations/consumer | existing unavailable-footprint coverage | MAPPED_AND_PASS |

Required assembled proof must name these IDs and execute all rows on the final exact candidate.
