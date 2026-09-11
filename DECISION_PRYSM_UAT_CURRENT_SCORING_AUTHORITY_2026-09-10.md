# PRYSM UAT Current Scoring Authority Decision — 2026-09-10

## Decision

For accelerated human UAT, the current PRYSM production scoring implementation is authoritative for the current-format TBK validation corpus.

Historical TBK ScoreSet `1.0.0` remains immutable historical evidence. It is no longer required to be semantically equivalent to the current ScoreSet `2.0.0` before UAT, because the current scoring implementation has legitimately evolved and the historical equivalence gate is now blocking validation of the current product rather than protecting it.

## Evidence for this decision

The isolated TBK reconstruction successfully produced a current ScoreSet `2.0.0`, current `decisionHierarchy`, and WriterInput `1.2.0` from the existing persisted canonical evidence with zero provider/model calls and no historical mutation.

The reconstruction preserved primary numeric scores, bands, readiness status, assessed weight, finding IDs/order, module/dimension eligibility, and suppressed-module state. Differences were concentrated in current root-cause/action wording and authority, including the current VAN-CONTENT-002 FAQ framing. Those differences are treated as current product semantics for UAT, not as a requirement to retrofit the historical snapshot.

## UAT boundary

The next UAT readiness build must use the current derivative TBK authority produced through the real current scoring path and current WriterInput builder.

It must:

- create a durable current-format TBK UAT fixture from current ScoreSet `2.0.0`, current findings, and WriterInput `1.2.0`;
- record derivation/source hashes and exact application identity;
- repair the UAT/Plane 3 harness to consume only the current-format fixture;
- fail closed on stale WriterInput versions, wrong hashes, wrong audit identity, or missing manifest;
- preserve the paused-GA4 commercial-outcome boundary;
- run deterministic focused and broad regression;
- stop before any Writer/Judge/provider/model call.

## Explicitly deferred

Not required before first human UAT:

- historical TBK semantic equivalence;
- Reboot corpus migration;
- full 5/5 + 3/3 current-format robustness sampling;
- 3/3 orchestration robustness;
- formal Plane 4 scoring.

These remain final-release hardening where required.

## Safety boundaries

This decision does not authorize:

- Writer/Judge/provider/model calls;
- provider recollection;
- production deployment;
- merge;
- production mutation;
- GA4 conversion-authority expansion.

## Next gate

Build and deterministically verify one durable current-format TBK UAT fixture and its fail-closed harness. If that passes, stop at `LIVE_UAT_PRECALL_READY`, then obtain one bounded authorization for one fresh current-format TBK Writer -> Judge validation.
