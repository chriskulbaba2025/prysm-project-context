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
- A complete replacement for that file was provided inline with only a bounded `renderNarrativeV2UatFromPersistedArtifacts` helper plus the authorized audit/viewer constants.
- The prepared replacement passed `node --check` in the assistant sandbox.
- An initial focused test produced 5 PASS / 1 FAIL: `NV2-PROD-02` expected `draft_rendered` but observed `narrative_failed`.
- `NV2-PROD-02` exercises the existing enabled Narrative v2 Writer/Judge production path; the new UAT helper is not called by that test, so causation requires a clean baseline run.
- After the stash-pop collision, `git diff -- src/narrative-v2/production-path.js` is empty. The target file is currently clean and matches application `main`.
- Existing stashes are unrelated historical stashes: `stash@{0}` = `temp-before-pr45-lifecycle-test`; `stash@{1}` = `pre-claude-auto-mode`. Neither is the UAT replacement. Do not modify or delete them.
- The UAT replacement is therefore not currently applied to the working tree and is not preserved in those existing stashes; it remains recoverable from the authoritative inline chat delivery.
- Project-wide code delivery is inline-only; generated/downloadable code files are prohibited.

Current environment / branch / version:
- Context repository: `chriskulbaba2025/prysm-project-context`, branch `main`.
- Application repository: `chriskulbaba2025/vantage-platform`, local branch `main`, HEAD `c116e730a38539066852f107582959693e666781`.
- `services/worker/src/narrative-v2/production-path.js` currently has no local diff and is suitable for an untouched-main baseline test.
- Production viewer target: v2.2.0 / 16 pages.
- Report design metadata: v2.0.0.
- Scoring version remains 4.1.1.

Completed:
- Report v2 rebuild coding, targeted tests, CI, merge, and production deployment verification.
- First visual UAT attempt proved the available approved audit is a persisted Viewer v2.1.0 artifact rather than a v2.2.0 presentation regression.
- Root cause of the UAT blocker was verified: immutable persisted report bytes are older than the deployed renderer.
- Bounded UAT rerender objective was explicitly authorized and persisted into project constraints.
- Minimum architecture was identified: render from persisted governed artifacts in memory and expose the result only through an authenticated UAT read path; do not rewrite S3 or lifecycle state.
- First source-file replacement was prepared inline and syntax-checked.
- The stash collision has been isolated without deleting any historical stash or unrelated untracked file.

In progress:
- Run the focused Narrative v2 test against clean untouched `main` to determine whether `NV2-PROD-02` is a pre-existing baseline failure.

Blocked:
- First source-file unit cannot be accepted until the clean baseline test is run and the focused-test failure is causally classified.

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
- Do not touch a second application source file until the first source-file unit is resolved.
- Do not pop, drop, or otherwise modify the two historical stash entries.

Exact next action:
From `services/worker`, with clean `production-path.js`, run `node --test src/application/narrative-v2-production-path.test.js` once. If `NV2-PROD-02` fails the same way, classify it as a pre-existing baseline failure and do not alter the UAT helper to fix it. If it passes, reapply the prepared inline UAT replacement and investigate only the introduced delta.

Last verified:
2026-08-22
