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
- Direct symbol checks confirmed neither `renderNarrativeV2UatFromPersistedArtifacts` nor `renderReportV2Uat` exists in the clean tracked baseline.
- The earlier PowerShell/.NET path mismatch is resolved. All four path checks reconcile to the intended Desktop working copy under `C:\Users\kulba\Desktop\vantage-platform`.
- Verified local file path: `C:\Users\kulba\Desktop\vantage-platform\services\worker\src\narrative-v2\production-path.js`.
- Local HEAD remains exactly `c116e730a38539066852f107582959693e666781`.
- `Pasted code(7).js` is disqualified as stale/non-authoritative.
- The exact current Desktop file was opened from the verified PowerShell location and supplied as `Pasted code(8).js`; it is the accepted manual baseline for this source-file unit.
- First surgical UAT edit is Git-verified: `import { REPORT_V2_VIEWER_VERSION } from "../report/render-report-v2.js";` was added immediately after the existing Narrative v2 renderer import.
- Second surgical UAT edit is Git-verified: `const UAT_RERENDER_AUDIT_ID = "d3b4cc62-9217-4c0b-b169-e24beb46a79c";` was added immediately after `NARRATIVE_V2_VERSION`.
- Latest `git diff -- src/narrative-v2/production-path.js` contains exactly those two additions and no other application-source change.
- Prior full-file paste attempts are abandoned.
- Existing unrelated historical stash entries remain untouched.
- Project-wide code delivery is inline-only; generated/downloadable code files are prohibited.

Current environment / branch / version:
- Context repository: `chriskulbaba2025/prysm-project-context`, branch `main`.
- Application repository: `chriskulbaba2025/vantage-platform`, local branch `main`, HEAD `c116e730a38539066852f107582959693e666781`.
- Working directory: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Verified target source file: `src/narrative-v2/production-path.js`.
- Accepted manual baseline: `Pasted code(8).js`.
- Current UAT edits in `production-path.js`: Viewer-version import + authorized audit-ID constant only.
- Unrelated untracked `?? ../../lifecycle-failure.txt` remains untouched.
- Production viewer target: v2.2.0 / 16 pages.
- Report design metadata: v2.0.0.
- Scoring version remains 4.1.1.

Completed:
- Report v2 rebuild coding, targeted tests, CI, merge, and production deployment verification.
- Root cause of the visual-UAT blocker was verified: immutable persisted report bytes are older than the deployed renderer.
- Bounded UAT rerender objective was authorized and persisted into project constraints.
- Baseline isolation proved `NV2-PROD-02` is pre-existing and out of scope.
- Local shell-path reconciliation is complete.
- Manual VS Code handoff for the exact current `production-path.js` is complete.
- First and second surgical edits to `production-path.js` are complete and verified by Git diff.

In progress:
- Add the bounded read-only UAT renderer function to `production-path.js`, then verify that complete source-file unit before moving to any second application file.

Blocked:
- No application-code blocker is currently established.

Important constraints:
- Work one verified application source file at a time.
- Do not directly edit `vantage-platform` unless the user explicitly changes the manual operating method.
- `Pasted code(8).js` is the accepted baseline for the current `production-path.js` source-file unit; do not substitute an earlier copy.
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
- Do not proceed to `production-runtime.js` or `server.js` until `production-path.js` is modified and verified by syntax plus Git diff.
- Avoid full-file rewrites; use small surgical edits only.
- Give the user one exact edit at a time with an exact search anchor, exact insertion/replacement text, and one verification command set after the edit.

Exact next action:
In the already-open `src/narrative-v2/production-path.js`, locate the end of `buildV2Model(...)`, immediately before `async function runNarrativeV2FromScored({`. Insert the complete exported `renderNarrativeV2UatFromPersistedArtifacts(...)` function supplied in the current chat. Save the file. Make no other change. Then run `node --check .\src\narrative-v2\production-path.js`, `git diff --check`, and `git diff -- src/narrative-v2/production-path.js`, and paste the complete output before proceeding.

Last verified:
2026-08-22
