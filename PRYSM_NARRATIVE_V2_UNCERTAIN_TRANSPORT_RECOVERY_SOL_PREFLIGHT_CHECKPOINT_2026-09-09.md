# PRYSM Narrative v2 Uncertain-Transport Recovery Sol Preflight Checkpoint — 2026-09-09

## Result
`REPAIR_REQUIRED`

Confidence: HIGH

Exact local application candidate reviewed:
`5bc26db3c9e909cca33526b3ac308b7fce55612d`

Base/published review SHA:
`c6c814613bb403705b9711466ebc223e3a4837e2`

Branch:
`review/prysm-solution-directive-authority-betty`

Worktree: CLEAN
Remote review SHA unchanged: `c6c814613bb403705b9711466ebc223e3a4837e2`

No model/provider calls, source edits, commits, pushes, deployments, or production mutation occurred during the Sol preflight.

## Blocking defects

1. **Durable recovery authorization is not authenticated.**
   - `authorizeTransportRecovery` persists an authorization artifact, but `reserveCall` validates only caller-supplied recovery fields.
   - It does not reload the durable recovery artifact, verify `authorizationSha256`, or prove the object came from the governed authorization function.
   - A forged caller object with matching live artifact hashes could satisfy the recovery predicate without a valid durable human authorization record.

2. **Recovery execution identity is not bound to the registered scope.**
   - The recovery authorization accepts an `executionId` that is not compared with `scope.executionId`.
   - This permits cross-execution recovery metadata if other hashes happen to match.

3. **Memory-only live-release prohibition is spoofable.**
   - The current durability guard trusts a mutable `storageBackend` string.
   - A memory-backed wrapper can claim `storageBackend="local"` and pass the live-release durability check without durable semantics.
   - The approved durability boundary therefore is not capability-authenticated.

4. **Post-response deterministic recovery is incomplete.**
   - Returned failure/malformed-response branches persist response material, but there is no complete general governed resume path that consumes persisted response or `POST_RESPONSE_LOCAL_FAILURE` artifacts without another provider request.
   - Existing special Writer pass-3 restart logic is not sufficient for the approved generic recovery contract.

## Additional observations
- Recovery state constants exist, but `RESPONSE_RETURNED` is not durably recorded as a distinct transition and `RECOVERY_FAILED` is never persisted.
- Existing tests are green but insufficient for authorization authenticity, execution-ID binding, response-restart continuation, completed-result reuse, tamper rejection, cross-process concurrent recovery, and non-spoofable durability.

## Preservation
The preflight found no changes to canonical remediation authority, scoring/evidence semantics, Writer/Judge semantic contracts, report renderer, report architecture, or provider/model selection.

## Required repair boundary
Remain inside the existing approved recovery surface:
- `services/worker/src/narrative-v2/live-binding.js`
- `services/worker/src/narrative-v2/orchestrator.js` only if required for deterministic response continuation/lineage
- live/release artifact-store capability/composition surface only as required to make durability non-spoofable
- directly affected deterministic tests

Do not broaden into scoring, evidence, canonical solutions, renderer/report, provider/model selection, or audit providers.

## Required repair outcomes
- Recovery must authenticate the exact persisted immutable authorization artifact and verify its hash/identity before reserving a recovery call.
- Recovery authorization must bind to the exact registered execution/audit scope.
- Durable live-release capability must be non-spoofable by ordinary caller mutation/wrapping.
- Persisted returned responses and post-response local failures must have a complete deterministic resume path requiring zero provider calls.
- Add adversarial tests for authorization forgery/tamper, execution mismatch, durability spoofing, returned-response restart, completed-result restart, recovery replay, and relevant budget/concurrency cases.

## Authorization state
No Writer/Judge/model execution is authorized.
No new clean TBK orchestration is authorized.
No push, deploy, production mutation, provider rerun, or main merge is authorized.

## Exact next action
Perform a bounded test-first implementation repair against local candidate `5bc26db3c9e909cca33526b3ac308b7fce55612d` to close the four Sol-identified blocking defects above. Use mocked/deterministic execution only. Rerun focused, broader Narrative/storage/production-path, and full worker regressions. Produce a Downloads proof and stop for a second independent preflight. Do not make any Writer/Judge/model/provider call, push, deploy, merge main, or mutate production.
