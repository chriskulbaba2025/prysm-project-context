# PRYSM City Media — frozen-source truth diagnosis (2026-10-18)

**Status:** SOURCE_BYTES PASS; EVIDENCE/CLIENT SEMANTICS FAIL; LIVE RENDER PARITY HOLD.
**Target:** audit `77b14b11-e034-456a-be77-6650cc37cf4a`, tenant `prysm-staging`, client `citymediacollective.com-city-media-collective`.
**App commit:** `bda9578029fda428e227bae774defb2e6c9a9809`.
**Input authority:** exact original 44-object read-only S3 export; 8,209,547 bytes; `EXPORT_MANIFEST.json` and 44/44 SHA-256 comparisons PASS. Raw bytes remain on operator's local ignored folder and in conversation upload, **not in this GitHub repository**.

## Proven failure boundaries

1. **Case-study extraction:** Crawl fetched 72 records (58 HTTP 200, 13 redirects, one 404). Four first-party `/our-work/` portfolio/case pages are HTTP 200 with named projects, headings and vendor word counts, but normalized `bodyText=""` and `_contentAvailable=false`; canonical `site.trust.caseStudies=false` and `completedWork=false`. Owners: `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js` (only 7 selected pages have body text), `services/worker/src/trust/completed-work-evidence.js`, semantic trust and score layers. Do not assert verified customer outcomes from heading alone; preserve PARTIAL and distinguish page existence from substantiated work.
2. **False content completeness:** `siteFootprint.status=UNAVAILABLE`, `incomplete=true`, zero usable sitemap URLs, only 7 of 72 normalized pages with body text; but `src/report-intelligence/semantic-ledger.js::scopeComplete` accepts task `coverage.completed=72/requested=72` as sufficient to confirm absence. Five buyer-need `ABSENT_CONFIRMED` rows are not defensible as verified site-wide gaps.
3. **Missing audit identity:** `src/report-intelligence/semantic-ledger.js::applicabilityFor` requires matching tenant/client/audit IDs on site/context AND content opportunity row; all are absent from exported site and idea rows. Therefore every one of 12 rows is `NO_ACTION` despite five `ABSENT_CONFIRMED`, four PARTIAL, two COVERED, one UNKNOWN. `src/report/v13/prysm-report-v13-pages.js::r6` mislabels all `NO_ACTION` as `Already covered`. Restore trusted envelope identity join with wrong-tenant negative controls, do not weaken identity guard.
4. **Incorrect CTA affected URL:** Playwright home CTA `visible=true, interactable=true` desktop+mobile; five other tested pages have desktop `visible=false, interactable=false, obstructed=true`, with no captured occluder identity. `VAN-PATH-001` names the **working homepage** because `src/scoring/score-components.js` omits `affectedUrls` and its add helper defaults to `site.targetUrl`. `src/evidence/conversion-path-validator.js` falls back to hidden semantic candidates without recording a selector/hit-test occluder. Confirmed affected-url error; overlay cause NOT PROVEN. Separate hidden/noninteractable from confirmed obstructed.
5. **FAQ Writer contradiction:** canonical `VAN-CONTENT-002` only confirms no explicit FAQ detected (not that buyer answers are absent). Priority Fixes instructs VERIFY, while saved Writer `funnelOpportunities.decision` says `Create an explicit FAQ`. Need cross-surface action-consistency publication gate; preserve VERIFY until absent buyer answers actually proven.
6. **Malformed intake:** `audit-request.targetAudience` is exactly 160 characters ending `, a`; `primaryGoal` empty; ten client-declared services versus zero structured site services. Intake/display must reject or flag truncation, while not confusing declared context with site proof.
7. **Live vs saved report:** Saved `report-v2/pages/index.html` and draft manifest generated 2026-10-14 ~19:39 UTC, client PDF printed October 18. In-memory read-only rerender may be enabled; export does NOT establish response bytes/header or current renderer parity. HOLD until authenticated GET SHA and `x-prysm-executive-rerender` header verification.

## Valid bounded findings / controls

- Site type `SERVICE_LEAD_GEN` comes from explicit intake; no evidence it requires reclassification.
- 8 missing descriptions / 58 assessed HTTP 200 pages has named affected URLs: preserve.
- Homepage mobile lab LCP ~5837.56ms: preserve as lab-only, not real-user impact.
- No supplied competitors: leave comparison withheld.
- The trust score 53/100 and overall score 67/100 are historical values, **not approved as corrected values**; rerun scoring after repaired evidence.

## Gates and one next action

First governed repair tranche `PRYSM-FIDELITY-REPAIR-01` should consume frozen local evidence under `C:\\g\\p001\\.governance\\evidence\\city-media-77b14b11-e034-456a-be77-6650cc37cf4a`, verify hashes and authority, repair source/content completeness/semantic-ID/CTA URL consistency without any new audit/provider/Writer calls, then replay saved evidence into a separate local candidate and compare canonical claims, scores and client rendering. Do not modify existing S3 reports, hardcode City Media results, push or deploy in the first tranche. Require negative tests: missing content body, incomplete sitemap, wrong tenant, generic project title, hidden CTA with no actual occluder, and CTA homepage positive control; include distinct TBK fixture regression.

The **source is verified**, **semantics are not client-safe**. Next stage is bounded diagnosis-driven repair and replay, not yet Claude prose changes. Full line-by-line download artifact prepared in conversation: `PRYSM-CityMedia-Source-Fidelity-Diagnosis-20261018.md`; portable witness in chat `PRYSM_CityMedia_Fidelity_Witness.py` with baseline source PASS / six semantic FAIL / one REVIEW / live parity HOLD.
