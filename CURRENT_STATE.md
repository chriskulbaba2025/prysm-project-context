# Current State

Project:
PRYSM — governed website conversion-readiness report

Current objective:
Complete authorized work package `PRYSM-V2-UAT-RERENDER-01`: produce a read-only Viewer v2.2.0 UAT render for existing audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` from already-persisted governed inputs, with zero provider calls, zero Writer/Judge/model calls, no new audit, no lifecycle transition, and no mutation of the approved report artifact.

Verified checkpoint:
- Authoritative context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Application working base: local `main` at `c116e730a38539066852f107582959693e666781` before the current uncommitted work-package edits.
- Working directory: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Current governed viewer contract: Viewer v2.2.0 / 16 pages; report design metadata 2.0.0; scoring remains 4.1.1.
- Existing completed audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` still serves immutable persisted Viewer v2.1.0 bytes. This work package must not rewrite that artifact.
- `NV2-PROD-02` is a verified pre-existing clean-main defect (5 PASS / 1 FAIL in `src/application/narrative-v2-production-path.test.js`) and remains out of scope.
- `src/narrative-v2/production-path.js` has the bounded UAT renderer additions only: Viewer-version import, authorized audit-ID constant, and one exported `renderNarrativeV2UatFromPersistedArtifacts(...)`. Syntax and diff checks passed; accidental duplicate function was removed.
- `src/application/production-runtime.js` has the bounded read-only runtime wiring only: import UAT renderer, add `getNarrativeV2UatRender(auditId, tenantId)`, expose it through `auditService`. Syntax/diff checks passed. `node --test .\src\application\report-design-boundary.test.js` passed 3/3.
- `src/server.js` has one bounded GET route only: `/api/v1/audits/d3b4cc62-9217-4c0b-b169-e24beb46a79c/uat-render`. It reuses `authorizeAuditAccess(...)`, `auditService.getAuditStatus(...)`, `authorizeReportAccess(...)`, and `reportPageLimiter`, then calls only `auditService.getNarrativeV2UatRender(...)` and streams returned HTML bytes with `cache-control: no-store` and `x-prysm-viewer-version`.
- `server.js` syntax/diff checks passed. Existing real-handler fail-closed regression `node --test .\src\identity\server-auth-fail-closed.test.js` passed 1/1 after the route addition.
- The existing `src/identity/server-auth-fail-closed.test.js` is the selected smallest direct route-test harness. It already imports the real `createRequestHandler`, provides request/response test doubles, and uses memory identity/lifecycle repositories. `createMemoryLifecycleRepository()` already exposes `findAuditTenant(auditId)`.
- No direct success-path test of the new UAT route has been added yet. The route must not be deployed or treated as complete until that direct proof is added and passes.
- Unrelated `../../lifecycle-failure.txt` remains untouched.
- Historical stash entries remain untouched.

Current environment / branch / version:
- Context repo: `chriskulbaba2025/prysm-project-context`, branch `main`.
- Application repo: `chriskulbaba2025/vantage-platform`, local branch `main`, base HEAD `c116e730a38539066852f107582959693e666781` plus current uncommitted work-package edits.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Viewer target: v2.2.0 / 16 pages.

Completed:
- Report v2 rebuild, targeted tests, CI, merge, and production deployment verification.
- Root cause of visual-UAT blocker verified: immutable persisted report bytes are older than deployed Viewer v2.2.0 renderer.
- Bounded UAT rerender authorization persisted in `CONSTRAINTS.md`.
- `production-path.js` UAT source-file unit completed and verified.
- `production-runtime.js` UAT source-file unit completed and verified.
- `server.js` bounded UAT route added and syntax/diff verified.
- Existing production-boundary regression passed 3/3.
- Existing server fail-closed authorization regression passed 1/1.

In progress:
- Add narrowly-scoped direct route tests to the existing `src/identity/server-auth-fail-closed.test.js` proving unauthorized denial and successful authorized Viewer v2.2.0 byte streaming through the stubbed read-only UAT service.

Blocked:
- No application-code blocker established. Deployment is intentionally blocked on direct UAT-route acceptance proof.

Important constraints:
- GitHub context is authoritative durable memory; new chats must read `PROJECT.md`, `CURRENT_STATE.md`, active `CONSTRAINTS.md`, and active `DECISIONS.md` before substantive work.
- Manual VS Code workflow remains mandatory: one verified source/test file at a time; do not directly edit `vantage-platform` unless the user explicitly changes the method.
- User supplies the exact current local file before modification. Do not substitute a stale or repository copy when the local working copy is required.
- Code is inline-only; never deliver PRYSM code as downloadable files.
- No provider, Writer, Judge, or other model calls for the UAT rerender path.
- No new audit.
- No lifecycle transition or state rewrite.
- No overwrite/delete/mutation of existing report, canonical evidence, scoring, findings, Narrative v2, or manifest artifacts.
- Normal tenant/report authorization must execute before any UAT bytes are returned.
- Do not edit `services/worker/src/report/sections-conversion.js`.
- Do not repair `NV2-PROD-02` in this work package.
- Do not modify historical stash entries or unrelated `lifecycle-failure.txt`.
- Do not deploy or call the production UAT endpoint until the direct route test passes and the complete local diff is re-verified.

Exact next action:
From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, run exactly `code .\src\identity\server-auth-fail-closed.test.js`. In VS Code, press `Ctrl+A`, then `Ctrl+C`, and paste the exact current local test file into the new chat. Do not edit it first. The new chat must read the authoritative project context repository before proposing the test edit.

Last verified:
2026-08-22
