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
- Commit `33ec9b63083f62141141ea6363828c9e8152f188` was pushed successfully to `origin/main`; a second push returned `Everything up-to-date`.
- GitHub remote verification confirms the exact commit SHA and message on `main`.
- Commit statuses currently show SUCCESS for Railway (`GENSEN process - vantage-platform`) and both Vercel deployments (`vantage-platform` and `prysm`).
- `.github/workflows/worker-ci.yml` is configured to run `Vantage Worker CI` on pushes to `main` and on pull requests.
- The available GitHub connector did not surface the push-triggered Actions run for this direct `main` push, so the GitHub Actions CI result remains to be verified explicitly before production UAT endpoint use.
- Existing completed audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` still serves immutable persisted Viewer v2.1.0 bytes. This work package must not rewrite that artifact.
- `NV2-PROD-02` remains a verified pre-existing clean-main defect and is out of scope.
- Historical stash entries remain untouched.

Current environment / branch / version:
- Context repo: `chriskulbaba2025/prysm-project-context`, branch `main`.
- Application repo: `chriskulbaba2025/vantage-platform`, local and remote `main` at `33ec9b63083f62141141ea6363828c9e8152f188` as last verified.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
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
- Work package committed locally and pushed to `origin/main` at `33ec9b63083f62141141ea6363828c9e8152f188`.
- Remote commit and successful Railway/Vercel deployment statuses verified.

In progress:
- Verify the push-triggered `Vantage Worker CI` run for commit `33ec9b63083f62141141ea6363828c9e8152f188` before calling or visually inspecting the production UAT endpoint.

Blocked:
- Production UAT endpoint use is intentionally blocked only on explicit verification of the GitHub Actions CI result for the pushed commit.

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
- Do not call the production UAT endpoint until the push-triggered GitHub Actions CI result is verified.

Exact next action:
From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, run exactly: `gh run list --workflow worker-ci.yml --commit 33ec9b63083f62141141ea6363828c9e8152f188 --limit 5`. Paste the complete output into the chat. Do not call the production UAT endpoint yet.

Last verified:
2026-08-22
