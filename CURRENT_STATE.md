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
- First governed application source-file unit is `services/worker/src/narrative-v2/production-path.js`.
- User supplied the exact current source, then pasted the complete inline replacement containing only the bounded `renderNarrativeV2UatFromPersistedArtifacts` helper plus the authorized audit/viewer constants.
- Local `node --check src/narrative-v2/production-path.js` passes.
- Focused suite with the UAT change applied: 5 PASS / 1 FAIL.
- Clean untouched `main` at `c116e730a38539066852f107582959693e666781` produced the exact same 5 PASS / 1 FAIL.
- The sole failure is `NV2-PROD-02`, which expects `draft_rendered` but receives `narrative_failed` on clean main as well.
- Therefore `NV2-PROD-02` is a verified pre-existing baseline defect and is not caused by `PRYSM-V2-UAT-RERENDER-01`.
- The first UAT source-file unit is accepted: no new regression was introduced by the change.
- Existing unrelated historical stash entries remain untouched.
- Project-wide code delivery is inline-only; generated/downloadable code files are prohibited.

Current environment / branch / version:
- Context repository: `chriskulbaba2025/prysm-project-context`, branch `main`.
- Application repository: `chriskulbaba2025/vantage-platform`, local branch `main`, base HEAD `c116e730a38539066852f107582959693e666781` with the accepted first UAT source-file change in the working copy.
- Production viewer target: v2.2.0 / 16 pages.
- Report design metadata: v2.0.0.
- Scoring version remains 4.1.1.

Completed:
- Report v2 rebuild coding, targeted tests, CI, merge, and production deployment verification.
- Root cause of the visual-UAT blocker was verified: immutable persisted report bytes are older than the deployed renderer.
- Bounded UAT rerender objective was authorized and persisted into project constraints.
- Minimum architecture was identified: render from persisted governed artifacts in memory and expose the result only through an authenticated UAT read path; do not rewrite S3 or lifecycle state.
- First source-file unit `production-path.js` is implemented, syntax-green, and verified not to introduce any new focused-test regression.
- Baseline isolation proved `NV2-PROD-02` is pre-existing and out of scope for this UAT work package.

In progress:
- Continue `PRYSM-V2-UAT-RERENDER-01` to the second governed source-file unit needed to expose the pure read-only renderer through the production runtime.

Blocked:
- No technical blocker.
- Manual source-file workflow requires the user to supply the exact current second source file before editing it.

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

Exact next action:
User supplies the exact current local `services/worker/src/application/production-runtime.js` from the synchronized `vantage-platform` working copy. Inspect that file and add only the smallest read-only runtime method needed to call `renderNarrativeV2UatFromPersistedArtifacts` for the authorized already-approved/published audit; run syntax and focused verification before touching `server.js`.

Last verified:
2026-08-22
