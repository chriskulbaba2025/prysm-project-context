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
- `src/narrative-v2/production-path.js` is complete for this work-package stage and verified by `node --check`, `git diff --check`, and full Git diff. It contains exactly: Viewer-version import, authorized audit-ID constant, and one exported read-only `renderNarrativeV2UatFromPersistedArtifacts(...)` function.
- `Pasted code(9).js` is the accepted manual baseline for `src/application/production-runtime.js`.
- `production-runtime.js` now contains exactly the intended additive UAT wiring:
  1. import `renderNarrativeV2UatFromPersistedArtifacts` from `../narrative-v2/production-path.js`;
  2. one `getNarrativeV2UatRender(auditId, tenantId)` method that loads existing audit metadata, resolves `clientId`, loads the persisted AuditRequest, and calls only the read-only persisted-artifact renderer;
  3. one `getNarrativeV2UatRender,` property exposed through the existing frozen `auditService` object.
- Latest full `production-runtime.js` diff shows only those intended additions. No lifecycle transition, audit execution, artifact write, provider call, or model call was added.
- `node --check .\src\application\production-runtime.js` and `git diff --check` both passed silently.
- Targeted runtime regression test `node --test .\src\application\report-design-boundary.test.js` passed 3/3:
  - `PRYSM-V2-PROD-01a` PASS
  - `PRYSM-V2-PROD-01b` PASS
  - `PRYSM-V2-PROD-01c` PASS
  - 0 fail, 0 skipped, 0 todo.
- Unrelated `../../lifecycle-failure.txt` remains untouched.
- Historical stash entries remain untouched.

Completed:
- Report v2 rebuild, targeted tests, CI, merge, and production deployment verification.
- Root cause of visual-UAT blocker verified: immutable persisted report bytes are older than deployed Viewer v2.2.0 renderer.
- Bounded UAT rerender authorization persisted in `CONSTRAINTS.md`.
- Local shell-path mismatch resolved.
- `production-path.js` UAT source-file unit completed and verified.
- Manual VS Code handoff for exact `production-runtime.js` completed.
- `production-runtime.js` import, read-only UAT method, and `auditService` exposure are complete and verified by syntax, diff check, full Git diff, and the existing production-boundary regression suite (3/3 PASS).

In progress:
- Move to the third and final planned application source-file unit, `src/server.js`, using the same manual VS Code handoff method before any edit.

Blocked:
- No current application-code blocker established.

Important constraints:
- Work one verified application source file at a time.
- Do not directly edit `vantage-platform` unless the user explicitly changes the manual operating method.
- User must supply the exact current `server.js` from the verified working copy before modification.
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

Exact next action:
From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, run exactly `code .\src\server.js`. In the VS Code editor that opens, press `Ctrl+A`, then `Ctrl+C`, and paste that exact current file into the chat. Do not edit it first and do not use an earlier copy.

Last verified:
2026-08-22
