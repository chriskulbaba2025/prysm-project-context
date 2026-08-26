# PRYSM Interpretation Integrity Ledger

Audit ID: `97d6b2c7-03b9-4530-8ea7-16557502c638`  
Target: `https://rebootbusinesscoaching.com/`  
Opened: 2026-08-26  
Status: Active — defects 1–4 closed locally; defect 5 diagnosed and ready for bounded repair; defects 6–7 remain

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

The two workstreams must be reconciled before final integrity sign-off, but explicit user authorization permits proven, bounded Interpretation Integrity repairs to proceed locally while Brad completes his forensic review.

## Verified application baseline

Application repository: `chriskulbaba2025/vantage-platform`  
Governed branch: `main`  
Verified local application HEAD for this repair package: `46d92a346763a8e3ab252d1c32fe79632e7110a4` — `test(onpage): align representative crawl ceiling`

No application push, deployment, paid provider call, production audit rerun, Writer/Judge rerun, rescoring of persisted production artifacts, or production-artifact mutation was performed during this Interpretation Integrity repair session.

Local manual edits exist in the user's Desktop working copy and must be verified with `git status --short` before any application commit.

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

The historical finding `VAN-TECH-004` could state an impossible result such as `3 of 0 images`. Canonical decision evidence showed image counters were not actually available (`_metaCountersAvailable: false`), yet the finding builder treated a non-zero `imagesMissingAlt` value as confirmed evidence and hardcoded `sourceStatus: AVAILABLE`.

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

Decision scope excludes clearly non-commercial utility/infrastructure/legal/error URL patterns from page-quality site conclusions, while leaving canonical evidence intact.

The scoped site is used for commercial scoring and downstream deterministic interpretation including:

- module scoring;
- funnel scoring;
- findings;
- rendering diagnostics;
- conversion paths;
- readiness map inputs;
- topic/content ideas.

Capability evidence and raw evidence confidence continue to use canonical evidence.

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

No Writer prompt change is required because the governed prompt serializes the complete WriterInput. No Judge orchestration change is required because the Judge already receives the identical governed WriterInput object.

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

The dedicated regression proves:

`ScoreSet.siteFootprint → WriterInput.deterministicAnalysis.siteFootprint → referenceIndex analysis:siteFootprint`

Expected outcome:

PRYSM can truthfully distinguish discovered site size from assessed representative coverage, preventing a representative sample from being described as an exhaustive whole-site assessment.

---

## Defect 5 — Business-impact wording can exceed what evidence proves

Status: **DIAGNOSED — BOUNDED REPAIR READY; NOT YET APPLIED**

Observed defect:

The historical canonical finding `VAN-PERF-001` contained:

- observed evidence: mobile LCP approximately `6962 ms` from PageSpeed lab evidence;
- canonical `businessImpact`: `Slow first impressions increase mobile abandonment`.

The evidence proves a slow measured LCP in the recorded lab test. It does not measure visitor abandonment or establish that the observed LCP caused abandonment. Narrative v2 reused the canonical causal statement in client-facing prose.

Verified root cause:

`services/worker/src/scoring/score-components.js` builds canonical findings and copies `opts.businessImpact` directly into both `businessImpact` and the display alias `impact` without an evidence-certainty constraint. Several deterministic finding templates therefore encode a business consequence more strongly than the evidence establishes.

`services/worker/src/narrative-v2/writer-findings.js` deliberately preserves canonical `businessImpact` unchanged, and `services/worker/src/report-content/build-package.js` likewise copies it rather than reinterpreting it. Those pass-through boundaries are not the origin of the defect.

Rendering-integrity diagnostics are a second producer feeding the same canonical concept. `services/worker/src/scoring/diagnostic-contracts.js` contains client-facing `impact` templates, and `buildRenderingDiagnosticFindings()` in `score-components.js` carries diagnostic `businessImpact` into findings. The Defect 5 repair must therefore cover both canonical impact producers.

Repair boundary:

- introduce one shared deterministic bounded-business-impact policy at scoring/diagnostic construction;
- require business-impact prose to be framed as a potential risk/opportunity rather than an observed causal/commercial outcome unless the underlying evidence itself directly proves that outcome;
- revise existing finding and rendering-diagnostic impact templates that violate the policy;
- test the shared policy directly and test representative canonical finding/diagnostic outputs;
- leave Writer/report pass-through unchanged;
- leave Judge changes for Defect 6.

Expected application file set:

- new `services/worker/src/scoring/business-impact-policy.js`;
- new `services/worker/src/scoring/business-impact-policy.test.js`;
- `services/worker/src/scoring/score-components.js`;
- `services/worker/src/scoring/score-components.test.js`;
- `services/worker/src/scoring/diagnostic-contracts.js`;
- `services/worker/src/scoring/rendering-diagnostics.test.js`.

Expected outcome:

A technical, search, rendering, trust, or conversion observation may support a bounded business risk or opportunity, but the canonical finding layer cannot present lost conversions, abandonment, ranking loss, revenue loss, or other downstream outcomes as established facts unless directly evidenced.

---

## Defect 6 — Judge may not independently challenge overreach embedded in canonical findings

Status: **REMAINING**

Risk:

The Judge validates Writer output against the governed WriterInput. If an overstatement is already embedded in a canonical finding or deterministic analysis field, the Judge may treat that upstream interpretation as authoritative rather than testing whether the narrative conclusion exceeds the underlying evidence.

Required repair objective:

Prove the exact Judge evidence-fidelity boundary and determine the smallest way to let the Judge challenge unsupported interpretation without allowing it to invent or rescore facts.

Do not weaken the existing Narrative v2 quality gate.

---

## Defect 7 — Finding evidence can hardcode `sourceStatus: AVAILABLE`

Status: **REMAINING**

Risk:

Some finding evidence records can declare `sourceStatus: AVAILABLE` instead of deriving the actual governed source/capability status. This can overstate certainty and create inconsistent limitations/provenance.

Required repair objective:

Find every hardcoded source-status path relevant to governed findings and derive status from the actual canonical source/capability state. Unknown/partial/unavailable must remain distinct.

---

## Final Data Utilization Audit — planned

After Brad's Evidence Integrity findings and Chris's Interpretation Integrity repairs are available, run one coordinated utilization audit across the important evidence fields.

For each important field/signal, trace:

`COLLECTED → NORMALIZED → CANONICAL → SCORED → WRITER-VISIBLE → JUDGE-VISIBLE → REPORT-USED`

Classify every gap as one of:

1. not collected;
2. collected but lost/changed before canonical evidence;
3. canonical but not used in scoring;
4. canonical/scored but not visible to Writer/Judge;
5. visible but not used in report;
6. used incorrectly or with excessive certainty;
7. correctly used.

This audit is intended to answer the product-level question: **Are we fully using the valuable evidence PRYSM already collects, and can every report conclusion be traced back to evidence that actually supports it?**

## Product boundary / tool-size risk

Current direction: do not expand PRYSM into a feature-for-feature replacement for every SEO, CRO, accessibility, analytics, crawler, and competitive-intelligence platform.

The preferred product role is a governed website decision system:

`COLLECT → GOVERN → RECONCILE → PRIORITIZE → INTERPRET → RECOMMEND`

Specialist providers may collect signals. PRYSM's differentiator is defensible synthesis, explicit uncertainty, representative coverage, prioritization, and actionable business interpretation.

Do not add a new capability merely because more data is technically collectible. A capability should materially improve business diagnosis or decision quality.

## Exact next action

1. Implement the shared bounded-business-impact policy as a new no-network scoring unit and verify it independently.
2. Apply the policy to the current local `score-components.js` canonical finding paths and update targeted scoring regressions.
3. Apply the same policy to `diagnostic-contracts.js` rendering-impact templates and update rendering diagnostics regressions.
4. When Defect 5 is green, mark it closed and diagnose Defect 6 from the exact Judge evidence-fidelity boundary.
5. Brad's Evidence Integrity stream remains read-only and must not be modified by this workstream.
