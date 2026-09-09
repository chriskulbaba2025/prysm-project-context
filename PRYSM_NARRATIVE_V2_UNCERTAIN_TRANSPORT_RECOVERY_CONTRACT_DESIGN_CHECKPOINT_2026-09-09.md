# PRYSM Narrative v2 Uncertain-Transport Recovery Contract Design Checkpoint — 2026-09-09

## Result
**CURRENT_TBK_CASE_UNRECOVERABLE_BUT_GENERAL_REPAIR_READY**

## Exact application candidate
- Repository: `chriskulbaba2025/vantage-platform`
- Branch: `review/prysm-solution-directive-authority-betty`
- SHA: `c6c814613bb403705b9711466ebc223e3a4837e2`

## Root defect
The Narrative v2 live binding commits an immutable paid-call reservation before fetch, but the fetch-exception path discards native transport-cause data and writes no failure/result record. Durable duplicate protection then correctly blocks blind replay. The TBK browser harness compounded this by using a process-local memory store, so the live ledger disappeared after process exit.

## Recovery design verdict
The general live-binding repair is design-ready, but the failed TBK execution itself is not recoverable because exact Writer 1 / Judge 1 reservation, response, result, pass-history, and orchestration artifacts were not durably preserved.

A future valid TBK release candidate therefore requires a **new clean orchestration after the recovery repair is implemented and separately authorized**.

## Frozen recovery states
The design defines these governed states:
1. `RESERVED`
2. `RESPONSE_RETURNED`
3. `CALL_COMPLETED`
4. `TRANSPORT_FAILED_PRE_TRANSMISSION`
5. `TRANSPORT_OUTCOME_UNCERTAIN`
6. `RETURNED_PROVIDER_FAILURE`
7. `POST_RESPONSE_LOCAL_FAILURE`
8. `RECOVERY_AUTHORIZED`
9. `RECOVERY_COMPLETED` or `RECOVERY_FAILED`

No uncertain state may silently retry, transition to completed, delete/rewrite its reservation, or evade duplicate protection.

## Selected recovery action
For future durable uncertain-transport cases, the bounded action is:

`REISSUE_SAME_PASS_AFTER_HUMAN_AUTHORIZATION`

It must:
- retain the original immutable reservation;
- create exactly one linked recovery authorization record;
- use a new monotonically increasing ledger call number while preserving the same semantic role/pass;
- preserve exact WriterInput, model, Judge revision directive, and Writer/Judge lineage;
- count conservatively against budgets and total call ceilings;
- reject a second recovery attempt.

## Transport-failure evidence contract
Persist a sanitized immutable failure record containing operational identity and safe native transport-cause fields when available, including role/pass/call/reservation/request hash/model/execution identity and sanitized cause metadata.

Never persist API keys, authorization headers, provider credentials, secret environment values, or prompt/body contents solely as transport evidence.

## Durability contract
A live release path must not rely on `createMemoryArtifactStore()` for reservation/recovery evidence.

Reservation, transport failure, raw response, result ledger, WriterInput, orchestration/pass history, and lifecycle state must be persisted through a durable governed store.

An isolated filesystem-backed governed store outside both repositories is acceptable for browser/release testing if it provides immutable write/read-back/hash verification and does not mutate production.

## Cost / call governance
- uncertain reservation estimated cost remains conservatively counted;
- recovery is an additional potential paid call and must pass budget preflight;
- uncertain fetch failure is never treated as zero cost;
- semantic Writer/Judge pass ceilings remain unchanged;
- recovery consumes an additional ledger call slot and cannot exceed the governed total call ceiling.

## Current TBK recoverability
**NO.**

The failed harness stored live-call state only in process memory. Only deterministic packet files remain. Exact Writer 1 / Judge 1 lineage cannot be reconstructed without fabrication, and Writer 2 has no persisted response/result.

The current run must not be resumed, recreated by clearing reservations, or restarted under a fresh identity as a workaround.

## Smallest implementation boundary
Primary production code:
- `services/worker/src/narrative-v2/live-binding.js`

Directly affected only if proven necessary:
- `services/worker/src/narrative-v2/orchestrator.js`
- `services/worker/src/narrative-v2/production-path.js`
- live/release artifact-store composition boundary

Tests:
- `services/worker/src/narrative-v2/live-binding.test.js`
- `services/worker/src/narrative-v2/live-revision-round.test.js`
- `services/worker/src/narrative-v2/orchestrator.test.js`
- nearest production-path recovery test
- nearest production persistence/durable-store test

## Required test coverage
The implementation must prove fail-closed behavior for:
- pre-connect/DNS failure with preserved cause;
- socket reset and timeout uncertainty;
- returned HTTP failure;
- malformed returned JSON;
- post-response local persistence failure;
- crash after reservation;
- crash after response persistence;
- restart with completed result;
- restart with uncertain reservation;
- unauthorized retry rejection;
- exactly-one authorized recovery;
- second recovery rejection;
- immutable original reservation;
- request hash / WriterInput / Judge-lineage / model mismatch rejection;
- budget and total-call ceiling enforcement;
- secret-sanitization assertions;
- durable store restart visibility;
- memory-only live release mode fails closed or is prohibited.

## Preservation
The repair must not alter canonical remediation authority, Writer/Judge semantic schemas, scoring, evidence, DecisionEvidence, CapabilityEvidence, finding IDs, ScoreSet, renderer, report architecture, provider/model selection, automatic semantic pass ceiling, or provider adapters.

## Authorization state
Not authorized yet:
- implementation of this application repair;
- any Writer/Judge/model call;
- any new TBK orchestration;
- deployment, production mutation, main merge, or audit-provider rerun.

Implementation requires explicit Chris approval.

After implementation is independently verified, a **separate explicit human authorization** is required for the new clean TBK model-backed release-candidate orchestration.

## Exact next action
Obtain explicit Chris approval for the bounded recovery-contract implementation only. Do not authorize or execute any Writer/Judge/model call as part of that implementation approval.
