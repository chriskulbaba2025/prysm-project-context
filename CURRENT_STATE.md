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
- `NV2-PROD-02` remains a verified pre-existing clean-main defect and is out of scope.
- `src/narrative-v2/production-path.js` contains the bounded read-only persisted-artifact UAT renderer only.
- `src/application/production-runtime.js` contains the bounded UAT renderer wiring only.
- `src/server.js` contains the one bounded GET route `/api/v1/audits/d3b4cc62-9217-4c0b-b169-e24beb46a79c/uat-render`, with normal audit/report authorization and report rate limiting before returned bytes.
- `src/identity/server-auth-fail-closed.test.js` contains the direct UAT-route acceptance proof and suppresses the server listen side effect only during test import.
- Direct UAT-route acceptance proof passed cleanly on 2026-08-22: 5 tests / 5 pass / 0 fail / 0 cancelled.
- Complete local work-package diff was re-verified on 2026-08-22. The diff contains only the four intended files above; `git diff --check` returned clean.
- `git status --short` showed only those four modified files plus pre-existing unrelated `../../lifecycle-failure.txt`, which remains untouched.
- Historical stash entries remain untouched.

Current environment / branch / version:
- Context repo: `chriskulbaba2025/prysm-project-context`, branch `main`.
- Application repo: `chriskulbaba2025/vantage-platform`, local branch `main`, base HEAD `c116e730a38539066852f107582959693e666781` plus four verified uncommitted work-package edits.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Viewer target: v2.2.0 / 16 pages.

Completed:
- Report v2 rebuild, targeted tests, CI, merge, and production deployment verification.
- Root cause of visual-UAT blocker verified: immutable persisted report bytes are older than deployed Viewer v2.2.0 renderer.
- Bounded UAT rerender authorization persisted in `CONSTRAINTS.md`.
- UAT renderer source-file unit completed and verified.
- UAT runtime wiring source-file unit completed and verified.
- Bounded UAT route source-file unit completed and verified.
- Existing production-boundary regression passed 3/3.
- Direct UAT-route acceptance test passed 5/5 with 0 fail and 0 cancelled.
- Complete local four-file diff verified clean; no unintended application files were modified.

In progress:
- Commit the verified four-file application work package locally without including unrelated `lifecycle-failure.txt`.

Blocked:
- No application-code blocker established. Production deployment/UAT endpoint call has not begun yet.

Important constraints:
- GitHub context is authoritative durable memory.
- Manual VS Code workflow remains mandatory; do not directly edit `vantage-platform` unless the user explicitly changes the method.
- Code is inline-only; never deliver PRYSM code as downloadable files.
- No provider, Writer, Judge, or other model calls for the UAT rerender path.
- No new audit.
- No lifecycle transition or state rewrite.
- No overwrite/delete/mutation of existing report, canonical evidence, scoring, findings, Narrative v2, or manifest artifacts.
- Normal tenant/report authorization must execute before any UAT bytes are returned.
- Do not edit `services/worker/src/report/sections-conversion.js`.
- Do not repair `NV2-PROD-02` in this work package.
- Do not modify historical stash entries or unrelated `lifecycle-failure.txt`.
- Do not include `../../lifecycle-failure.txt` in the application commit.

Exact next action:
From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, stage only the four verified work-package files and create one local commit: `git add src/narrative-v2/production-path.js src/application/production-runtime.js src/server.js src/identity/server-auth-fail-closed.test.js; git commit -m "feat(report-v2): add read-only UAT rerender route"; git status --short; git rev-parse HEAD`. Paste the complete output into the chat. Do not push or deploy yet.

Last verified:
2026-08-22
