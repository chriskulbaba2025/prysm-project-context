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
- Multiple full-file paste attempts were made for `production-path.js` and `production-runtime.js`, but tracked-state verification was incomplete or misleading.
- After `git restore -- src/application/production-runtime.js`, `git status --short` showed only unrelated untracked `../../lifecycle-failure.txt` and no tracked modifications.
- Because application HEAD is still `c116e730a38539066852f107582959693e666781`, this means no UAT application source-file change is currently confirmed in the working tree. The prior statement that the first source-file unit was accepted is retracted pending direct symbol verification.
- Existing unrelated historical stash entries remain untouched.
- Project-wide code delivery is inline-only; generated/downloadable code files are prohibited.

Current environment / branch / version:
- Context repository: `chriskulbaba2025/prysm-project-context`, branch `main`.
- Application repository: `chriskulbaba2025/vantage-platform`, local branch `main`, HEAD `c116e730a38539066852f107582959693e666781`.
- `git status --short` currently reports only `?? ../../lifecycle-failure.txt`.
- No tracked UAT application source-file modification is currently confirmed.
- Production viewer target: v2.2.0 / 16 pages.
- Report design metadata: v2.0.0.
- Scoring version remains 4.1.1.

Completed:
- Report v2 rebuild coding, targeted tests, CI, merge, and production deployment verification.
- Root cause of the visual-UAT blocker was verified: immutable persisted report bytes are older than the deployed renderer.
- Bounded UAT rerender objective was authorized and persisted into project constraints.
- Minimum architecture remains: render from persisted governed artifacts in memory and expose the result only through an authenticated UAT read path; do not rewrite S3 or lifecycle state.
- Baseline isolation proved `NV2-PROD-02` is pre-existing and out of scope.

In progress:
- Re-establish the true working-copy state before any more code is pasted.

Blocked:
- We must verify whether either UAT symbol actually exists in the two intended tracked files. Do not assume any prior paste was retained.

Important constraints:
- Work one verified application source file at a time.
- Do not directly edit `vantage-platform` unless the user explicitly changes the manual operating method.
- Never deliver PRYSM code files through generated/downloadable file links; all code replacements must be inline in the conversation, split into exact sequential chunks when necessary.
- For this work package only, a read-only UAT rerender path is authorized for audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c`.
- No provider, Writer, Judge, or other model calls for the UAT rerender path.
- No new audit.
- No lifecycle transition or state rewrite.
- No overwrite/delete/mutation of existing report, canonical evidence, scoring, findings, Narrative v2, or manifest artifacts.
- Normal tenant/report authorization must remain in force.
- Do not edit `services/worker/src/report/sections-conversion.js`.
- Do not repair the pre-existing `NV2-PROD-02` baseline failure inside `PRYSM-V2-UAT-RERENDER-01`.
- Do not pop, drop, or otherwise modify the two historical stash entries.
- Do not proceed to `server.js` until the preceding source-file units are actually present and verified by Git.
- Avoid further full-file rewrites where a small surgical edit is sufficient.

Exact next action:
From `services/worker`, run exactly:
`Select-String -Path src/narrative-v2/production-path.js -Pattern 'renderNarrativeV2UatFromPersistedArtifacts|PRYSM-V2-UAT-RERENDER-01'`
and
`Select-String -Path src/application/production-runtime.js -Pattern 'renderReportV2Uat|renderNarrativeV2UatFromPersistedArtifacts'`.
Use those outputs to establish whether either UAT change exists before any further editing.

Last verified:
2026-08-22
