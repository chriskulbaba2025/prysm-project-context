# PRYSM Clean TBK Writer/Judge — Pre-Execution Blocker

Date: 2026-09-09
Status: PRE-EXECUTION BLOCKED — AUTHORIZATION UNCONSUMED

## Authority

Application repository: `chriskulbaba2025/vantage-platform`

Exact application candidate: `a2c1587aa4dfa799dab3b6b2cfbd42b384e1a893`

Frozen TBK audit: `9714c206-8ed3-4686-8fe2-ceeca0ca0f82`

Authorized entrypoint: `services/worker/TBK-fresh-writer-judge.mjs`

Authorization boundary: `PRYSM_CLEAN_TBK_WRITER_JUDGE_AUTHORIZATION_BOUNDARY_2026-09-09.md`

## Verified pre-execution result

The authorized execution preflight stopped before the first model/provider call.

Result: `PRE_EXECUTION_BLOCKED`

Start SHA: `a2c1587aa4dfa799dab3b6b2cfbd42b384e1a893`

End SHA: `a2c1587aa4dfa799dab3b6b2cfbd42b384e1a893`

Worktree before: CLEAN

Worktree after: CLEAN

Model calls: 0

Writer/Judge passes: 0

Usage/cost: NONE

Provider recollection: NONE

Deployment: NONE

Production mutation: NONE

Main merge: NONE

Changed application files: NONE

Single-use authorization: **UNCONSUMED**.

## Exact blocker

The authorized entrypoint was preflighted in a plain local process that did not contain the required live Narrative v2 environment. The environment check returned the required Narrative enablement, live mode, Writer model, Judge model, API key presence, chat-completions URL presence, and price-table presence as missing/undefined.

Because `TBK-fresh-writer-judge.mjs` passes `process.env` directly to `createNarrativeV2LiveBinding()`, the live binding could not be verified and execution correctly stopped before any model/provider call.

## Established environment mechanism

Repository evidence shows `railway run -s vantage-platform` is an existing mechanism used to inject the Railway service environment into local commands.

Historical TBK execution evidence also shows the fresh TBK Writer/Judge path running under Railway CLI with the governed models resolved as Writer `gpt-5.6-terra` and Judge `gpt-5.6-sol`.

This evidence is used only to select the existing execution environment mechanism. Current model/provider values must still be verified from the current Railway-backed preflight before the authorized call is made; do not hardcode or restore values manually from history.

## Governed continuation

Do not create, edit, copy, or manually reconstruct environment variables.

At `C:\Users\kulba\Desktop\vantage-platform\services\worker`, use the existing Railway service environment for preflight:

`railway run -s vantage-platform node TBK-env-check.mjs`

The check must confirm the required live Narrative configuration is present without exposing secret values.

If and only if that Railway-backed preflight passes, execute the already-authorized single clean orchestration in the same established environment:

`railway run -s vantage-platform node TBK-fresh-writer-judge.mjs`

The existing single-use authorization remains valid and becomes consumed only when the first model/provider call is actually made.

All previous authorization limits remain unchanged: maximum two automatic Writer/Judge passes / four calls; no Pass 3; no second clean orchestration; no provider recollection; no deployment; no production mutation; no main merge.

## Exact next action

Run the Railway-backed environment preflight from the worker directory. If it passes, immediately execute exactly one authorized clean TBK Writer/Judge orchestration through the same Railway service environment, capture the governed proof, and stop at the first terminal result. If the Railway-backed environment preflight fails, stop before any model/provider call and report the exact Railway/configuration blocker without editing configuration.
