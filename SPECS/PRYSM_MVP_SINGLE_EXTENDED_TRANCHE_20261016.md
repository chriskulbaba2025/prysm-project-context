# PRYSM MVP — single extended staging development tranche
Date: 2026-10-16
Tranche: PRYSM-MVP-SINGLE-BATCH-20261016-01
State: READY TO LAUNCH AFTER LIVE TELEGRAM AUTHORITY PREFLIGHT; no code run authorized by this document alone.

## Product objective
Improve the **existing** PRYSM isolated-staging website audit so it correctly understands a website's business purpose, detects relevant patterns of repeated pages across *any* primary website type, and produces specific, evidence-grounded recommendations and a reliable approved client report. One coherent tranche with internal stages, not many unrelated short jobs.

## Exact starting authority
- Application: `chriskulbaba2025/prysm-staging-isolated`
- Branch: `repair/prysm-evidence-accuracy-20261013`
- Released starting SHA: `c0460142224fd6f9cfd8262dd8816aa6ccd89ac7`
- Current Vercel stable staging `prysm-staging-isolated.vercel.app` and isolated Railway worker were both verified on that SHA.
- Production `chriskulbaba2025/production-prysm` remains untouched.
- Existing GACM controller `chriskulbaba2025/gacm-controller` now has GitHub config pointing to the released SHA, but **the running local Telegram executable, local source checkout, runtime model availability and durable recovery are not yet verified**. Validate those first. Do not start a second controller or delete previous work.

## Work scope — one internally staged Codex work order
S0 — Read current production composition and approved GitHub context (as available locally), reconcile the actual executing worktree/ref and existing tests; identify owned producer-to-render paths before editing. Preserve existing unfinished work and report truth.

S1 — Business and website-purpose classification. Derive the business's primary purpose, market/service context and site structure from explicit intake and *same audit, owned first-party evidence*. Handle mixed organizations, professional services, healthcare, agencies, trades, local service sites, ecommerce, catalogues and directory-like sites generically. Explicitly preserve UNKNOWN, PARTIAL, UNAVAILABLE and conflicting signals; do not infer compliance duties or claim an unavailable service was absent.

S2 — Purpose-aware programmatic SEO. Reuse the existing `services/worker/src/evidence/programmatic-seo-analysis.js` and actual upstream/downstream composition. Find genuinely repeated page families across any site type: services, locations, condition/treatment pages, product/category patterns, portfolios, FAQs and directories where applicable. Sample/assess representative first-party evidence without assuming the homepage identifies all families; distinguish intentional distinct pages from thin/duplicated templates. Keep crawl caps and depth/coverage truth: 250 total pages / 20 priority URLs. No new live crawls, provider calls or fabricated page evidence.

S3 — Evidence-supported findings, scoring and six-page Executive Report handoff. Every proposed action must be demonstrably applicable to the specific business, anchored to the same audit's permitted first-party context, with appropriate limitations, confidence and citations. External SERP/competitor data are benchmarks, not substitutes for missing first-party proof. Rule out generic safety-policy/compliance recommendations without scoped relevance. Preserve approved Executive Report language, layout, scores and other sections unless the changed evidence contract requires a bounded fix. Ensure data survives canonical persistence, recovery, narrative validation and client rendering; no silent Writer/Judge expansion.

S4 — Targeted controls, end-to-end integration and exact-SHA Whole-App. Positive/negative fixtures spanning business types, partial/no scrape, conflicting classification, mixed sites, similar routes, varied templates, missing context, competitor contamination and incorrect scored absence. Run full affected tests, contracts/schemas, security/build, deterministic Whole-App and closure gates and reconcile all required implemented branch-matrix rows. If Writer/Judge prompt/schema or model-bearing semantics would change, stop at the separate model-bearing release gate — no live/paid calls.

S5 — Produce one candidate and one concise proof. Write `REPORT.md` in a named Downloads proof folder; include objective, repository, branch, start/end SHA, dirty state, files, root causes, exact test commands/counts, Whole-App branch coverage, model/provider usage, blocked proof planes, staging/production impact, and the next action. Where the GACM controller forbids commits/pushes/deployments, leave the verified patch uncommitted and give exact non-destructive instructions for the separately authorized release. Do **not** claim full app PASS merely from leaf tests or 17/17 branches without reconciliation.

## Execution policy
- ONE active Codex child, one writer. Continue automatically from S0 through S5; no user approval between ordinary diagnosed fixture/source edits, targeted repairs or regression reruns within scope.
- Up to three attempts per root defect before a diagnostic reset/HOLD. Do not patch by guesswork.
- No subagents, model escalation, extra staging environment, force-push, reset, stash, destructive workspace cleanup or real production change.
- No new audit, paid provider/model call, deployment, Git push, controller SHA change or browser automation. Chris alone performs interactive browser acceptance.
- Use a **supported, low-cost locally available Codex model**; preference GPT-6 Luna low effort only if the actual CLI accepts it. Never pretend a model was verified from a config string.
- Do not consume tokens on full test logs; store full proof on disk, summarize only failures and outcomes.
- Full pass is CODE VERIFIED; deployment, report UAT, and production acceptance are distinct later gates.

## Exit criterion and no-drift rule
Produce exactly one tested candidate with evidence and zero mandatory machine-gate failures. If blocked, report the exact owning boundary and smallest fix; no cascade of ungoverned task launches. Promote verified code in one staging release after the separately governed Git/release step. Keep at most one unreleased application candidate.
