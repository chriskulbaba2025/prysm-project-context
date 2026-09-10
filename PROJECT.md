# PRYSM Project Context

Project: PRYSM — governed website conversion-readiness and website decision system

Authoritative context repository: `chriskulbaba2025/prysm-project-context`

Primary application repository: `chriskulbaba2025/vantage-platform`

## Governing files

Read these before substantive PRYSM work:

1. `GITHUB_PROJECT_MEMORY_PROTOCOL.md`
2. `PRYSM_PERMANENT_MEMORY.md`
3. `PROJECT_CONTEXT_PROTOCOL.md`
4. `REPAIR_BOUNDARY_PROTOCOL.md`
5. `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`
6. `WORKFLOW_INSTRUCTIONS.md`
7. `SKILLS/GOVERNED_CODING_UPGRADE.md` for qualifying coding changes
8. `DECISION_PRYSM_AGENT_ROLE_GOVERNED_CODING_2026-09-10.md` for Codex/agent coding work
9. `TERMINOLOGY.md`
10. `CURRENT_STATE.md`
11. `CONSTRAINTS.md`
12. `DECISIONS.md`

For any application-changing production-closure or post-deployment validation repair, also read:

- `PRYSM_WHOLE_APP_TRANCHE_GATE.md`;
- `PRYSM_WHOLE_APP_BRANCH_COVERAGE_PROTOCOL.md`;
- `PRYSM_WHOLE_APP_BRANCH_MATRIX.md`;
- `PRYSM_MODEL_BEARING_RELEASE_GATE.md` when Writer/Judge/model-bearing behavior or Narrative semantic quality is touched or implicated by an escape;
- `PRYSM_MODEL_BEARING_GATE_STATE.json` whenever the Model-Bearing Release Gate applies;
- `PRYSM_POSTRUN_AUDIT_PROTOCOL.md`;
- the active dated decision/protocol file named by `CURRENT_STATE.md`.

Load additional specifications, skills, and reference material only when required by the active task.

## Authority

GitHub is the authoritative durable project memory. Chats are temporary working sessions. Current GitHub state overrides stale conversational summaries or duplicated Project Sources.

`PRYSM_PERMANENT_MEMORY.md` is the mandatory high-value operating-memory bootstrap for recurring launcher, diagnostic-hygiene, anti-thrash, agent-role, and role-handoff rules. It is an index; the detailed governing files it cites remain the source of truth.

`SKILLS/GOVERNED_CODING_UPGRADE.md` binds qualifying PRYSM coding changes to Governed Coding Upgrade v2.1.0 and its pinned provenance. `DECISION_PRYSM_AGENT_ROLE_GOVERNED_CODING_2026-09-10.md` defines the PRYSM agent-role authority profile: read-only Scout/Planner/Verifier/Challenger/Auditor roles, one Builder/write owner, machine/terminal proof, and separate Release Authority. These controls apply when Codex or another coding agent performs the implementation.

`WORKFLOW_INSTRUCTIONS.md` remains the governing manual-edit delivery protocol when Chris explicitly chooses direct manual/chat-guided source editing. Manual copy/paste mechanics do not override an explicitly authorized coherent Codex/agent change boundary governed by GCU and the agent-role decision. Hard production/authorization constraints remain unaffected.

`PRYSM_MODEL_BEARING_RELEASE_GATE.md` is the permanent release-proof standard for Writer/Judge/model-bearing changes. Deterministic Whole-App PASS is necessary but is not sufficient to prove stochastic Narrative reliability. `PRYSM_MODEL_BEARING_GATE_STATE.json` records that separate gate's durable current status and must not be inferred from `wholeAppGate`.

### Active Production Closure exception

For the active autonomous Production Closure package dated 2026-08-31, `DECISION_AUTONOMOUS_PRODUCTION_CLOSURE_2026-08-31.md`, `PRYSM_PRODUCTION_CLOSURE_ROADMAP_2026-08-31.md`, `PRYSM_WHOLE_APP_TRANCHE_GATE.md`, `PRYSM_WHOLE_APP_BRANCH_COVERAGE_PROTOCOL.md`, `PRYSM_WHOLE_APP_BRANCH_MATRIX.md`, `PRYSM_MODEL_BEARING_RELEASE_GATE.md` and its state file when applicable, `PRYSM_POSTRUN_AUDIT_PROTOCOL.md`, and the contracts under `tools/autorun/` are a specifically authorized project-level execution exception.

During that package only, those files supersede the manual-chat/source-file delivery mechanics in `WORKFLOW_INSTRUCTIONS.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `CONSTRAINTS.md`, and older decisions where those mechanics would prohibit direct autonomous local application edits, coherent multi-file contract migrations, deterministic local commits, normal pushes to the dedicated repair branch, or autonomous governance-memory synchronization.

The same autonomous execution exception remains active for any **single bounded post-deployment validation repair checkpoint `PDVn`** when `CURRENT_STATE.md`, `PRYSM_AUTORUN_STATE.json`, and a dated governing decision/protocol explicitly declare that checkpoint active after T7 completion. A PDV checkpoint does not reopen or invalidate T0-T7 or earlier independently PASSed PDV checkpoints. It uses the same repair branch, exact-SHA Whole-App Gate, Whole-App Branch Coverage Matrix, applicable Model-Bearing Release Gate/state, independent Auditor, root-defect accounting, and governance-synchronization controls. Its exact repair scope is governed by the dated post-deployment decision/protocol referenced by current state.

The exception does **not** supersede evidence-integrity semantics, no-guess/root-cause requirements, dirty-worktree preservation, three-attempt anti-thrash rules, Narrative quality gates, Whole-App branch completeness, model-bearing proof requirements, no-force-push rules, or production/external authorization boundaries. Merge to application `main`, deployment, production configuration mutation, live/paid provider/model execution, and starting a fresh production audit remain explicitly unauthorized unless a later durable instruction grants them.

## Startup rule

At the start of a new substantive chat:

- read this file;
- read `GITHUB_PROJECT_MEMORY_PROTOCOL.md` and `PRYSM_PERMANENT_MEMORY.md` first;
- read `REPAIR_BOUNDARY_PROTOCOL.md`, `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`, and `WORKFLOW_INSTRUCTIONS.md`;
- for any qualifying coding change, read `SKILLS/GOVERNED_CODING_UPGRADE.md`;
- for any Codex/agent coding workflow, read `DECISION_PRYSM_AGENT_ROLE_GOVERNED_CODING_2026-09-10.md`;
- read `TERMINOLOGY.md` when the task concerns footprint discovery, representative acquisition, provider crawl limits, assessed pages, or report coverage wording;
- read the latest `CURRENT_STATE.md`;
- read active `CONSTRAINTS.md` and `DECISIONS.md`;
- read `PRYSM_MODEL_BEARING_RELEASE_GATE.md` and `PRYSM_MODEL_BEARING_GATE_STATE.json` whenever the active task touches Writer/Judge/model-bearing behavior or Narrative semantic quality;
- load only the additional context required;
- continue from the exact next action in `CURRENT_STATE.md`.

For Codex/agent implementation, use the agent-role governed process: recover state → Scout/Triage → Plan + Freeze → Builder → Verify → Challenge → Terminal Verify/Machine Gate → Exact-Head Audit → Release Authority. Keep one implementation/write owner. Specialist agents are read-only unless a later explicit protocol defines non-overlapping write ownership. Routine PASS stages auto-continue inside the already authorized boundary; stop at blockers, scope changes, correction limits, or new authorization boundaries.

For ordinary/manual PRYSM work, before any application-file edit or request for a source file, the Mandatory Pre-Edit Gate in `REPAIR_BOUNDARY_PROTOCOL.md` must pass. Complete the repair design and expected file/test boundary first; only then begin the governed one-source-file-at-a-time implementation workflow.

For the active autonomous Production Closure package or explicitly active bounded `PDVn` checkpoint, follow the Active Production Closure exception above instead: the Codex Builder must recover exact local state first, follow the T0-T7 roadmap for roadmap work or the explicitly active PDV decision/current-state boundary for post-deployment repair, satisfy the Producer -> Contract/Persistence -> Loader -> Consumer dependency discipline where applicable, reconcile the Whole-App Branch Matrix, and satisfy the exact-SHA Whole-App Tranche Gate plus any applicable model-bearing release proof/state and independent Auditor before closure.

For every ordinary/manual source-file edit, `WORKFLOW_INSTRUCTIONS.md` is mandatory. In particular: give the exact path, exact current line numbers/ranges and anchors, present multiple edits bottom-up (highest line first), provide complete replacement blocks, and stop for verification before moving to the next source-file unit.

For diagnostics, troubleshooting, defect analysis, and repair planning, follow `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`: verify the executing boundary and direct evidence before stating a root cause or directing the user through a diagnostic path.

When ChatGPT facilitates PRYSM and another Codex/agent run is the exact next governed action, provide the execution-ready next prompt automatically in the same response. Do not make Chris ask separately for the prompt. This does not bypass any explicit approval boundary.

## Handoff rule

When the user asks to leave the chat, start a new chat, create a handoff, summarize for continuation, update project memory, or update source files, execute the complete Handoff Transaction in `GITHUB_PROJECT_MEMORY_PROTOCOL.md` before presenting the final handoff.

A handoff is not complete until the GitHub state update has succeeded and been verified.

## Key specification

The production product requirements are stored under `SPECS/`.

## Relevant skills

Reusable reasoning/governance procedures are stored under `SKILLS/` when they materially govern PRYSM work.
