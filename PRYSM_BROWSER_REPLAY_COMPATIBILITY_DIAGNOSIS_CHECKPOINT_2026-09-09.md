# PRYSM Browser Replay Compatibility Diagnosis Checkpoint — 2026-09-09

## Result

`NEW_PRODUCTION_SHAPED_RUN_REQUIRED`

## Exact application candidate

- Repository: `chriskulbaba2025/vantage-platform`
- Branch: `review/prysm-solution-directive-authority-betty`
- Exact SHA: `c6c814613bb403705b9711466ebc223e3a4837e2`
- Production baseline on `main`: `4202ed684754c382160289c801b83e654d697a69`
- Production remains unchanged.

## Root cause

The frozen TBK replay contains historical ScoreSet 1.0.0, findings, WriterInput, and Writer/Judge orchestration artifacts. Current deterministic scoring can derive a ScoreSet 2.0.0 and current findings from the frozen persisted evidence, but the derived values and finding identities differ from the historical derived artifacts. The persisted Writer/Judge records therefore fail current identity, version, reference, governed-order, and semantic validation. A legitimate current browser artifact cannot be produced from the frozen fixture alone without obtaining a new current Writer/Judge release candidate.

This is a replay-evidence currency problem, not a proven Canonical Remediation Authority Closure product defect.

## What can remain frozen and unchanged

The following persisted evidence inputs remain usable, subject to current schema validation:

- `governed/canonical/audit-request.json`
- `governed/canonical/decision-evidence.json`
- `governed/canonical/capability-evidence.json`

These are governed evidence inputs and do not need provider/model calls to reuse.

## What must be deterministically regenerated

Using current code and the frozen evidence inputs, the following derived artifacts must be regenerated together:

- `governed/canonical/findings.json`
- `governed/canonical/scores.json` as ScoreSet 2.0.0
- `governed/report-v2/narrative-v2/writer-input.json`

The diagnosis proved that replacing only `scores.json` is invalid because it would leave findings, finding IDs, hierarchy, root cause, WriterInput projections/referenceIndex, and persisted Writer/Judge references inconsistent.

## Writer/Judge boundary

The historical orchestration artifacts cannot be retained as valid current release evidence:

- `governed/report-v2/narrative-v2/orchestration.json`
- `governed/report-v2/narrative-v2/orchestration-final-pass.json`

Current validation against regenerated WriterInput fails due to current contract/prompt-version requirements, changed finding/root-cause references, governed-order differences, and current grounding requirements.

A current validated Writer/Judge release candidate cannot be deterministically synthesized or relabelled. It requires a legitimate Writer/Judge execution through the normal governed path.

## Canonical solution path

A legitimate current browser artifact must use the current production path:

1. load and validate current findings + ScoreSet;
2. `prepareCanonicalSolutions()`;
3. `buildSolutionAuthorityRecords()`;
4. `buildSolutionDirectiveInput()`;
5. `generateCanonicalSolutions()`;
6. inject `canonicalSolutions` into current report-model hydration;
7. run finalization;
8. render through `renderGovernedNarrativeReportV2()`;
9. persist/read back/hash-validate the current generated HTML.

The existing replay script does not currently prove this clean canonical path because its current replay model does not inject `canonicalSolutions` and it still contains a stale `id="narrative-layer"` structural assertion. `--legacy-compat` is not acceptable browser evidence.

## Required validations before browser acceptance

Before browser review can be treated as legitimate current evidence, all of the following must pass:

- current AuditRequest validation;
- current DecisionEvidence validation;
- current CapabilityEvidence validation;
- deterministic current score/finding derivation;
- current ScoreSet 2.0.0 validation;
- finding ID / hierarchy / root-cause consistency;
- deterministic current WriterInput construction;
- current WriterOutput validation;
- current JudgeResponse validation;
- matching references, versions, governed order, pass identity, and final release status;
- current finalization gate;
- canonical provider -> resolver -> generator preparation;
- current report-model hydration with canonical solutions;
- current renderer execution;
- current structural assertions and persisted HTML read-back/hash validation;
- no Writer metadata/remedy authority leakage;
- local HTTP browser review of the generated current artifact.

## Preservation

The diagnosis reports:

- application HEAD remained `c6c814613bb403705b9711466ebc223e3a4837e2`;
- branch remained `review/prysm-solution-directive-authority-betty`;
- application worktree remained clean;
- no application/fixture/test files were changed;
- no provider/model/network calls were made;
- no audit rerun occurred;
- no deployment, production mutation, reset, clean, stash, rebase, commit, push, or main merge occurred.

## Governance consequence

Browser review is now blocked on one material dependency: a **new current production-shaped TBK Writer/Judge release-candidate run** using the frozen evidence inputs plus deterministically regenerated current derived artifacts.

Current governance still prohibits release provider/model execution without explicit authorization. Therefore no Writer/Judge model execution is authorized by this checkpoint itself.

## Exact next gate

Obtain explicit human authorization for one bounded current TBK Writer/Judge release-candidate execution. After authorization, run only the minimum current governed path required to regenerate current ScoreSet/findings/WriterInput, obtain current validated Writer/Judge orchestration, generate canonical solutions through the current production authority path, render the current artifact locally, and stop for browser human review. Do not deploy, mutate production, rerun the audit providers, or merge `main`.
