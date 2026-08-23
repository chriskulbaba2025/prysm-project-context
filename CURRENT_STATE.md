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
- `src/application/production-runtime.js` is complete for this work-package stage. It imports the UAT renderer, exposes one read-only `getNarrativeV2UatRender(auditId, tenantId)` method, and exposes that method through `auditService`.
- `production-runtime.js` verification passed: syntax, `git diff --check`, full Git diff, and `node --test .\src\application\report-design-boundary.test.js` with 3/3 PASS.
- `Pasted code(10).js` is the accepted manual baseline for `src/server.js`.
- `server.js` contains one exact bounded GET route at `/api/v1/audits/d3b4cc62-9217-4c0b-b169-e24beb46a79c/uat-render` inserted immediately before the existing audit-status route matcher.
- Latest server diff shows only that route addition. It reuses `authorizeAuditAccess(...)`, `auditService.getAuditStatus(...)`, `authorizeReportAccess(...)`, and `reportPageLimiter`, then calls only `auditService.getNarrativeV2UatRender(...)` and streams returned HTML bytes with `cache-control: no-store` and `x-prysm-viewer-version`.
- No existing report route, report artifact, lifecycle state, provider path, or model path was modified.
- Server syntax/diff verification passed: `node --check .\src\server.js` and `git diff --check` produced no errors; full no-pager diff showed only the intended bounded route.
- Existing real-handler authorization regression `node --test .\src\identity\server-auth-fail-closed.test.js` passed 1/1 on 2026-08-22. It dynamically imports the real `createRequestHandler` and confirms the internal/principal auth boundaries remain fail-closed after the UAT route addition.
- The smallest direct route-test harness is the existing `src/identity/server-auth-fail-closed.test.js`; it already imports the real `createRequestHandler`, provides request/response test doubles, and uses memory identity/lifecycle repositories.
- `createMemoryLifecycleRepository()` already exposes `findAuditTenant(auditId)`, so the direct UAT route test can exercise the real audit-ownership authorization path without modifying application code.
- Unrelated `../../lifecycle-failure.txt` remains untouched.
- Historical stash entries remain untouched.

Completed:
- Report v2 rebuild, targeted tests, CI, merge, and production deployment verification.
- Root cause of visual-UAT blocker verified: immutable persisted report bytes are older than deployed Viewer v2.2.0 renderer.
- Bounded UAT rerender authorization persisted in `CONSTRAINTS.md`.
- Local shell-path mismatch resolved.
- `production-path.js` UAT source-file unit completed and verified.
- `production-runtime.js` UAT source-file unit completed and verified.
- Manual VS Code handoff for exact current `server.js` completed.
- Bounded server UAT route inserted and syntax/diff verified.
- Existing server fail-closed authorization regression passed 1/1.
- Direct UAT route test harness selected: `src/identity/server-auth-fail-closed.test.js`; no new test file is needed.

In progress:
- Extend only `src/identity/server-auth-fail-closed.test.js` with narrowly-scoped direct route tests proving unauthorized denial and successful authorized Viewer v2.2.0 byte streaming through `auditService.getNarrativeV2UatRender(...)`.

Blocked:
- No current application-code blocker established.

Important constraints:
- Work one verified application source/test file at a time.
- Do not directly edit `vantage-platform` unless the user explicitly changes the manual operating method.
- User must supply the exact current `src/identity/server-auth-fail-closed.test.js` from the verified Desktop working copy before modification.
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
From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, run exactly `code .\src\identity\server-auth-fail-closed.test.js`. In VS Code, press `Ctrl+A`, then `Ctrl+C`, and paste the exact current test file into the chat. Do not edit it first and do not use the GitHub copy as a substitute for the local working copy.

Last verified:
2026-08-22
