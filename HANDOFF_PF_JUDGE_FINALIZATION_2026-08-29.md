# PRYSM Handoff — PF Judge / Finalization Continuation

Date: 2026-08-29
Status: Active handoff

## Repository authority

Context repository:
`chriskulbaba2025/prysm-project-context`

Application repository:
`chriskulbaba2025/vantage-platform`

Application branch:
`main`

Last verified remote application checkpoint:
`90916e94f6feba73e7e60df54bd641bb2362454c`
`test(prysm): repair CI regression baselines`

The local application working tree is intentionally dirty and contains the uncommitted PF repair package. Do not reset, clean, checkout-overwrite, or discard it.

No application commit, push, deploy, provider recollection, production rerun, or paid Writer/Judge call was performed during the PF-09 through PF-15/PF-17 continuation.

## Read first in the next chat

```text
PROJECT.md
GITHUB_PROJECT_MEMORY_PROTOCOL.md
REPAIR_BOUNDARY_PROTOCOL.md
DIAGNOSTIC_EVIDENCE_PROTOCOL.md
WORKFLOW_INSTRUCTIONS.md
TERMINOLOGY.md
CURRENT_STATE.md
CONSTRAINTS.md
DECISIONS.md
CONVERSION_FIRST_V4_2.md
HANDOFF_PF_REPORT_INTEGRITY_REPAIR_2026-08-28.md
HANDOFF_PF_JUDGE_FINALIZATION_2026-08-29.md
```

Treat GitHub as authoritative. Do not reconstruct durable state from older chats.

## Frozen TBK baseline

Audit:
`9714c206-8ed3-4686-8fe2-ceeca0ca0f82`

Target:
`https://www.tbkcreative.com/`

Frozen governed fixture:
`C:\Users\kulba\Desktop\vantage-platform\services\worker\test-fixtures\report-replay\audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82\governed`

Do not recollect providers or mutate frozen raw/normalized/canonical evidence.

## PF repair status

Closed / PASS:
- PF-01 — PARTIAL is not complete assessment.
- PF-02 — cross-capability scoring isolation.
- PF-03 — negative finding certainty.
- PF-04 — preserve field-specific evidence certainty.
- PF-05 — denominator and decision-scope integrity.
- PF-06 — deterministic renderer certainty parity.
- PF-07 — Conversion-First consumer parity.
- PF-08 — remove stale root-cause authority.
- PF-17 — exact deterministic section filters.
- PF-09 — deterministic action-plan effort/order.
- PF-10 — supplied competitor allowlist.
- PF-11 — competitor capability viability.
- PF-12 — deterministic Narrative evidence-fidelity validator.
- PF-13 — neutral Narrative required-field state.
- PF-15 — Writer source-status reference completeness.

Still open — exactly three repair items:
1. PF-14 — safe Judge locking.
2. PF-16 — contract/version integrity.
3. PF-18 — stronger finalization gate.

After these three are green, the remaining work is verification rather than additional planned PF repair:
- selected regression suite;
- frozen deterministic TBK rebuild;
- offline/browser report acceptance;
- explicit approval before any fresh paid Writer/Judge run.

## Recent PF implementation details

### PF-17 — exact deterministic section filters — PASS

`src/report/report-detail-sections.js`

`performanceDetailSection()` now uses the exact `performance` module boundary rather than the broad `technical_performance` dimension, preventing unrelated metadata/headings/security findings from entering “Material performance findings.”

Proof:
```text
PF-17 exact deterministic performance filter: PASS
```

### PF-09 — deterministic action-plan effort/order — PASS

`src/narrative-v2/writer-input.js`
- deterministic conversion-influence projection now carries `action.effort`.

`src/narrative-v2/writer-prompt.js`
- Writer is explicitly bound to `deterministicAnalysis.conversionInfluence` order;
- `actionPlan.priority` must equal governed rank;
- `actionPlan.effort` must equal governed effort;
- Writer may not independently infer effort.

Proof:
```text
PF-09 deterministic action order and effort contract: PASS
```

### PF-10 — supplied competitor allowlist — PASS

`src/scoring/report-model.js`
- client-facing competitor comparison accepts a supplied-competitor allowlist and filters competitor results to those exact URLs;
- discovered SERP opportunity candidates/gaps are not projected into client-facing competitor claims.

`src/scoring/vantage-score.js`
- both competitor comparison branches pass `input.competitors`.

`src/report/render-report-v2.js`
- report renderer consumes sanitized `model.competitors?.opportunities`, not raw `model.competitorOpportunities`.

Proof:
```text
PF-10 supplied competitor allowlist: PASS
```

### PF-11 — competitor capability viability — PASS

`src/scoring/report-model.js`
- missing service evidence → `Not Assessed` rather than `Light`;
- missing CTA evidence → `Not Assessed` rather than `Light`;
- missing trust evidence → trust/EEAT `Not Assessed`;
- missing form/CTA evidence → path clarity `Not Assessed`;
- valid positive page-count evidence can still support content-depth labels.

The first proving attempt exposed a narrow runtime precondition: `scoreTrust(site)` expects `site.trust` and `site.socialLinks`. The final repair guards that call rather than broadening the investigation.

Proof:
```text
PF-11 competitor capability viability: PASS
```

### PF-12 — deterministic Narrative evidence-fidelity validator — PASS

`src/narrative-v2/writer-output.js`

`validateWriterOutput()` now invokes a deterministic semantic-fidelity validator before Judge execution can proceed. It rejects/prevents the known unsafe classes:
- PARTIAL evidence converted into unqualified absence;
- unmeasured commercial outcomes stated with causal certainty;
- non-AI evidence converted into established AI-search limitations;
- action priority/effort/order contradictions against `deterministicAnalysis.conversionInfluence`.

Proof:
```text
PF-12 deterministic Narrative evidence-fidelity validator: PASS
```

### PF-13 — neutral Narrative required-field state — PASS

`src/narrative-v2/writer-prompt.js`

Writer rule 8 now explicitly states that required negative-shaped fields do not require negative findings. `content.importantGaps`, `conversion.constraints`, `seoSerp.constraints`, `aiSearch.constraints`, `eeatTrust.proofGaps`, and `competitors.disadvantages` may use neutral evidence-bounded INTERPRETATION when no material negative condition is established.

The first proving test was wrong because it treated the structured schema’s existing word-count regex as a negative-content restriction. No source change was made for that test failure; corrected proof passed.

Proof:
```text
PF-13 neutral required-field state: PASS
```

### PF-15 — Writer source-status reference completeness — PASS with no source change

`src/narrative-v2/writer-input.js` already enumerates every key in `scoreGovernance.sourceDependencies` and creates an exact `source:<key>` reference of kind `source-status`.

The first proof used a brittle text slice and failed as a test artifact. The corrected structural proof passed. No production-code edit was required.

Proof:
```text
PF-15 Writer source-status reference completeness: PASS
```

## Known local PF source units changed

```text
services/worker/src/scoring/score-components.js
services/worker/src/scoring/vantage-score.js
services/worker/src/scoring/score-components.test.js
services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js
services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.test.js
services/worker/src/scoring/decision-scope.js
services/worker/src/scoring/decision-scope.test.js
services/worker/src/scoring/report-model.js
services/worker/src/report/report-detail-sections.js
services/worker/src/report/render-report-v2.js
services/worker/src/narrative-v2/writer-input.js
services/worker/src/narrative-v2/writer-scores.js
services/worker/src/narrative-v2/writer-prompt.js
services/worker/src/narrative-v2/writer-output.js
```

This list does not authorize reverting or rewriting any other dirty-tree work.

## Exact next action — PF-14

At the start of the next chat, verify local state once without cleaning:

```powershell
cd C:\Users\kulba\Desktop\vantage-platform\services\worker
git status --short
git rev-parse HEAD
```

Then perform the Mandatory Pre-Edit Gate for **PF-14 — safe Judge locking**.

Target behavior:
A field containing an unresolved material defect must not be treated as locked/clean or excluded from the next targeted Writer rewrite merely because the Judge emitted a locking directive.

Bounded investigation only:
- exact current Judge response contract/validator;
- deterministic Judge model-output normalization;
- revision-directive derivation/locking boundary;
- directly coupled pre-Writer targeted-revision validator only if required.

Do not redo the broad Narrative architecture investigation.

Use the shortest source query needed to identify:
- `fieldsToRewrite`;
- `fieldsLocked`;
- `defectIds`;
- `revisionDirective`;
- `normalizeJudgeModelOutput`;
- `validateJudgeResponse`.

Once the exact boundary is proven:
1. choose the smallest coherent source-file unit;
2. give exact Windows path;
3. give exact current start/finish lines and anchors;
4. provide the complete replacement block;
5. run one highest-information PF-14 proving test;
6. stop for the user’s result.

After PF-14 is green, continue PF-16, then PF-18.

## Active implementation discipline

- GitHub context is authoritative.
- Diagnose before coding; no guessing.
- Do not repeat the completed CF-01 or broad PF architecture investigation.
- One governed source-file unit at a time.
- Smallest proven coherent edit.
- One highest-information proving test, then move on if green.
- Maximum three unsuccessful attempts on the same observable issue before deeper diagnostic reset.
- Exact path, exact current lines/ranges and anchors, complete replacement blocks.
- Multiple edits are presented bottom-up.
- Source code is delivered directly in the conversation, never as a download.
- Preserve dirty-tree work and frozen evidence.
- No paid provider/model call, production audit, deploy, application push, configuration mutation, or persisted production mutation without explicit approval.
- Do not lower Narrative release thresholds, evidence-fidelity requirements, hard gates, dimension floors, major-defect protections, pass limits, or human-authorization requirements.
