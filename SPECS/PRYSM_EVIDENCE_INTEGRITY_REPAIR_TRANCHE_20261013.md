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
- Codex-local authorized source is `C:\\Users\\kulba\\Downloads\\PRYSM-MACFARLANE-EVIDENCE-REVIEW\\original-evidence\\` (existing export). The archived `original-evidence.zip` may exist only in the ChatGPT session; do **not** assume it is available on the Windows host. When ZIP is unavailable, verify 48 object files (excluding `UNAVAILABLE.md`), combined original bytes **6,492,169**, audit ID/tenant/client identity, and per-object SHA-256 manifest from the local directory. Do not recreate an archive and claim its ZIP checksum equals the frozen one.
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
- Inventory and hash the *unmodified* exported objects from the verified Codex-local directory. If the exact original ZIP is locally available, also verify its SHA-256; otherwise do not infer its ZIP hash. Verify stored `auditId`, tenant/client scope, 48 real objects, 6,492,169 combined bytes, artifact hashes and source provenance. Inventory persisted raw, normalized, canonical, narrative and rendered objects without changing them.
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


---

## 2026-10-13 amendment — M12 business-applicability and scrape-grounding gate

**Reason for amendment:** User-reported escape: a marketing-agency audit generated an irrelevant safety-policy recommendation. This account is a reported incident, **not yet reproduced from a named audit and persisted evidence**, and must not be treated as a proven root cause. The repair must be generic across industries, not an exclusion for marketing agencies or an exception for the Macfarlane fixture.

**Mandatory cross-cutting product rule:**

> Every finding, priority, recommendation, action and score must be applicable to the audited business and traceable to relevant evidence from that **same audit's owned target site**, authoritative permitted first-party business context, or explicitly marked external benchmark where appropriate. A generic industry checklist, background assumption, competitor page, unscoped search snippet, or merely absent URL is not evidence of a business-specific deficiency. No recommendation is approved solely because an industry keyword, model prior, or broad template matches.

This is **M12**, an acceptance-blocking criterion for the current evidence-integrity tranche, even if M01–M11 pass. It is an additional gate; do not silently reconstruct or replace any approved earlier contract. Write a separate frozen M12 acceptance addendum on the authorized repair branch before touching code. This is not authority for an unrelated architecture or prompt rewrite.

### M12 required diagnosis and producer→consumer map

1. Search for the actual **marketing-company safety-policy** finding/report instance and preserve audit ID, tenant ID, exact recommendation/finding/score, business classification and underlying first-party scrape evidence. If not available, classify the incident as USER-REPORTED / RUNTIME-ROOT-CAUSE-UNPROVEN. Do not fabricate a reproduction. Continue safely with controlled negative fixtures; do not declare the real incident resolved without exact-artifact proof.
2. Trace how **intake business context → site/industry classification and scope → raw page evidence → normalization/evidence availability → finding eligibility/semantic applicability → score and priority → deterministic report projection → Writer/Judge and HTML/PDF client rendering** connect. Identify every authority/gate bypass; verify the exact executing source SHA. Track each recommendation's originating rule and whether the source is first-party, supplied client context, cited external context, or unavailable.
3. Define a deterministic, inspectable **business applicability / evidence support** contract, with at minimum:
   - audited tenant/audit/site identity, dated source URL(s) or first-party supplied context ID;
   - observed business activities and profile confidence/status, including multi-service/hybrid/unknown businesses;
   - specific customer need, conversion decision, technical or commercial problem proposed;
   - applicable recommendation condition, reason it applies, positive supporting evidence and coverage status;
   - counterevidence/exceptions; what was not assessed; status `SUPPORTED`, `VERIFY`, `NOT_APPLICABLE`, or `UNAVAILABLE` without manufacturing `ABSENT`;
   - impact on score eligibility and whether action may enter `FIX`, `VERIFY`, or excluded from client recommendations.
   The rule may apply universally only if inherently universal **and observed** (e.g. objectively confirmed broken on-site navigation, verified expired certificate); even universal rules must obey sampled scope and verified evidence.
4. Do **not** use simplistic hardcoded exclusions such as “marketing agencies never need safety policies” or “trades always need safety policies.” A marketing agency may operate workshops, events, field production, or otherwise need safety information; a trades business may need internal statutory safety controls without necessarily needing a public website policy. Only relevant real business context and specific recommendation purpose can establish an actionable **website** recommendation. Legal/regulatory compliance must not be invented from site type.
5. If classification is unknown, first-party content is partial, evidence is missing, or scope is contradictory, **fail closed**: no scored deficiency, “must implement”, or client-facing fix-first recommendation. Permit narrowly worded `VERIFY` only when its business relevance is itself grounded. Do not increase a score merely because an inapplicable rule has been suppressed; preserve explicit assessed-weight/denominator eligibility.
6. Require provenance integrity through persisted decision evidence, scoring, report model, priorities and report publication/claim validator. Writer-generated suggestions cannot bypass a deterministic applicability gate or inject a generic/safety/legal claim. If the necessary fix materially changes WriterInput, Writer/Judge prompt/schema or their semantic authority, **STOP at MODEL_BEARING_GATE_HOLD**; no unauthorized model changes or paid calls.

### M12 cross-business regression matrix — fail closed and generalize

At minimum, exercise **six** different site-shaped controlled fixtures, plus real frozen audit artifacts where available. The scenarios must be generic without client/domain literal exceptions:

| Scenario | Required proof |
|---|---|
| Marketing/creative agency with only digital strategy, SEO and website services | No public workplace-safety-policy finding or scored deficiency without additional relevant first-party evidence. A stray word “safety” in unrelated copy does not authorize it. |
| Marketing agency that explicitly offers in-person event production or on-site services | Safety relevance is evaluated from those documented operations, yet still must not assume a public policy is required; show `VERIFY` or supported, narrowly scoped recommendation only if warranted. |
| Construction, installation or home-service contractor | Detect actual first-party warranty, project, safety or insurance material where available, but do not invent legal website compliance duties, certificates or public-policy absence under partial crawl. |
| Medical/health services website | Distinguish genuinely applicable care/trust/claims checks from generic construction safety language; support observations with page-specific context and scope; no fabricated clinical proof. |
| Online retailer or subscription service | Evaluate observed checkout, shipping, returns or subscription terms only when corresponding features are present; do not prescribe unrelated sector-specific policies. |
| Professional advisory services (law, accounting or consultancy) and/or mixed-service business | Derive applicability from exact marketed services, avoid ungrounded professional/legal obligations and resolve mixed/ambiguous classifications as `VERIFY` or `UNAVAILABLE`. |

Adversarial negatives also required for: no site-body evidence; PARTIAL/FAILED crawl; mismatched tenant/client/scope; external SERP result or competitor mentioning safety; generic footer navigation or topical words without applicable activity; change of industry label alone without changed first-party evidence; false positive generic FAQ question or “projects include” proof; stale/duplicate evidence; relevant first-party *positive* evidence; and legitimately applicable but unverified compliance claims.

**Per-case output:** exact first-party evidence fixture and expected/actual class → eligible finding/scoring rule (and assessed denominator) → priority/action type → rendered user-facing wording, including negative assertion that an irrelevant recommendation is **absent**; record counterexamples with failing red test and green proof. Include at least one real frozen non-Macfarlane, different-sector audit if already available **without** new crawl/provider/model calls, or explicitly `REAL_CROSS_SECTOR_FIXTURE_HOLD`.

### M12 acceptance rule and impact on G0–G5

- Insert M12 in the **next** correction's G0 acceptance freeze. Before changing a source file identify the full owning boundary, permitted file set and evidence lineage. Do not patch an individual forbidden keyword or brand/sector; fix the general applicability authority.
- On G1/G2/G3, every touched scoring or client-projection rule must demonstrate M12 applicability, including when the finding is an absence claim.
- G4 must test the six-sector fixtures and negative controls through actual assembled producer→scoring→priority→client projection path, not just leaf regexes. Frozen Macfarlane tests remain regression inputs, not target exceptions.
- G5 independent audit must inspect false-PASS counterexamples and a per-finding provenance matrix. An unsupported but plausible recommendation is a **FAIL**, not a stylistic issue.
- Do not call the tranche `CODE_VERIFIED` for M01–M12 until issue-specific direct and negative proof is supplied. Independently retain M03 certificate/browser, M10 model-bearing, and M11 visual/PDF HOLD until their actual proof planes pass.
- Maintain `CHANGE_ONLY` and all existing immutable-baseline, no-cost, no-deployment, no-production boundaries.
