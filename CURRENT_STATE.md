# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Complete DQV-005 downstream competitor-status propagation, then run the integrated DQV/Track B regression boundary before any production audit rerun.

Verified checkpoint:
- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Last verified remote application `main` before current local data-quality work: `33ec9b63083f62141141ea6363828c9e8152f188` — `feat(report-v2): add read-only UAT rerender route`.
- Current verified local application HEAD: `64c4e01f0f6d53c178d89b9c52756293a21bb4a4` — `fix(evidence): preserve canonical source status`.
- Current local DQV work is not pushed, deployed, or production-rerun.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Viewer contract remains Viewer v2.2.0 / 16 governed pages.
- Unrelated untracked local artifacts remain outside DQV scope: `../../lifecycle-failure.txt` and `prysm-v2.2.0-uat.html`.

Current environment / branch / version:
- Governed manual VS Code workflow on the Desktop application repository.
- Scoring remains v4.1.1 unchanged.
- Selected immutable validation audit: `97d6b2c7-03b9-4530-8ea7-16557502c638` for `https://rebootbusinesscoaching.com/`.

Completed:
- DQV-001 Track A SERP reliability complete locally; full SERP/source-policy boundary previously PASS 102/102.
- DQV-001 Track B representative sitemap footprint, programmatic SEO analysis, OnPage task policy, adapter/runtime integration complete locally.
- Track B representative acquisition integration previously PASS 92/92 with no paid provider call.
- DQV-001 DecisionEvidence propagation complete locally at commit `b4a32aca11d5cc78d9edcd5acc3b37ec734abf1b` — `feat(evidence): propagate representative site evidence`.
  - `siteFootprint` and `programmaticSeo` survive SourceResult → DecisionEvidence losslessly.
  - unavailable sitemap evidence cannot become `NOT_DETECTED` programmatic SEO.
  - focused DecisionEvidence verification PASS 11/11.
- DQV-005 source-level status foundation complete locally at commit `64c4e01f0f6d53c178d89b9c52756293a21bb4a4` — `fix(evidence): preserve canonical source status`.
  - DecisionEvidence now carries additive root `sourceStatus` keyed by `site`, `performance`, `competitors`, `backlinks`, `ga4`, and `gsc` as admitted sources are processed.
  - source-level status is preserved independently from item-level hydrated records.
  - a valid `FAILED` DataForSEO SERP SourceResult with zero returned competitors remains canonical `FAILED`, not `NOT_CONNECTED` or `NOT_APPLICABLE`.
  - malformed viable AVAILABLE/PARTIAL SourceResults remain fail-closed because status admission occurs only after viable validation passes.
  - governed persistence/read-back preserves the source-status map under the existing DecisionEvidence contract.
  - focused DecisionEvidence + contract verification PASS 24/24; `git diff --check` PASS.
- DQV-002 On-Page content parsing normalization remains verified locally.
- DQV-003 microdata provider contract remains verified locally.

In progress:
- DQV-005 downstream propagation is not complete.
- Proven remaining loss points:
  1. `src/report-content/build-package.js` currently infers competitor source state from the competitor item collection and can turn an empty failed source into `NOT_CONNECTED`.
  2. Viewer v2 `render-report-v2.js` no-comparison rendering does not distinguish canonical `FAILED` from other unavailable/not-connected/not-applicable states.
  3. `src/report/narrative-v2/production-path.js` manifest source status currently defaults an empty competitor collection to `NOT_APPLICABLE`.
- Downstream repair must consume canonical `decisionEvidence.sourceStatus.competitors` with a bounded legacy fallback for older persisted DecisionEvidence that lacks the root map.

Blocked:
- No current blocker.
- A paid production audit rerun remains intentionally blocked until the local downstream repair and regression boundary pass and the user explicitly approves the rerun.

Important constraints:
- GitHub context is authoritative durable memory.
- At substantive chat start, read `PROJECT.md`, `GITHUB_PROJECT_MEMORY_PROTOCOL.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `CURRENT_STATE.md`, active `CONSTRAINTS.md`, and active `DECISIONS.md`.
- Manual application edits remain user-applied in VS Code; do not directly modify `vantage-platform` through tools.
- Before an application-file edit, complete the Mandatory Pre-Edit Gate and use the current local source supplied by the user; do not reconstruct unverified application code.
- Manual edit instructions require exact repository-relative path, exact original line/anchor boundaries, complete coherent code, and bottom-up order when line shifts matter.
- Do not make paid provider calls, push, deploy, rerun the production audit, or mutate persisted artifacts without explicit approval.
- Preserve scoring v4.1.1.
- Do not touch the unrelated untracked files.
- Same-failure repair attempts are capped at three before a deeper diagnostic reset.

Exact next action:
Obtain the complete current local `services/worker/src/report-content/build-package.js`, inspect it as the next governed source-file unit, and implement DQV-005 competitor source-status propagation using canonical `decisionEvidence.sourceStatus.competitors` with legacy fallback. Add/adjust only the focused report-package regression required to prove `FAILED` stays `FAILED` and legacy evidence still works. Do not yet edit Viewer v2 or `production-path.js` in the same source-file unit.

Last verified:
2026-08-24
