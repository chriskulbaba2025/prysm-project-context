# PRYSM Evidence Integrity Repair — GACM-style tranche

**Tranche ID:** `PRYSM-EVIDENCE-INTEGRITY-20261013-01`  
**Date:** 2026-10-13  
**Status:** AUTHORIZED PLAN / IMPLEMENTATION NOT STARTED  
**Release intent:** `CHANGE_ONLY`. An offline, exact-head candidate and independent artifact audit are the terminal scope. **No staging deployment, production release, audit rerun, or paid calls.**

## Outcome and source authority

Repair the generic PRYSM evidence-to-report contracts behind the eleven Macfarlane accuracy issues so future different websites do not receive fabricated absence, unsupported proof, misleading scores, contradictory priorities, or false certainty. Treat Macfarlane as a regression *case*, never a target-specific code exception.

Authoritative frozen inputs:
- Application repository: `chriskulbaba2025/prysm-staging-isolated`.
- Immutable baseline SHA: `89672525b3151a3fc682036601efed0e171cefbe`.
- Reference branch: `freeze/prysm-before-evidence-accuracy-repairs-20261013`; **DO NOT MODIFY**.
- Authorized working branch: `repair/prysm-evidence-accuracy-20261013`; started at the same SHA.
- Deployed isolated staging uses `fix/prysm-exec-render-recovery-20261012`, currently at the frozen SHA. **Do not push repairs to this deployment-connected branch.**
- Audit `778e0a77-e488-4d3d-bbdc-91fe7bdb4ab6`, tenant `prysm-staging`, client `macfarlanewindowsanddoors.ca-macfarlane-windows-doors`.
- Exact original artifact export: `original-evidence.zip`, preserved byte-identically as `PRYSM-MACFARLANE-FROZEN-EVIDENCE-20261013.zip`; SHA-256 `bc87fbfd876f8e813222f1d24f1de4ca216c13106c754fef0b6efc7b78140263`; contains 48 persisted storage objects and a historical unavailable placeholder. Work from the 48 real objects; placeholder is not source authority.
- Root-cause register: `PRYSM-MACFARLANE-ACCURACY-DIAGNOSIS.md`, supplied in this ChatGPT project; M01–M11 are the initial observed defects, not proof that similar defects are absent elsewhere.
- Governing protocols: project `PROJECT.md`, `CURRENT_STATE.md`, `CONSTRAINTS.md`, `DECISIONS.md`, `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, `SKILLS/GOVERNED_CODING_UPGRADE.md`, `PRYSM_WHOLE_APP_TRANCHE_GATE.md`, `PRYSM_WHOLE_APP_BRANCH_COVERAGE_PROTOCOL.md` and model-bearing gate when implicated. Apply GCU 2.1.0.
- No Desktop Commander, no subagents, no model escalation. Use GPT-5.6 Luna in a single Codex session; separate documented role *checks* are permitted, but one implementation/write owner only.

## Mandatory protected invariants

1. No modifications to original audit objects, raw/normalized/canonical persisted data, scoring records, NDP, Writer/Judge outputs, reports, or published reports. **All corrected outputs are offline derived comparisons in a separate proof folder.**
2. No calls to DataForSEO, PageSpeed, external search, live models, Writer/Judge or other paid providers; no new audits or attempts to `resume`, `retry`, `approve`, `publish`, `recalculate` or `rerender` the persisted audit. Controlled stubs/replays with exact persisted bytes are allowed.
3. No PRYSM production, separate analytics product, data services, S3, PostgreSQL, Railway, Vercel or deployed branch mutation. No deployment, merge to default, or secrets in logs/proof artifacts. GitHub pushes, if used, are permitted **only to the dedicated repair branch after exact-SHA gates pass**. Never force-push.
4. Maintain the approved six Executive report sections, Trust & Credibility client-language standard, evidence citations, canonical scope, identity, source status, unknown/partial handling, and privacy/security boundaries. Do not silently alter accepted UX, canonical formulas, unrelated rules or model prompts.
5. Do not turn `PARTIAL`, `UNAVAILABLE`, `UNKNOWN`, `NOT_ASSESSED`, `BLOCKED` or `CONFLICTED` into measured zero, confirmed absence, success, or independent verification.
6. Preserve difference between **business-published assertion**, **observed on-page material**, **validated technical fact**, and **independently verified external proof**. Recorded schema *presence* is not a claim that markup is valid/rich-result eligible; FAQ *presence* is not complete answer coverage.
7. Existing readiness score **59/100 remains historical and provisional**. Do not replace it or claim a new certified score until offline full deterministic impacts, scope coverage, priorities and separate model-bearing limitations are reconciled.
8. No new third-party credentials or unrestricted accesses. Use the local exported ZIP as the primary artifact source. Continue only on verified exact branch/head/worktree.
9. Do not edit tests just to make regressions green or remove coverage. Maximum three unsuccessful iterations on a single failure; then STOP and perform a diagnostic reset with new evidence.

## Execution lifecycle — one logical candidate ahead

**Stage G0: Identity, preflight and freeze — MUST PASS before implementation**

- Verify exact application origin/repo, working branch and starting SHA, current remote SHA, tree cleanliness and no unexpected PR/commit divergence. If dirty, preserve all changes and use a fresh isolated worktree; do not reset or overwrite user work.
- Read governing files and mapped affected source files. Confirm the model-bearing and whole-app acceptance gates applicable to the proposed changes.
- Hash and inventory the *unmodified* original ZIP; verify stored `auditId`, tenant/client scope and source artifact provenance. Inventory persisted raw, normalized, canonical, narrative and rendered objects without changing them.
- Write `.governance/changes/PRYSM-EVIDENCE-INTEGRITY-20261013-01_CHECKLIST.md` on the **repair branch only** before coding. Include approved file scope, one observable acceptance contract per issue, positive/negative controls, producer → contract → validator → consumer → projection links, expected regression outputs and explicit HOLD branches.
- Reproduce original schema/FAQ/report contradictions offline using real persisted bytes. For other issues, establish expected-vs-actual and root cause or mark `UNRESOLVED`. No coding on unresolved material boundaries.
- Preflight GCU test commands; do not guess names and record exact commands.

**Stage G1: Evidence acquisition/normalization and content detection (M01, M02) — separate logical commits, tests after each**

- **M01 structured data:** Provider `microdata.items[*].inspection_info.types` contains actual schema.org types; `item.type=json_ld` is provider format, not a schema type. Correct the generic mapping and preserve type provenance, warnings and scope. Do not label invalid or unverified markup as validated. Must distinguish `HomeAndConstructionBusiness`, `Organization`, `WebSite`, etc., from unobserved `FAQPage` or `Service`. Verify downstream capability, module scoring eligibility, absence finding and priority projections.
- **M02 FAQ:** Preserve homepage H2 FAQ label and eight H4 questions across parsing and hydration. Recognize present FAQ without asserting adequate answers, complete buyer-question coverage or FAQ schema. Test heading-only, text-only, generic non-FAQ question labels, inaccessible/partial pages, Unicode/case/whitespace variations and negative siblings.

**Stage G2: Security, trust, counting and integration (M03–M07) — bounded logical units**

- **M03 TLS/interactive:** Consume the persisted `ssl_info.valid_certificate=false` and expiry as a historical dated technical observation, not a current live result. The recorded six `ERR_CERT_DATE_INVALID` browser path checks remain NOT_ASSESSED. Do not credit certificate validity solely because a URL begins with `https:`; separately score transport scheme, certificate evidence availability and risk where the existing contract permits. Keep failed lab scores unavailable and provider failures distinct.
- **M04 metadata:** Reconcile 3 HTTP-200 URLs, one redirect, reported normalized numerator 4 and finding numerator 5/29. Select a justified and explicit assessed-population policy; enforce one numerator/denominator/URL-set relationship through scoring and projection. Preserve distinction between HTML meta description, Open Graph description, duplicates and snippets (M09) without inferring search-result appearance.
- **M05 completed-work:** Generic “our projects” and unrelated image presence cannot automatically establish proprietary completed-work examples. Require provenance-linked examples or distinguish business-published claims. Test generic/actual verified examples and unrelated image controls.
- **M06 experience:** Parse “over 20 years” and variants as **CLAIMED_BY_SITE**, with source citation and `NOT_INDEPENDENTLY_VERIFIED`; do not automatically award independent credentials or results. Honor differing wording and cross-page assertions.
- **M07 SERP location:** Reject/normalize unsupported `London Ontario` provider formatting via validated location authority and preflight. Do not silently change region, invent a provider `location_code`, retry DataForSEO, or fill missing competitor data. Deterministic preflight acceptance is not evidence of live provider success.

**Stage G3: Canonical truth → report/UX integrity (M08–M11)**

- **M08 buyer questions:** A partial FAQ/coverage finding must never render “Important buyer questions are unanswered,” or be treated as confirmed buyer-question absence. `VERIFY` stays verify, including prioritization and user-facing section grouping; do not overwrite the canonical finding or loosen rendered-claim integrity.
- **M09 metadata provenance:** Explicitly label which HTML/OG/provider metadata field supports each count and recommendation; never substitute one for another.
- **M10 evidence-safe narrative:** Remove/guard false “Lab performance was measured: .” and internal terms (“deterministic analysis”, “authorized for consolidation”) from *visible client fields*, while preserving internal provenance. Do not rewrite Writer/Judge outputs, weaken validators, or silently change model-bearing semantics. If genuine prompt/Writer/Judge changes are required, STOP at a **MODEL_BEARING_GATE_HOLD** until separately authorized.
- **M11 PDF/presentation:** Six navigation **sections** are not necessarily six printed sheets. Check real browser export against the supplied 20-page observation if proof is available; make section/sheet numbering explicit and hide click-only instructions in print. Fix only confirmed clipping/overflow. Browser/PDF acceptance without a browser/PDF proof remains `VISUAL_HOLD`; deterministic HTML inspection alone does not earn PASS.
- Do not change the already-approved layout or unrelated client voice. Keep the original report unchanged; updated HTML must be an offline preview artifact.

**Stage G4: Offline end-to-end regression / false-PASS search**

- Build a deterministic, no-provider replay following the actual PRYSM execution boundaries as far as possible:
  `frozen SourceResults → normalized site evidence → DecisionEvidence/CapabilityEvidence → scores/findings → report model/root cause/priority → WriterInput/approved frozen narrative compatibility → client projection → Executive HTML`.
- When exact replay cannot legitimately traverse a model-bearing boundary without paid Writer/Judge calls, use controlled deterministic executors and clearly label the coverage limit. Never present mock Writer/Judge outputs as live client endorsement; treat outdated original NDP/runtime projections as historical, not corrected claims.
- Require 1) historical frozen evidence remains SHA-identical, 2) each corrected claim has exact supporting evidence URL/field/status, 3) each removed/changed false claim has an expected absence proof, 4) no score/priority shifts outside explainable changed inputs, 5) no ability to swap across audit/tenant IDs or publish unsupported facts.
- Add at least two **other representative site-shaped** positive/negative regression cases for each generic defect where practicable (fixture only; not paid audits). Probe mixed schema, no schema, FAQ without answers, FAQPage absent, redirect metadata, valid vs expired vs unavailable TLS, 301/200 populations, claimed experience vs independent proof, real vs generic portfolio, partial/failed provider statuses and scope.
- Include negative controls for missing/malformed artifacts, missing provenance, conflicting statuses, invalid source types, unknown scores, unauthorized/reportability states and report claim gate rejections.
- Run exact current targeted tests, affected integration, full worker narrative/report regressions, schemas/contracts, static checks, build, security and mandatory deterministic Whole-App gate for the candidate. A blocked or irrelevant whole-app gate is HOLD, not PASS.

**Stage G5: Exact-head validation, challenge and audit**

- Produce an issue-by-issue proof table `M01…M11`: baseline output → fixed offline output → original evidence locator/hash → code boundary → narrow tests → integration tests → negative counterexamples → effect on scoring/finding/action → status.
- Run an adversarial *read-only Challenger check* for over-correction, leakage, different-client regressions, fabricated confidence, downscored unknowns, altered preserved UX and cost side effects. This is NOT an independent agent audit; label it self-check.
- Commit the final verified candidate on **repair branch only**, run the exact-SHA Whole-App/machine gates and full applicable regression, record the exact SHA, clean diff/check and remote synchronization if pushed. Do not advance if the SHA moves after proof; rerun required gates.
- Produce `REPORT.md`, `EVIDENCE-MATRIX.md`, `BEFORE-AFTER.md`, `TESTS.md`, `DIFF-SCOPE.md`, `INTEGRITY.md`, `GATE-STATUS.md` and safely redacted outputs in `C:\Users\kulba\Downloads\PRYSM-EVIDENCE-INTEGRITY-20261013-01\`. Include full command stdout/exit code, date, environment, SHAs, file hashes, dirty state, supported/blocked boundaries, raw artifact preservation, client-facing sentences and model/provider invocation counters.
- Handoff exact application candidate SHA and proof ZIP to ChatGPT/human **independent review**. Same-session self-review does not count as independent acceptance.
- Only report `CODE_VERIFIED` if all in-scope deterministic/machine gates pass. Report `STAGING_READY_HOLD` and/or `MODEL_BEARING_GATE_HOLD` and/or `VISUAL_HOLD` explicitly where those planes are unproven. `CLIENT_REPORT_APPROVED` requires separate human accuracy/visual approval; `PRODUCTION_READY` is outside scope.
- If any required defect cannot be fixed without an unauthorized provider/model call, deployment, source-scope expansion or semantic authority change, **STOP at that gate**, preserve passing work, document exact blocker and safe next action. Do not use a weaker alternative to manufacture PASS.

## Stop conditions

Immediately stop for: baseline or head mismatch; wrong repository/project/environment; dirty unrelated work without isolation; production/deployment mutation attempt; missing/corrupt frozen raw bytes; paid/provider call attempted; source truth replaced by inference; first material new unscoped defect; inconsistent corrected score without explained denominator; any issue failing after three attempts; test gate false-PASS; GCU machine gate unavailable for a claimed full PASS; model-bearing release requirement without authorization; or no trustworthy browser/PDF proof for a visual PASS.

A stage PASS proceeds to the next authorized stage without asking again. A HOLD stops advancement; never flatten stage HOLD into whole-tranche PASS.

## Deliverable and authorization

The explicit user request authorizes **offline source/fixture repairs and audits on the dedicated repair branch** under these boundaries. It does **not** authorize staging deployment, production, new audits, live providers, live model runs, rewriting original persisted evidence or automatic merge. The independent reviewer decides acceptance. The next user action should be to run this exact work package in a single local GPT-5.6 Luna Codex session with access to the frozen ZIP, repository and proof location.

**Status at creation:** planning and package freeze only; no application source changes or tests executed.
