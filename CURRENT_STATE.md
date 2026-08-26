# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Complete the coordinated PRYSM audit-integrity program and prove whether missing or weak report conclusions are caused by collection, evidence preservation, downstream non-use, or interpretation error.

Two coordinated workstreams are active:
1. Evidence Integrity — Brad, using the private sandbox `chriskulbaba2025/betty-prysm-audit`.
2. Interpretation Integrity — Chris + primary assistant, using the local `vantage-platform` working copy and authoritative context repository.

The final product-level requirement is not merely to collect more data. PRYSM must preserve useful evidence, use it where materially relevant, and never state a conclusion more strongly than the evidence supports.

Verified checkpoint:
- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Evidence-review sandbox: `chriskulbaba2025/betty-prysm-audit` — PRIVATE.
- Brad GitHub account: `Omni-BG`.
- Governed application branch: `main`.
- Verified local application HEAD: `46d92a346763a8e3ab252d1c32fe79632e7110a4` — `test(onpage): align representative crawl ceiling`.
- Current governed acquisition contract remains: broad discovered footprint separate from assessed sample; deterministic must-have/representative priority plan; maximum 20 DataForSEO priority URLs; hard 250-page provider crawl ceiling; DataForSEO On-Page adapter v1.4.0.
- Viewer remains v2.2.0 / 16 governed pages.
- Scoring production version remains v4.1.1.
- Historical audit used for the integrity investigation: `97d6b2c7-03b9-4530-8ea7-16557502c638` for `https://rebootbusinesscoaching.com/`.
- Controlled production Narrative v2 audit `5d22dcef-7d98-422f-8415-933e7b02003e` remains `draft_rendered`; no fourth Writer/Judge pass is permitted.
- Detailed Interpretation Integrity ledger: `REFERENCE/INTERPRETATION_INTEGRITY_97d6b2c7.md`.
- Detailed acquisition/data investigation ledger remains: `REFERENCE/AUDIT_DATA_VALIDATION_97d6b2c7.md`.

Workstream authority split — explicit:
- Chris / Interpretation Integrity: user authorization is ACTIVE for local application-code edits required by proven, bounded Interpretation Integrity repairs, using the governed manual VS Code workflow and existing approval boundaries for push/deploy/paid/production actions.
- Brad / Evidence Integrity: READ-ONLY forensic authority only. Brad is NOT authorized by this workstream to edit production PRYSM application code, push, deploy, rerun audits, rescore, invoke providers/models, or mutate production artifacts.
- Do not conflate Brad's read-only investigation boundary with Chris's authorized local repair boundary.

Evidence Integrity workstream — Brad:
- Brad continues the independent forensic review in `chriskulbaba2025/betty-prysm-audit`.
- His boundary is RAW → NORMALIZED → CANONICAL → CAPABILITY/DECISION → SCORES/FINDINGS.
- He is determining whether useful evidence was PRESERVED, DROPPED, CHANGED, OVERWRITTEN, MISCLASSIFIED, INSUFFICIENT, or UNKNOWN.
- Brad's review remains read-only with respect to production PRYSM unless separately authorized.
- No Brad findings have yet been reconciled into this current state; do not invent or infer his conclusions.

Interpretation Integrity workstream — Chris + primary assistant:
- User explicitly authorized proven, bounded Interpretation Integrity repairs to proceed locally while Brad completes his Evidence Integrity review.
- Final integrity sign-off still requires reconciliation of both workstreams.
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
   - Repair: new decision-scoped site projection used for commercial scoring/report interpretation while canonical evidence remains unchanged.
   - Verified targeted result: 4/4 PASS, 0 fail, 96.3603 ms.

4. Representative-site coverage (`siteFootprint`) was preserved in DecisionEvidence but did not reach Writer/Judge.
   - Status: CLOSED LOCALLY.
   - Repair: ScoreSet carries governed `siteFootprint`; WriterInput admits it into `deterministicAnalysis` and `referenceIndex`; Judge receives the same governed WriterInput.
   - Existing WriterInput/reference-index result: 11/11 PASS, 0 fail, 96.0013 ms.
   - Dedicated no-network propagation regression: 1/1 PASS, 0 fail, 130.3129 ms.
   - Dedicated proof covers ScoreSet → WriterInput.deterministicAnalysis → `analysis:siteFootprint` reference indexing.
   - `git --no-pager diff --check`: clean after the dedicated regression was added.

5. Some business-impact wording can exceed what the underlying evidence proves.
   - Status: DIAGNOSED — repair not yet applied.
   - Verified root cause: canonical finding construction accepts `businessImpact` prose verbatim with no evidence-certainty constraint. Historical audit evidence measured mobile LCP at about 6962 ms while the canonical finding asserted `Slow first impressions increase mobile abandonment`; Narrative v2 then reused that causal claim.
   - Repair boundary: constrain business-impact language at canonical finding/diagnostic construction, not in Writer/report pass-through. Judge independence remains Defect 6.

6. Judge may be unable to independently challenge overreach already embedded in canonical findings/deterministic interpretation.
   - Status: REMAINING.

7. Some finding evidence paths can hardcode `sourceStatus: AVAILABLE` rather than preserve the actual governed source state.
   - Status: REMAINING.

Local Interpretation Integrity application files touched during the current manual work package include:
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

No application commit/push/deploy was performed as part of the current Interpretation Integrity session. The local working tree was verified against HEAD `46d92a346763a8e3ab252d1c32fe79632e7110a4` before the Defect 4 regression was added.

Offline replay harness:
- Local `scripts/replay-report.js` and fixture `test-fixtures/report-replay/audit-97d6b2c7` were previously verified 1/1 PASS in no-network mode.
- Do not rerun this harness merely for reassurance. Reopen only if a later defect directly implicates deterministic replay/rendering.

Final Data Utilization Audit — planned:
After Brad's Evidence Integrity findings and Chris's Interpretation Integrity repairs are available, trace each important signal through:

COLLECTED → NORMALIZED → CANONICAL → SCORED → WRITER-VISIBLE → JUDGE-VISIBLE → REPORT-USED

Classify each gap as:
1. not collected;
2. collected but lost/changed before canonical evidence;
3. canonical but not used in scoring;
4. canonical/scored but not visible to Writer/Judge;
5. visible but not used in report;
6. used incorrectly or with excessive certainty;
7. correctly used.

Current product boundary / tool-size position:
- Do not expand PRYSM into a feature-for-feature replacement for every SEO, CRO, accessibility, analytics, crawler, and competitive-intelligence platform.
- Preferred role: governed website decision system — COLLECT → GOVERN → RECONCILE → PRIORITIZE → INTERPRET → RECOMMEND.
- New capabilities should be added only when they materially improve business diagnosis or decision quality.

Current environment / branch / version:
- Governed manual VS Code workflow on Desktop application repository.
- Application path: `C:\Users\kulba\Desktop\vantage-platform`.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Branch: `main`.
- Verified local application HEAD: `46d92a346763a8e3ab252d1c32fe79632e7110a4`.
- On-Page adapter: v1.4.0.
- Governed provider crawl ceiling: 250 pages.
- Governed provider priority URL cap: 20.
- Viewer: v2.2.0 / 16 governed pages.
- Production scoring version: v4.1.1.

Completed:
- Representative Crawl Enforcement implementation is complete, pushed, and remotely green.
- Private Evidence Integrity sandbox is active for Brad.
- Interpretation Integrity defects 1, 2, 3, and 4 are closed locally with targeted regressions green.
- Defect 4 has dedicated no-network propagation proof 1/1 PASS.
- Durable Interpretation Integrity ledger exists in the authoritative context repository.
- Workstream code-edit authority is explicitly separated: Chris may perform governed local Interpretation Integrity repairs; Brad remains read-only.

In progress:
- Implement the bounded Defect 5 business-impact repair at the canonical finding/diagnostic construction boundary.
- Diagnose and repair defects 6 and 7 one at a time after Defect 5 is verified.
- Brad continues independent read-only Evidence Integrity forensic review.
- Reconcile both streams before final integrity sign-off.
- Run the final Data Utilization Audit after both tracks are ready.

Blocked:
- No known technical blocker.
- Brad's final Evidence Integrity findings are not yet available for reconciliation.

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
- Chris is authorized to edit local application code for proven, bounded Interpretation Integrity repairs. This does not itself authorize push, deploy, paid provider calls, production audit reruns, persisted production rescoring, Writer/Judge calls, or production-artifact mutation.
- Brad's Evidence Integrity workstream is read-only. Brad must not edit production PRYSM code or mutate production behavior under this workstream.
- Do not broaden Interpretation Integrity repairs into unrelated acquisition, lifecycle, storage, authentication, n8n, Viewer redesign, or general architecture work.

Exact next action:
Implement Defect 5 through the governed manual workflow. First create and verify the bounded business-impact policy unit, then apply it to canonical findings in `services/worker/src/scoring/score-components.js`, then to rendering diagnostic impact templates in `services/worker/src/scoring/diagnostic-contracts.js`, with targeted regressions proving unsupported causal/commercial outcomes cannot be emitted as established facts. Do not modify Writer/report pass-through or Judge code as part of Defect 5.

Last verified:
2026-08-26 America/Toronto
