# Current State

Project:
PRYSM — governed website conversion-readiness report

Current objective:
Complete authorized work package `PRYSM-V2-UAT-RERENDER-01`: produce and visually inspect a read-only Viewer v2.2.0 UAT render for existing audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` from already-persisted governed inputs, with zero provider calls, zero Writer/Judge/model calls, no new audit, no lifecycle transition, and no mutation of the approved report artifact.

Verified checkpoint:
- Authoritative context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Application working base before this work package: `main` at `c116e730a38539066852f107582959693e666781`.
- Verified work-package commit: `33ec9b63083f62141141ea6363828c9e8152f188` — `feat(report-v2): add read-only UAT rerender route`.
- The commit contains exactly four intended files: `services/worker/src/application/production-runtime.js`, `services/worker/src/identity/server-auth-fail-closed.test.js`, `services/worker/src/narrative-v2/production-path.js`, and `services/worker/src/server.js`.
- Direct UAT-route acceptance proof passed cleanly: 5 tests / 5 pass / 0 fail / 0 cancelled.
- Complete local work-package diff was verified clean; `git diff --check` returned no output.
- The only remaining local status item after commit is pre-existing unrelated `../../lifecycle-failure.txt`, which remains untouched and untracked.
- Commit `33ec9b63083f62141141ea6363828c9e8152f188` was pushed successfully to `origin/main`; remote GitHub verification confirms the exact commit SHA and message.
- Railway and both Vercel deployment statuses attached to the commit are SUCCESS.
- Push-triggered `Vantage Worker CI` run `32613952114` completed successfully on 2026-08-22. Every configured step passed, including `npm test`, Narrative v2, schemas, artifacts, lifecycle + Postgres, WP2–WP12 acceptance, and provisioning. The Node 20 deprecation annotation is informational and did not fail the run.
- Production worker base URL is `https://vantage-platform-production.up.railway.app`.
- First authorized production read-only UAT render call completed successfully on 2026-08-22 for audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c`: HTTP 200, `x-prysm-viewer-version: 2.2.0`, `cache-control: no-store`, 134274 bytes returned and saved locally as `prysm-v2.2.0-uat.html` in the worker directory.
- The UAT render remains a transient local inspection artifact only. The immutable persisted Viewer v2.1.0 report artifact was not overwritten or mutated.
- `NV2-PROD-02` remains a verified pre-existing clean-main defect and is out of scope.
- Historical stash entries remain untouched.

Current environment / branch / version:
- Context repo: `chriskulbaba2025/prysm-project-context`, branch `main`.
- Application repo: `chriskulbaba2025/vantage-platform`, local and remote `main` at `33ec9b63083f62141141ea6363828c9e8152f188` as last verified.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Production worker: `https://vantage-platform-production.up.railway.app`.
- Viewer target: v2.2.0 / 16 pages.
- Local UAT file: `C:\Users\kulba\Desktop\vantage-platform\services\worker\prysm-v2.2.0-uat.html`.

Completed:
- Report v2 rebuild, targeted tests, CI, merge, and production deployment verification for the prior Viewer v2.2.0 release.
- Root cause of visual-UAT blocker verified: immutable persisted report bytes are older than deployed Viewer v2.2.0 renderer.
- Bounded UAT rerender authorization persisted in `CONSTRAINTS.md`.
- UAT renderer source-file unit completed and verified.
- UAT runtime wiring source-file unit completed and verified.
- Bounded UAT route source-file unit completed and verified.
- Direct UAT-route acceptance test passed 5/5 with 0 fail and 0 cancelled.
- Complete local four-file diff verified clean; no unintended application files were modified.
- Work package committed and pushed to `origin/main` at `33ec9b63083f62141141ea6363828c9e8152f188`.
- Commit file set verified: exactly four intended files.
- Railway/Vercel deployment statuses verified successful.
- `Vantage Worker CI` run `32613952114` verified SUCCESS tip-to-tail.
- First production read-only UAT render call verified: HTTP 200 / Viewer 2.2.0 / no-store / 134274 bytes saved locally.

In progress:
- Visually inspect the local `prysm-v2.2.0-uat.html` render for the approved Viewer v2.2.0 / 16-page report presentation. Do not alter application code or publish/overwrite the approved persisted report artifact during inspection.

Blocked:
- No code, CI, deployment, or UAT-render blocker remains. Work package completion now depends on visual UAT findings.

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
- The UAT HTML must remain a transient local inspection artifact; do not publish it back over the approved report artifact.

Exact next action:
From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, run exactly: `start .\prysm-v2.2.0-uat.html`. Visually inspect the report in the browser. If anything looks wrong, capture a screenshot of the specific page/section and paste it into the chat. Do not edit or publish anything yet.

Last verified:
2026-08-22
