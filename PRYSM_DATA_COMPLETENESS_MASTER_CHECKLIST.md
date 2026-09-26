# PRYSM V1 Data Completeness Master Checklist

Version: 1.0.0
Frozen: 2026-09-26
Purpose: define the evidence required before PRYSM V1 is considered data-complete.

## Status vocabulary

Each item must be marked as exactly one of:

- UNVERIFIED — not checked yet; this is not evidence of failure.
- PRESENT — required evidence was collected and is usable.
- PARTIAL — some usable evidence exists, but the required evidence contract is incomplete.
- MISSING — required evidence was expected but was not collected, persisted, or projected.
- N/A — the evidence class does not apply to the audited business/site.
- NOT_CONNECTED — optional client-owned integration was not connected.

Default review view: show MISSING + PARTIAL first; UNVERIFIED remains visible until reviewed.

## Acceptance rule

PRYSM V1 is not data-complete until:
1. every REQUIRED item below has been proven PRESENT in at least one real staging audit;
2. each applicable REQUIRED item is PRESENT or explicitly PARTIAL/MISSING for every individual audit;
3. UNKNOWN/PARTIAL/NOT_CONNECTED states never become fabricated negative findings;
4. persisted evidence can be read back from the configured artifact store; and
5. the client-facing report projects the stored evidence without contradiction.

## Checklist

| ID | Evidence area | Required | Acceptance evidence |
|---|---|---|---|
| DC-001 | Website crawl | YES | Real pages, URLs, titles, headings, body evidence, HTTP status |
| DC-002 | Rendered-page evidence | YES | JS-rendered content collected where required |
| DC-003 | Primary conversion pages | YES | Primary conversion URLs identified |
| DC-004 | Conversion-path validation | YES | CTA/action path checked to destination/outcome |
| DC-005 | Forms / booking mechanisms | YES | Forms, booking, quote, purchase or signup mechanisms classified |
| DC-006 | Offer clarity | YES | Services/products/offers extracted correctly |
| DC-007 | Primary goal alignment | YES | Findings evaluated against supplied business goal |
| DC-008 | Trust evidence | YES | Reviews/testimonials/credentials/team/guarantees captured where present |
| DC-009 | Case-study / proof evidence | YES | Present evidence captured; absence remains UNKNOWN/not fabricated |
| DC-010 | Pricing / reassurance signals | YES | Pricing/estimate/financing/guarantee/risk-reducer evidence captured where present |
| DC-011 | Technical SEO | YES | Indexability/canonical/robots/redirect/status evidence |
| DC-012 | Structured data | YES | Schema types and relevant structured markup |
| DC-013 | DataForSEO On-Page | YES | Provider result with provenance and source status |
| DC-014 | DataForSEO Lighthouse mobile | YES | Mobile lab performance result or explicit provider failure state |
| DC-015 | DataForSEO Lighthouse desktop | YES | Desktop lab performance result or explicit provider failure state |
| DC-016 | Performance metrics | YES | Returned performance metrics projected without false zeroes |
| DC-017 | Performance failure semantics | YES | Missing metric => PARTIAL/UNKNOWN/FAILED, never fabricated score |
| DC-018 | Local Lighthouse fallback | YES | Used only after DataForSEO Lighthouse failure; provenance retained |
| DC-019 | DataForSEO SERP | YES | Search visibility/ranking evidence collected |
| DC-020 | Market/language normalization | YES | Location, country and language match supplied audit market |
| DC-021 | Local Maps evidence | CONDITIONAL | Local-pack/maps evidence where business/site is local |
| DC-022 | Business Profile evidence | CONDITIONAL | Local-profile evidence where applicable |
| DC-023 | Competitor inputs | YES | Supplied competitors persisted and used |
| DC-024 | Competitor comparison | YES | Comparative evidence, not generic narrative |
| DC-025 | DataForSEO Labs/domain ranking | YES | Domain/ranking visibility evidence collected |
| DC-026 | Backlink summary | YES | Aggregate backlink/referring-domain signals |
| DC-027 | Referring-domain detail | YES | Meaningful referring-domain evidence, not count only |
| DC-028 | 12-month backlink history | YES | Historical backlink/referring-domain trend |
| DC-029 | Content opportunities | YES | Recommendations tied to collected evidence |
| DC-030 | AI-search readiness | YES | Entity/schema/answer-first/FAQ/topic/local signals evaluated |
| DC-031 | Evidence provenance | YES | Provider, source status, timestamp/request ID/artifact ref where applicable |
| DC-032 | Raw evidence artifacts | YES | Raw provider evidence persisted |
| DC-033 | Normalized evidence artifacts | YES | Canonical normalized evidence persisted |
| DC-034 | Screenshot/diagnostic artifacts | YES | Persisted where evidence contract calls for them |
| DC-035 | S3 persistence | YES | Governed report/evidence artifacts exist in configured bucket/prefix |
| DC-036 | S3 readback | YES | Persisted audit/report can be retrieved from artifact store |
| DC-037 | Report projection | YES | Stored evidence appears correctly in client-facing report |
| DC-038 | UNKNOWN/PARTIAL handling | YES | Missing evidence is a limitation, not a negative claim |
| DC-039 | Cross-report consistency | YES | Scores, narratives, evidence and recommendations do not contradict |
| DC-040 | Seven-page report completeness | YES | All required report pages render and navigate |
| DC-041 | Print/PDF | YES | Full report prints/exports correctly |
| DC-042 | GA4 | OPTIONAL | Connected analytics when supplied by client |
| DC-043 | GSC | OPTIONAL | Connected Search Console when supplied by client |

## Coverage strategy

Real staging audits should deliberately cover different business/site shapes:
- local service business;
- service + booking + training + products;
- e-commerce;
- professional services;
- multi-location/local;
- weak/poor evidence site;
- larger content site;
- strong/high-performing site.

A site is selected because it can close known checklist gaps, not simply because another audit is needed.

## Working rule

After each completed audit:
1. copy this checklist into the audit-specific checklist;
2. resolve every row out of UNVERIFIED;
3. show PARTIAL + MISSING first;
4. choose the next audit based on remaining unproven rows;
5. repair only generic owning contracts/pipelines, never the named fixture;
6. repeat until required master coverage gaps = 0.
