# PRYSM — PF Regression Cleanup Continuation Handoff

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

The application working tree remains intentionally dirty with the governed PF repair package. Preserve all local PF edits, fixtures, replay artifacts, and diagnostics. Never reset, clean, checkout-overwrite, or discard unrelated work.

No application commit, push, deploy, provider recollection, fresh production audit, production mutation, or paid Writer/Judge call is authorized at this checkpoint.

## PF status

PF-01 through PF-18 remain closed by targeted proof. Do not reopen PF architecture without new direct evidence of a material defect.

## Integrated regression baseline

The selected integrated suite was previously run after PF closure:

- tests: 260
- pass: 231
- fail: 29

Do not interpret those 29 as current independent failures. The cleanup is being performed by shared failure family, and several families are now closed.

Do not rerun the full 260-test suite until the remaining known families are addressed.

## Regression families already closed before this continuation

1. `src/scoring/score-components.test.js` — structural repair family: 30/30 PASS.
2. `src/scoring/decision-scope.test.js` — PF-05 fixture integrity family: 5/5 PASS.
3. Judge prompt-version drift across `judge-contract.test.js`, `live-binding.test.js`, and `render-narrative-v2.test.js`: combined 27/27 PASS.

## Closed in the 2026-08-30 continuation

### 1. CONTRACT-CLOSURE family — CLOSED

Initial failure:

`CONTRACT-CLOSURE-01` through `CONTRACT-CLOSURE-05` failed because `productionShapedWriterInput()` no longer supplied mandatory `decisionEvidence` to `buildWriterInput()`.

Diagnosis:

- `buildWriterInput()` now fail-closes when `decisionEvidence` is absent because governed Writer action-plan parity derives Conversion-First influence from the canonical decision evidence object.
- Existing production-path tests confirmed the minimal valid local test shape can be `{ site: { targetUrl } }`.
- After adding `decisionEvidence`, 3/5 passed.
- The remaining two failures were a second stale fixture value: `rawPassingJudge()` still hard-coded `judgePromptVersion: "2.0.0"` while the governed version is `2.1.0`.

Bounded fixture corrections in:

`src/narrative-v2/contract-closure.test.js`

- add `decisionEvidence: { site: { targetUrl: "https://rebootbusinesscoaching.com/" } }` to `productionShapedWriterInput()`;
- update `judgePromptVersion` from `2.0.0` to `2.1.0` in `rawPassingJudge()`.

Proof:

`node --test src/narrative-v2/contract-closure.test.js`

- tests: 5
- pass: 5
- fail: 0

Classification: stale test fixture/contract drift, not a production runtime defect.

### 2. Writer semantic-fidelity family — CLOSED

Initial failures:

- `WRITER-OUT-01`
- `WRITER-OUT-06`

Initial error:

`writerOutput.rootCause.narrative.text states an unmeasured business outcome with causal certainty`

A first fixture wording correction alone did not clear the failure. The next diagnostic inspected the actual semantic-fidelity regexes and then directly tested the sentence against `causalCertaintyPattern`.

Proven production defect:

`causes?` in `src/narrative-v2/writer-output.js` matched the noun `cause` inside the governed phrase `root-cause assessment`, causing a false positive even when the sentence made no causal business-outcome claim.

Direct proof returned:

- matched token: `cause`
- match location: inside `root-cause`

Bounded production repair:

The causal-certainty regex now excludes `cause` / `causes` when immediately preceded by `root-` or `root `, while preserving detection of genuine causal language such as `causes conversions`.

The valid-output fixture wording in `writer-output.test.js` was also changed from `needed to generate qualified enquiries` to the bounded/non-causal `associated with the stated qualified-enquiry goal` during diagnosis and remains in the local repair package.

Proof:

`node --test src/narrative-v2/writer-output.test.js`

- tests: 10
- pass: 10
- fail: 0

Classification: genuine production semantic-validator false positive plus a valid fixture wording cleanup. The validator was repaired rather than weakened.

### 3. T-GATE-INT-02 hierarchy family — CLOSED

Failure:

`T-GATE-INT-02: consistent report passes and produces all required outputs`

Direct gate error:

`Root cause is derived from VAN-PERF-001, but the governed Conversion-First action hierarchy ranks VAN-TRUST-001 first.`

Diagnosis:

- `report-finalization-gate.js` derives the root-cause finding from the first score-bearing finding;
- the same gate builds the governed Conversion-First checklist/action plan with `buildFoundationChecklist(model)` + `buildActionPlan(model, checklist)`;
- the test fixture ordered `VAN-PERF-001` first even though the governed hierarchy correctly ranked `VAN-TRUST-001` first.

Bounded fixture correction in:

`src/scoring/report-finalization-gate.test.js`

The three score-bearing findings in `T-GATE-INT-02` were reordered to:

1. `VAN-TRUST-001`
2. `VAN-PERF-001`
3. `VAN-TECH-001`

Proof:

`node --test --test-name-pattern="T-GATE-INT-02" src/scoring/report-finalization-gate.test.js`

- tests: 1
- pass: 1
- fail: 0

Classification: stale integration fixture relative to the governed Conversion-First hierarchy, not a production defect.

## Remaining known regression families

Only these known families remain from the prior 260-test run:

1. `CR-26` / `CR-44` — competitor fixtures predate the supplied-competitor allowlist and likely no longer reach the governed comparison branch. Classify before editing.
2. `CR-43` — frozen rendered-report hashes changed and require explicit no-fabrication review before any re-freeze.
3. Four `vantage-score.test.js` assessed-weight expectations — likely stale relative to PF-01/PF-02 fractional assessed-weight semantics. Classify before editing; never update merely to silence failures.

After those families are addressed, rerun the selected 260-test suite. Only after that suite is green may the deterministic TBK package be rebuilt and reviewed offline from frozen evidence.

## Important active constraints

- Preserve the dirty local application working tree.
- Frozen TBK raw/normalized/canonical evidence is immutable.
- No reset, clean, checkout-overwrite, discard, push, deploy, production rerun, provider recollection, production mutation, or paid Writer/Judge call without explicit approval.
- Do not weaken Narrative release governance or semantic/evidence protections.
- Do not change scoring weights or scoring version merely to alter results.
- Work one failure family at a time: classify root cause first, make the smallest coherent repair, run one family-level proving test, and stop for the result.
- Maximum three unsuccessful repair attempts for the same observable failure before deeper diagnostic reset.
- Follow `REPAIR_BOUNDARY_PROTOCOL.md`, `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`, and `WORKFLOW_INSTRUCTIONS.md`.
- Exact Windows path, exact current line numbers/ranges and anchors, complete replacement blocks, and bottom-up ordering remain mandatory for manual surgical edits.
- Do not update a test merely to silence a regression.
- Browser-served report review remains an acceptance gate after automated regression cleanup.

## Exact next action

Inspect the CR-26 / CR-44 competitor regression family only.

From:

`C:\Users\kulba\Desktop\vantage-platform\services\worker`

run:

```powershell
rg -n -C 18 "CR-26|CR-44" src/report/render-report-v2-conversion.test.js
```

Then classify both tests together before any edit. The current working hypothesis is stale supplied-competitor fixture behavior, but that is not yet proven in this continuation checkpoint.

Do not run the full 260-test suite yet.
