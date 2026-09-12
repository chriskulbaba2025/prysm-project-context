# PRYSM Handoff — Plane 3 Harness Hardening

Date: 2026-09-11  
Project: PRYSM  
Authoritative context: `chriskulbaba2025/prysm-project-context`  
Application: `chriskulbaba2025/vantage-platform`

## Purpose

Continue the Model-Bearing Release Gate without reconstructing state from the prior chat and without repeating one-plumbing-defect-at-a-time paid-run attempts.

The next session must treat GitHub as authoritative and perform one consolidated zero-cost harness-hardening review before any further paid Plane 3 execution.

## Read first

1. `PROJECT.md`
2. `GITHUB_PROJECT_MEMORY_PROTOCOL.md`
3. `PRYSM_PERMANENT_MEMORY.md`
4. `REPAIR_BOUNDARY_PROTOCOL.md`
5. `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`
6. `WORKFLOW_INSTRUCTIONS.md`
7. `SKILLS/GOVERNED_CODING_UPGRADE.md`
8. `DECISION_PRYSM_AGENT_ROLE_GOVERNED_CODING_2026-09-10.md`
9. `CURRENT_STATE.md`
10. `CONSTRAINTS.md`
11. `DECISIONS.md`
12. `PRYSM_MODEL_BEARING_RELEASE_GATE.md`
13. `PRYSM_MODEL_BEARING_GATE_STATE.json`
14. this handoff

## Exact application checkpoint

- Exact local application candidate SHA: `8604603c789cbeb6af920467ab0a87434399692a`
- Application worktree: CLEAN at latest proof
- No push, deployment, merge, production audit resume, or Final Narrative Pass occurred after this candidate was created.
- Fresh TBK audit under investigation: `4b0b3568-19e5-4bff-a4e8-20b23f401f5e`
- Business: TBK Creative

## What is now proven

### 1. Original live pass-2 failure was recovered and diagnosed

Exact persisted Writer/Judge artifacts were recovered read-only. The original `Unauthorized Writer change outside revision directive` incident was reproduced deterministically.

The repair path established deterministic targeted Writer revision projection/enforcement and version-aware continuation compatibility. Broad deterministic closure passed before model-bearing validation began.

### 2. Deterministic closure is green

The deterministic candidate path reached:

- worker regressions: 1009 PASS / 0 FAIL
- production-path: 83 PASS / 0 FAIL
- Narrative v2: 160 PASS / 0 FAIL
- schema/contract: 14 PASS / 0 FAIL
- artifact: 106 PASS / 0 FAIL
- lifecycle: 57 PASS / 0 FAIL
- Whole-App: 90 PASS / 0 FAIL
- P-B01 through P-B16: PASS
- P-B08 exact targeted-revision branch: PASS

Do not rerun broad closure merely because the Plane 3 harness has an execution-plumbing issue. Re-run broad closure only if a later application change actually requires it.

### 3. Permanent Plane 3 model-bearing harness exists

Harness files:

- `services/worker/scripts/plane3-model-bearing.mjs`
- `services/worker/scripts/plane3-model-bearing.test.js`

It defaults to zero-call preflight and requires explicit execution authorization.

Approved validation plan is still:

- 5 independent Writer samples using `gpt-5.6-terra`
- Judge on P01, P02, P03 using `gpt-5.6-sol`
- 5 Writer + 3 Judge = maximum 8 calls
- conservative provider-spend ceiling: USD 4.44
- frozen TBK corpus only
- no crawl, recollection, rescore, or production audit mutation

No additional current-compatible real corpus cases were available. Do not fabricate additional corpus cases.

### 4. Current WriterInput reconstruction is proven

Frozen canonical artifacts reconstruct current WriterInput:

- WriterInput version: `1.2.0`
- SHA-256: `5313c1929a5bfca31d8ed7e92ade706d378c426b3dddab22d37778ea69eef7e2`

Historical WriterInput `1.0.0` is reference-only.

### 5. First genuine paid Writer sample exposed a validator false positive, not a Writer-quality failure

A real `gpt-5.6-terra` P01 call produced the bounded sentence:

> CTA clarity assesses the observed invitation, while conversion-path clarity assesses the observed route from that invitation toward the next step. Both were positively assessed in scope, without establishing completed actions or conversion performance.

The pre-repair validator incorrectly treated `without establishing ...` as an established commercial outcome.

Proven classification: `VALIDATOR_FALSE_POSITIVE`.

That validator was repaired narrowly. The same persisted response now validates successfully, while unsupported causal claims continue to fail.

Current validator SHA-256 recorded in the run manifest:

`0C702869DBAE1BA99E17A15B23F33A271AD78A6A6D894D0AF86D8BB46F0776CF`

The repair created current application candidate:

`8604603c789cbeb6af920467ab0a87434399692a`

Focused and broad deterministic verification remained green after the repair.

Historical paid P01 call cost from the earlier candidate: USD 0.137876. Preserve its raw artifacts; do not rewrite or delete them.

Historical P01 raw response SHA-256:

`7a3d95525e633a0897ff0a2612f94b6c0fe8821ffcc63f305c5fb2b9899e00b6`

### 6. Secure production runtime injection is proven

Local paid execution initially stopped because the local shell did not contain the production Narrative environment variables. This was not a product/model failure.

A safe Railway CLI local-command environment injection was then proven:

`railway run --no-local --project 9dfaead1-79d7-4582-9c58-0999a1d07b84 --environment production --service vantage-platform -- <local command>`

Target:

- Railway project: GENSEN
- environment: production
- service: vantage-platform

Safe runtime identity was proven without printing secrets:

- `PRYSM_LLM_MODE=live`
- Narrative v2 enabled
- Writer `gpt-5.6-terra`
- Judge `gpt-5.6-sol`
- max input 120000
- Writer max output 12000
- Judge max output 8000
- API key SET
- chat-completions URL SET
- price entries matched the governed manifest

Zero-call preflight through this injected runtime returned READY.

### 7. Current blocker is the harness execution identity

The latest execution stopped before a new provider call because the harness reuses an old persisted execution identity.

Proven owning file/function:

- `services/worker/scripts/plane3-model-bearing.mjs`
- `executeManifest`

Current construction:

`executionId: \`plane34-${sample.sampleId}\``

Therefore P01 always becomes:

`plane34-PRIMARY_TBK_P01`

The production live binding correctly refuses a duplicate paid Writer pass against that persisted failed reservation.

Changing only `isolatedOutputRoot` does not fix this because the executionId itself is unchanged.

No current CLI argument, manifest field, or environment variable can provide a fresh run identity.

Latest classification:

`HARNESS_EXECUTION_IDENTITY_DEFECT`

Latest attempt made:

- Writer calls: 0
- Judge calls: 0
- paid provider calls: 0
- cost: USD 0.00
- production writes: 0
- deployments: 0
- pushes: 0

The old P01 reservation and artifacts remain intact and must remain intact.

## Process correction for the next session

Do **not** immediately patch only the run ID and attempt another paid execution.

The recent sequence exposed multiple harness-plumbing gaps one at a time: current WriterInput compatibility, stale validator identity, local production-runtime injection, and now execution-ID reuse. The next session must consolidate this work so the user is not sent through another run/fail/patch loop for basic harness plumbing.

Before the next paid call, perform one bounded zero-cost **Plane 3 harness hardening audit** across the complete execution boundary:

1. unique per-run execution identity;
2. P01-P05 identity isolation within one run;
3. preserved historical reservations/results;
4. secure Railway runtime injection;
5. manifest/source/runtime identity parity;
6. fresh output namespace and no overwrite path;
7. reservation/retry/restart behavior;
8. call-ceiling enforcement;
9. cost-ceiling enforcement and cumulative accounting;
10. temporary paid-authorization scoping/cleanup;
11. failure-stop behavior before the next sample;
12. raw response/result-ledger preservation;
13. preflight proving zero provider calls;
14. execution proving no production audit mutation;
15. post-run worktree/repository integrity.

The review should identify all remaining harness-only defects in one pass. If a coherent harness repair is required, freeze one bounded repair scope, implement it once, run focused harness tests, and prove a fresh unused execution namespace before asking for new paid authorization.

Do not automatically rerun the full Whole-App/closure suite for a harness-only interface repair unless direct evidence shows application behavior outside the harness was touched.

## Exact next action

Run a consolidated **zero-cost Plane 3 harness-hardening audit** against exact application SHA `8604603c789cbeb6af920467ab0a87434399692a`.

The audit must start from the proven execution-identity defect above and inspect all remaining execution-plumbing boundaries listed in this handoff before any source edit or paid call.

Expected outcome:

- either `HARNESS_HARDENING_SCOPE_PROVEN` with one coherent repair boundary;
- or `HARNESS_READY_WITHOUT_FURTHER_REPAIR` if no additional repair is actually required.

Do not make a paid model call during this audit.

## Authorization state

The previous paid Plane 3 authorization applied to exact application SHA `8604603c789cbeb6af920467ab0a87434399692a`, but it was not consumed by the latest harness attempts because they made zero new provider calls.

If the harness source changes, the application SHA will change and a **fresh explicit paid authorization is required for that new exact SHA** before any Writer/Judge execution.

Not authorized during the next harness-hardening audit:

- paid Writer/Judge calls
- crawls
- evidence/provider recollection
- rescoring
- audit resume
- Final Narrative Pass
- production writes
- push
- deployment
- merge

## Release-gate position

Planes 1-2 deterministic/replay foundations are substantially closed for this candidate path.

Plane 3 has **not** passed. It is currently blocked by validation-harness execution plumbing before a clean 5-Writer / 3-Judge sample can run.

Plane 4 has not been completed because a valid five-sample Writer set has not yet been produced.

Plane 5 independent semantic challenge has not begun.

Planes 6-7 deployment identity and final production confirmation have not begun for this candidate.

Do not claim PRYSM is ready to deploy/live-test until these remaining release gates are actually closed.

## User direction

The user explicitly wants fewer repeated micro-gates and more real forward progress. The next session should consolidate related harness checks before asking for another paid run. Avoid another sequence of one plumbing defect per attempt.

Betty is not a PRYSM gate.
