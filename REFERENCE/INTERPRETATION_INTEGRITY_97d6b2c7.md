# PRYSM Interpretation Integrity Ledger

Audit ID: `97d6b2c7-03b9-4530-8ea7-16557502c638`  
Target: `https://rebootbusinesscoaching.com/`  
Opened: 2026-08-26  
Status: COMPLETE LOCALLY — 7/7 known Interpretation Integrity defects closed; awaiting reconciliation with Brad's Evidence Integrity stream

## Purpose

Durable workstream ledger for the Interpretation Integrity investigation. This track tests whether governed evidence that PRYSM already has is correctly scoped, interpreted, propagated into scoring/findings, exposed to Writer/Judge, and used in the final client report.

This ledger is complementary to Brad's Evidence Integrity workstream. Brad is tracing acquisition and evidence preservation. Chris's workstream traces downstream use and interpretation.

Core semantic rule:

**UNKNOWN / UNAVAILABLE / NOT DEEPLY PARSED / PARTIAL must never become ABSENT / FALSE / ZERO / FULLY ASSESSED.**

Important commercial pages must drive site-level conclusions. Utility/infrastructure pages may remain in canonical evidence but must not distort commercial scoring or narrative.

## Workstream split

### Brad — Evidence Integrity

Brad is independently reviewing the private sandbox `chriskulbaba2025/betty-prysm-audit`.

His forensic boundary is:

`RAW → NORMALIZED → CANONICAL → CAPABILITY/DECISION → SCORES/FINDINGS`

His task is to determine whether useful data was actually collected, preserved, dropped, changed, overwritten, misclassified, insufficient, or unknown. His work remains read-only with respect to production PRYSM unless separately authorized.

### Chris — Interpretation Integrity

Chris's boundary is:

`CANONICAL/DECISION EVIDENCE → SCORING → FINDINGS → WRITER INPUT → JUDGE → CLIENT REPORT`

This track determines whether available evidence is actually used, weighted correctly, scoped correctly, and expressed no more strongly than the evidence supports.

The Interpretation Integrity stream is now complete locally. Final integrity sign-off still requires reconciliation with Brad's Evidence Integrity findings and the final Data Utilization Audit.

## Verified application baseline

Application repository: `chriskulbaba2025/vantage-platform`  
Governed branch: `main`  
Verified application baseline before this local repair package: `46d92a346763a8e3ab252d1c32fe79632e7110a4` — `test(onpage): align representative crawl ceiling`

No application push, deployment, paid provider call, production audit rerun, Writer/Judge rerun, rescoring of persisted production artifacts, or production-artifact mutation was performed during this Interpretation Integrity repair session.

Local manual edits remain in the user's Desktop working copy and must be verified with `git status --short` before any application commit.

## Offline replay harness

A bounded no-network report replay harness was created locally at:

`C:\Users\kulba\Desktop\vantage-platform\services\worker\scripts\replay-report.js`

Fixture root:

`C:\Users\kulba\Desktop\vantage-platform\services\worker\test-fixtures\report-replay\audit-97d6b2c7`

Verified result:

- replay fixtures: 1
- PASS: 1/1
- no provider calls
- no Writer/Judge calls
- no lifecycle mutation
- no production writes

Do not rerun this harness merely for reassurance. Reopen it only if a later defect directly implicates deterministic replay/rendering.

---

## Defect 1 — Unknown image evidence created a negative finding

Status: **CLOSED LOCALLY**

Observed defect:

The historical finding `VAN-TECH-004` could state an impossible result such as `3 of 0 images`. Canonical decision evidence showed image counters were not actually available (`_metaCountersAvailable: false`), yet the finding builder treated a non-zero `imagesMissingAlt` value as confirmed evidence.

Repair:

`C:\Users\kulba\Desktop\vantage-platform\services\worker\src\scoring\score-components.js`

The finding now requires known image evidence before `VAN-TECH-004` can be emitted:

- meta counters must not be explicitly unavailable;
- `imageCount` must be finite and greater than zero;
- `imagesMissingAlt` must be finite and greater than zero.

Regression:

`C:\Users\kulba\Desktop\vantage-platform\services\worker\src\scoring\score-components.test.js`

Verified targeted output:

- tests: 25
- pass: 25
- fail: 0

Expected outcome:

Unknown image evidence can no longer become a confirmed negative accessibility/technical finding.

---

## Defect 2 — Parsing completion was mistaken for usable content evidence

Status: **CLOSED LOCALLY**

Observed defect:

The historical audit had completed content-parsing requests whose returned records contained no usable body-content fields:

- `text: ""`
- `wordCount: null`
- `mainContentChars: null`
- `hasMainContent: false`

Request completion could still cause `content.body` to be treated as `AVAILABLE`, making content-depth/funnel conclusions eligible despite no usable body evidence.

Repair:

`C:\Users\kulba\Desktop\vantage-platform\services\worker\src\evidence\capability-evidence.js`

Usable content is now determined from actual returned fields. A record is usable only when at least one of these is explicitly present as usable evidence:

- non-empty `text`;
- finite numeric `wordCount`;
- finite numeric `mainContentChars`.

`hasMainContent: false` alone is not treated as proof that body evidence was successfully captured.

Semantics:

- all requested records usable, no failures → `AVAILABLE`;
- some usable → `PARTIAL`;
- none usable → `UNAVAILABLE`.

Verified targeted output:

- tests: 46
- pass: 46
- fail: 0

Expected outcome:

PRYSM no longer confuses a successful provider request with successful evidence acquisition. Unsupported content scoring and narrative conclusions are suppressed when body evidence is unavailable.

---

## Defect 3 — Utility pages distorted commercial scoring and conclusions

Status: **CLOSED LOCALLY**

Observed audit pages included both commercial pages and utility/infrastructure pages such as:

- `/cdn-cgi/l/email-protection`
- `/privacy-and-accessibility-statements`

Those utility pages could influence site-level page counts, average words, metadata findings, heading findings, page ordering, conversion paths, readiness mapping, and report interpretation.

Repair files:

`C:\Users\kulba\Desktop\vantage-platform\services\worker\src\scoring\decision-scope.js`

`C:\Users\kulba\Desktop\vantage-platform\services\worker\src\scoring\vantage-score.js`

The repair creates a decision-scoped copy for scoring/report interpretation while preserving raw canonical evidence unchanged.

The scoped site is used for commercial scoring and downstream deterministic interpretation including module scoring, funnel scoring, findings, rendering diagnostics, conversion paths, readiness map inputs, and topic/content ideas.

Regression:

`C:\Users\kulba\Desktop\vantage-platform\services\worker\src\scoring\decision-scope.test.js`

Verified output:

- tests: 4
- pass: 4
- fail: 0
- duration: 96.3603 ms

Expected outcome:

Commercial conclusions reflect the pages that matter to buyers/search/conversion rather than low-value infrastructure or legal pages. Canonical evidence remains auditable and unchanged.

---

## Defect 4 — Representative-site coverage did not reach Writer/Judge

Status: **CLOSED LOCALLY**

Observed defect:

`decision-evidence.js` already preserved governed `siteFootprint` evidence from the On-Page SourceResult, but the Narrative v2 WriterInput was assembled only from AuditRequest + ScoreSet + Findings + CapabilityEvidence. `scores.json` did not carry `siteFootprint`, so Writer and Judge could not know how the assessed representative sample related to the broader discovered site footprint.

Verified path:

`DecisionEvidence.site.siteFootprint` existed → ScoreSet omitted it → `writer-input.js` could not project it → Writer could not cite it → Judge received the same incomplete WriterInput.

Local repair files:

`C:\Users\kulba\Desktop\vantage-platform\services\worker\src\scoring\scoring-service.js`

`buildScoreSet()` now carries the already-governed `model.evidence.site.siteFootprint` into `scores.json` when present. It does not reconstruct or infer missing footprint values.

`C:\Users\kulba\Desktop\vantage-platform\services\worker\src\narrative-v2\writer-input.js`

`siteFootprint` is now an admitted `DETERMINISTIC_ANALYSIS_FIELDS` field and therefore appears in `WriterInput.deterministicAnalysis` and `WriterInput.referenceIndex` when present.

Verified existing Writer boundary output after local edits:

- tests: 11
- pass: 11
- fail: 0
- duration: 96.0013 ms

Dedicated no-network regression:

`C:\Users\kulba\Desktop\vantage-platform\services\worker\src\narrative-v2\site-footprint-propagation.test.js`

Verified output:

- tests: 1
- pass: 1
- fail: 0
- duration: 130.3129 ms
- `git --no-pager diff --check`: clean

Expected outcome:

PRYSM can truthfully distinguish discovered site size from assessed representative coverage, preventing a representative sample from being described as an exhaustive whole-site assessment.

---

## Defect 5 — Business-impact wording exceeded what evidence proved

Status: **CLOSED LOCALLY**

Observed defect:

The historical canonical finding `VAN-PERF-001` contained measured mobile LCP evidence of approximately `6962 ms`, but its `businessImpact` asserted `Slow first impressions increase mobile abandonment`. The evidence proved a slow measured LCP in the recorded lab test; it did not measure visitor abandonment or prove causation.

Root cause:

Canonical finding and rendering-diagnostic construction accepted business-impact prose without a shared certainty constraint. Downstream Writer/report pass-through then reused those claims.

Repair:

A shared deterministic bounded business-impact policy was added:

- `services/worker/src/scoring/business-impact-policy.js`
- `services/worker/src/scoring/business-impact-policy.test.js`

Canonical finding and rendering-diagnostic impact templates now express unsupported downstream business consequences as bounded risks/opportunities rather than established causal outcomes.

Representative requirement:

A technical, search, rendering, trust, or conversion observation may support a bounded business risk or opportunity, but cannot state lost conversions, abandonment, ranking loss, revenue loss, or other downstream outcomes as facts unless directly evidenced.

Verified output:

- tests: 92
- pass: 92
- fail: 0
- `git --no-pager diff --check`: clean

Expected outcome:

Business-impact wording now reflects the actual evidence certainty at the canonical producer boundary.

---

## Defect 6 — Judge did not independently challenge upstream overreach

Status: **CLOSED LOCALLY**

Observed defect:

The live Narrative v2 Judge prompt required evaluation against WriterInput and prohibited invented evidence/facts, but did not explicitly require the Judge to independently challenge causal claims, root-cause claims, commercial outcomes, conversion/revenue/traffic/ranking/engagement/abandonment claims, or interpretations already embedded upstream in findings/businessImpact.

Root cause:

The Judge could treat an upstream interpretation as authoritative merely because it was already present in governed input.

Repair:

`services/worker/src/narrative-v2/live-binding.js`

The Judge prompt now explicitly requires:

- independent challenge of factual, causal, and commercial claims;
- evidence must support the stated level of certainty;
- technical conditions, correlation, or missing evidence cannot prove downstream outcomes;
- unsupported overstatement must be treated as `UNSUPPORTED_FACT` plus an evidenceFidelity failure;
- inferred implications must remain bounded;
- the Judge must not trust a claim merely because it exists upstream;
- UNKNOWN / UNAVAILABLE / PARTIAL / not-deeply-parsed cannot become ABSENT / FALSE / ZERO / fully assessed.

Regression:

`services/worker/src/narrative-v2/live-binding.test.js`

The regression inspects the actual outgoing Judge request and proves the governed user prompt contains the independent-overreach requirements.

Verified output:

- tests: 10
- pass: 10
- fail: 0
- duration: approximately 287.8688 ms
- `git --no-pager diff --check`: clean

Expected outcome:

Judge evidence-fidelity review is now independent of upstream interpretation and can challenge unsupported overstatement without inventing or rescoring evidence.

---

## Defect 7 — Finding evidence silently promoted source state to AVAILABLE

Status: **CLOSED LOCALLY**

Observed defect:

`services/worker/src/scoring/score-components.js` contained finding-construction paths that could hardcode or default `sourceStatus` to `AVAILABLE`, including generic evidence mapping, performance evidence fallback, conversion-path evidence, and rendering-diagnostic evidence.

This created a risk that PARTIAL or missing governed state could be represented downstream as fully AVAILABLE.

Repair:

- generic finding evidence no longer silently defaults missing status to `AVAILABLE`;
- DataForSEO/on-page finding evidence inherits the actual site source status;
- invalid/missing evidence statuses suppress affected findings instead of inventing availability;
- slow-LCP evidence preserves actual mobile/performance source state;
- conversion-path evidence uses the governed `conversion.path` capability status;
- rendering-diagnostic findings require a valid provider status rather than defaulting to `AVAILABLE`.

Regression:

`services/worker/src/scoring/score-components.test.js`

New regression:

`INTERPRETATION-07: PARTIAL source status is preserved in finding evidence`

It proves a PARTIAL site crawl generating `VAN-TECH-001` retains:

`sourceStatus: PARTIAL`

and is not promoted to:

`sourceStatus: AVAILABLE`.

Verified output:

- tests: 27
- pass: 27
- fail: 0
- duration: approximately 186.9034 ms
- `git --no-pager diff --check`: clean

Expected outcome:

A downstream finding can no longer increase certainty merely because it was constructed successfully.

---

## Interpretation Integrity final status

Known defects: 7  
Closed locally: 7 / 7  
Open known Interpretation Integrity defects: 0

Do not create a Defect 8 merely to continue investigation. A new defect requires direct evidence from reconciliation or the final Data Utilization Audit.

Canonical source states remain:

- AVAILABLE
- PARTIAL
- FAILED
- NOT_CONNECTED
- UNAVAILABLE
- BLOCKED
- NOT_APPLICABLE

Core invariant:

A downstream layer must never increase certainty without evidence.

Examples:

- PARTIAL ≠ AVAILABLE
- UNAVAILABLE ≠ ABSENT
- FAILED ≠ ZERO
- NOT_CONNECTED ≠ ZERO
- unknown ≠ false
- not parsed ≠ absent
- not assessed ≠ passed
- request completed ≠ evidence obtained

## Local application state boundary

The Interpretation Integrity repairs are LOCAL and UNCOMMITTED/UNPUSHED unless separately approved.

At minimum, the local repair stream touched:

- `services/worker/src/scoring/score-components.js`
- `services/worker/src/scoring/score-components.test.js`
- `services/worker/src/evidence/capability-evidence.js`
- related capability/scoring regression tests
- `services/worker/src/scoring/decision-scope.js`
- `services/worker/src/scoring/vantage-score.js`
- `services/worker/src/scoring/decision-scope.test.js`
- `services/worker/src/scoring/scoring-service.js`
- `services/worker/src/narrative-v2/writer-input.js`
- `services/worker/src/narrative-v2/site-footprint-propagation.test.js`
- `services/worker/src/scoring/business-impact-policy.js`
- `services/worker/src/scoring/business-impact-policy.test.js`
- `services/worker/src/narrative-v2/live-binding.js`
- `services/worker/src/narrative-v2/live-binding.test.js`

This is not guaranteed to be the complete dirty working-tree diff. Verify the actual local state before any application commit.

## Reconciliation phase — next

Before any new repair, retrieve Brad / Omni-BG's Evidence Integrity report/state from:

`chriskulbaba2025/betty-prysm-audit`

Produce one evidence-backed reconciliation table:

`ISSUE → STREAM THAT FOUND IT → PIPELINE STAGE → VERIFIED EVIDENCE → CURRENT STATUS → OVERLAP/CONFLICT → ACTION REQUIRED`

Do not repair suspicious code merely because it exists. A repair requires:

`observable defect → executing path → direct evidence → bounded root cause → smallest repair → deterministic regression`

## Final Data Utilization Audit — planned next

After reconciliation, trace each important evidence family through:

`COLLECTED → NORMALIZED → CANONICAL → SCORED → WRITER-VISIBLE → JUDGE-VISIBLE → REPORT-USED`

For each transition answer:

1. What field/value enters?
2. What transformation occurs?
3. What source status accompanies it?
4. Can certainty increase here?
5. Is anything dropped?
6. Is anything defaulted?
7. Is anything converted from unknown to false/zero/absent?
8. Is the field score-bearing?
9. Is the field Writer-visible?
10. Is the field Judge-visible?
11. Does the final report actually use it?
12. If it is not used, is that intentional and documented?

Classify each material evidence family as:

- FULLY UTILIZED
- PARTIALLY UTILIZED
- COLLECTED BUT UNUSED
- TRANSFORMED INCORRECTLY
- STATUS DEGRADED
- STATUS IMPROPERLY UPGRADED
- NOT WRITER-VISIBLE
- NOT JUDGE-VISIBLE
- NOT REPORT-USED
- INTENTIONALLY EXCLUDED

This audit answers the product-level question:

**Are we fully using the valuable evidence PRYSM already collects, and can every report conclusion be traced back to evidence that actually supports it?**

## Product boundary / tool-size risk

Do not expand PRYSM into a feature-for-feature replacement for every SEO, CRO, accessibility, analytics, crawler, and competitive-intelligence platform.

The preferred product role is a governed website decision system:

`COLLECT → GOVERN → RECONCILE → PRIORITIZE → INTERPRET → RECOMMEND`

Specialist providers may collect signals. PRYSM's differentiator is defensible synthesis, explicit uncertainty, representative coverage, prioritization, and actionable business interpretation.

## Exact next action

1. Start the next session by reading the authoritative project-context files.
2. Verify local application state with read-only commands only: `git rev-parse HEAD`, `git status --short`, `git --no-pager diff --stat`.
3. Do not clean, reset, commit, push, deploy, or mutate the local application state.
4. Retrieve Brad's Evidence Integrity findings from `chriskulbaba2025/betty-prysm-audit`.
5. Produce the reconciliation table before proposing any additional application repair.
6. After reconciliation, begin the final Data Utilization Audit.
