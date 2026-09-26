# PRYSM Audit Data Completeness — New Era Plumbing

Audit ID: `834c5b80-8eda-4609-8512-041ae7a83d90`
Created: 2026-09-26
Master contract: `PRYSM_DATA_COMPLETENESS_MASTER_CHECKLIST.md`

## Known starting evidence

- Audit completed far enough for the main report and multiple report pages to return HTTP 200.
- This does **not** prove each DataForSEO source executed successfully.
- Use this audit as the first baseline for provider-by-provider evidence verification.

## Missing-first review

Verified against the persisted PostgreSQL lifecycle plus governed S3 source checkpoints, raw artifacts, normalized artifacts and canonical artifacts on 2026-09-26. Rows that still require deeper content/report inspection remain UNVERIFIED.

| ID | Evidence area | Status | Evidence / note |
|---|---|---|---|
| DC-001 | Website crawl | PRESENT | DataForSEO On-Page AVAILABLE; 9 pages; raw + normalized readback PASS. |
| DC-002 | Rendered-page evidence | PARTIAL | Content evidence available, but interactive evidence unavailable. |
| DC-003 | Primary conversion pages | PARTIAL | 4 conversion-path pages selected/validated; all 4 returned PARTIAL. |
| DC-004 | Conversion-path validation | PARTIAL | Conversion-path validation status PARTIAL: 4 requested, 4 partial, 0 pass. |
| DC-005 | Forms / booking mechanisms | PARTIAL | Forms=0 and CTAs=0 while interactive evidence is unavailable; true absence vs capture gap not yet resolved. |
| DC-006 | Offer clarity | UNVERIFIED | |
| DC-007 | Primary goal alignment | UNVERIFIED | |
| DC-008 | Trust evidence | PRESENT | 7 trust signals captured in On-Page evidence. |
| DC-009 | Case-study / proof evidence | UNVERIFIED | |
| DC-010 | Pricing / reassurance signals | UNVERIFIED | |
| DC-011 | Technical SEO | PRESENT | On-Page evidence includes status, canonical, redirects, security headers and technical fields. |
| DC-012 | Structured data | PRESENT | Structured-data field captured; schemaTypes observed count=0. |
| DC-013 | DataForSEO On-Page | PRESENT | DataForSEO On-Page AVAILABLE v1.4.1; raw + normalized artifacts readable. |
| DC-014 | DataForSEO Lighthouse mobile | PRESENT | DataForSEO Lighthouse mobile AVAILABLE with performance score. |
| DC-015 | DataForSEO Lighthouse desktop | PRESENT | DataForSEO Lighthouse desktop AVAILABLE with performance score. |
| DC-016 | Performance metrics | PRESENT | Mobile and desktop performance scores present. |
| DC-017 | Performance failure semantics | UNVERIFIED | |
| DC-018 | Local Lighthouse fallback | N/A | DataForSEO Lighthouse succeeded; local fallback was not used. |
| DC-019 | DataForSEO SERP | PRESENT | SERP AVAILABLE; 4 keywords, 74 results; raw + normalized artifacts readable. |
| DC-020 | Market/language normalization | UNVERIFIED | |
| DC-021 | Local Maps evidence | PRESENT | 20 Local Maps results captured. |
| DC-022 | Business Profile evidence | PARTIAL | Business-profile field was collected but no profile was returned; exact-match absence vs retrieval gap not yet resolved. |
| DC-023 | Competitor inputs | PRESENT | 3 supplied competitors persisted. |
| DC-024 | Competitor comparison | PRESENT | 74 competitor results plus 3 supplied competitors present in decision evidence. |
| DC-025 | DataForSEO Labs/domain ranking | PRESENT | DataForSEO Labs enrichment present (2 fields). |
| DC-026 | Backlink summary | PRESENT | Backlinks AVAILABLE; 157 backlinks reviewed; authority summary present. |
| DC-027 | Referring-domain detail | PRESENT | 21 referring-domain records captured. |
| DC-028 | 12-month backlink history | PARTIAL | Backlink history contains 10 periods; 12-month requirement not yet met. |
| DC-029 | Content opportunities | UNVERIFIED | |
| DC-030 | AI-search readiness | UNVERIFIED | |
| DC-031 | Evidence provenance | PRESENT | Source checkpoints include provider, execution key, completion time and artifact references. |
| DC-032 | Raw evidence artifacts | PRESENT | Raw artifacts readable for On-Page, Lighthouse, SERP and backlinks. |
| DC-033 | Normalized evidence artifacts | PRESENT | Normalized artifacts readable for On-Page, Lighthouse, SERP and backlinks. |
| DC-034 | Screenshot/diagnostic artifacts | UNVERIFIED | |
| DC-035 | S3 persistence | PRESENT | Governed artifacts persisted in configured S3 staging prefix. |
| DC-036 | S3 readback | PRESENT | Raw, normalized and canonical artifacts successfully read back from S3. |
| DC-037 | Report projection | UNVERIFIED | |
| DC-038 | UNKNOWN/PARTIAL handling | UNVERIFIED | |
| DC-039 | Cross-report consistency | UNVERIFIED | |
| DC-040 | Seven-page report completeness | UNVERIFIED | |
| DC-041 | Print/PDF | UNVERIFIED | |
| DC-042 | GA4 | NOT_CONNECTED | No GA4 source checkpoint; optional integration not connected. |
| DC-043 | GSC | NOT_CONNECTED | No GSC source checkpoint; optional integration not connected. |

## Exit rule

This audit is reviewed only when no applicable row remains UNVERIFIED. The working review should surface MISSING + PARTIAL first.
