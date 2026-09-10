# PRYSM Clean TBK Writer/Judge Authorization Boundary

Date: 2026-09-09
Status: AUTHORIZED — ONE CLEAN MODEL-BACKED EXECUTION

## Authority

Application repository: `chriskulbaba2025/vantage-platform`

Exact application candidate: `a2c1587aa4dfa799dab3b6b2cfbd42b384e1a893`

Application review branch: `review/prysm-solution-directive-authority-betty`

The branch name is historical only. Betty is not a PRYSM gate.

Frozen TBK audit identity: `9714c206-8ed3-4686-8fe2-ceeca0ca0f82`

Frozen target: `https://www.tbkcreative.com/`

Prepared execution entrypoint:
`services/worker/TBK-fresh-writer-judge.mjs`

## Explicit human authorization

On 2026-09-09 Chris explicitly authorized exactly one new clean TBK Writer/Judge automatic release-candidate orchestration under this prepared boundary against exact candidate `a2c1587aa4dfa799dab3b6b2cfbd42b384e1a893`.

This authorization is single-use and limited to the automatic two-pass/four-call boundary below.

## Authorized execution boundary

The authorized execution is one new clean Narrative v2 TBK Writer/Judge release-candidate orchestration against the frozen governed TBK WriterInput already stored in the repository fixture.

The prepared entrypoint:
- loads the frozen TBK WriterInput and frozen canonical audit request;
- creates a fresh execution ID;
- creates an isolated durable filesystem artifact store under the operating-system temp directory;
- invokes the current candidate's real Narrative v2 live Writer/Judge binding;
- writes the new orchestration result only to that isolated execution ledger.

This is not a retry, resume, or reconstruction of the historical failed TBK Writer pass 2.

## Automatic model-call ceiling

The current live binding permits at most two automatic Writer/Judge passes:

`Writer 1 -> Judge 1 -> Writer 2 -> Judge 2`

Maximum authorized model/provider calls for this single clean automatic run: **4**.

If Judge 2 still returns `REVISE`, the orchestration must stop at governed human review. Writer/Judge Pass 3 is **not** included in this authorization and requires a separate explicit human authorization.

The absolute six-call ceiling remains unchanged but is not permission to use calls 5-6.

## Explicitly prohibited

This authorization does not permit:
- retry or reconstruction of the historical failed TBK Writer pass 2;
- audit-provider recollection or recrawl;
- DataForSEO/PageSpeed/backlink/GA4/GSC/provider reruns;
- rescoring or mutation of frozen governed TBK evidence;
- mutation or overwrite of historical TBK Narrative artifacts;
- Pass 3 Writer/Judge execution;
- model escalation or hidden fallback;
- network retry outside the governed recovery contract;
- a second clean orchestration run under this authorization;
- deployment or production promotion;
- production mutation;
- application main merge.

## Required pre-execution checks

Before the first paid/model call:
1. verify local application HEAD equals exact candidate `a2c1587aa4dfa799dab3b6b2cfbd42b384e1a893` and worktree is clean;
2. verify the configured live Narrative environment is enabled and required model/provider configuration is present without printing secrets;
3. record the configured Writer model ID, Judge model ID, prompt/contract versions, and applicable cost/budget configuration;
4. confirm the execution uses the frozen TBK input and a new isolated execution identity;
5. confirm no provider recrawl/recollection path is invoked.

If any check fails, stop before a model/provider call. The authorization remains unconsumed until the first model/provider call is actually made.

## Required execution evidence

The model-backed run must record at minimum:
- exact candidate SHA;
- frozen audit ID;
- fresh execution ID;
- Writer/Judge model identifiers;
- prompt/contract versions;
- pass number for each call;
- raw/parsed output artifact identities or hashes where produced by the governed binding;
- validation result and complete validation errors;
- Judge result for every completed pass;
- usage/cost for every returned model call;
- terminal orchestration status;
- proof that no audit-provider recollection, deployment, production mutation, or main merge occurred.

Any Codex/execution run longer than 10 lines must also create the required Downloads proof artifact under the active PRYSM proof discipline.

## Stop condition

After the clean automatic orchestration reaches either `RELEASE_CANDIDATE`, a governed execution failure, or `HUMAN_REVIEW_REQUIRED`, stop and return the exact result and evidence. Do not launch Pass 3, rerun the orchestration, retry an uncertain call outside the persisted-response recovery contract, deploy, merge, or mutate production without a new explicit authorization.

## Current authorization state

**AUTHORIZED — SINGLE USE, NOT YET CONSUMED.**

Exact next action: execute the required pre-execution checks against the exact local candidate and, only if they all pass, run exactly one clean TBK Writer/Judge automatic orchestration through `services/worker/TBK-fresh-writer-judge.mjs`. Stop at the first terminal result and produce the required proof artifact. Do not run Pass 3 or any second orchestration.
