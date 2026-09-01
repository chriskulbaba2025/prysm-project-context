# PRYSM Project Context

Project: PRYSM — governed website conversion-readiness and website decision system

Authoritative context repository: `chriskulbaba2025/prysm-project-context`

Primary application repository: `chriskulbaba2025/vantage-platform`

## Governing files

Read these before substantive PRYSM work:

1. `GITHUB_PROJECT_MEMORY_PROTOCOL.md`
2. `PROJECT_CONTEXT_PROTOCOL.md`
3. `REPAIR_BOUNDARY_PROTOCOL.md`
4. `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`
5. `WORKFLOW_INSTRUCTIONS.md`
6. `TERMINOLOGY.md`
7. `CURRENT_STATE.md`
8. `CONSTRAINTS.md`
9. `DECISIONS.md`

Load additional specifications, skills, and reference material only when required by the active task.

## Authority

GitHub is the authoritative durable project memory. Chats are temporary working sessions. Current GitHub state overrides stale conversational summaries or duplicated Project Sources.

`WORKFLOW_INSTRUCTIONS.md` is the current governing manual-edit delivery protocol and supersedes older manual-code-flow wording elsewhere in the context repository when that older wording is inconsistent with it. Hard production/authorization constraints remain unaffected.

### Active Production Closure exception

For the active autonomous Production Closure package dated 2026-08-31, `DECISION_AUTONOMOUS_PRODUCTION_CLOSURE_2026-08-31.md`, `PRYSM_PRODUCTION_CLOSURE_ROADMAP_2026-08-31.md`, `PRYSM_WHOLE_APP_TRANCHE_GATE.md`, `PRYSM_POSTRUN_AUDIT_PROTOCOL.md`, and the contracts under `tools/autorun/` are a specifically authorized project-level execution exception.

During that package only, those files supersede the manual-chat/source-file delivery mechanics in `WORKFLOW_INSTRUCTIONS.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `CONSTRAINTS.md`, and older decisions where those mechanics would prohibit direct autonomous local application edits, coherent multi-file contract migrations, deterministic local commits, normal pushes to the dedicated repair branch, or autonomous governance-memory synchronization.

The same autonomous execution exception remains active for the bounded post-deployment validation repair checkpoints `PDV1` and `PDV2` when `CURRENT_STATE.md` and `PRYSM_AUTORUN_STATE.json` explicitly declare one active after T7 completion. These checkpoints do not reopen or invalidate T0-T7; they use the same repair branch, exact-SHA Whole-App Gate, independent Auditor, root-defect accounting, and governance-synchronization controls. Each exact repair scope is governed by the post-deployment decision file referenced by current state.

The exception does **not** supersede evidence-integrity semantics, no-guess/root-cause requirements, dirty-worktree preservation, three-attempt anti-thrash rules, Narrative quality gates, no-force-push rules, or production/external authorization boundaries. Merge to application `main`, deployment, production configuration mutation, live/paid provider/model execution, and starting a fresh production audit remain explicitly unauthorized unless a later durable instruction grants them.

## Startup rule

At the start of a new substantive chat:

- read this file;
- read `GITHUB_PROJECT_MEMORY_PROTOCOL.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`, and `WORKFLOW_INSTRUCTIONS.md`;
- read `TERMINOLOGY.md` when the task concerns footprint discovery, representative acquisition, provider crawl limits, assessed pages, or report coverage wording;
- read the latest `CURRENT_STATE.md`;
- read active `CONSTRAINTS.md` and `DECISIONS.md`;
- load only the additional context required;
- continue from the exact next action in `CURRENT_STATE.md`.

For ordinary/manual PRYSM work, before any application-file edit or request for a source file, the Mandatory Pre-Edit Gate in `REPAIR_BOUNDARY_PROTOCOL.md` must pass. Complete the repair design and expected file/test boundary first; only then begin the governed one-source-file-at-a-time implementation workflow.

For the active autonomous Production Closure package, follow the Active Production Closure exception above instead: the Codex Builder must recover exact local state first, follow the T0-T7 roadmap for roadmap work or the explicitly active PDV1/PDV2 decision/current-state boundary for the bounded post-deployment repair, satisfy the Producer -> Contract/Persistence -> Loader -> Consumer dependency discipline where applicable, and satisfy the exact-SHA Whole-App Tranche Gate plus independent Auditor before closure.

For every ordinary/manual source-file edit, `WORKFLOW_INSTRUCTIONS.md` is mandatory. In particular: give the exact path, exact current line numbers/ranges and anchors, present multiple edits bottom-up (highest line first), provide complete replacement blocks, and stop for verification before moving to the next source-file unit.

For diagnostics, troubleshooting, defect analysis, and repair planning, follow `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`: verify the executing boundary and direct evidence before stating a root cause or directing the user through a diagnostic path.

## Handoff rule

When the user asks to leave the chat, start a new chat, create a handoff, summarize for continuation, update project memory, or update source files, execute the complete Handoff Transaction in `GITHUB_PROJECT_MEMORY_PROTOCOL.md` before presenting the final handoff.

A handoff is not complete until the GitHub state update has succeeded and been verified.

## Key specification

The production product requirements are stored under `SPECS/`.

## Relevant skills

Reusable reasoning/governance procedures are stored under `SKILLS/` when they materially govern PRYSM work.
