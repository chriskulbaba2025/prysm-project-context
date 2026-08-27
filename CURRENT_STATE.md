# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

Current objective:
Finish the local PRYSM Audit Integrity repair checkpoint by assigning the correct On-Page adapter version bump and running the final aggregate deterministic regression. After that, perform the final end-to-end Data Utilization Audit.

Verified checkpoint:
- Authoritative context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Evidence-review repository: `chriskulbaba2025/betty-prysm-audit`.
- Governed application branch: `main`.
- Verified application baseline before the current local integrity repairs: `46d92a346763a8e3ab252d1c32fe79632e7110a4` — `test(onpage): align representative crawl ceiling`.
- Local application integrity repairs remain uncommitted/unpushed. No deployment, production rerun, paid provider call, Writer/Judge call, persisted production rescore, or production-artifact mutation has been authorized or performed as part of this repair stream.
- Viewer remains v2.2.0 / 16 governed pages.
- Production scoring version remains v4.1.1.
- Governed DataForSEO On-Page provider ceiling remains 250 pages.
- Governed provider `priority_urls` ceiling remains 20.
- On-Page adapter is still v1.4.0 locally until the final repair-version bump is deliberately assigned and verified.

Integrity workstreams:

1. Interpretation Integrity — COMPLETE LOCALLY, 7/7 known defects closed.
   - Unknown image evidence cannot create negative image findings.
   - Content Parsing request completion is not treated as usable body-content evidence.
   - Utility/legal/infrastructure pages cannot distort commercial conclusions.
   - Representative `siteFootprint` reaches Writer/Judge-visible evidence.
   - Business-impact wording is bounded by deterministic policy.
   - Judge independently challenges unsupported causal/commercial overreach.
   - Finding evidence preserves governed source status and no longer silently upgrades to AVAILABLE.
   - Do not invent an Interpretation Defect 8 without new direct evidence.

2. Evidence Integrity — SIX VERIFIED DEFECTS ARE NOW CLOSED LOCALLY UNDER TARGETED DETERMINISTIC TESTS.

Evidence Defect 1 — governed deep candidates silently truncated at 20 before Content Parsing accounting:
- CLOSED LOCALLY.
- Full governed selected set is preserved before the Content Parsing runtime budget.
- Provider `priority_urls <= 20` remains unchanged and separate.
- URL-aware Content Parsing ledger now records selected/requested/completed/failed/unassessed truth.
- Regression: `EVIDENCE-01: governed deep selection survives beyond 20 and budget overflow is explicitly unassessed`.
- Relevant adapter/representative test run: 76/76 PASS, 0 fail; `git --no-pager diff --check` clean.

Evidence Defect 2 — `contentParsingPageLimit` default/provenance drift:
- CLOSED LOCALLY.
- Governed default is 20 in schema, orchestration/source identity, and runtime.
- Source identity proves omitted limit is equivalent to explicit 20 and explicit 30 remains distinguishable.

Evidence Defect 3 — `maxPages` default/provenance drift:
- CLOSED LOCALLY.
- Governed default is 250 in schema, orchestration/source identity, and runtime/provider ceiling.
- Source identity proves omitted maxPages is equivalent to explicit 250.
- Focused source-execution identity result for Defects 2/3: 12/12 PASS, 0 fail; schema check returned `{ maxPages: 250, contentParsingPageLimit: 20 }`; `git --no-pager diff --check` clean.

Evidence Defect 4 — incomplete governed deep coverage could be represented too optimistically in score-bearing body/trust/offer capability availability:
- CLOSED LOCALLY.
- New URL-aware acquisition ledger is used as the governing coverage truth when present.
- If selected governed deep URLs are failed or unassessed, site-wide `content.body`, `trust.proof`, and `offer.clarity` fail closed to UNAVAILABLE under the current scoring model.
- Legacy artifacts without the URL-aware ledger preserve prior derivation semantics rather than being retroactively reclassified.
- Regression: `EVIDENCE-04: incomplete governed deep coverage fails closed for body, trust, and offer capabilities`.

Evidence Defect 5 — programmatic representative analysis confused crawled pages with deeply assessed pages:
- CLOSED LOCALLY.
- Programmatic deep-dependent representative analysis now accepts the Content Parsing acquisition ledger and counts a representative page as deeply assessed only when its normalized URL is in `completedUrls`.
- Crawled-only representatives do not prove trust/schema/offer deep assessment.
- Legacy analysis without the new ledger preserves historical behavior.
- Regression: `EVIDENCE-05: crawled representative pages are not deeply assessed without completed Content Parsing`.

Evidence Defect 6 — configured/provider crawl ceiling used as expected/requested record count and false failures:
- CLOSED LOCALLY.
- A complete small crawl no longer turns the 250-page ceiling into `250 requested / 7 completed / 243 failed`.
- Completed small-site coverage uses observed/returned crawl volume; failed is bounded at actual attempted/expected records.
- Regression: `EVIDENCE-06: completed small crawl never converts the 250-page ceiling into failed coverage`.
- Focused adapter result when closed: 72/72 PASS, 0 fail; `git --no-pager diff --check` clean.

Latest combined Defect 4/5 verification:
- `src/evidence/evidence-integrity-deep-coverage.test.js`
- `src/evidence/capability-evidence.test.js`
- `src/evidence/programmatic-seo-analysis.test.js`
- `src/adapters/dataforseo-onpage/dataforseo-onpage-representative-evidence.test.js`
- Result: 34/34 PASS, 0 fail, 331.8612 ms.
- `git --no-pager diff --check`: clean.

Current local repair surface includes at minimum:
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.test.js`
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-representative-evidence.test.js`
- `services/worker/src/contracts/audit-request.schema.json`
- `services/worker/src/orchestration/audit-orchestrator.js`
- `services/worker/src/orchestration/source-execution-identity.test.js`
- `services/worker/src/evidence/capability-evidence.js`
- `services/worker/src/evidence/programmatic-seo-analysis.js`
- new `services/worker/src/evidence/evidence-integrity-deep-coverage.test.js`
- plus the previously completed local Interpretation Integrity files.

This list is not a substitute for the actual dirty-tree check. Do not clean/reset or overwrite local work.

Current environment / branch / version:
- Desktop application path: `C:\Users\kulba\Desktop\vantage-platform`.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Branch: `main`.
- Verified baseline before local repairs: `46d92a346763a8e3ab252d1c32fe79632e7110a4`.
- Current adapter version before final bump: v1.4.0.
- Provider crawl ceiling: 250.
- Provider priority URL cap: 20.
- Viewer: v2.2.0 / 16 governed pages.
- Production scoring version: v4.1.1.

Completed:
- Representative Crawl Enforcement is complete, pushed, and remotely green from the earlier work package.
- Interpretation Integrity defects 1–7 are closed locally.
- Evidence Integrity defects 1–6 are closed locally under their targeted deterministic regressions.
- Defect 1 preserves the full governed deep selected set and explicitly records runtime-budget overflow as unassessed rather than failed or silently dropped.
- Defects 2/3 align 20/250 configuration provenance and source-execution identity.
- Defect 4 fails score-bearing body/trust/offer availability closed when governed deep coverage is incomplete.
- Defect 5 distinguishes crawled representatives from deeply completed representatives.
- Defect 6 separates provider ceiling from actual expected/requested crawl volume.

In progress:
- Final repair-version assignment for the DataForSEO On-Page adapter.
- Final aggregate deterministic regression over the combined Interpretation + Evidence Integrity repair surface.
- Final Data Utilization Audit after the repaired local checkpoint is fully green.

Blocked:
- No known technical blocker.
- Integrity repair is not ready to commit/push yet because the adapter version bump and final aggregate regression have not been completed.

Important constraints:
- GitHub context is authoritative durable memory.
- `REPAIR_BOUNDARY_PROTOCOL.md`, `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`, and `WORKFLOW_INSTRUCTIONS.md` remain mandatory.
- Never guess current local line numbers. For every code edit provide the exact full Windows path, exact current line/range, current anchor/FIND text, complete replacement/insertion, and next anchor. Multiple edits must be delivered bottom-up. If current lines may have shifted, obtain a line-numbered local snippet first.
- Never guess a root cause. Require direct executing-path evidence.
- Same observable failure is capped at three unsuccessful repair attempts before a deeper diagnostic reset.
- Do not ask the user to scroll back for code or instructions; restate what is required in the current response.
- Preserve broad discovered footprint separately from assessed-page/deep-assessment evidence.
- UNKNOWN / UNAVAILABLE / PARTIAL / NOT DEEPLY PARSED / unassessed must never become ABSENT / FALSE / ZERO / FULLY ASSESSED.
- The 250-page provider ceiling and 20-provider-priority-URL cap remain unchanged.
- Do not bump adapter version by assumption. Inspect current versioning convention and all materially coupled adapter-version assertions/fixtures first, then assign the smallest correct version change.
- Do not update tests merely to silence regressions. Test changes require the intended repaired contract.
- Do not push, deploy, run production audits, call paid providers/models, rescore persisted production data, run Writer/Judge, or mutate production artifacts without explicit approval.
- Do not clean/reset the dirty working tree.

Exact next action:
In the fresh chat, after reading the governing context files, run only these read-only local checks first: `git rev-parse HEAD`, `git status --short`, and `git --no-pager diff --stat`. Then inspect the current adapter-version declaration and its exact coupled tests/fixtures before proposing the final version bump.

Last verified:
2026-08-26 America/Toronto
