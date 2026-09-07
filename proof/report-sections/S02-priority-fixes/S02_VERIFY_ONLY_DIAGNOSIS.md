# S02 Verify-Only Failure Diagnosis — Priority Fixes

Section: `S02 — Priority Fixes`
Date: 2026-09-07
Status: **PASS — ALL FIVE FAILURES ARE STALE ASSERTIONS**
Stage: `BUILD BLOCKED — TEST-ONLY REPAIR AWAITING EXPLICIT AUTHORIZATION`
Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md` v1.2.0
Contract: `S02_CONTRACT.md` — APPROVED / FROZEN
Bounded build proof: `S02_BOUNDED_BUILD_PROOF.md`

## Candidate identity

- Repository: `C:\Users\kulba\Desktop\vantage-platform`
- Worker: `C:\Users\kulba\Desktop\vantage-platform\services\worker`
- Branch: `p1/bounded-build-cross-report-integrity`
- Historical committed HEAD: `a9523ac3de98de76335a05304b60bec246242b65`
- Viewer: `2.3.0`
- HEAD alone does not identify the governed candidate; the intentional dirty P1/S01/S02 worktree remains part of it and must be preserved.

No application file was edited during diagnosis.

## Verify-only gate under diagnosis

Command:

`node --test src/report/render-report-v2-sections.test.js src/report/karen-style-regression.test.js`

Result before diagnosis:

- tests: `18`
- pass: `13`
- fail: `5`
- exit code: `1`

Failures:

1. `KAREN-REG-02`
2. `IL-03`
3. `IL-04`
4. `V2R-06`
5. `V2R-08`

## Classification

All five failures are **STALE_ASSERTION**. No genuine S02 regression was proven.

### KAREN-REG-02

The test still requires the former literal heading `E. What should be fixed first?` as the Priority Fixes semantic marker.

The frozen S02 contract intentionally replaced that old Section E presentation with one authoritative ranked client sequence headed in client language as `What should you fix first?`.

Classification: **STALE_ASSERTION**.

### V2R-06

The test still requires the old literal `E. What should be fixed first?` among preserved v2 report strings.

That heading is intentionally superseded by the frozen S02 presentation contract.

Classification: **STALE_ASSERTION**.

### V2R-08

The test still uses the old `E. What should be fixed first?` string as the Priority Fixes area marker.

The underlying Priority Fixes area remains present, but its presentation marker has intentionally changed under the approved S02 contract.

Classification: **STALE_ASSERTION**.

### IL-03

The test applies `!html.includes("unknown")` to the entire rendered document after a traced broken-link fixture.

The S02 build correctly preserves bounded uncertainty elsewhere in the report, including phrases such as `other pages remain unknown`. The S02 source change does not alter internal-link rendering semantics.

Therefore the document-wide prohibition now rejects legitimate S02 uncertainty rather than proving an internal-link regression.

Classification: **STALE_ASSERTION**.

### IL-04

Same root cause as IL-03. The historical string broken-link path still retains its count-only limitation behavior, but the test rejects any `unknown` anywhere in the full rendered report.

The frozen S02 contract explicitly requires bounded unknown/unassessed wording where evidence scope is incomplete.

Classification: **STALE_ASSERTION**.

## Causal conclusion

The authorized S02 renderer changes:

- created one client-facing ranked Priority Fixes sequence;
- moved Foundation Readiness and deterministic Action Plan to Supporting Detail;
- moved Narrative Root Cause, Narrative Conversion, and Narrative Action Plan to Supporting Detail;
- preserved governed action order;
- preserved bounded uncertainty.

The five verify-only failures are caused by expectations that predate the frozen S02 presentation contract or by assertions scoped too broadly across the entire report.

No evidence proves a change to:

- scoring;
- evidence semantics;
- Client Truth;
- `action-priority.js` ordering;
- Writer/Judge contracts;
- lifecycle;
- canonical artifacts;
- providers/models;
- production state.

## Smallest safe repair boundary

A follow-up repair can be **test-only**, limited to exactly:

1. `services/worker/src/report/render-report-v2-sections.test.js`
2. `services/worker/src/report/karen-style-regression.test.js`

Permitted repair intent:

- replace obsolete `E. What should be fixed first?` expectations with the frozen S02 Priority Fixes marker;
- narrow IL-03 / IL-04 from whole-document `unknown` rejection to the internal-link surface or to direct source/target/count-only assertions;
- preserve substantive internal-link regression coverage;
- make no application source change.

## Prohibited boundaries

Do not modify:

- `src/report/render-report-v2.js` during this test-only repair unless a new diagnosis proves a source regression;
- `src/report/render-narrative-v2.js` during this test-only repair unless a new diagnosis proves a source regression;
- `src/report/action-priority.js`;
- `src/scoring/score-components.js`;
- scoring/report-model/Client Truth producers or validators;
- evidence contracts/adapters/collection;
- Writer/Judge generation/schema/validation/orchestration;
- lifecycle/storage/auth;
- canonical artifacts;
- provider/model behavior;
- production state;
- unrelated P1/S01/S02 dirty work.

No reset, clean, restore, checkout-overwrite, destructive revert, stash, discard, commit, push, merge, deploy, provider/model call, production audit, or TBK rerender is authorized.

## Diagnosis decision

**PASS.**

All five verify-only failures are stale assertions. The smallest legitimate next boundary is a two-file test-only repair.

Exact next action: Chris explicitly authorizes the bounded test-only repair in `render-report-v2-sections.test.js` and `karen-style-regression.test.js`; then rerun only the verify-only gate and return proof. Do not advance to deterministic audit or real TBK rerender until that gate passes and is reviewed.