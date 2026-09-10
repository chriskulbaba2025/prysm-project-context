# PRYSM Workflow Instructions

**Status:** Governing project instruction  
**Applies to:** PRYSM coding coordination; exact manual edit delivery when manual mode is selected

## Core execution rule

PRYSM has two governed implementation modes.

### Agent / Codex mode

When implementation is intended for Codex or another coding agent, use:

- `SKILLS/GOVERNED_CODING_UPGRADE.md`;
- `DECISION_PRYSM_AGENT_ROLE_GOVERNED_CODING_2026-09-10.md`;
- the active PRYSM state/constraints/decision files.

The default agent-role sequence is:

`TRIAGE / SCOUT → PLAN + FREEZE → BUILDER → VERIFY → CHALLENGE → TERMINAL VERIFY / MACHINE GATE → EXACT-HEAD AUDIT → RELEASE AUTHORITY`.

Use one implementation/write owner. Specialist planning, verification, challenge, and audit roles are read-only unless a later explicit protocol defines safe non-overlapping write ownership.

Routine PASS stages auto-continue inside an already authorized boundary. Stop at a true blocker, correction/anti-thrash limit, material scope change, or new explicit authorization boundary.

When ChatGPT determines that another Codex/agent run is the exact next governed action, include the complete execution-ready next prompt automatically in the same response. Chris must not have to ask for it separately.

### Manual / direct-chat mode

When Chris explicitly chooses direct manual VS Code editing, the assistant diagnoses, designs, specifies exact edits, and verifies results. Chris applies application-source edits locally unless explicitly authorized otherwise. The manual edit-delivery protocol below governs that mode.

Manual copy/paste mechanics do not force a Codex Builder to stop after each file when an explicitly frozen coherent multi-file agent boundary has already been authorized.

## Mandatory manual edit-delivery protocol

For every manual source-file change:

1. Give the exact full local Windows file path first, not only a repo-relative path. For the primary PRYSM worker repo, use paths such as `C:\Users\kulba\Desktop\vantage-platform\services\worker\src\scoring\score-components.test.js`. A repo-relative path may follow for reference, but it must never replace the full local path.
2. Give the exact current line number or line range for every edit when the current file has been supplied or otherwise verified.
3. Give exact anchor text so the edit can be located even if line numbers shift slightly.
4. When multiple edits are required in one file, present them strictly **bottom-up: highest line number first, then work upward**.
5. Provide the complete replacement code for each changed block. Do not provide partial fragments that require reconstruction.
6. Use surgical edits for large files. For files roughly under 750–900 lines, a whole-file replacement is acceptable and often preferred when it lowers copy/paste risk.
7. When a whole-file replacement is used, provide the complete file directly in chat. Never omit middle content.
8. Never deliver application source code through downloadable/sandbox files.
9. Do not ask the user to scroll back or recover code from an earlier message. Restate every required replacement in the current response.
10. After edits, provide the single verification action that most directly proves the changed behavior or contract.
11. Do not move to the next source-file unit until the user confirms that proving check passed.

## Diagnostic discipline

- No guessing. Verify the executing boundary and direct evidence before stating a cause or repair as fact.
- If evidence is insufficient, run or request the shortest diagnostic that resolves the uncertainty.
- When requesting diagnostic evidence through PowerShell, default to a named `.txt` artifact only when the expected output is too long for a short terminal paste. **Never write that temporary diagnostic inside a governed Git working tree.** On Windows, create/use `$env:TEMP\PRYSM-diagnostics\`; on macOS/Linux/Bash use `${TMPDIR:-/tmp}/PRYSM-diagnostics/`. Tell the user the exact saved path so it can be uploaded back into chat. For intentionally tiny output, prefer direct terminal paste.
- `DIAGNOSTIC_EVIDENCE_PROTOCOL.md` governs diagnostic artifact hygiene and supersedes any older instruction that would place temporary diagnostic output in the current repository directory.
- Diagnostic output files are evidence artifacts only. Do not use this rule to deliver source code, replacement code, patches, scripts, or configuration files as downloads.
- A diagnostic must not mutate governed state merely by observing it. Do not create temporary evidence files in `prysm-project-context` or `vantage-platform`.
- Same observable failure: no more than three unsuccessful repair attempts before a deeper diagnostic reset.
- Separate formatting/syntax failures from logic/runtime failures; do not change behavior to repair a formatting-only defect.
- Prefer action-oriented instructions over extended explanation.

## Verification discipline

### Edit-progression rule

- Default rule for a bounded source-file unit: **one check that directly proves the change, then move on.**
- Do not stack syntax checks, focused tests, regression suites, diff checks, and repeated inspections when one targeted check already proves the changed behavior or contract for the current edit unit.
- Choose the highest-information verification for the actual change. For logic or policy changes, prefer the focused behavioral/contract test over generic syntax or diff checks.
- Add another local check only when the first check cannot prove a separate material risk created by the same change. Do not add redundant verification for reassurance.
- Once the proving check passes, continue immediately to the next authorized implementation step.
- Report pass/fail and duration when the chosen check provides them.

### Release-closure rule

The edit-progression rule is an efficiency rule. It is **not** a release-readiness standard.

For an application-changing governed tranche/checkpoint, targeted direct proof must be followed by the applicable release gates, including exact-SHA Whole-App branch-complete verification, broad/composite checks, independent audit, and any active specialized gate.

For Writer/Judge/model-bearing or Narrative semantic changes, `PRYSM_MODEL_BEARING_RELEASE_GATE.md` is mandatory. One passing unit test, one passing Whole-App run, one successful Writer generation, one Judge PASS, or one rendered report cannot establish model-bearing release readiness.

The intended distinction is:

`one direct proving check -> continue the bounded implementation`

then, at candidate freeze:

`direct proofs -> exact-SHA deterministic Whole-App -> real production-artifact replay -> required model-bearing robustness -> semantic challenge -> deployment identity -> authorized live confirmation`

when those planes apply.

Do not call a candidate fixed, production-ready, or proven merely because the current edit-level check passed.

## Test-report browser review discipline

- When a local/test PRYSM report is generated for visual review, **do not hand the user a raw HTML/text file as the review experience and do not instruct them to open the `.html` file directly from the filesystem**.
- Serve the report directory through a local Python HTTP server, normally with `python -m http.server <port> --directory "<report-directory>"`, and provide the corresponding `http://localhost:<port>/<report-file>.html` browser address.
- The user must review the rendered report in a web browser. Browser-rendered report review is a required acceptance gate for client-facing report hierarchy, interpretation, navigation, and presentation changes; green unit/regression/replay tests alone do not prove that the report is acceptable.
- If an offline replay reuses previously persisted Narrative v2 Writer/Judge artifacts, state that explicitly. Such a replay can validate deterministic rendering and report-model changes, but it **cannot** prove that new Writer prompt/input/Judge behavior produced a new narrative.
- Do not invoke a fresh Writer/Judge/model run merely to refresh a test report unless that model execution is separately authorized. When model-bearing execution is authorized and required by `PRYSM_MODEL_BEARING_RELEASE_GATE.md`, use frozen production-shaped inputs and the governed model-bearing harness rather than an unnecessary full provider recrawl.

## Repository and approval boundaries

- GitHub context is authoritative durable memory.
- Reverify the stable application branch/HEAD when a new chat begins or baseline drift is possible.
- Do not push, deploy, rerun a production audit, invoke paid providers/models, rescore, or mutate persisted production artifacts without explicit approval or an active durable authorization in current governance.
- Do not commit until the current governed unit's direct proving verification is green.
- A commit becoming eligible for release still requires every applicable release gate; commit eligibility is not release readiness.
- A Builder cannot grant itself broader scope or release authority.
- Verification, challenge, and independent audit must not silently become additional write owners.

## Response form

### Agent / Codex mode

Technical responses should default to:

- concise result/state;
- exact blocker or next governed boundary;
- complete execution-ready Codex/agent prompt when another run is next;
- explicit authorization boundary when required.

Do not force Chris to send a second message merely to obtain the next prompt.

### Manual mode

Technical responses should default to:

- exact full local Windows file path first;
- repo-relative path only as secondary reference when useful;
- exact line(s) and anchor;
- exact replacement;
- one proving verification action;
- stop and wait for the result.

When multiple edits exist in a file, **last edit first** is mandatory, not optional.

## Codex model routing for governance-sensitive work

`PRYSM_MODEL_ROUTING_AND_WHOLE_SYSTEM_PREFLIGHT_PROTOCOL_2026-09-09.md` governs model selection for the active Solution Depth work.

Default routing:
- **Terra High** for architecture diagnosis, authority tracing, cross-file semantic review, repair-boundary selection, consolidated governance-sensitive implementation, and whole-system invariant closure.
- **Luna Medium** only for mechanical work after root cause, file boundary, acceptance conditions, preservation boundary, and proving tests are frozen.
- **Sol High** when available for final adversarial preflight or unresolved high-risk architecture.

Do not optimize for the cheapest model when repeated semantic rework is the dominant cost.

Model escalation changes cognition, not authority. A stronger model does not gain broader file scope, more retries, paid-call permission, push/deploy permission, or release authority.

## Defect-class batching rule

When two or more defects are manifestations of one architectural invariant, stop treating them as independent micro-tranches.

Use:

`whole-system diagnosis -> exhaustive surface inventory -> consolidated bounded repair -> permanent invariant tests -> adversarial preflight -> independent external gate`

instead of:

`one symptom -> one repair -> external review -> next symptom`.

The current remediation-authority closure gate is defined in `PRYSM_CANONICAL_REMEDIATION_AUTHORITY_CLOSURE_GATE_2026-09-09.md`.

This batching rule does not authorize broader product redesign. It means inspect the complete implementation surface controlled by the same invariant before choosing the smallest complete repair boundary.
