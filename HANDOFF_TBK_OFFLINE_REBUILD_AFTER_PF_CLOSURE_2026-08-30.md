# PRYSM — TBK Offline Rebuild After PF Regression Closure

Date: 2026-08-30  
Status: Active continuation checkpoint

## Repository authority

Treat `chriskulbaba2025/prysm-project-context` as authoritative durable project memory. Do not reconstruct current state from older chats.

Read first:

- `PROJECT.md`
- `GITHUB_PROJECT_MEMORY_PROTOCOL.md`
- `REPAIR_BOUNDARY_PROTOCOL.md`
- `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`
- `WORKFLOW_INSTRUCTIONS.md`
- `TERMINOLOGY.md`
- `CURRENT_STATE.md`
- `CONSTRAINTS.md`
- `DECISIONS.md`
- `CONVERSION_FIRST_V4_2.md`
- this handoff

Application repository: `chriskulbaba2025/vantage-platform`  
Branch: `main`  
Last verified application SHA: `90916e94f6feba73e7e60df54bd641bb2362454c`  
Local worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`

The application working tree remains intentionally dirty with the governed PF/CF-01 repair package plus regression-contract corrections. Preserve all local edits, fixtures, replay artifacts, and diagnostics. Never reset, clean, checkout-overwrite, or discard unrelated work.

No application commit, push, deploy, provider recollection, fresh production audit, production mutation, or paid Writer/Judge call occurred during this regression-cleanup continuation.

## Regression cleanup status — GREEN

PF-01 through PF-18 remain closed. The integrated regression cleanup is now complete.

### CR-26 / CR-44 — CLOSED

Classification: stale competitor test fixtures relative to the governed supplied-competitor allowlist, not a production defect.

Repair:

- competitor-specific matrix cases now provide an explicit input containing `competitors: ["https://rival.com"]`;
- `scoreWith()` / `modelForSite()` test helpers accept the explicit input only where required;
- competitor branches now exercise the current supplied-competitor contract.

Proof:

- CR-26 / CR-44: **2/2 PASS**.

### CR-43 — CLOSED

The full rendered-report golden hashes changed across all 27 branch fixtures after the governed PF/report repairs.

A bounded no-fabrication review of the changed production report/scoring files confirmed the changes were explained by intentional governed behavior, including:

- PARTIAL evidence remains bounded instead of becoming absence;
- validated browser conversion observations are retained;
- client competitor output stays inside supplied usable evidence;
- executive priority/root-cause presentation follows the governed Conversion-First action hierarchy;
- fractional assessed-weight semantics propagate honestly into rendered output.

The golden hashes were deliberately re-frozen only after that review.

Proof:

- CR-43: **1/1 PASS**.

### `vantage-score.test.js` assessed-weight family — CLOSED

Classification: stale expectations relative to PF fractional assessed-weight semantics, not a scoring defect.

Verified current fixture behavior:

- fully available fixture assessed weight: **97**, not 100;
- performance-unavailable fixture assessed weight: **87**, not 90;
- readiness remains `Complete` where governed thresholds still permit it.

The test names/expectations were corrected to describe the actual governed coverage rather than obsolete exact-boundary assumptions.

Proof:

- `src/scoring/vantage-score.test.js`: **70/70 PASS**.

## Full worker aggregate closure

First full `npm test` after the known regression families were repaired:

- tests: 957
- pass: 952
- fail: 5

Those five failures collapsed into three root-cause families.

### PC-03/07 supplied competitor production-path test — CLOSED

The hydrated supplied competitor was correctly `AVAILABLE`, but the test called `competitorComparison()` without its new third `suppliedCompetitors` argument. The production scorer already passed `input.competitors || []`.

Classification: stale test invocation, not a production defect.

Bounded correction:

- test now calls `competitorComparison(hydrated.evidence.competitors, null, [SUPPLIED_URL])`.

Proof:

- PC-03/07: **1/1 PASS**.

### `run-audit` finalization family — CLOSED

Three failures shared one real production integration defect. Direct `_gateErrors` diagnostic proved:

`Root cause is derived from VAN-TECH-003, but the governed Conversion-First action hierarchy ranks VAN-CONTENT-002 first.`

Cause:

- `scoreAudit()` still persisted root cause from the first raw score-bearing finding;
- the finalization gate correctly compared that against the governed Conversion-First action plan;
- the renderer had already moved to the Conversion-First hierarchy, leaving the canonical model/gate binding stale.

Production repair:

- `scoreAudit()` now derives canonical root cause from `buildFoundationChecklist()` + `buildActionPlan()`;
- the canonical model carries `rootCauseRuleId`;
- the finalization gate validates that explicit rule binding, with a legacy fallback for older/manual fixtures;
- the gate was not weakened.

Proof:

- affected `run-audit` family: **3/3 PASS**.

### TBK-REPAIR-02 browser conversion score — CLOSED

The current conversion scoring semantics produced 100 while the fixture still expected 94.

Classification: stale expectation after PF fractional-assessment repair.

Reason:

- browser evidence fully proves CTA readiness and form readiness for the tested scope;
- unassessed trust-dependent and CTA-cardinality terms are excluded from the assessed denominator rather than silently scored as zero;
- normalized assessed conversion terms therefore score 100.

Bounded correction:

- fixture expectation changed from 94 to 100;
- production scoring was not changed for this failure.

Proof:

- TBK-REPAIR-02: **1/1 PASS**.

## Final aggregate verification

Final command:

```powershell
npm test
```

Verified result:

- tests: **957**
- pass: **957**
- fail: **0**
- cancelled: **0**
- skipped: **0**
- duration: **18391.4511 ms**

This supersedes the earlier 260-test / 231-pass / 29-fail cleanup baseline. The known regression-cleanup phase is complete.

## Frozen TBK package

Frozen audit remains:

- Audit: `9714c206-8ed3-4686-8fe2-ceeca0ca0f82`
- Target: `https://www.tbkcreative.com/`
- Governed fixture: `C:\Users\kulba\Desktop\vantage-platform\services\worker\test-fixtures\report-replay\audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82\governed`

Raw/normalized/canonical frozen evidence remains immutable. Derived findings, scores, report inputs, and deterministic HTML may now be rebuilt locally/in memory from the frozen fixture for offline review.

## Important active constraints

- Preserve the dirty local application working tree.
- Do not reset, clean, checkout-overwrite, or discard the local repair package.
- No application commit/push/deploy is authorized yet.
- No provider recollection or fresh production audit is authorized.
- No paid Writer/Judge call is authorized at this checkpoint.
- Frozen TBK raw/normalized/canonical evidence is immutable.
- Do not change scoring weights or scoring version merely to alter results.
- Preserve Viewer v2.2.0, provider crawl ceiling 250, priority-URL ceiling 20, and production content-parsing default 50.
- Preserve Narrative release governance, evidence-fidelity protections, pass limits, and human authorization boundaries.
- Browser-served report review remains an acceptance gate; automated green tests alone do not approve final client interpretation/presentation.
- Follow `REPAIR_BOUNDARY_PROTOCOL.md`, `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`, and `WORKFLOW_INSTRUCTIONS.md` for any further code repair.
- Manual edits require exact path, current lines/anchors, complete replacement blocks, and bottom-up ordering.

## Exact next action

From:

`C:\Users\kulba\Desktop\vantage-platform\services\worker`

run exactly:

```powershell
git diff --check
```

If it passes, preserve the green local package and proceed to rebuild the deterministic TBK report offline from the frozen governed fixture for browser-served report review. Do not call providers or Writer/Judge models.
