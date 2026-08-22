# GitHub Project Memory Protocol

**Version:** 1.0.0  
**Status:** Governing project instruction  
**Purpose:** Portable, model-independent continuity across chats and LLMs

---

## 1. Governing Principle

**GitHub is the authoritative durable memory for this Project. Chats are temporary working sessions.**

The model must not rely on conversational memory, prior summaries, or its own recollection when authoritative Project state is available in the designated GitHub repository.

The repository must be treated as the current source of truth for:

- current state;
- durable decisions;
- hard constraints;
- architecture and specifications;
- relevant skills and operating procedures;
- verified next action.

---

## 2. Required Repository

Each Project must use its own designated GitHub repository.

The repository identity must be recorded in `PROJECT.md`.

Minimum authoritative files:

```text
PROJECT.md
CURRENT_STATE.md
DECISIONS.md
CONSTRAINTS.md
PROJECT_CONTEXT_PROTOCOL.md
```

Add only when materially useful:

```text
ARCHITECTURE.md
CHANGELOG.md
/SPECS
/SKILLS
/REFERENCE
```

Do not create duplicate sources of truth for the same state.

---

## 3. Authority Order

When information conflicts, use this order:

1. Platform, safety, legal, privacy, security, and authorization requirements.
2. Explicit current user instruction.
3. Project-level instructions.
4. `PROJECT.md`.
5. Latest verified `CURRENT_STATE.md`.
6. Active `CONSTRAINTS.md`.
7. Active `DECISIONS.md`.
8. Approved specifications, contracts, and architecture.
9. Governing skills and procedures.
10. Reference material.
11. Current conversation.
12. Older conversations, summaries, memories, or assumptions.

Never silently resolve a material contradiction.

---

## 4. New Chat Bootstrap — Mandatory

Before substantive work in a new chat:

1. Identify the designated GitHub repository from the Project instruction or `PROJECT.md`.
2. Read `PROJECT.md`.
3. Read the latest `CURRENT_STATE.md`.
4. Read the active portions of `CONSTRAINTS.md`.
5. Read the active portions of `DECISIONS.md`.
6. Load only the specifications, architecture, skills, or reference material required by the current task.
7. Determine the exact current objective and next action.
8. Continue from that state.

Do not ask the user to restate information that can be recovered from the repository.

Do not reconstruct the Project from conversational memory when the repository is accessible.

### If GitHub cannot be accessed

Do not invent the current state.

State clearly that authoritative repository state could not be verified and use only the information directly available in the current session until repository access is restored.

---

## 5. Minimum-Sufficient Retrieval

Do not load the entire repository by default.

Use three levels:

### L0 — Orientation
Read `PROJECT.md` and the latest state summary.

### L1 — Working Context
Read the specific decisions, constraints, specifications, or skills needed for the active task.

### L2 — Detail
Read code, logs, reports, full specifications, or historical records only when necessary.

The objective is **minimum sufficient authoritative context**, not maximum context.

---

## 6. During-Work State Discipline

While working:

- separate verified facts from assumptions;
- do not overwrite verified state with inference;
- preserve existing decisions unless explicitly superseded;
- record only durable decisions in `DECISIONS.md`;
- record only hard boundaries in `CONSTRAINTS.md`;
- keep `CURRENT_STATE.md` focused on present truth;
- update specifications only when the specification itself has legitimately changed;
- do not use state files as transcripts;
- do not record speculative work as complete.

For technical or governed work, preserve exact identifiers when material:

- repository;
- branch;
- SHA;
- PR;
- deployment;
- version;
- environment;
- audit/run ID;
- test or verification result.

---

## 7. Durable-State Trigger

A repository context update is required when completed work materially changes any of the following:

- current objective;
- verified checkpoint;
- completed work;
- in-progress work;
- blocker;
- exact next action;
- branch, SHA, PR, version, deployment, or environment;
- durable decision;
- hard constraint;
- architecture or contract;
- governing procedure.

Trivial conversational details must not be persisted.

---

## 8. Handoff Trigger — Mandatory

When the user asks to:

- leave the chat;
- start a new chat;
- create a handoff;
- summarize for continuation;
- update project memory;
- update source files;
- prepare a checkpoint for the next session;

the model must execute the **Handoff Transaction** below before presenting the final handoff.

A summary alone is not a completed handoff.

---

## 9. Handoff Transaction

Perform in this order:

### Step 1 — Re-read authoritative state

Read the current versions of:

```text
PROJECT.md
CURRENT_STATE.md
DECISIONS.md
CONSTRAINTS.md
```

and any governing files materially affected by the work.

### Step 2 — Reconcile session evidence

Compare:

```text
repository state before session
+
verified work completed in session
+
current repository state
```

Do not persist claims that were not verified.

### Step 3 — Update durable files

Update only files whose durable content materially changed.

Normally:

- `CURRENT_STATE.md` — update whenever present truth changed.
- `DECISIONS.md` — append/update only durable decisions.
- `CONSTRAINTS.md` — update only hard boundaries.
- `ARCHITECTURE.md` / specs — update only when their governed content actually changed.
- `CHANGELOG.md` — update only when the Project uses it and the change qualifies.

Do not modify `PROJECT_CONTEXT_PROTOCOL.md` merely to record routine state.

### Step 4 — Write to GitHub

Persist the updated files to the designated GitHub repository using the available authorized GitHub mechanism.

Use a concise commit message describing the state change.

Do not claim that GitHub was updated unless the write operation succeeded.

### Step 5 — Verify the write

Re-read or otherwise verify the committed repository state.

Confirm that:

- the intended files contain the new state;
- the commit exists;
- no unintended context files were changed;
- `CURRENT_STATE.md` contains one exact next action;
- no unresolved contradiction was silently introduced.

### Step 6 — Produce the handoff

Only after successful verification, provide a concise handoff containing:

```text
Repository:
Verified checkpoint:
Current branch/SHA/version when material:
Completed:
Blocked:
Important active constraints:
Exact next action:
Context commit:
```

The handoff must point the next model back to the repository rather than duplicating the full Project history.

---

## 10. Handoff Completion Gate

A handoff is **PASS** only when all applicable conditions are true:

- current session changes have been reconciled;
- durable files have been updated;
- GitHub write succeeded;
- written state was verified;
- exact next action is present;
- no material contradiction remains unresolved.

If any required condition fails, the handoff is **INCOMPLETE**.

Do not represent an incomplete handoff as complete.

---

## 11. New-Chat Continuation Command

A new chat should be able to begin with a minimal instruction such as:

> Continue from the authoritative Project state in the designated GitHub repository. Read the governing context files first and proceed from the exact next action in `CURRENT_STATE.md`.

The user should not need to paste a large historical handoff.

---

## 12. Cross-Model Portability

This protocol is model-independent.

Any LLM or agent may participate if it has authorized read access to the repository.

To perform state updates and complete handoffs, the agent must also have authorized write access.

Examples include:

- ChatGPT;
- Codex;
- Claude Code;
- OpenCode;
- DeepSeek-based agents;
- Gemini-based agents;
- other GitHub-capable LLM runtimes.

The repository, not the LLM vendor, owns Project continuity.

If an agent has read-only access, it may use the state but must not claim to have completed the Handoff Transaction.

---

## 13. Write Safety

Before modifying GitHub context:

- preserve unrelated user work;
- do not overwrite newer authoritative changes without reconciling them;
- verify repository and branch identity;
- use the smallest necessary context-file change;
- never store credentials, secrets, tokens, passwords, or sensitive authentication material in Project memory;
- do not force-push or destructively rewrite history for routine state maintenance.

If concurrent changes create a material conflict, resolve the authoritative state before committing.

---

## 14. State File Contract

`CURRENT_STATE.md` must use this structure:

```text
# Current State

Project:
Current objective:
Verified checkpoint:
Current environment / branch / version:
Completed:
In progress:
Blocked:
Important constraints:
Exact next action:
Last verified:
```

Rules:

- one present truth;
- one exact next action;
- verified facts only;
- concise enough to load at every new chat;
- no transcript;
- no obsolete state presented as current.

---

## 15. Decision File Contract

Use:

```text
## Decision: [short name]

Date:
Status: Active | Superseded | Reversed

Decision:
[durable decision]

Reason:
[why it was made]

Implication:
[what future work must respect]
```

Do not store temporary implementation choices unless they govern future work.

---

## 16. Constraint File Contract

Store only hard boundaries that future work must respect.

Examples:

- prohibited system changes;
- authorization boundaries;
- security requirements;
- scope freezes;
- required approval gates;
- production restrictions;
- immutable contracts.

Do not use `CONSTRAINTS.md` for preferences or temporary notes.

---

## 17. Verification Rule

The model must distinguish:

```text
KNOWN
VERIFIED
ASSUMED
UNRESOLVED
```

Only verified durable state may be written as completed truth.

When evidence contradicts existing state, reopen only the dependent state or decision. Do not silently rewrite history.

---

## 18. Anti-Drift Rules

Never:

- treat an old chat summary as more authoritative than current GitHub state;
- mark work complete because it was planned;
- overwrite current state with a stale handoff;
- duplicate the same authoritative fact across many files unnecessarily;
- update every file at every handoff when nothing changed;
- create a giant context dump;
- claim a commit, push, test, deployment, or verification that was not directly confirmed;
- continue substantive work from an uncertain repository baseline when that uncertainty could change the result.

---

## 19. Operating Shortcut

The normal lifecycle is:

```text
NEW CHAT
→ READ GITHUB STATE
→ LOAD MINIMUM REQUIRED CONTEXT
→ WORK
→ VERIFY
→ USER REQUESTS HANDOFF
→ RECONCILE STATE
→ UPDATE DURABLE FILES
→ COMMIT TO GITHUB
→ VERIFY COMMIT
→ RETURN SHORT HANDOFF
→ NEW CHAT READS GITHUB
```

---

## 20. Governing Outcome

A Project using this protocol should be able to move between chats and between compatible LLMs without rebuilding context from memory.

The repository is the durable Project brain.

The model is a temporary reasoning and execution layer.

**No verified GitHub update means no completed handoff.**
