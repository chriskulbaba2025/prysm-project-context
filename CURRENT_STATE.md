# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Close Representative Crawl Enforcement locally, then begin a fresh chat to verify the local application checkpoint and decide the push/deploy boundary before any production validation.

Verified checkpoint:
- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Governed application branch: `main`.
- Remote/application GitHub baseline before this local package remained `edd034b62529a4d7317c1416cdb37c71b7cfb517` — `fix(serp): keep request timeout active in CI`.
- User-verified local application commit is `e77832e1aab5e9b1621e31e761e865ff86c795cc` — `feat(onpage): enforce representative crawl ceilings`.
- The `e77832e...` application commit is local only at this handoff. It has not been pushed or deployed.
- Representative Crawl Enforcement changed 10 application files and closed with final focused regression **100/100 PASS**, 0 fail, 0 cancelled; final `git diff --check` PASS before commit.
- Footprint discovery now exposes a deterministic priority-selection contract that protects must-have commercial/conversion roles before material-family representatives consume the 20-slot priority budget.
- Priority-selection truth records must-have, representative, supplemental, represented-family, and unrepresented-family information.
- DataForSEO On-Page adapter version advanced to `1.4.0` and enforces a hard provider crawl ceiling of **250 pages** at the paid-task boundary.
- Direct requested crawl sizes of 10, 250, 500, and 100000 were covered by tests; requests above 250 are reduced to 250 and an explicit limitation is recorded.
- DataForSEO client now independently enforces `maxCrawlPages: 250`, caps `priority_urls` at 20, and prevents direct page retrieval above 250 even if the adapter is bypassed.
- Production config now resolves `VANTAGE_ONPAGE_MAX_PAGES` with default 250 and maximum 250.
- Production runtime/config regression proves default 250 and clamps oversized configuration to 250.
- Business services are propagated into sitemap-footprint selection so commercial-role priority can use audit service context.
- DecisionEvidence provenance tests were updated for On-Page adapter v1.4.0.
- Official DataForSEO evidence did not justify using undocumented URL-filter behavior as the representative-acquisition guarantee.
- Custom robots suppression was deliberately not added because replacing/overriding a site’s robots policy would create the wrong governance tradeoff for this product.
- Current product contract is bounded representative acquisition, not exhaustive crawling: broad footprint understanding → material-family classification → must-have/representative priority plan → max 20 priority URLs → hard 250-page provider crawl → explicit footprint-versus-assessed coverage truth.
- Large-site audit success does not require crawling every discovered URL.
- Viewer remains v2.2.0 / 16 governed pages.
- Scoring remains v4.1.1 unchanged.
- Controlled production Narrative v2 audit `5d22dcef-7d98-422f-8415-933e7b02003e` remains `draft_rendered`; no fourth Writer/Judge pass is permitted.
- No production audit rerun, paid provider call, push, deployment, rescoring, Writer/Judge call, or persisted production mutation occurred as part of Representative Crawl Enforcement.

Current environment / branch / version:
- Governed manual VS Code workflow on Desktop application repository.
- Application path: `C:\Users\kulba\Desktop\vantage-platform`.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Branch: `main`.
- User-verified local application HEAD: `e77832e1aab5e9b1621e31e761e865ff86c795cc`.
- Remote GitHub application baseline prior to push remains `edd034b62529a4d7317c1416cdb37c71b7cfb517` until verified otherwise in the next chat.
- On-Page adapter: v1.4.0.
- Governed provider crawl ceiling: 250 pages.
- Governed provider priority URL cap: 20.
- Viewer: v2.2.0 / 16 governed pages.
- Scoring: v4.1.1.

Completed:
- Representative Crawl Enforcement implementation is complete and committed locally.
- Sitemap-footprint priority contract is implemented and tested.
- Adapter hard ceiling is implemented and tested.
- Client defense-in-depth hard ceiling is implemented and tested.
- Production configuration ceiling is aligned and tested.
- Production runtime/config policy regression is aligned and tested.
- Final focused regression is 100/100 PASS.
- Final diff review found no remaining logic blocker; formatting defects identified during review were corrected and reverified before commit.
- Governing terminology and manual edit-delivery instructions have been added to the context repository for future chats.

In progress:
- Durable context/handoff update only.

Blocked:
- No technical blocker.
- Push/deploy/production validation remain approval-gated and have not occurred.

Important constraints:
- GitHub context is authoritative durable memory.
- `WORKFLOW_INSTRUCTIONS.md` is mandatory for manual application edits: exact path, exact current line numbers/ranges, anchor text, complete replacement block, multiple edits strictly bottom-up/highest-line-first, one consolidated verification block, and no move to the next source-file unit until the user confirms verification.
- Do not ask the user to scroll back for prior code/instructions; restate required code in the current response.
- For source files roughly under 750–900 lines, whole-file replacement is acceptable/preferred when it reduces risk; larger files use surgical edits.
- `DIAGNOSTIC_EVIDENCE_PROTOCOL.md` remains mandatory: no guessing; verify executing boundary and direct evidence before stating causes or repairs as fact.
- Same observable failure remains capped at three unsuccessful repair attempts before a deeper diagnostic reset.
- Preserve discovered-footprint evidence separately from assessed-page evidence. Never imply a 250-page assessment is an exhaustive crawl of a larger site.
- Do not raise the 250-page provider crawl ceiling because a site is larger.
- Do not use custom robots override to manufacture representative acquisition without a separately approved, evidence-backed design.
- Preserve scoring v4.1.1 and Viewer v2.2.0 / 16 pages unless separately approved.
- Do not push, deploy, rerun production audits, recollect paid provider evidence, rescore, invoke paid Writer/Judge calls, or mutate persisted production artifacts without explicit approval.

Exact next action:
Start a fresh chat. Read `PROJECT.md`, `GITHUB_PROJECT_MEMORY_PROTOCOL.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`, `WORKFLOW_INSTRUCTIONS.md`, `TERMINOLOGY.md`, `CURRENT_STATE.md`, active `CONSTRAINTS.md`, active `DECISIONS.md`, and `EFFICIENCY_METRICS.md`. Treat GitHub as authoritative. Then verify the local `vantage-platform` `main` HEAD is exactly `e77832e1aab5e9b1621e31e761e865ff86c795cc` and the working tree is clean. If verified, compare local versus remote state and stop for explicit approval before any push or deployment.

Last verified:
2026-08-25 America/Toronto
