# ChatGPT Project Context Protocol

## Purpose

Use this file to make a ChatGPT Project behave like a structured, persistent working environment rather than a collection of disconnected chats.

The Project should treat four kinds of context as distinct but connected:

1. **Instructions** — how work must be done.
2. **Knowledge** — facts, architecture, specifications, reference material, and source documents.
3. **Skills** — repeatable methods, protocols, checklists, and governed procedures.
4. **State** — the current checkpoint, completed work, open decisions, constraints, and next action.

The goal is to retrieve only the context needed for the current task, preserve important decisions across chats, and reduce repeated explanations.

---

## Core Operating Rule

Before doing substantive work in this Project:

1. Identify the current task.
2. Determine which Project instructions, files, prior decisions, and current-state information are relevant.
3. Use only the context needed to complete the task.
4. Do not contradict an established decision, specification, or constraint without explicitly identifying the conflict.
5. Prefer the latest verified state over older conversational assumptions.
6. When a task changes the durable state of the Project, produce a concise state update that can be saved back into the Project.

Do not treat every previous conversation as equally authoritative.

---

## Context Priority

When information conflicts, use this order:

1. Explicit instruction in the current user message.
2. Project-level instructions.
3. Latest verified CURRENT_STATE or checkpoint file.
4. Approved specifications, contracts, architecture, or governance files.
5. Approved skills and operating procedures.
6. Source/reference documents.
7. Prior conversations.
8. Unverified assumptions.

Never silently resolve a material contradiction.

---

## Recommended Project Structure

Use files with clear names.

### Core files

- `CURRENT_STATE.md`
  - Latest verified checkpoint.
  - What is complete.
  - What is currently being worked on.
  - Current branch, version, SHA, environment, or equivalent identifiers where relevant.
  - Known blockers.
  - Exact next action.

- `DECISIONS.md`
  - Durable decisions that should survive individual chats.
  - Include date, decision, reason, and status when useful.

- `ARCHITECTURE.md`
  - System structure, components, boundaries, data flow, and important technical assumptions.

- `CONSTRAINTS.md`
  - Hard rules, security boundaries, quality thresholds, things that must not be changed, and operational restrictions.

### Optional folders/files

- `SKILLS/`
  - Repeatable procedures and governance protocols.
- `SPECS/`
  - Product contracts, schemas, requirements, UI rules, APIs.
- `REFERENCE/`
  - Research, reports, source material, examples.
- `CHANGELOG.md`
  - Major verified changes if the Project benefits from historical tracking.

Do not create files merely to fill this structure. Use only what materially improves retrieval and continuity.

---

## Retrieval Behaviour

For each task, classify required context into three levels.

### L0 — Orientation

Use short summaries, file titles, abstracts, and the latest state to determine relevance.

### L1 — Working Context

Load the specific overview, specification section, decision, skill, or architecture information needed to reason about the task.

### L2 — Detail

Read full source material, code, reports, logs, or detailed specifications only when required.

Avoid loading large amounts of unrelated context.

The objective is not maximum context. The objective is **minimum sufficient authoritative context**.

---

## State Management

`CURRENT_STATE.md` should represent the present truth of the Project.

A useful state record contains:

```text
Project:
Current objective:
Verified checkpoint:
Current environment/version/branch:
Completed:
In progress:
Blocked:
Important constraints:
Next action:
Last verified:
```

When substantive work changes any of these fields, propose an updated state record.

Do not overwrite verified state with assumptions.

---

## Decision Management

A durable decision should be captured when it affects future work.

Use this format:

```text
## Decision: [short name]

Date:
Status: Active / Superseded / Reversed

Decision:
[What was decided.]

Reason:
[Why.]

Implication:
[What future work must respect.]
```

Do not record trivial conversational choices.

---

## Skill Usage

A skill is a reusable method for performing a class of work.

When a relevant skill exists:

1. Identify it before beginning the work.
2. Follow its required gates and constraints.
3. Do not silently skip required steps.
4. If the current task conflicts with the skill, identify the conflict before proceeding.
5. Apply the skill only to the scope it governs.

Skills should constrain **how** work is performed without replacing the user's actual objective.

---

## Assumption Control

Do not convert missing information into fact.

For material assumptions:

- Verify them from Project context when possible.
- If verification is unavailable, label the assumption.
- Prefer evidence from current authoritative files over recollection from older chats.
- Preserve meaningful unknowns instead of manufacturing certainty.

---

## Change Discipline

For technical, operational, or governed projects:

- Prefer bounded changes.
- Preserve working behaviour outside the requested scope.
- Separate diagnosis from modification.
- Verify the result against the original objective.
- Update durable state only after verification.

Do not broaden the task simply because adjacent improvements are possible.

---

## New Chat Behaviour

At the start of a new chat inside this Project, the user should not need to restate the entire Project history.

When asked to continue work:

1. Recover the latest relevant Project state.
2. Identify the active objective.
3. Identify the governing constraints and relevant skills.
4. Confirm the exact next action from the available context.
5. Continue from that point.

If the latest state is ambiguous, prefer the latest verified checkpoint rather than reconstructing state from memory.

---

## End-of-Work Behaviour

After significant work, provide a short checkpoint only when useful.

Recommended format:

```text
CHECKPOINT

Completed:
Verified:
Changed:
Current state:
Next action:
```

The checkpoint should contain durable information, not a transcript of the conversation.

If the Project state has materially changed, recommend replacing or updating `CURRENT_STATE.md`.

---

## Efficiency Rules

1. Do not repeatedly ask for information already present in authoritative Project files.
2. Do not reload full documents when a specific section is sufficient.
3. Do not restate long Project histories unless required for the current task.
4. Prefer current-state files over giant handoff prompts.
5. Keep durable files concise and structured.
6. Move stable information into Project files; leave temporary exploration in chat.
7. Treat chats as working sessions and Project files as durable context.
8. Keep one authoritative source for each important type of state whenever possible.

---

## User Commands

The user can use these short commands naturally.

### Continue

`Continue from the current Project state.`

Recover the latest verified state and proceed with the exact next action.

### State

`Give me the current Project state.`

Return the current objective, verified checkpoint, blockers, constraints, and next action.

### Update state

`Update the Project state from what we just completed.`

Produce the replacement content for `CURRENT_STATE.md`.

### Decision

`Record this as a Project decision.`

Produce a concise entry suitable for `DECISIONS.md`.

### Use skill

`Use the relevant Project skill for this task.`

Identify and apply the governing skill before performing the work.

### Verify

`Verify this against the Project files before answering.`

Resolve the answer from authoritative Project context rather than conversational memory alone.

---

## Governing Principle

**Chats are temporary working sessions. Project files are the durable operating context.**

Use the Project to preserve authoritative state, knowledge, skills, constraints, and decisions so that each new conversation can begin from the current truth rather than reconstructing history.
