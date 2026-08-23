# Current State

Project:
PRYSM — governed website conversion-readiness report

Current objective:
Execute authorized work package `PRYSM-V2-UAT-RERENDER-01`: produce a read-only Viewer v2.2.0 UAT render for existing audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` from already-persisted governed inputs, with zero provider calls, zero Writer/Judge/model calls, no new audit, no lifecycle transition, and no mutation of the approved report artifact.

Verified checkpoint:
- Authoritative context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Application base `main`: `c116e730a38539066852f107582959693e666781`.
- Working directory: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Current governed viewer contract: Viewer v2.2.0 / 16 pages.
- Existing completed audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` still serves immutable persisted Viewer v2.1.0 bytes; this work package must not rewrite that artifact.
- `NV2-PROD-02` remains a verified pre-existing clean-main defect and is out of scope.
- `src/narrative-v2/production-path.js` is complete for this work-package stage and verified by `node --check`, `git diff --check`, and full Git diff. It contains exactly: Viewer-version import, authorized audit-ID constant, and one exported read-only `renderNarrativeV2UatFromPersistedArtifacts(...)` function. The earlier accidental duplicate was removed.
- `Pasted code(9).js` is the accepted manual baseline for `src/application/production-runtime.js`.
- First `production-runtime.js` edit is Git-verified: import `renderNarrativeV2UatFromPersistedArtifacts` from `../narrative-v2/production-path.js`.
- Second `production-runtime.js` edit is Git-verified by full diff: one new `getNarrativeV2UatRender(auditId, tenantId)` method was added immediately before `getAuditStatus(...)`.
- The new runtime method only loads existing audit metadata, resolves the persisted audit scope, loads the persisted AuditRequest, and calls `renderNarrativeV2UatFromPersistedArtifacts(...)`. It does not execute an audit, call providers/models, write artifacts, or transition lifecycle state.
- Latest full `production-runtime.js` diff shows only the intended import replacement and the new read-only runtime method.
- Unrelated `../../lifecycle-failure.txt` remains untouched.
- Historical stash entries remain untouched.

Completed:
- Report v2 rebuild, targeted tests, CI, merge, and production deployment verification.
- Root cause of visual-UAT blocker verified: immutable persisted report bytes are older than deployed Viewer v2.2.0 renderer.
- Bounded UAT rerender authorization persisted in `CONSTRAINTS.md`.
- Local shell-path mismatch resolved.
- `production-path.js` UAT source-file unit completed and verified.
- Manual VS Code handoff for exact `production-runtime.js` completed.
- `production-runtime.js` import and read-only UAT method are now present and Git-diff verified.

In progress:
- Expose `getNarrativeV2UatRender` through the existing `auditService` object in `production-runtime.js`, then run syntax/diff verification for the complete source-file unit before moving to `server.js`.

Blocked:
- No current application-code blocker established.

Important constraints:
- Work one verified application source file at a time.
- Do not directly edit `vantage-platform` unless the user explicitly changes the manual operating method.
- `Pasted code(9).js` is the accepted baseline for `production-runtime.js`; do not substitute an earlier copy.
- Never deliver PRYSM code files through generated/downloadable links; code must be inline in chat.
- No provider, Writer, Judge, or other model calls for the UAT rerender path.
- No new audit.
- No lifecycle transition or state rewrite.
- No overwrite/delete/mutation of existing report, canonical evidence, scoring, findings, Narrative v2, or manifest artifacts.
- Normal tenant/report authorization must remain in force.
- Do not edit `services/worker/src/report/sections-conversion.js`.
- Do not repair `NV2-PROD-02` in this work package.
- Do not modify historical stash entries.
- Avoid full-file rewrites; use surgical edits only.
- Give one exact edit at a time with an exact search anchor, insertion/replacement text, and verification command set.
- Do not move to `server.js` until `production-runtime.js` is modified and verified by syntax plus Git diff.

Exact next action:
In the already-open `src/application/production-runtime.js`, locate the `const auditService = Object.freeze({` block near the end of the file. Inside that object, add exactly one property line `getNarrativeV2UatRender,` immediately after `getAuditStatus,`. Save the file. Make no other change. Then run `node --check .\src\application\production-runtime.js`, `git diff --check`, and `git --no-pager diff -- src/application/production-runtime.js`, and paste the complete output before proceeding.

Last verified:
2026-08-22
