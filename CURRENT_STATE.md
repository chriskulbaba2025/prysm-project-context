# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Move from locally verified DQV-001 Track B + DQV-005 repair into controlled production audit/UAT validation of the real evidence-acquisition → DecisionEvidence → report path.

Verified checkpoint:
- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Last verified remote application `main` before current local data-quality work: `33ec9b63083f62141141ea6363828c9e8152f188` — `feat(report-v2): add read-only UAT rerender route`.
- Last explicitly captured local application HEAD before the final test-only adapter-version alignment: `86f134b` — `fix(narrative-v2): preserve competitor source status`.
- After the final test-only adapter-version alignment, `git status --short` was clean for governed files and showed only the two known unrelated untracked artifacts. The exact resulting local HEAD SHA was not pasted and must be re-verified at the next chat before production work.
- Integrated DQV/Track B regression boundary PASS **185/185**, 0 failures, duration ~18.3s.
- Current local DQV work is not verified pushed, deployed, or production-rerun.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Viewer contract remains Viewer v2.2.0 / 16 governed pages.
- Scoring remains v4.1.1 unchanged.
- Unrelated untracked local artifacts remain outside DQV scope: `../../lifecycle-failure.txt` and `prysm-v2.2.0-uat.html`.

Current environment / branch / version:
- Governed manual VS Code workflow on Desktop application repository, local branch `main`.
- Selected immutable validation audit remains `97d6b2c7-03b9-4530-8ea7-16557502c638` for `https://rebootbusinesscoaching.com/`.
- No production audit rerun has been authorized in this checkpoint.

Completed:
- DQV-001 Track A SERP reliability complete locally; full SERP/source-policy boundary PASS 102/102.
- DQV-001 Track B representative large-site acquisition complete locally:
  - recursive same-origin sitemap/sitemap-index footprint discovery;
  - deterministic URL-family clustering and representative selection bounded to 20 URLs;
  - bounded deep On-Page parsing for important pages plus material cluster representatives;
  - explicit incomplete/unavailable footprint semantics;
  - `siteFootprint` / `programmaticSeo` propagation through DecisionEvidence;
  - governed whole-source On-Page policy of 60 minutes / one attempt and 30-minute task polling;
  - DQV-002 content normalization and DQV-003 microdata contracts remain green.
- Representative acquisition integration previously PASS 92/92 with no paid provider call.
- DQV-001 DecisionEvidence propagation complete locally at commit `b4a32aca11d5cc78d9edcd5acc3b37ec734abf1b` — `feat(evidence): propagate representative site evidence`.
- DQV-005 source-level status foundation complete locally at commit `64c4e01f0f6d53c178d89b9c52756293a21bb4a4` — `fix(evidence): preserve canonical source status`.
- DQV-005 downstream competitor-status propagation complete locally:
  - `report-content/build-package.js` consumes canonical `decisionEvidence.sourceStatus.competitors` with bounded legacy fallback;
  - Viewer v2 distinguishes canonical `FAILED`, `NOT_CONNECTED`, and `NOT_APPLICABLE` instead of collapsing them;
  - Narrative v2 model and report manifest preserve canonical competitor source status;
  - end-to-end Narrative v2 regression proves canonical `FAILED` reaches Viewer v2 and persisted manifest;
  - focused Narrative v2 production-path suite PASS 7/7;
  - report-content focused suite PASS 25/25;
  - Viewer v2 conversion suite PASS 46/46.
- DQV-005 report-content local commit verified earlier: `3776b9e7f39f7fcf396464330f4c889976d4158b` — `fix(report): preserve competitor source status`.
- Narrative v2 local commit explicitly captured: `86f134b` — `fix(narrative-v2): preserve competitor source status`.
- Final stale On-Page adapter-version literal in `decision-evidence-production-regression.test.js` was aligned from `1.2.0` to current `1.3.0`; focused DE-16 regression PASS 1/1 before the final integrated run.
- Final integrated DQV/Track B boundary PASS **185/185**; `git diff --check` PASS; governed working tree clean except the known unrelated untracked artifacts.
- No paid provider call, application push, deployment, production audit rerun, or persisted production-artifact mutation was performed during the final DQV-005/Track B regression closure.

In progress:
- No application repair is currently in progress.
- The next phase is controlled production validation proving that the real audit gathers and preserves a robust, representative evidence set and that the final client report accurately reflects site structure/content, conversion signals, technical/performance health, competitor context, backlinks, and connected analytics/search-console evidence when available.

Blocked:
- No code/test blocker.
- Production audit rerun remains blocked pending explicit user approval.
- Before any production action, the exact current local application HEAD must be re-verified because the post–test-only-fix SHA was not captured in the prior chat.

Important constraints:
- GitHub context is authoritative durable memory.
- At substantive chat start, read `PROJECT.md`, `GITHUB_PROJECT_MEMORY_PROTOCOL.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `CURRENT_STATE.md`, active `CONSTRAINTS.md`, and active `DECISIONS.md`.
- Manual application edits remain user-applied in VS Code; do not directly modify `vantage-platform` through tools.
- Before any new application-file edit, complete the Mandatory Pre-Edit Gate and use the complete current local source supplied by the user; do not reconstruct unverified application code.
- **Strict manual-edit rule:** every manual code change instruction must include the exact repository-relative path, exact current/original start and end line numbers, start/end anchor text, explicit replace/insert/delete direction, and the complete code example. Line numbers alone are never sufficient. Use bottom-up order when multiple edits would shift lines.
- Do not make paid provider calls, push, deploy, rerun a production audit, or mutate persisted artifacts without explicit approval.
- Preserve scoring v4.1.1 and Viewer v2.2.0 / 16 pages unless a deliberate approved migration occurs.
- Do not touch `../../lifecycle-failure.txt` or `prysm-v2.2.0-uat.html`.
- Same-failure repair attempts remain capped at three before a deeper diagnostic reset.

Exact next action:
From `C:\Users\kulba\Desktop\vantage-platform\services\worker`, verify the exact local `HEAD` and clean governed working tree first. Then prepare the controlled production audit/UAT validation plan for audit-data quality and report completeness, including provider/cost boundaries and success criteria, and obtain explicit user approval before any paid provider call or production audit rerun.

Last verified:
2026-08-25
