# PRYSM Narrative v2 Uncertain-Transport Recovery — Sol Preflight 3 Checkpoint

Date: 2026-09-09

Application repository: `chriskulbaba2025/vantage-platform`

Branch: `review/prysm-solution-directive-authority-betty`

Exact local candidate reviewed: `760d546c02e892360165497801d25a94cbcb941c`

Published remote review base remains: `c6c814613bb403705b9711466ebc223e3a4837e2`

## Result

**REPAIR_REQUIRED**

Confidence: **HIGH**

Worktree at preflight: CLEAN

Model/provider application calls: 0

Source/test changes during preflight: NONE

Push/deployment/production mutation/main merge: NONE

## Four original blockers

1. Durable recovery authorization authenticity — **CLOSED**.
2. Exact execution-scope binding — **CLOSED**.
3. Non-spoofable durable-store capability — **CLOSED**.
4. Generic post-response restart integration — **OPEN**, narrowed to two defects in `services/worker/src/narrative-v2/live-binding.js`.

## Blocking defects

### 1. Resumable POST_RESPONSE_LOCAL_FAILURE is rejected before deterministic resume

Normal Writer/Judge invocation now reaches `invoke()` and checks durable state before a new reservation/fetch. However, the current pre-reservation branch rejects every persisted result with `validationResult === "FAIL"` before `resumePersistedCall()` can run.

`persistReturnedFailure()` records legitimate `POST_RESPONSE_LOCAL_FAILURE` entries with `validationResult: "FAIL"`. Therefore a valid persisted provider response plus a local post-response failure is treated as terminal rather than resumable.

Required repair: distinguish resumable `POST_RESPONSE_LOCAL_FAILURE` / `RESPONSE_RETURNED` states from terminal returned-provider/recovery failures before the generic failed-result rejection.

### 2. Persisted response identity/digest binding is incomplete

`resumePersistedCall()` checks reservation identity and some result/content relationships, but it does not independently prove the persisted response bytes against the stored response-state digest, and response/response-meta artifacts are not independently bound to the active audit/execution scope.

Required repair: before normalization or deterministic continuation, verify the exact persisted response bytes against the stored SHA/digest and verify response-state/response-meta identity against auditId, executionId, reservation/call, role/pass, model, and request identity where represented by the frozen contract.

Cross-execution or tampered response substitution must fail closed with zero provider calls.

## What remains PASS

- normal restart dispatch exists before reserve/fetch;
- `RESPONSE_RETURNED` restart works in the covered fixture with zero provider calls;
- completed-result restart works in the covered fixture with zero provider calls;
- no provider fallback after persisted-recovery failure;
- uncertain-transport governance remains fail-closed;
- durable human authorization remains authenticated;
- one-recovery limit and duplicate protection remain PASS;
- execution binding remains PASS for authorization/reservation recovery;
- cost accounting and call ceilings remain PASS;
- durable-store capability remains PASS;
- secret sanitization remains PASS;
- canonical authority, scoring/evidence, Writer/Judge semantics, and report/renderer preservation remain PASS.

## Test gaps to close

Add deterministic mocked tests proving:
- normal restart from a legitimate `POST_RESPONSE_LOCAL_FAILURE` resumes from exact persisted response with zero fetch/provider calls;
- returned-provider and recovery-terminal failures remain blocked;
- tampered persisted response bytes are rejected by digest verification;
- response/response-meta substitution across audit/execution is rejected;
- wrong reservation/model/role/pass/request identity is rejected;
- invalid Writer/Judge persisted response fails closed;
- no provider fallback occurs on any failed persisted-response validation.

## Current authorization state

No Writer/Judge/model/provider call is authorized.

No TBK orchestration, audit-provider rerun, push, deployment, production mutation, or main merge is authorized.

The existing bounded recovery implementation authorization covers this final repair because it remains inside the previously approved Narrative v2 recovery contract and directly affected tests only.

## Exact next action

At exact local candidate `760d546c02e892360165497801d25a94cbcb941c`, implement a bounded test-first repair in `services/worker/src/narrative-v2/live-binding.js` and directly affected recovery tests only: (1) distinguish resumable `POST_RESPONSE_LOCAL_FAILURE`/`RESPONSE_RETURNED` from terminal provider/recovery failure states before failed-result rejection; and (2) cryptographically and scope-bind persisted response/state/meta identity before deterministic resume. Prove zero provider calls on all restart paths, rerun focused and relevant regressions plus full worker suite and `git diff --check`, create one local candidate if green, produce a Downloads proof, and STOP for another independent Sol High preflight. Do not call models/providers, push, deploy, merge main, rerun audit providers, or mutate production.
