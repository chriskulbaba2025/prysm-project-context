# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Reconcile the completed local Interpretation Integrity repair stream with Brad's independent Evidence Integrity findings, then run the final end-to-end Data Utilization Audit to prove that valuable evidence is preserved, correctly scoped, correctly interpreted, visible to Writer/Judge where intended, and actually used in the final report.

Two coordinated workstreams:
1. Evidence Integrity — Brad, using the private sandbox `chriskulbaba2025/betty-prysm-audit`.
2. Interpretation Integrity — Chris + primary assistant, using the local `vantage-platform` working copy and authoritative context repository.

The final product-level requirement is not merely to collect more data. PRYSM must preserve useful evidence, use it where materially relevant, and never state a conclusion more strongly than the evidence supports.

Verified checkpoint:
- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Evidence-review sandbox: `chriskulbaba2025/betty-prysm-audit` — PRIVATE.
- Brad GitHub account: `Omni-BG`.
- Governed application branch: `main`.
- Verified GitHub/local application baseline before the current local Interpretation Integrity repairs: `46d92a346763a8e3ab252d1c32fe79632e7110a4` — `test(onpage): align representative crawl ceiling`.
- Current governed acquisition contract remains: broad discovered footprint separate from assessed sample; deterministic must-have/representative priority plan; maximum 20 DataForSEO priority URLs; hard 250-page provider crawl ceiling; DataForSEO On-Page adapter v1.4.0.
- Viewer remains v2.2.0 / 16 governed pages.
- Scoring production version remains v4.1.1.
- Historical audit used for the integrity investigation: `97d6b2c7-03b9-4530-8ea7-16557502c638` for `https://rebootbusinesscoaching.com/`.
- Controlled production Narrative v2 audit `5d22dcef-7d98-422f-8415-933e7b02003e` remains `draft_rendered`; no fourth Writer/Judge pass is permitted.
- Detailed Interpretation Integrity ledger: `REFERENCE/INTERPRETATION_INTEGRITY_97d6b2c7.md`.
- Detailed acquisition/data investigation ledger: `REFERENCE/AUDIT_DATA_VALIDATION_97d6b2c7.md`.

Workstream authority split — explicit:
- Chris / Interpretation Integrity: user authorization was ACTIVE for local application-code edits required by proven, bounded Interpretation Integrity repairs, using the governed manual VS Code workflow and existing approval boundaries for push/deploy/paid/production actions.
- Brad / Evidence Integrity: READ-ONLY forensic authority only. Brad is NOT authorized by this workstream to edit production PRYSM application code, push, deploy, rerun audits, rescore, invoke providers/models, or mutate production artifacts.
- Do not conflate Brad's read-only investigation boundary with Chris's authorized local repair boundary.

Evidence Integrity workstream — Brad:
- Brad continues the independent forensic review in `chriskulbaba2025/betty-prysm-audit`.
- His boundary is RAW → NORMALIZED → CANONICAL → CAPABILITY/DECISION → SCORES/FINDINGS.
- He is determining whether useful evidence was PRESERVED, DROPPED, CHANGED, OVERWRITTEN, MISCLASSIFIED, INSUFFICIENT, or UNKNOWN.
- Brad's review remains read-only with respect to production PRYSM unless separately authorized.
- Brad's final findings must be reconciled with Chris's completed Interpretation Integrity stream before product-level integrity sign-off.

Interpretation Integrity workstream — Chris + primary assistant:
- Status: COMPLETE LOCALLY — 7/7 known Interpretation Integrity defects closed with deterministic local verification.
- No known Interpretation Integrity defect remains open.
- Do not invent a Defect 8 merely to continue testing. A new defect requires direct evidence from reconciliation or the final utilization trace.
- Core semantic rule: UNKNOWN / UNAVAILABLE / NOT DEEPLY PARSED / PARTIAL must never become ABSENT / FALSE / ZERO / FULLY ASSESSED.
- Important commercial/conversion pages must drive site-level narrative and scoring; utility/infrastructure pages may remain in canonical evidence but must not distort commercial conclusions.

Interpretation defect status:

1. Unknown image evidence could create `VAN-TECH-004`, including impossible wording such as `3 of 0 images`.
   - Status: CLOSED LOCALLY.
   - Repair: require known image evidence before emitting the finding.
   - Verified targeted result: 25/25 PASS, 0 fail.

2. Completed content-parsing requests could be treated as usable body-content evidence even when returned content fields were empty/null.
   - Status: CLOSED LOCALLY.
   - Repair: capability status now depends on actual usable `text`, numeric `wordCount`, or numeric `mainContentChars`, not request completion alone.
   - Verified targeted result: 46/46 PASS, 0 fail.

3. Utility/infrastructure/legal pages could distort commercial page counts, content averages, metadata findings, heading findings, and downstream interpretation.
   - Status: CLOSED LOCALLY.
   - Repair: decision-scoped site projection is used for commercial scoring/report interpretation while canonical evidence remains unchanged.
   - Verified targeted result: 4/4 PASS, 0 fail, 96.3603 ms.

4. Representative-site coverage (`siteFootprint`) was preserved in DecisionEvidence but did not reach Writer/Judge.
   - Status: CLOSED LOCALLY.
   - Repair: ScoreSet carries governed `siteFootprint`; WriterInput admits it into `deterministicAnalysis` and `referenceIndex`; Judge receives the same governed WriterInput.
   - Existing WriterInput/reference-index result: 11/11 PASS, 0 fail, 96.0013 ms.
   - Dedicated no-network propagation regression: 1/1 PASS, 0 fail, 130.3129 ms.
   - `git --no-pager diff --check`: clean after the dedicated regression.

5. Business-impact wording could exceed what the underlying evidence proves.
   - Status: CLOSED LOCALLY.
   - Repair: shared deterministic bounded business-impact policy added at canonical finding/rendering-diagnostic construction.
   - New shared policy files: `services/worker/src/scoring/business-impact-policy.js` and `services/worker/src/scoring/business-impact-policy.test.js`.
   - Canonical findings and rendering diagnostics now enforce bounded commercial/business-impact wording.
   - Verified result: 92/92 PASS, 0 fail; `git --no-pager diff --check` clean.

6. Judge could fail to independently challenge unsupported causal/commercial interpretation already embedded upstream.
   - Status: CLOSED LOCALLY.
   - Root cause: the live Judge prompt did not explicitly require independent challenge of causal claims, root-cause claims, commercial outcomes, conversion/revenue/traffic/ranking/engagement/abandonment claims, or upstream interpretations already embedded in findings/businessImpact.
   - Repair: `services/worker/src/narrative-v2/live-binding.js` now requires independent factual/causal/commercial challenge; evidence must support the stated certainty; technical conditions/correlation/missing evidence cannot prove downstream outcomes; unsupported overstatement maps to `UNSUPPORTED_FACT` + evidenceFidelity failure; inferred implications must remain bounded; upstream presence does not make a claim authoritative; UNKNOWN/UNAVAILABLE/PARTIAL/not-deeply-parsed cannot become ABSENT/FALSE/ZERO/fully assessed.
   - Regression: `services/worker/src/narrative-v2/live-binding.test.js` inspects the actual outgoing Judge request and proves the governed prompt contains the independent-overreach requirements.
   - Verified result: 10/10 PASS, 0 fail, approximately 287.8688 ms; `git --no-pager diff --check` clean.

7. Finding evidence could silently hardcode/default `sourceStatus` to `AVAILABLE` rather than preserve governed source state.
   - Status: CLOSED LOCALLY.
   - Repair: `services/worker/src/scoring/score-components.js` no longer silently promotes missing/partial evidence to AVAILABLE in finding construction; DataForSEO/on-page evidence inherits actual site source status; invalid/missing statuses suppress affected findings rather than invent availability; LCP evidence preserves actual mobile/performance source state; conversion-path evidence uses the governed capability status; rendering diagnostics require a valid provider status.
   - Regression: `INTERPRETATION-07: PARTIAL source status is preserved in finding evidence` in `services/worker/src/scoring/score-components.test.js`.
   - Verified result: 27/27 PASS, 0 fail, approximately 186.9034 ms; `git --no-pager diff --check` clean.

Local Interpretation Integrity application files touched during the repair stream include at minimum:
- `services/worker/src/scoring/score-components.js`
- `services/worker/src/scoring/score-components.test.js`
- `services/worker/src/evidence/capability-evidence.js`
- related capability/scoring regression tests
- new `services/worker/src/scoring/decision-scope.js`
- `services/worker/src/scoring/vantage-score.js`
- new `services/worker/src/scoring/decision-scope.test.js`
- `services/worker/src/scoring/scoring-service.js`
- `services/worker/src/narrative-v2/writer-input.js`
- new `services/worker/src/narrative-v2/site-footprint-propagation.test.js`
- new `services/worker/src/scoring/business-impact-policy.js`
- new `services/worker/src/scoring/business-impact-policy.test.js`
- `services/worker/src/narrative-v2/live-binding.js`
- `services/worker/src/narrative-v2/live-binding.test.js`

This list is not guaranteed to be the complete dirty working-tree diff. Before any application commit or reconciliation edit, inspect the actual local state with `git status --short` and `git --no-pager diff --stat`.

No application commit/push/deploy was performed as part of the completed Interpretation Integrity repair stream. Local application repairs remain uncommitted/unpushed until explicitly approved.

Offline replay harness:
- Local `scripts/replay-report.js` and fixture `test-fixtures/report-replay/audit-97d6b2c7` were previously verified 1/1 PASS in no-network mode.
- Do not rerun this harness merely for reassurance. Reopen only if a later defect directly implicates deterministic replay/rendering.

Next coordinated phase — reconciliation:
Before any new repair, reconcile Brad's Evidence Integrity findings with Chris's completed Interpretation Integrity findings.

Required reconciliation table:
ISSUE → STREAM THAT FOUND IT → PIPELINE STAGE → VERIFIED EVIDENCE → CURRENT STATUS → OVERLAP/CONFLICT → ACTION REQUIRED

Do not begin a repair merely because code looks suspicious. A repair requires:
observable defect → executing path → direct evidence → bounded root cause → smallest repair → deterministic regression.

Final Data Utilization Audit — next after reconciliation:
Trace each important evidence family through:

COLLECTED → NORMALIZED → CANONICAL → SCORED → WRITER-VISIBLE → JUDGE-VISIBLE → REPORT-USED

For each transition determine:
1. what field/value enters;
2. what transformation occurs;
3. what source status accompanies it;
4. whether certainty can increase;
5. whether anything is dropped;
6. whether anything is defaulted;
7. whether unknown becomes false/zero/absent;
8. whether the field is score-bearing;
9. whether it is Writer-visible;
10. whether it is Judge-visible;
11. whether the final report actually uses it;
12. if unused, whether exclusion is intentional and documented.

Classify material evidence families as:
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

Current product boundary / tool-size position:
- Do not expand PRYSM into a feature-for-feature replacement for every SEO, CRO, accessibility, analytics, crawler, and competitive-intelligence platform.
- Preferred role: governed website decision system — COLLECT → GOVERN → RECONCILE → PRIORITIZE → INTERPRET → RECOMMEND.
- New capabilities should be added only when they materially improve business diagnosis or decision quality.

Current environment / branch / version:
- Governed manual VS Code workflow on Desktop application repository.
- Application path: `C:\Users\kulba\Desktop\vantage-platform`.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Branch: `main`.
- Verified baseline before local repairs: `46d92a346763a8e3ab252d1c32fe79632e7110a4`.
- On-Page adapter: v1.4.0.
- Governed provider crawl ceiling: 250 pages.
- Governed provider priority URL cap: 20.
- Viewer: v2.2.0 / 16 governed pages.
- Production scoring version: v4.1.1.

Completed:
- Representative Crawl Enforcement implementation is complete, pushed, and remotely green.
- Private Evidence Integrity sandbox is active for Brad.
- Interpretation Integrity defects 1–7 are closed locally with deterministic regressions green.
- Durable Interpretation Integrity ledger exists in the authoritative context repository.
- Workstream code-edit authority remains explicitly separated: Chris may perform governed local repairs when directly proven; Brad remains read-only.

In progress:
- Brad completes/submits Evidence Integrity findings.
- Reconcile Brad's Evidence Integrity stream with Chris's completed Interpretation Integrity stream.
- Run the final Data Utilization Audit after reconciliation.

Blocked:
- No known technical blocker.
- Final coordinated integrity sign-off waits on Brad's Evidence Integrity findings/reconciliation.

Important constraints:
- GitHub context is authoritative durable memory.
- `WORKFLOW_INSTRUCTIONS.md`, `REPAIR_BOUNDARY_PROTOCOL.md`, and `DIAGNOSTIC_EVIDENCE_PROTOCOL.md` remain mandatory.
- Never guess a root cause. Verify direct artifact/code/test evidence first.
- Same observable failure remains capped at three unsuccessful repair attempts before a deeper diagnostic reset.
- Do not ask the user to scroll back for prior code/instructions; restate required code in the current response.
- For manual edits, give the full local Windows path first and provide the complete final file once whenever practical; do not knowingly make the user paste a file and then immediately repatch it for already-knowable changes.
- Preserve discovered-footprint evidence separately from assessed-page evidence.
- Never imply a representative sample is exhaustive coverage of a larger site.
- Unknown/partial/unavailable evidence must not become negative evidence.
- Chris may edit local application code only for proven, bounded repairs. This does not itself authorize push, deploy, paid provider calls, production audit reruns, persisted production rescoring, Writer/Judge calls, or production-artifact mutation.
- Brad's Evidence Integrity workstream is read-only. Brad must not edit production PRYSM code or mutate production behavior under this workstream.
- Do not broaden the final integrity work into unrelated acquisition, lifecycle, storage, authentication, n8n, Viewer redesign, or general architecture work.

Exact next action:
1. In a fresh chat, read the authoritative project-context files.
2. Verify local application HEAD and dirty working tree with read-only commands only: `git rev-parse HEAD`, `git status --short`, `git --no-pager diff --stat`.
3. Do not alter or clean the working tree.
4. Retrieve Brad / Omni-BG's Evidence Integrity report/state from `chriskulbaba2025/betty-prysm-audit`.
5. Produce the evidence-backed reconciliation table before proposing any new repair.
6. After reconciliation, begin the final Data Utilization Audit.

Last verified:
2026-08-26 America/Toronto
