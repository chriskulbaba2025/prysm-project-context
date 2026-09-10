# Governed Coding Upgrade — PRYSM Invocation Rule

**Required skill:** `governed-coding-upgrade`  
**Active pinned baseline:** 2.1.0  
**Canonical repository:** `chriskulbaba2025/governed-coding-upgrade-skill`  
**Canonical main SHA supplied with portable package:** `caa81324026b9936f4c9e658e9fb1819f7f403cf`

## Mandatory use

For every PRYSM task that changes source code, tests, schemas, dependencies, executable configuration, infrastructure-as-code, migrations, persistence, jobs, integrations, build/release logic, or runtime behavior, load and obey Governed Coding Upgrade v2.1.0 before editing.

Read-only inspection does not require the full lifecycle unless repository governance says otherwise.

Do not silently adopt a later GCU version when its governing behavior differs. Review and deliberately adopt it first.

## PRYSM agent-role profile

For Codex/agent coding work, also read and obey:

`DECISION_PRYSM_AGENT_ROLE_GOVERNED_CODING_2026-09-10.md`

The default role pipeline is:

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

Role authority is intentionally separated:

- Scout/Triage: read/search only.
- Planner: read/search only; freezes release intent, production spine/contract map when applicable, scope, acceptance, proofs, invariants, and stop conditions.
- Builder: sole implementation/write owner for the active governed change.
- Verifier: commands/read only; proves the actual frozen requirements.
- Challenger: independent read-only adversarial review; actively seeks false PASSes, ordinary bypasses, and coherent defect classes.
- Terminal Verifier/Machine Gate: commands/read only; proves cross-boundary/terminal readiness for the declared release intent.
- Auditor: independent exact-head read-only audit.
- Release Authority: Chris plus the required machine conditions; coding agents do not self-authorize release boundaries.

Escalate intelligence/model capability when needed, not autonomy or scope.

## GCU v2.1.0 controls that remain mandatory

Apply the full canonical lifecycle as relevant, including:

- repository preflight and exact starting SHA;
- explicit `CHANGE_ONLY`, `STAGING_READY`, or `PRODUCTION_READY` release intent;
- Production Spine tracing for cross-boundary production work;
- Producer → Contract → Consumer mapping;
- frozen checklist and permitted/prohibited file scope;
- acceptance-contract freeze before production implementation;
- false-PASS scan;
- sequential evidence gate;
- balanced narrow/integration/terminal verification;
- real production-path acceptance when claimed;
- evidence preservation and validated-object continuity;
- negative-path proof;
- external-call identity/cost/retry evidence;
- terminal-path/full-system readiness where applicable;
- machine release gate;
- independent exact-head audit;
- correction/re-audit when proof escapes;
- truthful separation of change PASS from release/system readiness.

## PRYSM-specific authority

Current user instruction, active PRYSM `PROJECT.md`, `CURRENT_STATE.md`, `CONSTRAINTS.md`, `DECISIONS.md`, dated governing decisions/protocols, approved specifications/contracts, and application-repository governance remain authoritative over lower-level implementation procedure according to the project authority order.

Paid/live model/provider calls, production reruns, push/deployment/production mutation, and application-main merge remain governed by their specific active authorization boundaries. A green coding-agent result does not grant them.

## Minimum execution boundary

Before editing:

- verify repository root;
- verify branch;
- verify exact starting SHA;
- verify working tree;
- identify active PR when relevant;
- read governing PRYSM context;
- declare release intent;
- freeze permitted/prohibited scope;
- trace the production spine/contract handoffs when applicable;
- define direct positive proof and required negative proof before implementation.

## Auto-continuation

Within an already authorized bounded change, routine stage PASS proceeds to the next governed stage without requiring repeated user prompts. Stop only at a real blocker, a governance/anti-thrash limit, scope expansion, or a new explicit authorization boundary.

When ChatGPT facilitates the workflow and the next governed action is another Codex/agent run, provide the execution-ready next prompt automatically in the same response rather than making Chris ask for it separately.

## Manual-work fallback

When Chris explicitly chooses direct manual/chat-guided source editing, `WORKFLOW_INSTRUCTIONS.md` governs exact path/line/anchor/bottom-up replacement delivery.

Manual one-file-at-a-time copy/paste mechanics do not constrain a Codex Builder operating inside an explicitly frozen coherent multi-file agent change boundary.

## Completion rule

Do not claim a coding change complete from prose, agent confidence, or green narrow tests alone. Verify the exact changed boundary, required direct/negative proofs, scope, terminal/system conditions when claimed, machine gate, and exact-head audit according to GCU v2.1.0 and active PRYSM constraints.
