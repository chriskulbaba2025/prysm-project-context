# Current State

Project:
PRYSM — governed website conversion-readiness report

Current objective:
Execute authorized work package `PRYSM-V2-UAT-RERENDER-01`: produce a read-only Viewer v2.2.0 UAT render for existing audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` from already-persisted governed inputs, with zero provider calls, zero Writer/Judge/model calls, no new audit, no lifecycle transition, and no mutation of the approved report artifact.

Verified checkpoint:
- Authoritative context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Application base `main`: `c116e730a38539066852f107582959693e666781`.
- Working directory: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Current governed viewer contract: Viewer v2.2.0 / 16 pages.
- Existing completed audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` still serves immutable persisted Viewer v2.1.0 bytes; this work package must not rewrite that artifact.
- `NV2-PROD-02` remains a verified pre-existing clean-main defect and is out of scope.
- `Pasted code(8).js` is the accepted clean manual baseline for `src/narrative-v2/production-path.js`.
- The stale earlier `Pasted code(7).js` remains disqualified.
- `production-path.js` now contains exactly these intended UAT additions:
  1. `import { REPORT_V2_VIEWER_VERSION } from "../report/render-report-v2.js";`
  2. `const UAT_RERENDER_AUDIT_ID = "d3b4cc62-9217-4c0b-b169-e24beb46a79c";`
  3. one exported `renderNarrativeV2UatFromPersistedArtifacts(...)` function inserted immediately after `buildV2Model(...)` and before `runNarrativeV2FromScored(...)`.
- The accidental duplicate copy of the UAT renderer function has been removed.
- Latest verification passed silently:
  - `node --check .\src\narrative-v2\production-path.js`
  - `git diff --check`
- Latest `git --no-pager diff -- src/narrative-v2/production-path.js` shows exactly one import, one authorized audit-ID constant, and one read-only UAT renderer function; no other application-source change is present in this file.
- The UAT renderer reads persisted WriterInput, orchestration result, canonical findings/scores, capability evidence, and decision evidence; validates the persisted release candidate; runs the deterministic finalization gate; renders Viewer v2.2.0 HTML in memory; returns bytes; and does not write artifacts or transition lifecycle state.
- Unrelated `../../lifecycle-failure.txt` remains untouched.
- Historical stash entries remain untouched.

Completed:
- Report v2 rebuild, targeted tests, CI, merge, and production deployment verification.
- Root cause of visual-UAT blocker verified: immutable persisted report bytes are older than deployed Viewer v2.2.0 renderer.
- Bounded UAT rerender authorization persisted in `CONSTRAINTS.md`.
- Local shell-path mismatch resolved.
- Manual VS Code handoff for exact `production-path.js` completed.
- `production-path.js` UAT source-file unit is now modified and verified by syntax check, diff check, and full Git diff.

In progress:
- Move to the next required application source-file unit, `src/application/production-runtime.js`, using the same manual VS Code handoff method.

Blocked:
- No current application-code blocker established.

Important constraints:
- Work one verified application source file at a time.
- Do not directly edit `vantage-platform` unless the user explicitly changes the manual operating method.
- User supplies the exact current file from the verified working copy before modification.
- Never deliver PRYSM code files through generated/downloadable links; code must be inline in chat.
- No provider, Writer, Judge, or other model calls for the UAT rerender path.
- No new audit.
- No lifecycle transition or state rewrite.
- No overwrite/delete/mutation of existing report, canonical evidence, scoring, findings, Narrative v2, or manifest artifacts.
- Normal tenant/report authorization must remain in force.
- Do not edit `services/worker/src/report/sections-conversion.js`.
- Do not repair `NV2-PROD-02` in this work package.
- Do not modify historical stash entries.
- Avoid full-file rewrites; use surgical edits only.
- Give one exact edit at a time with an exact search anchor, insertion/replacement text, and verification command set.

Exact next action:
From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, run exactly `code .\src\application\production-runtime.js`. In the VS Code editor that opens, press `Ctrl+A`, then `Ctrl+C`, and paste that exact current file into the chat. Do not edit it first and do not use any earlier copy.

Last verified:
2026-08-22
