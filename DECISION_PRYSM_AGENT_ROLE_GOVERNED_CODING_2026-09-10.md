# Decision — PRYSM Agent-Role Governed Coding Process

**Date:** 2026-09-10  
**Status:** Active governing process decision  
**Applies to:** PRYSM coding work executed through Codex or another coding agent

## Decision

PRYSM adopts an agent-role execution profile on top of Governed Coding Upgrade (GCU) v2.1.0.

The governing principle is:

> Separate cognition from authority. Decompose work until the assigned agent can perform its role reliably. Require evidence between stages. Escalate intelligence when needed rather than granting broader autonomy.

The process is:

```text
REQUEST
→ TRIAGE / SCOUT
→ PLAN + FREEZE
→ IMPLEMENT / BUILDER
→ VERIFY
→ CHALLENGE
→ TERMINAL VERIFY / MACHINE GATE
→ EXACT-HEAD AUDIT
→ RELEASE AUTHORITY
```

If a stage fails, return to the owning stage with the proven defect. If the same root remains unresolved after the governed correction limit, perform the required diagnostic/process reset and, where appropriate, escalate model capability or reasoning effort. Do not widen file scope, production authority, external-call authority, or release authority merely because a stronger agent is used.

## GCU authority and provenance

This profile does not replace GCU. It is the PRYSM role/authority mapping used when applying GCU.

Active governed-coding baseline:

- Skill: `governed-coding-upgrade`
- Version: `2.1.0`
- Canonical repository: `chriskulbaba2025/governed-coding-upgrade-skill`
- Canonical main SHA supplied with the portable source package: `caa81324026b9936f4c9e658e9fb1819f7f403cf`

GCU v2.1.0 controls remain mandatory, including release intent, production-spine / Producer → Contract → Consumer tracing when applicable, acceptance freeze, false-PASS rejection, sequential evidence, balanced verification, terminal-path proof, machine gate, exact-head audit, correction/re-audit, and truthful release state.

A later GCU version is not silently adopted. It requires deliberate review/adoption when it changes governing behavior.

## Role authority

### 1. TRIAGE / SCOUT — read/search only

Purpose:
- recover authoritative GitHub state;
- identify the exact task, branch, SHA, runtime, governing contracts, and likely owning boundary;
- locate direct evidence before diagnosis.

May:
- read repository state, code, artifacts, logs, governance, and test evidence;
- run non-mutating discovery commands.

May not:
- edit files;
- change scope;
- authorize external/model/provider calls;
- claim root cause without direct evidence.

### 2. PLAN + FREEZE — read/search only

Purpose:
- declare `CHANGE_ONLY`, `STAGING_READY`, or `PRODUCTION_READY` release intent;
- trace the Production Spine and Producer → Contract → Consumer map when applicable;
- freeze the smallest coherent permitted/prohibited file boundary;
- define the acceptance contract, direct positive proof, negative/fail-closed proof, protected invariants, and stop conditions before implementation.

The Planner may suggest changes. Suggestions are advisory until they are inside the governed frozen scope and any required user authorization is present.

### 3. IMPLEMENT / BUILDER — sole write owner

Purpose:
- implement only the frozen coherent repair/change.

Authority:
- one implementation/write owner per active governed change;
- scoped application/test edits only within the authorized boundary;
- local deterministic commit only when the active gate explicitly permits it and proving checks are green.

May not:
- self-expand scope;
- rewrite governance to make a failing change pass;
- authorize its own paid/model/provider calls, push, deployment, production mutation, or main merge;
- act as its own independent auditor.

### 4. VERIFY — commands/read only

Purpose:
- execute the frozen proving checks against the actual implementation;
- record exact commands, outputs, pass/fail counts, durations, call/write counts, hashes/identities, and relevant negative evidence.

Verification must exercise the real governed production boundary being claimed, using controlled dependencies below that boundary where required by GCU.

The Verifier does not repair failing code. A failure routes back to the Builder with the exact failed evidence.

### 5. CHALLENGE — independent read-only adversarial review

Purpose:
- assume an apparent PASS may be false;
- actively seek false-PASS proof, ordinary reachable bypasses, missing negative cases, producer/consumer discontinuity, stale evidence, semantic loopholes, and downstream blind spots.

The Challenger must inspect the coherent defect class, not stop at the first trivial variant when the same invariant could fail elsewhere.

The Challenger does not edit. Demonstrated defects return to the owning Builder boundary.

### 6. TERMINAL VERIFY / MACHINE GATE — commands/read only

Purpose:
- prove cross-section integration and terminal user/business behavior for the declared release intent;
- run the applicable machine-enforceable gate against the exact candidate head;
- fail closed on missing, stale, failed, or unprovable mandatory conditions.

Agent confidence or prose cannot override the machine gate.

### 7. EXACT-HEAD AUDIT — independent read-only

Purpose:
- audit the actual candidate SHA, complete diff, checklist, production spine, contract map, acceptance proof, false-PASS scan, negative paths, external-call evidence, protected invariants, machine gate, and exact-head CI where required.

The Auditor must not rely on the Builder report alone and must not modify the candidate under audit.

### 8. RELEASE AUTHORITY — human + governed machine conditions

The coding agent is not the release authority.

Chris retains explicit authorization authority for boundaries that require human approval, including as applicable:
- live/paid provider or model execution;
- production reruns or fresh audits;
- push when the active gate has not already granted bounded publication authority;
- deployment / production promotion;
- production configuration mutation;
- production data/artifact mutation;
- merge to application `main`.

Green implementation/tests do not imply these authorizations.

## Auto-continuation rule

Within an already authorized bounded change, routine stage PASS should continue to the next governed stage without forcing Chris to type `go` after every mechanical step.

Stop for Chris only when:
- a new explicit authorization boundary is reached;
- scope would materially change;
- live/paid/model/provider execution is needed and not already authorized;
- push/deploy/production/main authority is needed and not already granted;
- a real blocker or governance hold occurs;
- the governing correction/anti-thrash limit is reached.

## Automatic next-prompt rule

When ChatGPT is facilitating PRYSM and a proof/review establishes that the next governed action is a repair, preflight, verification, publication, or other Codex/agent run, the same response must include the execution-ready next Codex prompt automatically.

Chris should not have to send a separate message asking for the prompt.

The prompt must preserve:
- exact repository/root/branch/SHA identities;
- permitted/prohibited scope;
- release intent;
- direct proof and negative proof;
- protected invariants;
- call/cost/side-effect ceilings;
- stop conditions;
- proof-file requirements when applicable;
- the next authorization boundary.

This rule does not pre-authorize an action that still requires explicit user approval. In that case, provide the ready prompt or bounded authorization gate while clearly preserving the approval boundary.

## One-owner / specialist-agent rule

Use specialist agents to improve cognition and proof, not to create competing writers.

Default:
- one Builder/write owner;
- any number of bounded read-only Scout/Planner/Verifier/Challenger/Auditor roles when useful;
- no parallel agents editing the same governed change unless a future explicit protocol defines safe non-overlapping write ownership.

Do not nest agents simply to repeat the same review. Assign each agent a distinct proof responsibility.

## Escalation rule

Escalation means stronger reasoning/model capability or a deeper evidence pass for an unresolved boundary. It does not mean:
- broader file permissions;
- broader product scope;
- relaxed validation;
- more retries;
- permission to bypass GCU gates;
- release authority.

Use the active PRYSM model-routing protocol for model selection. When a weaker/mechanical agent cannot resolve a semantic or architectural boundary, escalate cognition while keeping the same governed authority boundary.

## Evidence and proof discipline

Every qualifying coding change must retain GCU v2.1.0 evidence discipline:
- exact starting state;
- release intent;
- frozen scope/checklist;
- real-path proof where applicable;
- negative/fail-closed proof;
- sequential section evidence;
- no false-PASS harnesses;
- external-call measurement when applicable;
- exact final SHA and diff;
- terminal verification when applicable;
- machine gate;
- independent exact-head audit;
- truthful `CHANGE RESULT`, `SYSTEM READINESS`, and final release state.

For Codex runs longer than 10 lines of material output, create the project-required Downloads proof artifact with result, pass/fail counts, durations, exact SHA/IDs, and key evidence before stopping.

## Relationship to manual workflow

`WORKFLOW_INSTRUCTIONS.md` remains the governing delivery protocol when Chris explicitly chooses direct manual/chat-guided file editing.

For Codex/agent implementation, this decision and `SKILLS/GOVERNED_CODING_UPGRADE.md` govern the agent-role execution lifecycle. Manual copy/paste rules do not force a Codex Builder to stop after each file when a coherent multi-file frozen repair boundary has already been authorized.

Hard PRYSM evidence, model-bearing, production, cost, no-force-push, and user-authorization constraints remain unchanged.
