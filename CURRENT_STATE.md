# Current State

Project: PRYSM

## Current objective

Reach a safe live human UAT as quickly as possible. Chris has explicitly prioritized live testing over further exhaustive retrofit of the legacy Plane 3 corpus.

Decision: `DECISION_PRYSM_ACCELERATED_LIVE_UAT_PATH_2026-09-10.md`

This accelerated UAT path does not waive the permanent final-release gates. It narrows the immediate objective to proving one clean current-format production-shaped audit through the real current scoring → WriterInput → Writer/Judge path, then making that candidate available for Chris to test live/staging.

## Exact application checkpoint

- Application repository: `chriskulbaba2025/vantage-platform`
- Local application: `C:\Users\kulba\Desktop\vantage-platform`
- Branch: `review/prysm-solution-directive-authority-betty` (historical name only; Betty is not a PRYSM gate)
- Verified semantic application base: `d7ce3cfe69d5ada8f6d4541c8a9603f17e932a97`
- Current Plane 3 tooling HEAD: `5f2c1a27cbb6eaf022fb9d61dc9a2d6c37a9c3eb`
- Application worktree: CLEAN at last proof
- Current ScoreSet contract: `2.0.0`
- Current WriterInput version: `1.2.0`
- GA4 downstream commercial-outcome authority remains PAUSED for this release.

## What was proven

The prior fresh Plane 3 model-bearing run used historical WriterInput `1.0.0` fixtures directly, so it did not prove the repaired current WriterInput `1.2.0` boundary. The failed Reboot sample was correctly rejected by the existing WriterOutput validator.

Both legacy TBK/Reboot corpora contain ScoreSet `1.0.0` and no current `decisionHierarchy`. Current WriterInput `1.2.0` therefore cannot be legitimately built from those persisted scores without reconstructing current score authority.

A later diagnosis proved that the existing persisted canonical evidence is sufficient to attempt an isolated current deterministic scoring reconstruction without provider recollection. Chris explicitly authorized that isolated reconstruction, with no provider/model calls and no historical artifact mutation.

## Accelerated live-UAT path

TBK is now the single primary current-format UAT corpus unless a deterministic blocker proves it unusable.

Immediate path:

1. Reconstruct TBK only in isolated scratch storage through the current production scoring boundary using existing canonical evidence.
2. Require current ScoreSet `2.0.0`, current `decisionHierarchy`, and WriterInput `1.2.0` from production-owned builders.
3. Compare only material governed conclusions needed to ensure the reconstruction did not silently change the audit.
4. If TBK qualifies, repair the UAT/Plane 3 harness in the same zero-model-call run so it consumes the exact current-derived TBK packet and rejects stale versions/hashes.
5. Run deterministic focused and broad regression and create one local repair commit.
6. Stop before Writer/Judge/model calls.
7. Then obtain one explicit bounded current-format Writer→Judge authorization.
8. After one clean current-format Writer→Judge validation, move directly to live/staging UAT deployment authorization and give Chris the exact URL/test steps.

## Deferred until final-release hardening

Not required before the first human UAT:

- retrofitting the full legacy Reboot corpus;
- 5/5 + 3/3 current-format Writer robustness sampling;
- 3/3 full robustness orchestrations;
- formal Plane 4 semantic scoring.

Those remain release-hardening gates where required by the permanent protocol.

## Current authorization boundary

Already authorized:

- isolated deterministic current-scoring reconstruction from existing persisted canonical evidence;
- isolated derivative artifacts only;
- no historical mutation;
- no provider recollection;
- no Writer/Judge/model calls.

Not yet authorized:

- Writer/Judge/provider/model-bearing calls;
- provider recollection;
- deployment;
- merge;
- production mutation.

## Exact next action

Run one long governed GPT-5.6 Terra / High zero-model-call accelerator against application HEAD `5f2c1a27cbb6eaf022fb9d61dc9a2d6c37a9c3eb`: reconstruct TBK only through current production scoring into isolated scratch storage; require ScoreSet `2.0.0` and WriterInput `1.2.0`; compare material audit conclusions against the historical TBK authority; if equivalent, repair the harness to consume only that current-derived packet with fail-closed version/hash assertions; run deterministic regressions; create one local commit; stop before any Writer/Judge/model call.

Last verified: 2026-09-10 America/Toronto
