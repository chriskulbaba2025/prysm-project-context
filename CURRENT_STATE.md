# Current State

Project:
PRYSM — governed website conversion-readiness report

Current objective:
Complete authorized work package `PRYSM-V2-UAT-RERENDER-01`: produce a read-only Viewer v2.2.0 UAT render for existing audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` from already-persisted governed inputs, with zero provider calls, zero Writer/Judge/model calls, no new audit, no lifecycle transition, and no mutation of the approved report artifact.

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
- Production worker base URL is configured in `vercel.json` as `https://vantage-platform-production.up.railway.app`.
- Existing completed audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` still serves immutable persisted Viewer v2.1.0 bytes through the normal report path. This work package must not rewrite that artifact.
- `NV2-PROD-02` remains a verified pre-existing clean-main defect and is out of scope.
- Historical stash entries remain untouched.

Current environment / branch / version:
- Context repo: `chriskulbaba2025/prysm-project-context`, branch `main`.
- Application repo: `chriskulbaba2025/vantage-platform`, local and remote `main` at `33ec9b63083f62141141ea6363828c9e8152f188` as last verified.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Production worker: `https://vantage-platform-production.up.railway.app`.
- Viewer target: v2.2.0 / 16 pages.

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

In progress:
- Perform the first authorized production read-only UAT render call for audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c`, verify HTTP 200 and `x-prysm-viewer-version: 2.2.0`, save the returned HTML locally, then visually inspect it. This is a transient read-only render only.

Blocked:
- No code, CI, or deployment blocker remains for the authorized UAT render call.

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
From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, run exactly the following one-line command to call the deployed read-only UAT route using the Railway-injected production secret, print only status/viewer metadata, and save the returned bytes locally as `prysm-v2.2.0-uat.html`:

`railway run node -e "const fs=require('fs');fetch('https://vantage-platform-production.up.railway.app/api/v1/audits/d3b4cc62-9217-4c0b-b169-e24beb46a79c/uat-render',{headers:{'x-vantage-secret':process.env.VANTAGE_WEBHOOK_SECRET}}).then(async r=>{const b=Buffer.from(await r.arrayBuffer());console.log('HTTP',r.status);console.log('Viewer',r.headers.get('x-prysm-viewer-version'));console.log('Cache',r.headers.get('cache-control'));if(!r.ok){console.log(b.toString('utf8'));process.exit(1)}fs.writeFileSync('prysm-v2.2.0-uat.html',b);console.log('Saved',b.length,'bytes')}).catch(e=>{console.error(e);process.exit(1)})"`

Paste the complete output into the chat. Do not open or publish the saved HTML until HTTP 200 and Viewer 2.2.0 are confirmed.

Last verified:
2026-08-22
