# P5 Candidate Evidence — Structured Data / Entity Evidence

Date: 2026-09-02  
Application candidate: `89b1957b98ac5064527bc55cf7eb20caf2889051`  
Root defect: `P5_SCHEMA_TYPE_ALIAS_LEAK`

The OnPage normalizer filters provider category aliases `json_ld` and `microdata` before populating page/site schema type collections. A deterministic fixture containing aliases plus `Organization` and `LocalBusiness` produced exactly `["LocalBusiness", "Organization"]`, while retaining body text and `AVAILABLE` source status.

Focused adapter proof: `node --test src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.test.js --test-name-pattern='provider structured-data category aliases'` — **74/74 PASS**.

Whole-App proof: `node scripts/prysm-whole-app-gate.js` — **PASS**, base **87/87**, P-B01 through P-B16; Writer parity **10/10**; Narrative v2 **10/10**; zero live provider calls.

No typed location/entity field was added because current acquisition data lacks a typed, provenance-bearing observation. No prompt/model, n8n, report copy, production, or live-provider behavior changed.
