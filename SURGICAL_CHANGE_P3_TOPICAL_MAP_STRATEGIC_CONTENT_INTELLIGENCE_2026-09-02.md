# Surgical Change Contract — P3 Topical Map / Strategic Content Intelligence

Date: 2026-09-02
Change tier: Tier 2 — bounded cross-boundary contract enrichment
Release intent: `CHANGE_ONLY`
Application branch: `repair/prysm-report-improvement`
Diagnostic: `DIAGNOSTIC_P3_TOPICAL_MAP_STRATEGIC_CONTENT_INTELLIGENCE_2026-09-02.md`

## Objective

Enrich deterministic content opportunities so each supported opportunity is site-specific and actionable, while preserving the existing Awareness/Consideration/Decision framing, evidence humility, current scoring semantics, and the existing report page.

## Causal boundary

Producer: `services/worker/src/scoring/report-model.js` (`contentIdeas`)

Contract/persistence: `services/worker/src/contracts/score.schema.json`, current report-view-model contract, and existing ScoreSet/ViewModel pass-throughs.

Consumers: `services/worker/src/report-model/current-model.js`, `services/worker/src/report-view-model/build-view-model.js`, `services/worker/src/report/render-report-v2.js`, and Narrative `writer-input.js` deterministic-analysis/reference projection.

## Bounded implementation

- Add a deterministic, backward-compatible opportunity-row shape containing stage, topic/question, why it matters to the supplied goal/business context, current evidence/status, gap or explicit not-established state, recommended asset, placement, and priority.
- Derive current evidence only from the supplied governed site/page/deep-content fields; never reconstruct historical P0 selection reasons or convert unavailable/partial evidence into absence.
- Preserve existing array names and Awareness → Consideration → Decision mapping; do not change score values, finding ranking, Writer/Judge prompts, model calls, provider policy, n8n, or competitor qualification.
- Make the current contract validate the enriched rows and ensure persistence/reload and report/Narrative consumers receive the same projection.

## Acceptance / Test Areas

1. Fully available production-shaped content evidence produces site-specific rows with exact supporting URLs/observations and all required intelligence fields.
2. Partial, unavailable, and no-body evidence stays explicit and produces bounded opportunity language rather than a fabricated gap or negative finding.
3. Intake services and primary goal remain deterministic inputs; identical evidence/context remains byte-stable.
4. Existing stage derivation, row limits, score behavior, and current renderer remain compatible.
5. Persisted ScoreSet/ViewModel round-trip retains enriched rows; current validation rejects materially incomplete rows.
6. Narrative WriterInput receives the same enriched deterministic analysis without prompt/model changes.
7. Whole-App branch matrix is updated for any newly material branch and exact-SHA gate is rerun; no live provider/model calls.

## Proof and stop conditions

Direct producer/contract/consumer proof must pass before broad regression. Any required prompt/model change, paid/live execution, deployment, merge to `main`, or fresh production audit is outside this contract and requires the protected boundary stop.
