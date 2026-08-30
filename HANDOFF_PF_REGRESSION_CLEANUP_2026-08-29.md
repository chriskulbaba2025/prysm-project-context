# PRYSM — PF Regression Cleanup Handoff

Date: 2026-08-29  
Status: Active continuation checkpoint

## Repository authority

Treat `chriskulbaba2025/prysm-project-context` as authoritative durable project memory. Do not reconstruct current state from older chats.

Application repository: `chriskulbaba2025/vantage-platform`  
Branch: `main`  
Last verified application SHA: `90916e94f6feba73e7e60df54bd641bb2362454c`  
Local worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`

The application working tree remains intentionally dirty with the governed PF repair package. Preserve all local PF edits, fixtures, and diagnostics. Never reset, clean, checkout-overwrite, or discard unrelated work.

No application commit, push, deploy, provider recollection, fresh production audit, production mutation, or paid Writer/Judge call is authorized at this checkpoint.

## Frozen TBK baseline

Frozen audit: `9714c206-8ed3-4686-8fe2-ceeca0ca0f82`  
Target: `https://www.tbkcreative.com/`  
Frozen governed fixture: `C:\Users\kulba\Desktop\vantage-platform\services\worker\test-fixtures\report-replay\audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82\governed`

Frozen evidence remains immutable. Derived findings/scores/report inputs may be rebuilt locally/in memory only after regression cleanup is green.

Narrative identity `ea9a3b49-d393-4633-956b-d6cb1a2a3fc8` is exhausted at six calls and may not receive another call. Identity `9c87448a-c1a1-41eb-a0e5-a8dd63cf8da4` remains diagnostic evidence only.

## PF status

PF-01 through PF-18 are closed by targeted proof.

PF-18 completed units:

- PF-18.1 impossible denominator backstop — PASS.
- PF-18.2 PARTIAL-to-unqualified-absence backstop — PASS.
- PF-18.3 supplied competitor allowlist backstop — PASS.
- PF-18.4 action/root-cause hierarchy disagreement backstop — PASS. `src/scoring/report-finalization-gate.js` reuses `buildFoundationChecklist(model)` + `buildActionPlan(model, checklist)` and rejects disagreement between deterministic root cause and the governed Conversion-First action hierarchy.
- PF-18.5 invalid Narrative semantic state — PASS by proving the existing governed release chain already revalidates semantic Writer output; no duplicate validator was required.

Do not reopen the PF architecture unless new direct evidence proves a material defect.

## Selected integrated regression checkpoint

The selected integrated suite was run after PF closure:

- tests: 260
- pass: 231
- fail: 29

The failures were clustered by root cause rather than treated as 29 independent product defects.

### Closed regression family 1 — `score-components.js` structural repair

A local manual edit had accidentally placed the PF-04 test block inside production `calculateEvidenceConfidence()`, and PF-01 image logic referenced `sourceComplete` without its declaration.

The production file was repaired so:

- the misplaced test block is removed from production code;
- `sourceComplete` is declared from `site.sourceStatus === SOURCE_STATUS.AVAILABLE`;
- PARTIAL observed image defects remain score-bearing;
- PARTIAL clean subsets do not establish whole-scope PASS credit.

Proof:

`node --test src/scoring/score-components.test.js`

- tests: 30
- pass: 30
- fail: 0

### Closed regression family 2 — PF-05 decision-scope fixture integrity

The utility-contaminated scoring test initially produced technical score `43` versus clean `39`.

Bounded diagnostics proved the difference was solely the image sub-rule:

- clean technical sub-weight assessed: 70, including image evidence;
- contaminated scoped technical sub-weight assessed: 60, with image evidence correctly removed because the fixture claimed `imageCount: 1` but supplied no page-level image object to reconcile after utility-page filtering.

The exploratory `decisionCapabilities` change in `vantage-score.js` did not alter the result and was removed.

The test fixture was corrected by adding the actual commercial image to `commercialPage()`, preserving the PF-05 invariant rather than weakening the assertion.

Proof:

`node --test src/scoring/decision-scope.test.js`

- tests: 5
- pass: 5
- fail: 0

### Closed regression family 3 — Judge prompt-version fixture drift

Three regression helpers still hard-coded `judgePromptVersion: "2.0.0"` even though the governed prompt version is `2.1.0`.

Files corrected:

- `src/narrative-v2/judge-contract.test.js`
- `src/narrative-v2/live-binding.test.js`
- `src/report/render-narrative-v2.test.js`

Proof:

`node --test src/narrative-v2/judge-contract.test.js src/narrative-v2/live-binding.test.js src/report/render-narrative-v2.test.js`

- tests: 27
- pass: 27
- fail: 0

Do not rerun the full 260-test suite until the remaining known stale regression families are repaired.

## Remaining known regression families

From the prior integrated run, the known unresolved families are:

1. `CONTRACT-CLOSURE-01` through `CONTRACT-CLOSURE-05` — test helper builds WriterInput without newly required `decisionEvidence`.
2. `WRITER-OUT-01` and `WRITER-OUT-06` — old valid-output fixture prose now violates the deterministic semantic-fidelity rule against unmeasured business outcomes stated with causal certainty.
3. `T-GATE-INT-02` — old fixture root cause disagrees with the governed Conversion-First action hierarchy.
4. `CR-26` / `CR-44` — competitor fixtures predate the supplied-competitor allowlist and no longer reach the governed comparison branch.
5. `CR-43` — frozen render hashes changed and require explicit no-fabrication review before re-freezing.
6. Four `vantage-score.test.js` assessed-weight expectations — likely stale relative to PF-01/PF-02 fractional assessed-weight semantics; classify before editing and do not update merely to silence failures.

Treat each remaining group as one bounded failure family. Separate genuine product defects from stale test contracts before any edit.

## Process correction for regression cleanup

Use failure-family clustering rather than sequentially debugging every failing test.

For each family:

1. identify the shared root cause;
2. classify it as production defect, stale fixture/contract, or intentional frozen-output change;
3. make the smallest coherent edit;
4. run one family-level proving test;
5. stop for the result;
6. rerun the full selected suite only after all known families are addressed.

The existing maximum-three-attempt diagnostic reset remains in force. Do not broaden investigation after a boundary is already proven.

## Exact next action

Inspect only the fixture constructor at the top of:

`C:\Users\kulba\Desktop\vantage-platform\services\worker\src\narrative-v2\contract-closure.test.js`

Run:

```powershell
$i = 0
Get-Content src/narrative-v2/contract-closure.test.js | ForEach-Object {
  $i++
  if ($i -ge 1 -and $i -le 80) {
    "{0,4}: {1}" -f $i, $_
  }
}
```

Then repair the entire five-test `CONTRACT-CLOSURE-01` through `CONTRACT-CLOSURE-05` family in one bounded fixture edit if the displayed helper confirms the missing `decisionEvidence` input.

Proving test after that edit:

```powershell
node --test src/narrative-v2/contract-closure.test.js
```

Stop for the result before moving to another failure family.
