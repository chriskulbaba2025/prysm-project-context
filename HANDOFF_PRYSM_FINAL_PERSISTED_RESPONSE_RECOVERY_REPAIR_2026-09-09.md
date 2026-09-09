# PRYSM New-Chat Handoff — Final Persisted-Response Recovery Repair

Date: 2026-09-09

## Authority
Treat this GitHub repository as authoritative. Do not reconstruct state from the previous chat.

Application repository: `chriskulbaba2025/vantage-platform`

Governance/context repository: `chriskulbaba2025/prysm-project-context`

Local application root: `C:\Users\kulba\Desktop\vantage-platform`

Worker: `C:\Users\kulba\Desktop\vantage-platform\services\worker`

Application branch: `review/prysm-solution-directive-authority-betty`

Current exact local candidate: `760d546c02e892360165497801d25a94cbcb941c`

Published remote review SHA: `c6c814613bb403705b9711466ebc223e3a4837e2`

Production baseline on `main`: `4202ed684754c382160289c801b83e654d697a69`

Production remains unchanged.

## Read first in the new chat
1. `CURRENT_STATE.md`
2. `HANDOFF_PRYSM_FINAL_PERSISTED_RESPONSE_RECOVERY_REPAIR_2026-09-09.md`
3. `PRYSM_NARRATIVE_V2_UNCERTAIN_TRANSPORT_RECOVERY_SOL_PREFLIGHT_3_CHECKPOINT_2026-09-09.md`
4. `PRYSM_NARRATIVE_V2_PERSISTED_CALL_RESTART_INTEGRATION_CHECKPOINT_2026-09-09.md`
5. `PRYSM_NARRATIVE_V2_UNCERTAIN_TRANSPORT_RECOVERY_SOL_PREFLIGHT_2_CHECKPOINT_2026-09-09.md`
6. `PRYSM_NARRATIVE_V2_UNCERTAIN_TRANSPORT_RECOVERY_REPAIR_CHECKPOINT_2026-09-09.md`
7. `PRYSM_NARRATIVE_V2_UNCERTAIN_TRANSPORT_RECOVERY_CONTRACT_DESIGN_CHECKPOINT_2026-09-09.md`
8. `PRYSM_CANONICAL_REMEDIATION_AUTHORITY_CLOSURE_GATE_2026-09-09.md`
9. `PRYSM_MODEL_ROUTING_AND_WHOLE_SYSTEM_PREFLIGHT_PROTOCOL_2026-09-09.md`
10. `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`
11. `REPAIR_BOUNDARY_PROTOCOL.md`
12. `WORKFLOW_INSTRUCTIONS.md`

## Product state
PRYSM remains close to a team-showable MVP. Canonical remediation authority is already closed and green.

Governing invariant:

**Canonical solutions are the sole source of client remediation anywhere in the final client artifact.**

Priority Fixes remains the sole complete remedy owner.

Previously verified:
- canonical closure focused suite: 112/112 PASS;
- full worker baseline: 1009/1009 PASS;
- canonical authority Sol preflight: REAL PROGRESS — YES / HIGH / READY_FOR_BROWSER_REVIEW;
- deterministic current TBK packet finalization: PASS / 0 errors;
- no audit-provider rerun required for the deterministic packet.

## Historical failed TBK orchestration
One previously authorized TBK Writer/Judge run was consumed:
- Writer 1 completed and validated;
- Judge 1 completed and validated and requested REVISE;
- Writer 2 failed after paid-call reservation with `fetch failed`;
- the historical run is unrecoverable because its live reservation/result/orchestration ledger was stored in process-local memory and disappeared on exit.

Do not retry or reconstruct that historical execution.

## Recovery architecture progression
Recovery diagnosis result: `APPLICATION_RECOVERY_DEFECT_FOUND`.

Recovery design result: `CURRENT_TBK_CASE_UNRECOVERABLE_BUT_GENERAL_REPAIR_READY`.

Future governed uncertain-transport recovery action remains:
`REISSUE_SAME_PASS_AFTER_HUMAN_AUTHORIZATION`.

Recovery implementation progressed through:
- first candidate `5bc26db3c9e909cca33526b3ac308b7fce55612d`;
- repair candidate `dea764964800dde03238c925c86fdd44b7eccd3f`;
- persisted-call restart integration candidate `760d546c02e892360165497801d25a94cbcb941c`.

## Current third-Sol result
Third independent Sol High preflight result: `REPAIR_REQUIRED` / HIGH confidence.

All major recovery boundaries are now closed except two final defects.

Closed and preserve:
- durable human authorization authenticity;
- authorization hash validation;
- exact audit/execution binding;
- non-spoofable filesystem/object-store durability capability;
- normal persisted-state check before fresh reservation/fetch;
- normal `RESPONSE_RETURNED` restart for covered fixture;
- completed-result restart for covered fixture;
- no provider fallback after persisted-recovery validation failure;
- uncertain transport governance;
- one-recovery limit;
- duplicate protection;
- request/model/role/pass/WriterInput/Judge lineage checks;
- conservative cost accounting;
- total call ceiling;
- automatic semantic pass ceiling unchanged;
- secret sanitization;
- canonical authority preservation;
- scoring/evidence preservation;
- Writer/Judge semantic preservation;
- report/renderer preservation.

## Two remaining blocking defects
### 1. Resumable POST_RESPONSE_LOCAL_FAILURE is rejected too early
`persistReturnedFailure()` can persist a legitimate local-after-response failure using `validationResult: "FAIL"`.

The current `invoke()` pre-reservation path rejects failed persisted results before `resumePersistedCall()` can consume the already-returned provider response.

Required repair:
- distinguish a valid resumable `POST_RESPONSE_LOCAL_FAILURE` / `RESPONSE_RETURNED` condition from terminal returned-provider/recovery failure;
- allow only the valid persisted-response case into deterministic recovery;
- terminal and unknown states remain fail-closed;
- zero fresh reservation/fetch/provider call on deterministic restart.

### 2. Persisted response identity/digest binding is incomplete
Before deterministic reuse, the system must independently prove the persisted response belongs to the active governed call.

Required repair:
- recompute SHA-256 from exact persisted response bytes/content;
- compare against durable response-state/meta digest(s);
- bind response/state/meta to exact auditId, executionId, reservationId, callNumber, role, passNumber, modelId, and requestSha256 as represented by the current contract;
- tampered or cross-audit/cross-execution substituted response material must fail closed;
- no provider fallback after validation failure.

## Exact repair boundary
Primary source:
- `services/worker/src/narrative-v2/live-binding.js`

Direct test surface:
- `services/worker/src/narrative-v2/transport-recovery.test.js`

Do not broaden unless the code proves another source file is strictly required. If so, stop and report the boundary before changing it.

## Required new tests
Test first. Mock/block all network/provider behavior.

At minimum prove:
- normal restart from valid `POST_RESPONSE_LOCAL_FAILURE` uses persisted response and makes 0 fetch/provider calls;
- `RETURNED_PROVIDER_FAILURE` remains terminal;
- `RECOVERY_FAILED` remains terminal;
- tampered response bytes fail digest verification;
- cross-audit response substitution rejects;
- cross-execution response substitution rejects;
- wrong reservation/call/model/role/pass/request identity rejects;
- invalid persisted Writer response fails closed;
- invalid persisted Judge response fails closed;
- no persisted-recovery validation failure can fall through to fresh reserve/fetch/provider execution.

## Verification required after repair
Run:
- focused recovery tests;
- Narrative v2 regression;
- storage/artifact-store regression;
- production-path tests;
- full worker suite;
- `git diff --check`.

Require 0 failures.

Create one local candidate commit only if green. Do not push.

Required proof file:
`C:\Users\kulba\Downloads\PRYSM-NARRATIVE-V2-PERSISTED-RESPONSE-FINAL-REPAIR-PROOF.txt`

Expected successful result:
`FINAL_REPAIR_PASS`

Then STOP for another independent Sol High preflight.

## Authorization state
The existing bounded recovery implementation authorization remains applicable to this final repair because it remains within the approved recovery contract.

NOT authorized:
- Writer call;
- Judge call;
- application model/provider call;
- new TBK release-candidate orchestration;
- retry/resume of historical failed TBK run;
- audit-provider rerun;
- push;
- deploy;
- production mutation;
- main merge.

A separate explicit Chris authorization is required before any future model-backed TBK run.

## Exact next action
At exact local candidate `760d546c02e892360165497801d25a94cbcb941c`, use Luna Medium to perform the bounded test-first final persisted-response recovery repair in `live-binding.js` plus directly affected recovery tests only. Close the two defects above, rerun all required deterministic regressions, create one new local candidate if green, write the required Downloads proof, and STOP for independent Sol High preflight. No model/provider calls, push, deploy, main merge, audit-provider rerun, or production mutation.