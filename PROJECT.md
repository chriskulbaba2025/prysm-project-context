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

## Startup rule

At the start of a new substantive chat:

- read this file;
- read `GITHUB_PROJECT_MEMORY_PROTOCOL.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`, and `WORKFLOW_INSTRUCTIONS.md`;
- read `TERMINOLOGY.md` when the task concerns footprint discovery, representative acquisition, provider crawl limits, assessed pages, or report coverage wording;
- read the latest `CURRENT_STATE.md`;
- read active `CONSTRAINTS.md` and `DECISIONS.md`;
- load only the additional context required;
- continue from the exact next action in `CURRENT_STATE.md`.

Before any application-file edit or request for a source file, the Mandatory Pre-Edit Gate in `REPAIR_BOUNDARY_PROTOCOL.md` must pass. Complete the repair design and expected file/test boundary first; only then begin the governed one-source-file-at-a-time implementation workflow.

For every manual source-file edit, `WORKFLOW_INSTRUCTIONS.md` is mandatory. In particular: give the exact path, exact current line numbers/ranges and anchors, present multiple edits bottom-up (highest line first), provide complete replacement blocks, and stop for verification before moving to the next source-file unit.

For diagnostics, troubleshooting, defect analysis, and repair planning, follow `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`: verify the executing boundary and direct evidence before stating a root cause or directing the user through a diagnostic path.

## Handoff rule

When the user asks to leave the chat, start a new chat, create a handoff, summarize for continuation, update project memory, or update source files, execute the complete Handoff Transaction in `GITHUB_PROJECT_MEMORY_PROTOCOL.md` before presenting the final handoff.

A handoff is not complete until the GitHub state update has succeeded and been verified.

## Key specification

The production product requirements are stored under `SPECS/`.

## Relevant skills

Reusable reasoning/governance procedures are stored under `SKILLS/` when they materially govern PRYSM work.
