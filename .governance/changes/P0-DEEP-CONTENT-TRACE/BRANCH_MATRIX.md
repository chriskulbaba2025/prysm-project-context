# P0 Deep Content/Page-Selection Trace — Branch Matrix

**Candidate/base SHA:** `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`

| Branch ID | Production condition/path | Material handoff | Scenario/test | Status before repair |
|---|---|---|---|---|
| P0-B01 | Available crawl; selected URLs; usable parsed body | adapter → hydration → content capability | existing deep normalization + new trace test | MAPPED_AND_PASS for existing behavior; trace UNIMPLEMENTED |
| P0-B02 | Selected URLs exceed content-parsing budget | acquisition ledger → programmatic analysis | EVIDENCE-01 | MAPPED_AND_PASS for existing behavior; trace UNIMPLEMENTED |
| P0-B03 | Provider completes but returns empty body | provider result → capability evidence | existing empty content-parsing test | MAPPED_AND_PASS for existing behavior; trace UNIMPLEMENTED |
| P0-B04 | Parsing disabled or endpoint failure | acquisition status → fail-closed consumer | existing disabled/failure coverage | MAPPED_AND_PASS for existing behavior; trace UNIMPLEMENTED |
| P0-B05 | No usable footprint/key pages | adapter skip path → limitations/consumer | existing unavailable-footprint coverage | MAPPED_AND_PASS for existing behavior; trace UNIMPLEMENTED |

Required assembled proof must name these IDs and execute all rows on the final exact candidate.
