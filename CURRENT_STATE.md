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
- `server.js` syntax/diff checks passed. Existing real-handler fail-closed regression remained green after the route addition.
- `src/identity/server-auth-fail-closed.test.js` now contains the direct UAT-route acceptance proof. Because importing `server.js` starts a real listener as a module side effect, the test temporarily suppresses `Server.prototype.listen` only during that import and restores it immediately afterward; no forced `process.exit()` remains.
- Direct route acceptance proof passed cleanly on 2026-08-22: 5 tests / 5 pass / 0 fail / 0 cancelled in `node --test .\src\identity\server-auth-fail-closed.test.js`. The two UAT-specific assertions prove unauthenticated denial before rendering bytes and successful authorized Viewer v2.2.0 byte streaming through the stubbed read-only UAT service.
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
- Direct UAT-route acceptance test completed and passed 5/5 with 0 fail and 0 cancelled.

In progress:
- Re-verify the complete local work-package diff before any deployment or production UAT endpoint call.

Blocked:
- No application-code blocker established. Deployment remains intentionally blocked until the complete local diff is re-verified.

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
- Do not deploy or call the production UAT endpoint until the complete local diff is re-verified.

Exact next action:
From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, run exactly: `git status --short; git diff --check; git diff -- src/narrative-v2/production-path.js src/application/production-runtime.js src/server.js src/identity/server-auth-fail-closed.test.js` and paste the complete output into the chat. Do not commit, deploy, or call the production UAT endpoint yet.

Last verified:
2026-08-22
