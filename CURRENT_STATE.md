# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Begin a fresh edit/debug session from the fully pushed Representative Crawl Enforcement baseline. Reproduce any current application/trial issue first, collect direct evidence, then repair only the proven boundary through the governed manual workflow.

Verified checkpoint:
- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Governed application branch: `main`.
- Current verified application HEAD/remote `main`: `46d92a346763a8e3ab252d1c32fe79632e7110a4` — `test(onpage): align representative crawl ceiling`.
- Prior Representative Crawl Enforcement application commit: `e77832e1aab5e9b1621e31e761e865ff86c795cc` — `feat(onpage): enforce representative crawl ceilings`.
- `e77832e...` was pushed successfully to `main`; a post-push CI failure was then diagnosed from direct logs as one stale regression assertion expecting the old 500-page crawl contract.
- The stale assertion was corrected only in `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-representative-evidence.test.js`: expected `max_crawl_pages` changed from 500 to governed 250.
- Correction verification: targeted representative-evidence regression **3/3 PASS**; full worker suite **925/925 PASS**, 0 fail, 0 cancelled; `git diff --check` PASS.
- Correction commit `46d92a3...` was pushed successfully; local HEAD and `origin/main` matched and the working tree was clean at verification.
- GitHub remote status checks for `46d92a3...` all reached SUCCESS: Vercel `vantage-platform`, Vercel `prysm`, and GENSEN process.
- Current governed acquisition contract remains unchanged: broad discovered footprint separate from assessed sample; deterministic must-have/representative priority plan; maximum 20 DataForSEO priority URLs; hard 250-page provider crawl ceiling; DataForSEO On-Page adapter v1.4.0; production config default/max 250; large-site success does not require exhaustive crawling; no custom robots override as the representative-acquisition mechanism.
- Viewer remains v2.2.0 / 16 governed pages.
- Scoring remains v4.1.1 unchanged.
- Controlled production Narrative v2 audit `5d22dcef-7d98-422f-8415-933e7b02003e` remains `draft_rendered`; no fourth Writer/Judge pass is permitted.
- No new production audit, paid provider/model call, rescore, Writer/Judge call, or persisted production mutation was performed during the CI correction.

Current environment / branch / version:
- Governed manual VS Code workflow on Desktop application repository.
- Application path: `C:\Users\kulba\Desktop\vantage-platform`.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Branch: `main`.
- Verified local/remote application HEAD: `46d92a346763a8e3ab252d1c32fe79632e7110a4`.
- On-Page adapter: v1.4.0.
- Governed provider crawl ceiling: 250 pages.
- Governed provider priority URL cap: 20.
- Viewer: v2.2.0 / 16 governed pages.
- Scoring: v4.1.1.

Completed:
- Representative Crawl Enforcement implementation is complete, pushed, and remotely green.
- Sitemap-footprint priority contract is implemented and tested.
- Adapter hard ceiling, client defense-in-depth ceiling, and production config ceiling are implemented and tested.
- Post-push stale 500-page regression assertion was diagnosed from direct evidence, corrected to 250, fully regression-tested, committed, pushed, and remotely green.

In progress:
- Preparing a fresh chat for application edit/debug work and a controlled trial.
- User intends to test through the normal PRYSM app UI; `https://www.tbkcreative.com/` was selected as the trial site, but no new audit execution was verified in this handoff.

Blocked:
- No known technical blocker at handoff.
- The next defect, if any, is not yet proven. Do not infer a cause before reproducing it and collecting direct evidence.

Important constraints:
- GitHub context is authoritative durable memory.
- `WORKFLOW_INSTRUCTIONS.md` is mandatory for manual application edits: exact path, exact current line numbers/ranges, anchor text, complete replacement block, multiple edits strictly bottom-up/highest-line-first, one consolidated verification block, and no move to the next source-file unit until the user confirms verification.
- Before any source edit, satisfy `REPAIR_BOUNDARY_PROTOCOL.md`: verify the executing boundary, map the full repair, expected file set, downstream reactions, and tests first.
- `DIAGNOSTIC_EVIDENCE_PROTOCOL.md` remains mandatory: no guessing; reproduce the issue and verify direct evidence before stating root cause or repair.
- Same observable failure remains capped at three unsuccessful repair attempts before a deeper diagnostic reset.
- Do not ask the user to scroll back for prior code/instructions; restate required code in the current response.
- Preserve discovered-footprint evidence separately from assessed-page evidence. Never imply a 250-page assessment is exhaustive coverage of a larger site.
- Do not raise the 250-page provider crawl ceiling because a site is larger.
- Do not use custom robots override to manufacture representative acquisition without a separately approved, evidence-backed design.
- Preserve scoring v4.1.1 and Viewer v2.2.0 / 16 pages unless separately approved.
- Do not push, deploy, rerun production audits, recollect paid provider evidence, rescore, invoke paid Writer/Judge calls, or mutate persisted production artifacts without explicit approval at the applicable step.

Exact next action:
Start a fresh chat. Read `PROJECT.md`, `GITHUB_PROJECT_MEMORY_PROTOCOL.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`, `WORKFLOW_INSTRUCTIONS.md`, `TERMINOLOGY.md`, `CURRENT_STATE.md`, active `CONSTRAINTS.md`, active `DECISIONS.md`, and `EFFICIENCY_METRICS.md`. Treat GitHub as authoritative. Verify local `vantage-platform` `main` HEAD is exactly `46d92a346763a8e3ab252d1c32fe79632e7110a4` and the working tree is clean. Then reproduce the application/trial problem the user wants edited/debugged and collect the shortest direct diagnostic evidence before proposing any source-file change.

Last verified:
2026-08-26 America/Toronto
