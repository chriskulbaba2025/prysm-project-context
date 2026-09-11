# Current State

Project: PRYSM

## Current objective

Reach a safe live human UAT as quickly as possible. Chris has explicitly prioritized live testing over further exhaustive retrofit of the legacy Plane 3 corpus.

Current UAT authority decision: `DECISION_PRYSM_UAT_CURRENT_SCORING_AUTHORITY_2026-09-10.md`.

For accelerated UAT, the current PRYSM production scoring implementation is authoritative. Historical TBK ScoreSet `1.0.0` remains immutable historical evidence and is no longer required to be semantically equivalent to current ScoreSet `2.0.0` before first human UAT.

## Exact application checkpoint

- Application repository: `chriskulbaba2025/vantage-platform`
- Local application: `C:\Users\kulba\Desktop\vantage-platform`
- Branch: `review/prysm-solution-directive-authority-betty` (historical name only; Betty is not a PRYSM gate)
- Verified semantic application base: `d7ce3cfe69d5ada8f6d4541c8a9603f17e932a97`
- Current Plane 3 tooling HEAD: `5f2c1a27cbb6eaf022fb9d61dc9a2d6c37a9c3eb`
- Application worktree: CLEAN at latest proof
- Current ScoreSet contract: `2.0.0`
- Current WriterInput version: `1.2.0`
- GA4 downstream commercial-outcome authority: PAUSED for this release
- Deployment: NONE
- Main merge: NONE
- Production mutation: NONE

## Latest TBK current-format reconstruction

Latest proof result: `TBK_MATERIAL_SCORING_CHANGE / HIGH` under the prior historical-equivalence gate.

The isolated reconstruction itself succeeded:

- source audit: `9714c206-8ed3-4686-8fe2-ceeca0ca0f82`
- current ScoreSet `2.0.0` produced by the current production scoring path
- scoringVersion: `4.1.1`
- derivative ScoreSet SHA: `6492e317299099c90e3389ca768d05e5acdfb3f00a6b1722ae0bf70eb62d334e`
- current WriterInput `1.2.0` built successfully
- current WriterInput SHA: `d95dc2922f8cef3813812a7f3704aef10fc78e5dc2e43e4dd04ddf8fdfa3d6da`
- current decisionHierarchy constructed and validated
- primary numeric scores, bands, readiness status, assessed weight, finding IDs/order, module/dimension eligibility, and suppressed-module state matched the historical audit
- current root-cause/action authority differs from the historical snapshot, including current `VAN-CONTENT-002` FAQ framing
- provider/model calls: 0
- provider recollection: 0
- historical mutations: 0
- application changes: 0

Those semantic differences are now accepted as current product semantics for UAT rather than treated as a blocker requiring historical retrofit.

## Accelerated UAT path

TBK is the single current-format UAT validation corpus.

Immediate path:

1. Re-run/reuse the already proven current TBK reconstruction through current production scoring and WriterInput construction.
2. Create a new durable current-format TBK UAT fixture containing current ScoreSet `2.0.0`, current findings, WriterInput `1.2.0`, and a derivation manifest.
3. Repair the Plane 3/UAT harness so it consumes only that current-format fixture and fails closed on stale versions, wrong hashes, wrong audit identity, or missing manifest.
4. Run focused harness tests plus WriterInput, Narrative v2, production-path, storage/recovery, full worker, and `git diff --check`.
5. Create one local repair commit and stop before any Writer/Judge/provider/model call.
6. If deterministic verification passes, status becomes `LIVE_UAT_PRECALL_READY`.
7. Then obtain one bounded authorization for exactly one fresh current-format TBK Writer -> Judge validation.
8. If that one real validation passes, move directly to staging/live UAT deployment authorization and provide Chris the exact URL and test steps.

## Deferred until final-release hardening

Not required before first human UAT:

- historical TBK semantic equivalence;
- Reboot corpus retrofit;
- 5/5 + 3/3 current-format Writer robustness sampling;
- 3/3 full robustness orchestrations;
- formal Plane 4 semantic scoring.

These remain final-release hardening where required by the permanent protocol.

## Current authorization boundary

Authorized now:

- deterministic current-format TBK UAT fixture construction from existing canonical evidence;
- current production scoring/WriterInput reconstruction in isolated or fixture-generation context;
- harness repair limited to current-UAT fixture identity/version/hash enforcement;
- deterministic tests and one local commit.

Not authorized now:

- Writer/Judge/provider/model-bearing calls;
- provider recollection;
- deployment;
- merge;
- production mutation;
- GA4 conversion-authority expansion.

## Model routing

- Current-format fixture/harness build: GPT-5.6 Terra / High
- Mechanical follow-up after semantics frozen: GPT-5.6 Luna / Medium
- One future real Writer: `gpt-5.6-terra`
- One future real Judge: `gpt-5.6-sol`

## Exact next action

Run one long governed GPT-5.6 Terra / High zero-model-call UAT-readiness build against exact application HEAD `5f2c1a27cbb6eaf022fb9d61dc9a2d6c37a9c3eb`. Treat the current production TBK scoring result as authoritative for UAT; create one durable current-format TBK fixture using current ScoreSet `2.0.0` and WriterInput `1.2.0`; repair the harness to consume only that fixture with fail-closed version/hash/audit/manifest checks; run deterministic regression; create one local commit; and stop at `LIVE_UAT_PRECALL_READY` before any Writer/Judge/provider/model call.

Last verified: 2026-09-10 America/Toronto
