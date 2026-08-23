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
- The exact current `src/server.js` was opened from the verified Desktop working copy and supplied as `Pasted code(10).js`; it is the accepted manual baseline for the third source-file unit.
- `Pasted code(10).js` already contains the required reusable security boundaries: `authorizeAuditAccess(...)`, `authorizeReportAccess(...)`, `reportPageLimiter`, `sendRouteError(...)`, and the governed `/api/v1/audits` request boundary.
- The smallest server implementation is one exact read-only GET route for the single authorized UAT audit ID. It will reuse the existing tenant ownership check, report-role authorization, and report rate limiter, then call only `auditService.getNarrativeV2UatRender(...)` and stream the returned in-memory HTML bytes.
- No existing report route, report artifact, lifecycle state, provider path, or model path needs to be modified.
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

In progress:
- Add the one bounded authenticated UAT GET route to `src/server.js`, then verify syntax and full diff before any test or deployment step.

Blocked:
- No current application-code blocker established.

Important constraints:
- Work one verified application source file at a time.
- Do not directly edit `vantage-platform` unless the user explicitly changes the manual operating method.
- `Pasted code(10).js` is the accepted baseline for `server.js`; do not substitute an earlier copy.
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
In the already-open `src/server.js`, locate the comment `// GET /api/v1/audits/:auditId — audit status`. Immediately above that comment, insert the complete bounded GET route supplied in the current chat for `/api/v1/audits/d3b4cc62-9217-4c0b-b169-e24beb46a79c/uat-render`. The route must: require `auditService.getNarrativeV2UatRender`; call `authorizeAuditAccess`; resolve current audit state through `auditService.getAuditStatus`; call `authorizeReportAccess`; apply `reportPageLimiter`; call only `auditService.getNarrativeV2UatRender`; and stream returned HTML bytes with `no-store`. Save the file. Make no other change. Then run `node --check .\src\server.js`, `git diff --check`, and `git --no-pager diff -- src/server.js`, and paste the complete output before proceeding.

Last verified:
2026-08-22
