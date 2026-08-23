# Current State

Project:
PRYSM — governed website conversion-readiness report

Current objective:
Execute authorized work package `PRYSM-V2-UAT-RERENDER-01`: produce a read-only Viewer v2.2.0 UAT render for existing audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` from already-persisted governed inputs, with zero provider calls, zero Writer/Judge/model calls, no new audit, no lifecycle transition, and no mutation of the approved report artifact.

Verified checkpoint:
- Authoritative context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Application base `main`: `c116e730a38539066852f107582959693e666781`.
- PR #78 — `design(report-v2): complete governed 16-page report` — is merged and deployed.
- Current governed viewer contract: Viewer v2.2.0 / 16 pages.
- Existing completed audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` still serves immutable persisted Viewer v2.1.0 bytes; deploying Viewer v2.2.0 does not rewrite that artifact.
- User explicitly authorized `PRYSM-V2-UAT-RERENDER-01` on 2026-08-22.
- `CONSTRAINTS.md` contains the bounded authorization: read-only/in-memory render only; no artifact mutation; no lifecycle transition; zero provider/model calls; ordinary report authorization remains required.
- Clean untouched `main` at `c116e730a38539066852f107582959693e666781` produces 5 PASS / 1 FAIL in `src/application/narrative-v2-production-path.test.js`.
- The sole failure is `NV2-PROD-02`, which expects `draft_rendered` but receives `narrative_failed` on clean main. This is a verified pre-existing baseline defect and is out of scope for this UAT work package.
- Direct symbol checks confirmed neither `renderNarrativeV2UatFromPersistedArtifacts` nor `renderReportV2Uat` exists in the current tracked working copy.
- `git status --short` shows only unrelated untracked `../../lifecycle-failure.txt`; there are no tracked UAT source changes.
- The earlier PowerShell/.NET path mismatch is resolved. `Get-Location`, `git rev-parse --show-toplevel`, `Resolve-Path .\src\narrative-v2\production-path.js`, and `[Environment]::CurrentDirectory` now all reconcile to the intended Desktop working copy under `C:\Users\kulba\Desktop\vantage-platform`.
- Verified local file path: `C:\Users\kulba\Desktop\vantage-platform\services\worker\src\narrative-v2\production-path.js`.
- Local HEAD remains exactly `c116e730a38539066852f107582959693e666781`.
- `git diff -- src/narrative-v2/production-path.js` is empty and `git diff --cached -- src/narrative-v2/production-path.js` is empty.
- `Select-String` against both the disk file and `HEAD:services/worker/src/narrative-v2/production-path.js` returns no `UAT_RERENDER` symbols.
- The uploaded `Pasted code(7).js` contained UAT rerender code and duplicate `UAT_RERENDER_*` constants, but that content does not match the verified tracked Desktop file and must be treated as a stale/non-authoritative copy. It must not be used as the edit baseline.
- Prior full-file paste attempts are abandoned. No UAT application source-file change is currently accepted or present in the tracked working copy.
- Existing unrelated historical stash entries remain untouched.
- Project-wide code delivery is inline-only; generated/downloadable code files are prohibited.

Current environment / branch / version:
- Context repository: `chriskulbaba2025/prysm-project-context`, branch `main`.
- Application repository: `chriskulbaba2025/vantage-platform`, local branch `main`, HEAD `c116e730a38539066852f107582959693e666781`.
- Working directory: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Verified target source file: `src/narrative-v2/production-path.js` in that working directory.
- Last verified tracked state: no UAT source modifications; only unrelated `?? ../../lifecycle-failure.txt`.
- Production viewer target: v2.2.0 / 16 pages.
- Report design metadata: v2.0.0.
- Scoring version remains 4.1.1.

Completed:
- Report v2 rebuild coding, targeted tests, CI, merge, and production deployment verification.
- Root cause of the visual-UAT blocker was verified: immutable persisted report bytes are older than the deployed renderer.
- Bounded UAT rerender objective was authorized and persisted into project constraints.
- Minimum architecture remains: render from persisted governed artifacts in memory and expose the result only through an authenticated UAT read path; do not rewrite S3 or lifecycle state.
- Baseline isolation proved `NV2-PROD-02` is pre-existing and out of scope.
- Local shell-path reconciliation is complete.
- Working-copy verification proved all prior UAT paste attempts are absent from tracked source.
- The stale uploaded code copy has been explicitly disqualified as an edit baseline.

In progress:
- Obtain the exact current `production-path.js` from the verified Desktop working copy through the manual VS Code handoff before making the first surgical UAT edit.

Blocked:
- No application-code blocker is currently established. Work is paused only at the required manual source-file handoff boundary.

Important constraints:
- Work one verified application source file at a time.
- Do not directly edit `vantage-platform` unless the user explicitly changes the manual operating method.
- The user must supply the exact current file from the verified VS Code/current working copy before source modification.
- Do not use `Pasted code(7).js` or any earlier stale copy as the edit baseline.
- Never deliver PRYSM code files through generated/downloadable file links; all code replacements must be inline in the conversation.
- For this work package only, a read-only UAT rerender path is authorized for audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c`.
- No provider, Writer, Judge, or other model calls for the UAT rerender path.
- No new audit.
- No lifecycle transition or state rewrite.
- No overwrite/delete/mutation of existing report, canonical evidence, scoring, findings, Narrative v2, or manifest artifacts.
- Normal tenant/report authorization must remain in force.
- Do not edit `services/worker/src/report/sections-conversion.js`.
- Do not repair the pre-existing `NV2-PROD-02` baseline failure inside `PRYSM-V2-UAT-RERENDER-01`.
- Do not pop, drop, or otherwise modify the two historical stash entries.
- Do not proceed to `production-runtime.js` or `server.js` until `production-path.js` is actually modified and verified by Git.
- Avoid full-file rewrites; use small surgical edits only.

Exact next action:
From the already-verified PowerShell location `C:\Users\kulba\Desktop\vantage-platform\services\worker`, run exactly `code .\src\narrative-v2\production-path.js`. In the VS Code editor that opens, press `Ctrl+A`, then `Ctrl+C`, and paste that exact file into the chat. Do not edit it first and do not use any previously uploaded copy.

Last verified:
2026-08-22
