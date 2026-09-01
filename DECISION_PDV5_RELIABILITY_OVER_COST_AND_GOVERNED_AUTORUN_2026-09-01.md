# Decision: PDV5 Writer completion over cost, using existing governed autorun

Date: 2026-09-01
Status: Active

## Decision

PDV5 has one objective:

**Make a normal PRYSM audit reliably get through Writer/Narrative and complete.**

PDV5 continues through the existing governed GitHub -> PowerShell -> `tools/autorun/PRYSM-AUTORUN.ps1` -> Builder/Auditor loop.

Do not replace that operating method with an ad-hoc standalone Codex command unless the owner explicitly changes the method.

The owner explicitly prioritizes Writer/Narrative reliability over Writer/Judge call cost. Materially useful paid Writer/Judge calls are authorized.

## Scope

The active failure is audit `aab3c6f9-0cfd-44fb-a263-5c02f6834d8d`, which reached `narrative_pending` and failed on Writer pass 1.

PDV5 therefore owns only the path required to make that stage complete reliably:

`persisted evidence/scores -> WriterInput -> Writer prompt/schema -> Writer output -> normalization/validation -> bounded retry/revision if required -> Judge if required -> finalization -> completed/renderable report state`

Do not spend PDV5 on broad governance redesign, crawler redesign, scoring redesign, report styling, unrelated deployment architecture, or general product improvements unless direct evidence proves one of those is actually causing Writer/Narrative completion failure.

## Required Writer blind-spot review

Builder must inspect all material ways the Writer path can die, especially:

- prompt/validator mismatch;
- schema/validator mismatch;
- missing WriterInput context;
- AI-search/citation-readiness support;
- semantically irrelevant evidenceRefs;
- field/word/character/format limits;
- PARTIAL/UNKNOWN/UNAVAILABLE wording;
- statement-class mismatch;
- normalization damage;
- pass-1 invalid output being treated as terminal;
- missing bounded correction/retry using actual validation errors;
- corrected output not being revalidated;
- retry loops/duplicate spend;
- Judge/revision handoff failures caused by Writer contract;
- Writer-valid output failing finalization because of the same Writer contract;
- intermittent model-output failure against identical frozen production input.

## Required proof

PDV5 may not close from one green validator test.

Minimum proof:

1. exact persisted production Writer failure reproduced;
2. Writer root cause(s) proven;
3. coherent Writer repair implemented;
4. 5/5 independent Writer generations PASS on the failed TBK production-shaped WriterInput;
5. 3/3 Writer generations PASS on at least one additional real persisted WriterInput when available;
6. 3/3 complete real Writer/Judge Narrative runs against frozen production-shaped evidence reach the normal completed/renderable report state, with at least two using the failed TBK input;
7. generated outputs remain evidence-safe and meet the five semantic quality thresholds in the active protocol;
8. nearby Writer-completion failure cases are deliberately challenged;
9. existing Whole-App/Narrative regressions remain green on the exact candidate;
10. independent Auditor finds no material Writer-completion or evidence-integrity defect.

## Cost

Cost minimization must not cause a necessary Writer/Judge proof to be skipped.

Prefer repeated Writer/Judge runs against stored evidence over repeated full provider recrawls because the current defect is downstream of collection/scoring.

## Stop condition

After the Writer repair satisfies the required proof, stop at:

`READY_FOR_ONE_AUTHORIZED_LIVE_VALIDATION`

The next step is one fresh normal PRYSM audit in the app.

Do not turn PDV5 into another governance project.