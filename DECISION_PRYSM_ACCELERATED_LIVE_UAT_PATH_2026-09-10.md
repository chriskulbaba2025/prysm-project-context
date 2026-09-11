# PRYSM Accelerated Live UAT Path — 2026-09-10

## Decision

Chris has explicitly prioritized reaching a live human test as soon as safely possible. PRYSM will stop spending release time retrofitting the full legacy Plane 3 corpus merely to prove current WriterInput semantics.

This does **not** waive the permanent release gate or claim Plane 3 release completion. It creates a narrower **live-UAT readiness path** whose purpose is to get one clean current-format production-shaped audit through the real current scoring → WriterInput → Writer/Judge path, then make it available for Chris to test in a live/staging environment.

## Current known state

- Semantic candidate: `d7ce3cfe69d5ada8f6d4541c8a9603f17e932a97`
- Local Plane 3 tooling HEAD: `5f2c1a27cbb6eaf022fb9d61dc9a2d6c37a9c3eb`
- Current ScoreSet contract: `2.0.0`
- Current WriterInput: `1.2.0`
- Historical TBK/Reboot fixtures remain `1.0.0` WriterInput/ScoreSet artifacts and are preserved as historical evidence.
- Existing canonical evidence is sufficient to attempt an isolated current deterministic reconstruction without provider recollection.
- Chris already authorized isolated deterministic current-scoring reconstruction from existing canonical evidence, but not Writer/Judge calls, provider recollection, deployment, merge, or production mutation.

## Accelerated UAT gate

Use **TBK as the single primary current-format UAT corpus** unless a deterministic blocker proves it unusable.

The minimum path to live UAT is:

1. Reconstruct TBK in an isolated scratch store through the current production scoring boundary using existing canonical evidence only.
2. Require current ScoreSet `2.0.0`, current `decisionHierarchy`, and current WriterInput `1.2.0` from production-owned builders.
3. Compare only release-critical/material semantics needed to prove the reconstruction did not silently change the audit: scores/bands/readiness/root cause/findings/eligibility/suppression/priority/evidence status and values. Representation-only envelope differences are allowed.
4. If TBK materially changes, stop and report the exact difference. Do not spend time reconstructing Reboot merely for UAT.
5. If TBK qualifies, repair the Plane 3/UAT harness to consume the exact current-derived TBK WriterInput and fail closed on non-current versions/hashes.
6. Run focused deterministic tests and broad regression required by that harness change.
7. Stop before any Writer/Judge/model-bearing call and request one explicit bounded current-format Writer→Judge authorization.
8. After one clean current-format Writer→Judge validation, proceed to a live/staging UAT deployment authorization and give Chris the exact test URL/instructions.

## Deliberately deferred from UAT readiness

The following remain release-hardening work and are **not prerequisites to the first live human UAT**:

- proving current-format robustness across the entire historical TBK/Reboot Plane 3 corpus;
- completing 5/5 + 3/3 independent Writer samples;
- completing 3/3 Writer→Judge robustness orchestrations;
- formal Plane 4 semantic scoring;
- retrofitting Reboot solely to make old fixtures current.

Those gates remain required before final release if the permanent release protocol still requires them.

## Preservation

- No provider recollection without fresh authorization.
- No historical artifact mutation.
- No invented `decisionHierarchy`.
- No weakening WriterOutput/Judge validators.
- GA4 downstream commercial-outcome authority remains paused.
- No deployment or production mutation without fresh authorization.

## Immediate next action

Use the already authorized isolated deterministic reconstruction scope to reconstruct **TBK only** through the current scoring and WriterInput boundaries. If TBK qualifies, in the same zero-model-call run repair the UAT harness to consume the current-derived packet, add fail-closed current-version/hash assertions, run deterministic regression, and create one local commit. Stop before the first Writer/Judge call.
