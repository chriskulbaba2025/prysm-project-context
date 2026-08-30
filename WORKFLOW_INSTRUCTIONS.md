# PRYSM Workflow Instructions

**Status:** Governing project instruction
**Applies to:** All manual application-code work unless the user explicitly changes the operating method

## Core execution rule

PRYSM application changes use a governed manual VS Code workflow. The assistant diagnoses, designs, specifies exact edits, and verifies results. The user applies application-source edits locally unless explicitly authorized otherwise.

## Mandatory edit-delivery protocol

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
- When requesting diagnostic evidence through PowerShell, default to a command that writes the diagnostic output to a named `.txt` file in the current working directory using `Set-Content` (or an equivalent redirection), then tell the user the exact saved path so that text file can be uploaded back into chat for review. Prefer this over asking the user to paste long terminal output. Direct paste is appropriate only when the expected result is intentionally tiny, such as a single line or short summary.
- Diagnostic output files are evidence artifacts only. Do not use this rule to deliver source code, replacement code, patches, scripts, or configuration files as downloads.
- Same observable failure: no more than three unsuccessful repair attempts before a deeper diagnostic reset.
- Separate formatting/syntax failures from logic/runtime failures; do not change behavior to repair a formatting-only defect.
- Prefer action-oriented instructions over extended explanation.

## Verification discipline

- Default rule: **one check that directly proves the change, then move on.**
- Do not stack syntax checks, focused tests, regression suites, diff checks, and repeated inspections when one targeted check already proves the changed behavior or contract.
- Choose the highest-information verification for the actual change. For logic or policy changes, prefer the focused behavioral/contract test over generic syntax or diff checks.
- Add another check only when the first check cannot prove a separate material risk created by the same change. Do not add redundant verification for reassurance.
- Once the proving check passes, continue immediately to the next authorized step.
- Report pass/fail and duration when the chosen check provides them.

## Test-report browser review discipline

- When a local/test PRYSM report is generated for visual review, **do not hand the user a raw HTML/text file as the review experience and do not instruct them to open the `.html` file directly from the filesystem**.
- Serve the report directory through a local Python HTTP server, normally with `python -m http.server <port> --directory "<report-directory>"`, and provide the corresponding `http://localhost:<port>/<report-file>.html` browser address.
- The user must review the rendered report in a web browser. Browser-rendered report review is a required acceptance gate for client-facing report hierarchy, interpretation, navigation, and presentation changes; green unit/regression/replay tests alone do not prove that the report is acceptable.
- If an offline replay reuses previously persisted Narrative v2 Writer/Judge artifacts, state that explicitly. Such a replay can validate deterministic rendering and report-model changes, but it **cannot** prove that new Writer prompt/input/Judge behavior produced a new narrative.
- Do not invoke a fresh Writer/Judge/model run merely to refresh a test report unless that model execution is separately authorized. First make the deterministic/browser-rendered report internally consistent, then obtain any required approval for a fresh narrative generation.

## Repository and approval boundaries

- GitHub context is authoritative durable memory.
- Reverify the stable application branch/HEAD when a new chat begins or baseline drift is possible.
- Do not push, deploy, rerun a production audit, invoke paid providers/models, rescore, or mutate persisted production artifacts without explicit approval.
- Do not commit until the current governed unit's single proving verification is green.

## Response form

Technical responses should default to:

- exact full local Windows file path first;
- repo-relative path only as secondary reference when useful;
- exact line(s) and anchor;
- exact replacement;
- one proving verification action;
- stop and wait for the result.

When multiple edits exist in a file, **last edit first** is mandatory, not optional.
