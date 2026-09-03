# P6 Candidate Evidence — Unavailable / Partial Evidence Actionability

Date: 2026-09-02  
Candidate branch: `repair/prysm-report-improvement`  
Exact candidate: `7580d9b479190bc95065f4edc66245d083f575f7`  
Base candidate: `89b1957b98ac5064527bc55cf7eb20caf2889051`  
Classification: `VERIFIED_DESIGN_GAP` — `P6_UNAVAILABLE_ACTIONABILITY_CONTRACT`  
Change tier / release intent: `T2_BOUNDARY` / `CHANGE_ONLY`

## Requirement and bounded change

For already-unavailable or partial evidence, retain the actual status and limitation while giving the client: required source/information, how to enable or collect it, and the additional insight that would then be possible. The additive deterministic roadmap is consumed only by affected report renderers. It does not alter acquisition, canonical evidence, status derivation, scoring, persistence, Writer/Judge inputs, prompts, n8n, configuration, or live behavior.

Changed application surfaces:

- `services/worker/src/report/unavailable-roadmap.js`
- `services/worker/src/report/render-approved-report.js`
- `services/worker/src/report/report-detail-sections.js`
- deterministic direct tests in `src/audit/approved-pages.test.js` and `src/report/p6-unavailable-roadmap.test.js`

## Direct proof

`node --test src/report/p6-unavailable-roadmap.test.js src/audit/approved-pages.test.js` — **22/22 PASS**.

This proves:

- unavailable CrUX with valid lab profiles remains explicitly distinct from real-user field performance and receives a collection/insight path;
- unavailable accessibility and partial accessibility/crawl rows retain `UNAVAILABLE`/`PARTIAL`, receive actionable metadata, and are not promoted to findings;
- GA4/backlink deferred rows retain their source status and have source-specific roadmap information;
- available GA4/backlink control has no fabricated deferred roadmap row.

## Exact deterministic verification

- `npm test` — **PASS** (worker regression; no failures).
- `npm run test:narrative-v2` — **114/114 PASS**.
- `npm run verify:prysm-whole-app` — **87/87 PASS**; P-B01 through P-B16 executed, including persistence/replay and renderer paths.
- `git diff --check` — **PASS**.

No live provider or model calls occurred. The Model-Bearing Release Gate is **N/A** because no prompt, model input, semantic orchestration, or stochastic behavior changed.

## Determinacy

Requirement preservation: **PASS**.  
Change hypothesis: **PROVEN**.  
Producer → contract → consumer: existing evidence/capability status → deterministic roadmap projection → approved/deferred, accessibility/mobile, and performance renderers.  
Protected surfaces: **PRESERVED**.  
Unauthorized scope expansion: **ZERO**.  
Causal necessity and Surgical Determinacy: **PASS**.

## Audit handoff condition

The immutable candidate is `7580d9b479190bc95065f4edc66245d083f575f7`; it must be independently challenged before P6 closure. Production remains the protected SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`.

## Same-root repair after P6-MAJOR-01

The Evidence Appendix omission is repaired by routing the existing deterministic roadmap into `sections-performance.js::appendix` for non-`AVAILABLE` Website Capture, Performance, Backlinks, and GA4 source states. Fully available sources receive no fabricated roadmap.

Exact repair candidate: `3fb3042c04d874d44ff7f984bf279fd7b452327c`.

- direct P6 positive/negative proof: **24/24 PASS**;
- worker regression: **981/981 PASS**;
- Narrative v2: **114/114 PASS**;
- Whole-App gate: **87/87 PASS**, P-B01 through P-B16, with P-B17 direct appendix proof separately executed;
- render golden matrix reviewed and re-frozen for the intentional Appendix output change;
- `git diff --check`: **PASS**;
- zero live provider/model calls; Model-Bearing Release Gate: **N/A**.

The application branch was pushed and remote equality verified. Independent re-audit is required before P6 closure.
