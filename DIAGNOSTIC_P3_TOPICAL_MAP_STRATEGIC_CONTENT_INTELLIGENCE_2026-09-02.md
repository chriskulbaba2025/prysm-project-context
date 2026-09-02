# P3 Diagnostic Evidence — Topical Map / Strategic Content Intelligence

Date: 2026-09-02
Application candidate: `repair/prysm-report-improvement` @ `a2c54692ce231c34e4f693a6bb34ed3db527d1d6`
Classification: **VERIFIED_DESIGN_GAP**

## Requirement preserved

Move from generic content suggestions to site-specific strategic content intelligence while preserving the Awareness → Consideration → Decision framing where valid. Each governed opportunity should provide, where supported: topic/question, business need, current evidence/existing content, gap, recommended asset, placement, funnel stage, and priority. Partial/unavailable evidence must remain explicit and must not become a negative finding.

## Executing boundary traced

`scoreAudit()` in `services/worker/src/scoring/vantage-score.js:1563-1567` calls `contentIdeas(decisionSite, input)` from `services/worker/src/scoring/report-model.js:528-625`.

The producer:

- derives at most three topic strings from intake services, crawled services, and multi-word topic keywords;
- varies only the first topic and optional primary goal in otherwise fixed TOFU/MOFU/BOFU/leading templates;
- emits no per-opportunity evidence reference, existing-page URL, page-class/current-content observation, explicit gap basis, recommended placement, or evidence/capability status;
- uses fallback topics `your service`, `the process`, and `your goals` when meaningful topics are absent;
- is passed through `scoring-service.js`, `build-view-model.js`, `current-model.js`, and the report renderer as `contentIdeas` without a richer governed opportunity contract.

The client consumer is `services/worker/src/report/render-report-v2.js:820+`, which renders the four producer arrays and counts/labels them as content opportunities. The Narrative consumer receives the same deterministic projection through `writer-input.js` and the `analysis:contentIdeas` reference, while the prompt requires specific opportunities but has no richer deterministic fields to ground them.

## Required acceptance artifact trace

| Selected URL | selection reason | page class | body requested | body returned/status | downstream modules |
|---|---|---|---|---|---|
| Available P0-governed deep-content page selections | P0 trace now records this for newly acquired pages; historical reason is explicitly `NOT_RECORDED` | retained by P0 trace | retained by P0 trace | retained returned/unavailable status by P0 trace | scoring/contentIdeas → persisted ScoreSet/ViewModel → Narrative WriterInput → report renderer |

P0 evidence is sufficient to support site-specific current-content references for newly traced pages, but the current P3 producer does not consume or preserve those fields in opportunity rows. This is the design boundary requiring repair.

## Deterministic proof

- Authoritative command: `npm test -- --test-name-pattern='content|funnel|topic|business-context'` from `services/worker`.
- Exact-candidate result: **968/968 PASS**, 0 failures.
- Relevant passing cases include `WP-D-05: intake services change content scoring deterministically`, `WP-D-06: readinessMap stages derive from page purpose`, `WP-D-06: service with no matching page → deterministic site-level fallback`, and the complete `scoreAudit` model test.
- No live provider or model call was made.

## Finding

**VERIFIED_DESIGN_GAP:** the upstream P0 selection/deep-content boundary is now governed for newly acquired evidence, but P3 content opportunities remain generic template projections and cannot satisfy the requested site-specific intelligence contract. A bounded repair must add deterministic evidence-grounded opportunity data at the producer/contract/consumer boundary. Prompt-only tuning is not justified.

## Scope boundary

No application files were edited during diagnosis. No historical P0 selection reason is reconstructed. Any model-bearing or prompt change is out of scope unless separately justified and gated.
