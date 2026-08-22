# Current State

Project:
PRYSM — governed website conversion-readiness report

Current objective:
Execute authorized work package `PRYSM-V2-UAT-RERENDER-01`: produce a read-only Viewer v2.2.0 UAT render for existing audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` from already-persisted governed inputs, with zero provider calls, zero Writer/Judge/model calls, no new audit, no lifecycle transition, and no mutation of the approved report artifact.

Verified checkpoint:
- Authoritative context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Application `main`: `c116e730a38539066852f107582959693e666781`.
- PR #78 — `design(report-v2): complete governed 16-page report` — is merged.
- Current governed viewer contract: Viewer v2.2.0 / 16 pages.
- Targeted verification at PR #78: syntax 4/4 PASS; viewer 9/9 PASS; conversion/depth 46/46 PASS; core Report v2 10/10 PASS; total 65/65 PASS; GitHub CI SUCCESS.
- Production custom domain `prysm.omnipressence.com` is served by Vercel project `prysm`, deployment `dpl_EdXeiBvZM1bEPRJHyMnHnsGuTtiZ`, READY, target production, exact Git SHA `c116e730a38539066852f107582959693e666781`.
- Existing completed audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` currently serves persisted Viewer v2.1.0 report bytes.
- Deploying Viewer v2.2.0 does not rewrite that approved persisted artifact.
- Existing resume behavior cannot rerender the audit because resume accepts only `scored`, `narrative_pending`, and `narrative_ready`, not `approved`.
- `render-report-v2.js` at the verified application head identifies Viewer v2.2.0 and defines 16 governed pages.
- The Narrative v2 render path already reconstructs its deterministic renderer model from persisted AuditRequest, canonical scores/findings, capability evidence, decision evidence, and persisted Narrative v2 Writer/Judge release-candidate artifacts.
- User explicitly authorized `PRYSM-V2-UAT-RERENDER-01` on 2026-08-22.
- `CONSTRAINTS.md` contains the bounded authorization: read-only/in-memory render only; no artifact mutation; no lifecycle transition; zero provider/model calls; ordinary report authorization remains required.
- User supplied the exact current `services/worker/src/narrative-v2/production-path.js` source for the first governed source-file unit.
- A complete replacement for that file has been prepared with only a bounded `renderNarrativeV2UatFromPersistedArtifacts` helper plus the authorized audit/viewer constants.
- The prepared replacement passes `node --check` in the assistant sandbox.
- Diff review confirms the prepared change is limited to the two UAT constants and the new read-only helper; existing execution paths are otherwise unchanged.
- The prior response incorrectly offered the replacement as a downloadable code file even though the authoritative `DECISIONS.md` already required direct in-conversation delivery for this workflow.
- Project governance has been strengthened: `CONSTRAINTS.md` now prohibits downloadable/generated code-file delivery across the entire PRYSM Project, and `DECISIONS.md` now contains the matching durable project-wide inline-only code-delivery decision.

Current environment / branch / version:
- Context repository: `chriskulbaba2025/prysm-project-context`, branch `main`.
- Application repository: `chriskulbaba2025/vantage-platform`, stable `main` at `c116e730a38539066852f107582959693e666781` before the user applies the prepared replacement.
- Production viewer target: v2.2.0 / 16 pages.
- Report design metadata: v2.0.0.
- Scoring version remains 4.1.1.

Completed:
- Report v2 rebuild coding, targeted tests, CI, merge, and production deployment verification.
- First visual UAT attempt proved the available approved audit is a persisted Viewer v2.1.0 artifact rather than a v2.2.0 presentation regression.
- Root cause of the UAT blocker was verified: immutable persisted report bytes are older than the deployed renderer.
- Bounded UAT rerender objective was explicitly authorized and persisted into project constraints.
- Minimum architecture was identified: render from persisted governed artifacts in memory and expose the result only through an authenticated UAT read path; do not rewrite S3 or lifecycle state.
- First source-file replacement has been prepared and syntax-checked, but has not yet been verified in the user's working repository.
- Project-wide code delivery is now explicitly inline-only; generated/downloadable code files are prohibited.

In progress:
- `PRYSM-V2-UAT-RERENDER-01` implementation using the existing manual governed source-file workflow.

Blocked:
- No technical blocker currently.
- The first source-file unit cannot be marked complete until the user pastes the complete inline `production-path.js` replacement into the synchronized working copy and runs the focused local verification.

Important constraints:
- Work one verified application source file at a time.
- Do not directly edit `vantage-platform` unless the user explicitly changes the manual operating method.
- Never deliver PRYSM code files through generated/downloadable file links; all code replacements must be inline in the conversation, split into exact sequential chunks when necessary.
- For this work package only, a read-only UAT rerender path is authorized for audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c`.
- No provider, Writer, Judge, or other model calls.
- No new audit.
- No lifecycle transition or state rewrite.
- No overwrite/delete/mutation of existing report, canonical evidence, scoring, findings, Narrative v2, or manifest artifacts.
- Normal tenant/report authorization must remain in force.
- Do not edit `services/worker/src/report/sections-conversion.js`.
- After each source-file change, syntax and relevant targeted tests must pass before proceeding to another source file.

Exact next action:
Assistant returns the complete prepared `services/worker/src/narrative-v2/production-path.js` replacement directly in the conversation in sequential code blocks with no omitted content; user pastes it into the synchronized working copy, then from `services/worker` runs `node --check src/narrative-v2/production-path.js` and `node --test src/application/narrative-v2-production-path.test.js`; do not touch a second application source file until both pass.

Last verified:
2026-08-22
