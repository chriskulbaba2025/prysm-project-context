# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

Current objective:
Complete `S05 — Content Opportunities` build-boundary diagnosis after the baseline human-review audit and bounded client contract were reviewed and approved.

## Verified checkpoint

- Active P#: `P1 — Cross-Report Contradiction Integrity`.
- Approved architecture remains **Deterministic Client Truth Contract + existing governed Writer/Judge**.
- Intentional dirty application worktree must be preserved.
- RSIP version: `1.2.0`.
- Report-wide IA contract version: `1.1.0`.
- Viewer presentation version: `2.3.0`.
- `S01 — Executive Scorecard`: **PASS_LOCKED**, score `98/100`, hard-gate failures `0`.
- `S02 — Priority Fixes`: **PASS_LOCKED**, score `97/100`, hard-gate failures `0`.
- `S03 — Conversion Journey`: **PASS_LOCKED**, score `97/100`, hard-gate failures `0`.
- S03 final accepted artifact: `C:\Users\kulba\Downloads\PRYSM-S03-TBK-EXECUTIVE-BRIDGE-REVIEW.html`.
- S03 final accepted artifact SHA-256: `A0D4F0F6AD045D8AC2F25F87850145C3D2E87E48CFDA7AD2A626206B077292DB`.
- S03 closure proof: `proof/report-sections/S03-conversion-journey/S03_CLOSURE.md`.
- Only active RSIP section: `S05 — Content Opportunities`.
- S05 baseline human-review audit: **COMPLETE**.
- S05 baseline score: **58/100**.
- S05 hard-gate failures: **0**.
- S05 baseline proof: `proof/report-sections/S05-content-opportunities/S05_BASELINE_AUDIT.md`.
- S05 bounded client contract: **APPROVED FOR BUILD-BOUNDARY DIAGNOSIS**.
- Current S05 stage: **BUILD_BOUNDARY_DIAGNOSIS**.

## Locked report-wide narrative pattern

The accepted S03 page establishes the client-facing rule:

**Primary pages interpret. Deeper pages explain.**

Do not reopen S01, S02, or S03 without new evidence or an explicit user-directed reopen under RSIP.

## S05 baseline conclusion

Root cause:

The current Content Opportunities page is structured as a topical/content export rather than a prioritized client decision page. It presents buyer-need rows, generated opportunities, covered topics, and leading search intents, but it does not make the first commercially meaningful content action obvious.

Main defects:
- no obvious first content action;
- dense interpretation-heavy tables;
- weak distinction between current strength, evidence-backed gap, and qualified opportunity;
- generic journey-connection language;
- supporting SEO/search-intent detail competes with the primary client story;
- buyer-stage grouping exists but does not explain decision sequence;
- PARTIAL content-body evidence requires explicit scope qualification.

## Approved bounded S05 contract

Primary hierarchy:
- Kicker: `Content Opportunities`
- H2: `What content would help buyers move forward?`
- one concise bounded verdict explaining that the site has a usable content foundation, the main opportunity is stronger buyer decision support, and content-body evidence remains PARTIAL.

Primary client story:
1. `What is already helping buyers`
2. `Where decision support is thin`
3. `What to create or improve first`

Primary qualified opportunities should render as concise client-facing cards rather than a dense five-column table.

Each opportunity card must include:
- buyer question / need;
- buyer stage;
- why it matters;
- recommended asset;
- journey connection;
- intended decision-support role;
- evidence qualification.

Contract rules:
- preserve governed opportunity order; do not recompute ranking;
- make the first opportunity visually obvious without creating a new scoring system;
- distinguish current strength, evidence-backed gap, and qualified opportunity;
- journey connection must be specific where governed, otherwise explicitly bounded;
- keep search-intent and raw topical/technical detail subordinate and move it to Supporting Detail where possible;
- preserve PARTIAL content-body scope and unassessed-page uncertainty;
- search demand or competitor presence alone must not create a recommendation;
- do not claim traffic, rankings, revenue, conversion uplift, or search volume without evidence;
- follow the locked narrative rule: **Primary pages interpret. Deeper pages explain.**

## Likely ownership to diagnose

Inspect only; no edit authorization yet:
- `services/worker/src/report/render-report-v2.js`
- `services/worker/src/report/render-report-v2-sections.test.js`
- `services/worker/src/report/render-report-v2.test.js`
- `services/worker/src/report/render-narrative-v2.js`
- `services/worker/src/report/render-narrative-v2.test.js`

The baseline identified `render-report-v2.js` as the primary presentation owner. The narrative seam must be inspected before determining whether it needs editing or only verification.

If any additional source/test file appears necessary, identify the exact file and reason before any build authorization.

## Important preservation rules

Do not change governed evidence, scoring, Client Truth, action priority/order, Writer/Judge objects, S01/S02/S03 locked content/order, viewer navigation count/order/labels, Supporting Detail assignments, canonical artifacts, or production state.

Preserve the intentional dirty P1/S01/S02/S03 worktree. No reset, clean, restore, checkout-overwrite, destructive revert, stash, discard, push, merge, deploy, provider/model call, production audit, or production mutation.

## Exact next action

Perform **S05 build-boundary diagnosis only**.

Inspect the five likely ownership files listed above and return:
1. exact rendering function(s) owning S05;
2. exact tests that will become stale;
3. whether `render-narrative-v2.js` requires editing or inspection only;
4. any additional source/test file required;
5. exact bounded build scope;
6. proposed verification command set.

Do not edit application code, tests, or report artifacts. Do not rerender. Stop after diagnosis and return the exact bounded build scope for approval.

Last verified:
2026-09-07
