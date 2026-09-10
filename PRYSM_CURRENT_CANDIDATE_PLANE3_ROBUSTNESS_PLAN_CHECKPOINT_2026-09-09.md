# PRYSM Current-Candidate Plane 3 Robustness Plan Checkpoint

Date: 2026-09-09
Status: PLAN FROZEN — WRITER-ONLY HARNESS REQUIRED — MODEL EXECUTION NOT AUTHORIZED

## Authority

Application repository: `chriskulbaba2025/vantage-platform`

Exact application candidate at diagnosis: `a2c1587aa4dfa799dab3b6b2cfbd42b384e1a893`

Application branch: `review/prysm-solution-directive-authority-betty` — historical name only; Betty is not an active gate.

Worktree at diagnosis: CLEAN.

## Current Plane 3 credit

The successful current-candidate TBK run supplies:
- 1/5 independent primary TBK Writer generation from Writer pass 1;
- 1/3 complete Writer -> Judge orchestration;
- 1 final validated release candidate.

Writer pass 2 was a governed revision and does not count as a second independent Writer sample.

## Remaining sample requirement

- Primary TBK independent Writer generations remaining: 4.
- Reboot Business Coaching independent Writer generations remaining: 3.
- Additional complete Writer -> Judge orchestration runs remaining: 2.

The first-pass Writer output from each future complete orchestration may count as one independent Writer generation. With optimal allocation, five additional Writer-only generations remain.

Minimum additional model calls: 9.

Maximum bounded exposure for the minimum remaining plan: 13 calls if both future complete orchestrations use their existing two-pass/four-call ceiling.

No Pass 3 is authorized or implied.

## Confirmed corpus

Primary:
- TBK Creative
- audit `9714c206-8ed3-4686-8fe2-ceeca0ca0f82`

Confirmed distinct additional real production-shaped input:
- Reboot Business Coaching
- audit `97d6b2c7-03b9-4530-8ea7-16557502c638`
- target `https://rebootbusinesscoaching.com/`

Second distinct additional real corpus input: NOT CONFIRMED. Do not fabricate one. Other identified TBK refresh fixtures are TBK variants and are not separate businesses.

## Execution-method diagnosis

Existing current-candidate full-orchestration executable:
`services/worker/TBK-fresh-writer-judge.mjs`

It is TBK-specific and invokes the complete orchestration. It is not parameterized for Reboot and has no Writer-only mode.

`services/worker/scripts/current-replay-controlled-narrative.js` uses controlled/mock Writer and Judge builders and is not valid live model-bearing robustness evidence.

The live binding exposes `writerExecutor`, but no checked-in governed executable/release harness currently invokes it for an isolated Writer-only robustness sample.

Therefore:

**No existing governed Writer-only execution command is available.**

Do not substitute an ad hoc `node -e` call or mock replay helper.

## Required bounded implementation

Before any further Plane 3 model execution, create a non-production governed Writer-only robustness harness that:
- accepts exactly one frozen governed WriterInput per isolated execution;
- uses the existing live binding `writerExecutor` without altering Writer/Judge semantics or model routing;
- creates a fresh execution identity;
- creates an isolated durable filesystem ledger;
- persists raw/parsed/validation/usage/cost evidence through the governed persistence path;
- records input/model/prompt/contract identities;
- performs normal cost preflight and respects existing budget ceilings;
- invokes no provider evidence recollection/recrawl/rescore path;
- writes no historical Narrative artifacts;
- has deterministic tests proving input identity, execution isolation, persistence, model/prompt/contract identity capture, validation behavior, cost-ceiling behavior, and zero provider recollection.

This is test/tooling infrastructure only. No production behavior repair is indicated by the diagnosis.

## Cost planning

Observed current-run Writer actual costs: USD `0.114492` and `0.132426`.

Observed current-run Judge actual costs: USD `0.236090` and `0.176855`.

Estimated nine-call minimum: approximately USD `1.154` to `1.399`.

Estimated thirteen-call bounded maximum: approximately USD `1.736` to `2.136`.

These are estimates only. They are not authorization. Current verified configured execution ceilings were soft USD 1, hard USD 5 per governed execution, and daily hard USD 30. Actual configured values must still be verified at execution time.

## Future per-sample evidence requirement

Record at minimum:
- exact candidate SHA;
- audit ID;
- fresh execution ID;
- isolated ledger path;
- model ID;
- prompt version;
- output/contract version;
- schema/validator identity where available;
- sample type and pass number;
- raw and parsed output hashes;
- complete validation result/errors;
- Writer/Judge result where invoked;
- token usage;
- estimated and actual cost;
- final status;
- proof of no provider recollection.

Do not share execution identities or overwrite historical artifacts.

## Stop conditions

Stop before any model call if candidate/worktree/configuration/input identity/ledger durability/budget checks fail; if required integrity fields are missing; if a provider recollection path is reached; if cost/call ceilings would be exceeded; or if an unauthorized semantic pass would be required.

A materially invalid required sample fails the model-bearing gate and must be diagnosed rather than implicitly retried.

## Current authorization state

No additional Writer/Judge/model/provider execution is authorized.

The next implementation gate also requires explicit Chris authorization before application/tooling changes are made.

## Exact next gate

Obtain explicit Chris authorization to implement and deterministically test the bounded non-production Writer-only robustness harness described above. That implementation authorization must authorize **zero model/provider calls**. After deterministic harness verification passes, freeze the exact Plane 3 execution allocation and request a separate model-call authorization.
