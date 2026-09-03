# P5 Diagnostic Evidence — Structured Data / Entity Evidence

Date: 2026-09-02
Status: Verified diagnostic; repair contract not yet frozen
Application candidate: `28b25f64e3140968842cfdec265b9583e1c995d9`
Production SHA: `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`

## Requirement preserved

Verify what PRYSM actually detects and what client-facing schema/entity information is produced before changing report copy. In particular, determine whether `json_ld` is surfaced as a schema/entity type, which actual schema types reach evidence, why location/market evidence can be unavailable, and whether rendered/include/component content reaches the relevant evidence boundary.

## Executing path

1. DataForSEO OnPage adapter: `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`
   - `extractSchemaTypes(raw)` reads `raw.structured_data || raw.microdata` and adds `item.type`, `item.types[]`, and `raw.meta.structured_data_types` directly to the type set (lines 491-514 at the diagnostic candidate).
   - `extractMicrodataTypes(raw)` similarly adds `item.type` directly (lines 874-881).
   - The normalized page contract exposes `schemaTypes` and `hasMicrodata` (lines 429-431).
2. Site aggregation: `services/worker/src/evidence/site-crawler.js`
   - Aggregates page `schemaTypes` into site `schemaTypes` (lines 47-50, 130).
3. Scoring: `services/worker/src/scoring/score-components.js` and `services/worker/src/scoring/vantage-score.js`
   - Schema/entity scoring and AI-readiness use the non-empty `site.schemaTypes` collection.
4. Client report: `services/worker/src/report/sections-seo.js`, `services/worker/src/report/report-detail-sections.js`, and `services/worker/src/report/sections-performance.js`
   - The schema section joins and displays `site.schemaTypes` as named types and checks those values for `LocalBusiness`, `Organization`, `Person`, `Service`, and `FAQ`.
   - The performance/AI-readiness panel uses collection length and LocalBusiness matching as client-facing evidence.
5. n8n payload preparation: `services/worker/src/n8n/prepare-payload.js`
   - Preserves only `schemaCount`, not type provenance or actual type/entity details.

## Controlled fixture observations

Fixture: `services/worker/test-fixtures/report-replay-offline/audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82-current/governed/normalized/dataforseo-onpage.json`

| Field | Observed value | Interpretation |
|---|---|---|
| source status | `PARTIAL` | Crawl reached the 250-page ceiling. |
| site `schemaTypes` | `["json_ld"]` | Provider extraction label is exposed as a schema type. |
| site `microdataTypes` | `["json_ld"]` | Same provider label is exposed as a microdata type. |
| first sampled pages | `schemaTypes: []` on first two; homepage `hasMicrodata: true`, `content: true` | Content/rendered evidence exists for at least one page, but the normalized schema type is not a schema.org type. |
| location/entity fields | no normalized `location`, `geographicContext`, or structured entity object | This fixture does not prove visible location text was missed; it proves the current normalized contract does not preserve a typed location/entity observation for this path. |
| limitations | crawl limit/page ceiling | Coverage is partial and must remain explicit. |

## Classification

`VERIFIED_ROOT_CAUSE` for `P5_SCHEMA_TYPE_ALIAS_LEAK`: provider transport/category token `json_ld` is admitted into the canonical `schemaTypes`/`microdataTypes` collections, and downstream consumers interpret non-empty collections as actual schema/entity evidence. This is a producer/normalization contract defect, not a copy-only issue.

`VERIFIED_DESIGN_GAP` for location/entity evidence: the traced normalized site/page contract carries schema type names and generic content signals but no typed, provenance-bearing location/entity observations. The controlled fixture cannot establish that visible include/component location text was absent from the fetched body, so no historical missed-location claim is made.

## Evidence boundary and safety conclusion

The current DataForSEO `/on_page/pages` path is metadata-oriented and does not reliably provide complete rendered/include/component body evidence. The existing code already marks content-dependent signals unavailable/partial when content evidence is absent. A repair must preserve that humility, retain actual schema types only, and add bounded evidence-status/provenance for location/entity observations only where the executing acquisition path supplies them. No prompt, model, n8n, live provider call, or production mutation is authorized by this diagnostic.

## Acceptance rows

| Selected URL | selection reason | page class | body requested | body returned/status | downstream modules |
|---|---|---|---|---|---|
| `https://www.tbkcreative.com/` | controlled normalized replay sample; homepage present in returned crawl pages | homepage | provider OnPage page record; content evidence available | body/content available for this page; site status `PARTIAL` | site aggregation; schema/entity scoring; SEO schema section; AI-readiness panel; n8n compact payload |
| `https://www.tbkcreative.com/logout/` | first returned crawl page in controlled normalized replay | utility/authentication-like page | provider OnPage page record | no content evidence; `schemaTypes: []` | site aggregation and coverage/limitations only |

## Next governed action

Freeze a Surgical Change Contract for the smallest deterministic producer/contract/consumer correction covering: (a) filtering provider category aliases such as `json_ld` from actual schema type collections, (b) preserving actual schema.org types when present, and (c) deciding whether a typed location/entity evidence field is justified by existing acquisition data. Do not change client copy until the contract and direct proof are complete.
