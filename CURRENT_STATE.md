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
- Last verified remote application baseline before the current local Interpretation Integrity repair package: `46d92a346763a8e3ab252d1c32fe79632e7110a4` — `test(onpage): align representative crawl ceiling`.
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
   - Status: IMPLEMENTED LOCALLY; dedicated defect-specific regression proof still required before closure.
   - Local repair: ScoreSet now carries governed `siteFootprint`; WriterInput admits it into `deterministicAnalysis` and `referenceIndex`; Judge already receives the same governed WriterInput.
   - Existing WriterInput/reference-index tests after the local edit: 11/11 PASS, 0 fail, 96.0013 ms.

5. Some business-impact wording can exceed what the underlying evidence proves.
   - Status: REMAINING.

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

No application commit/push/deploy was performed as part of the current Interpretation Integrity session. Exact local working-tree state must be reverified before further editing or any application commit.

Offline replay harness:
- Local `scripts/replay-report.js` and fixture `test-fixtures/report-replay/audit-97d6b2c7` were previously verified 1/1 PASS in no-network mode.
- Do not rerun the replay harness merely for reassurance. Reopen only if a later defect directly implicates deterministic replay/rendering.

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
- Last verified remote application baseline before the current local repair package: `46d92a346763a8e3ab252d1c32fe79632e7110a4`.
- On-Page adapter: v1.4.0.
- Governed provider crawl ceiling: 250 pages.
- Governed provider priority URL cap: 20.
- Viewer: v2.2.0 / 16 governed pages.
- Production scoring version: v4.1.1.

Completed:
- Representative Crawl Enforcement implementation is complete, pushed, and remotely green.
- Private Evidence Integrity sandbox is active for Brad.
- Interpretation Integrity defects 1, 2, and 3 are closed locally with targeted regressions green.
- Interpretation Integrity defect 4 production-path edits are applied locally and existing Writer boundary tests are green.
- Durable Interpretation Integrity ledger has been added to the authoritative context repository.
- Workstream code-edit authority is explicitly separated: Chris may perform governed local Interpretation Integrity repairs; Brad remains read-only.

In progress:
- Close defect 4 with one dedicated no-network regression proving `siteFootprint` survives canonical scoring projection into WriterInput/referenceIndex.
- Diagnose and repair defects 5, 6, and 7 one at a time.
- Brad continues independent read-only Evidence Integrity forensic review.
- Reconcile both streams before final integrity sign-off.
- Run the final Data Utilization Audit after both tracks are ready.

Blocked:
- No known technical blocker.
- Defect 4 is not yet closed because its specific end-to-end propagation regression has not yet been run.
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
Start the next chat by reading the governing context files and `REFERENCE/INTERPRETATION_INTEGRITY_97d6b2c7.md`. Then, in `C:\Users\kulba\Desktop\vantage-platform\services\worker`, verify the local application state with `git rev-parse HEAD` and `git status --short`. After that, close Interpretation Integrity defect 4 with one dedicated no-network regression proving `siteFootprint` survives ScoreSet → WriterInput.deterministicAnalysis → `analysis:siteFootprint` reference indexing. If green, mark defect 4 closed and proceed immediately to defect 5 diagnosis. Do not rerun defects 1–3 or the offline replay harness unless new evidence directly implicates them.

Last verified:
2026-08-26 America/Toronto
