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
10. After edits, provide one consolidated verification block for that source-file unit.
11. Do not move to the next source-file unit until the user confirms the current verification result.

## Diagnostic discipline

- No guessing. Verify the executing boundary and direct evidence before stating a cause or repair as fact.
- If evidence is insufficient, run or request the shortest diagnostic that resolves the uncertainty.
- Same observable failure: no more than three unsuccessful repair attempts before a deeper diagnostic reset.
- Separate formatting/syntax failures from logic/runtime failures; do not change behavior to repair a formatting-only defect.
- Prefer action-oriented instructions over extended explanation.

## Verification discipline

For each source-file unit, use the smallest sufficient sequence, normally:

1. `node --check` for changed JavaScript files;
2. focused targeted tests for the changed contract;
3. relevant regression set when the unit closes;
4. `git --no-pager diff --check`;
5. final diff review before commit when the change set is material.

Report test totals, failures, and duration when available.

## Repository and approval boundaries

- GitHub context is authoritative durable memory.
- Reverify the stable application branch/HEAD when a new chat begins or baseline drift is possible.
- Do not push, deploy, rerun a production audit, invoke paid providers/models, rescore, or mutate persisted production artifacts without explicit approval.
- Do not commit until the current governed unit and its required regression set are green.

## Response form

Technical responses should default to:

- exact full local Windows file path first;
- repo-relative path only as secondary reference when useful;
- exact line(s) and anchor;
- exact replacement;
- one verification block;
- stop and wait for the result.

When multiple edits exist in a file, **last edit first** is mandatory, not optional.
