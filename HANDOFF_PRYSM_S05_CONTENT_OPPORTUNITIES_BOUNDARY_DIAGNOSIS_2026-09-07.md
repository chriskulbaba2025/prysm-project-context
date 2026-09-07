# PRYSM Handoff — S05 Content Opportunities Build-Boundary Diagnosis

Date: 2026-09-07
Authoritative repo: `chriskulbaba2025/prysm-project-context`
Application repo: `chriskulbaba2025/vantage-platform`
Application branch: `p1/bounded-build-cross-report-integrity`
Historical committed HEAD: `a9523ac3de98de76335a05304b60bec246242b65`

## Start here in the next chat

Read in this order:
1. `CURRENT_STATE.md`
2. `PRYSM_REPORT_SECTION_STATE.json`
3. `PRYSM_REPORT_SECTION_REGISTRY.md`
4. `proof/report-sections/S05-content-opportunities/S05_BASELINE_AUDIT.md`
5. this handoff

Treat GitHub as authoritative. Do not reconstruct state from the prior chat.

## Locked prior sections

- S01 — Executive Scorecard: **PASS_LOCKED 98/100**, 0 hard gates.
- S02 — Priority Fixes: **PASS_LOCKED 97/100**, 0 hard gates.
- S03 — Conversion Journey: **PASS_LOCKED 97/100**, 0 hard gates.
- S03 final accepted artifact: `C:\Users\kulbaba\Downloads\PRYSM-S03-TBK-EXECUTIVE-BRIDGE-REVIEW.html`
- S03 final SHA-256: `A0D4F0F6AD045D8AC2F25F87850145C3D2E87E48CFDA7AD2A626206B077292DB`
- Locked narrative rule: **Primary pages interpret. Deeper pages explain.**

Do not reopen S01/S02/S03 without new evidence or explicit user authorization under RSIP.

## Active section

S05 — Content Opportunities

Current stage: **BUILD_BOUNDARY_DIAGNOSIS**

Baseline:
- COMPLETE
- 58/100
- 0 hard gates
- proof: `proof/report-sections/S05-content-opportunities/S05_BASELINE_AUDIT.md`

## S05 root cause

The current primary page is a topical/content export rather than a prioritized client decision page. The user should not have to interpret dense tables, generic generated titles, or SEO-support data to determine what content to create first.

## Approved client contract

Kicker:
`Content Opportunities`

H2:
`What content would help buyers move forward?`

Primary client story:
1. `What is already helping buyers`
2. `Where decision support is thin`
3. `What to create or improve first`

Primary opportunities should be concise cards, each containing:
- buyer question / need;
- buyer stage;
- why it matters;
- recommended asset;
- journey connection;
- intended decision-support role;
- evidence qualification.

Rules:
- preserve governed opportunity order;
- do not recompute ranking or scoring;
- make first opportunity visually obvious without inventing a new ranking system;
- distinguish current strength, evidence-backed gap, and qualified opportunity;
- use specific journey connection where governed, otherwise bounded language;
- subordinate search-intent and raw topical/technical detail;
- move supporting detail behind Supporting Detail where possible;
- preserve PARTIAL content-body scope and unassessed-page uncertainty;
- search demand or competitor presence alone does not create a recommendation;
- no unsupported traffic, ranking, revenue, search-volume, or conversion-uplift claims.

## Likely build ownership to diagnose

Inspect only; do not edit yet:
- `services/worker/src/report/render-report-v2.js`
- `services/worker/src/report/render-report-v2-sections.test.js`
- `services/worker/src/report/render-report-v2.test.js`
- `services/worker/src/report/render-narrative-v2.js`
- `services/worker/src/report/render-narrative-v2.test.js`

The baseline identified `render-report-v2.js` as the primary presentation owner. The narrative seam has not yet been authorized for editing; determine whether it requires an edit or inspection/verification only.

## Exact next action

DIAGNOSIS ONLY.

Return:
1. exact rendering function(s) owning S05;
2. exact test assertions/files that will become stale;
3. whether `render-narrative-v2.js` requires editing or inspection only;
4. any additional source/test file required;
5. exact bounded build scope;
6. proposed verification commands.

Stop after returning the boundary. Do not implement until the boundary is approved.

## Preservation constraints

Do not change:
- governed evidence;
- scoring;
- Client Truth;
- action order;
- Writer/Judge objects;
- S01/S02/S03 locked surfaces;
- navigation count/order/labels;
- Supporting Detail assignment;
- canonical artifacts;
- production state.

Preserve the intentional dirty worktree. No reset, clean, restore, checkout-overwrite, destructive revert, stash, discard, push, merge, deploy, provider/model call, production audit, or production mutation.

## User workflow note

For diagnostic outputs intended for upload back into ChatGPT, write them as `.txt` files under `C:\Users\kulbaba\Downloads` and verify path, size, and SHA-256 before returning.
