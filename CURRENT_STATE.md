# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Repair the Narrative v2 human-review continuation path discovered during controlled production validation, then resume the same scored audit without recollecting evidence or rescoring.

Verified checkpoint:
- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Remote application `main` verified at `fd56a7e2901a505bd9416934a38dd47e026a68a6` — `test(evidence): align onpage adapter version`.
- The repaired application commit was pushed and the production deployment was verified active/successful before the validation audit.
- Local full worker test command was user-verified PASS **917/917**, 0 failures, 0 cancelled, duration ~19.7s. A prior GitHub Actions cancellation was not reproducible locally; no source change was warranted from that CI symptom.
- Integrated DQV/Track B regression boundary previously PASS **185/185**, 0 failures.
- Viewer remains v2.2.0 / 16 governed pages.
- Scoring remains v4.1.1 unchanged.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Controlled production validation audit: `5d22dcef-7d98-422f-8415-933e7b02003e` for `https://rebootbusinesscoaching.com/`.
- That audit successfully advanced through evidence collection and scoring, then reached `narrative_pending → narrative_failed` with lifecycle reason `narrative-v2-human-review-required`.
- The failure is therefore a Narrative v2 release/continuation workflow issue, not evidence-collection or scoring failure.
- Current production Narrative v2 live binding allows two automatic Writer/Judge rounds (maximum four model calls), while the governed Judge contract supports three total narrative passes.
- Existing `resumeAudit()` currently treats only `scored`, `narrative_pending`, and `narrative_ready` as resumable; the lifecycle contract itself permits `narrative_failed → narrative_pending`.
- The portal currently has review actions only after `draft_rendered`; it does not expose Judge defects or a governed final-revision authorization action from `narrative_failed`.

Current environment / branch / version:
- Governed manual VS Code workflow on Desktop application repository, expected local branch `main`.
- Remote `main` currently `fd56a7e2901a505bd9416934a38dd47e026a68a6`.
- No application code for the Narrative v2 continuation repair has been changed yet.
- No additional production audit, provider recollection, third Writer/Judge round, deployment, or production configuration change has been performed.

Completed:
- DQV-001 Track A SERP reliability and Track B representative large-site evidence acquisition are complete and deployed in the current production baseline.
- DQV-005 canonical/downstream source-status propagation is complete and deployed in the current production baseline.
- Controlled production audit proved the repaired evidence/scoring path can reach `scored` on the live target.
- Narrative v2 quality-gate behavior was mapped: release requires the existing governed threshold; the quality standard itself is not being lowered.
- Mandatory Pre-Edit Gate for the human-review continuation repair is **PASS**.
- Approved repair design:
  - preserve audit `5d22dcef-7d98-422f-8415-933e7b02003e`;
  - reuse persisted evidence and scores;
  - expose exact Judge defects when human review is required;
  - require explicit human authorization for one final third Writer/Judge round;
  - no DataForSEO/PageSpeed/backlinks/GA4/GSC recollection and no scoring rerun;
  - preserve prior narrative artifacts; final-round artifacts must be additive/auditable;
  - stop for genuine manual review if pass 3 still fails;
  - no fourth pass/unbounded repair loop.
- User also approved moving the Narrative v2 Writer to the higher-tier Terra model for the next controlled production validation while keeping the Judge model unchanged. The exact provider model identifier and price-table entry must be verified before deployment configuration changes.
- Cost guard: projected paid exposure below USD $2 is approved for ordinary validation; if a paid action is projected to exceed $2, stop and warn the user before the call.

In progress:
- Narrative v2 governed human-review continuation repair has been fully designed but implementation has not started.
- Expected application boundary is approximately:
  - `services/worker/src/narrative-v2/orchestrator.js`
  - `services/worker/src/narrative-v2/live-binding.js`
  - `services/worker/src/narrative-v2/production-path.js`
  - `services/worker/src/application/production-runtime.js`
  - `services/worker/src/server.js`
  - `lib/worker-client.ts`
  - a narrow Next.js narrative-review/continuation API route
  - `components/AuditReviewActions.tsx`
  - `app/audits/[auditId]/page.tsx` only if required to surface the Judge review summary
  - focused orchestration/live-binding/production-path/API/UI regression tests.
- Implementation must remain one verified source-file unit at a time under the manual VS Code workflow.

Blocked:
- No design blocker.
- Before editing the first source file, the exact local application `HEAD` and governed working-tree cleanliness must be verified against the remote baseline because only remote `main` is currently re-verified in GitHub.
- The exact persisted Judge defect list for audit `5d22dcef-7d98-422f-8415-933e7b02003e` has not yet been inspected; implementation must expose it generically from the governed orchestration artifact rather than hardcoding this audit's defects.

Important constraints:
- GitHub context is authoritative durable memory.
- At substantive chat start, read `PROJECT.md`, `GITHUB_PROJECT_MEMORY_PROTOCOL.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `CURRENT_STATE.md`, active `CONSTRAINTS.md`, and active `DECISIONS.md`.
- Manual application edits remain user-applied in VS Code; do not directly modify `vantage-platform` through tools.
- The Mandatory Pre-Edit Gate for this repair is already PASS; do not remap it unless new evidence materially changes the boundary.
- For every manual code edit, provide exact repository-relative path, exact original start/end line numbers, start/end anchor text, explicit replace/insert/delete direction, complete replacement code, and bottom-up order when multiple edits shift lines.
- No paid provider/model call, push, deploy, production configuration mutation, new production audit, or persisted production-artifact mutation without explicit approval.
- Preserve scoring v4.1.1 and Viewer v2.2.0 / 16 pages.
- Preserve the existing Narrative v2 quality gate. Do not lower it as part of this repair.
- A final third Writer/Judge round must be explicitly human-authorized and cost-preflighted; stop/warn above the user's USD $2 projected-exposure threshold.
- Keep the Judge model unchanged; Writer model upgrade is configuration-driven and must not be hardcoded.
- Same-failure repair attempts remain capped at three before a deeper diagnostic reset.

Exact next action:
From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, verify the exact local `HEAD` and governed clean working tree against remote `main` `fd56a7e2901a505bd9416934a38dd47e026a68a6`; do not request or edit the first source file until that baseline check passes.

Last verified:
2026-08-25 11:26 America/Toronto
