# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

Current objective:
Implement the Conversion-First v4.2 CF-01 report-process repair against the frozen TBK production audit. The evidence/scoring baseline is valid; the current defect is client-facing interpretation, priority hierarchy, and cross-consumer consistency. The immediate goal is to stop technical-hygiene findings such as missing meta descriptions from automatically becoming the primary executive problem when stronger buyer/conversion evidence exists.

Verified checkpoint:
- Application repository: `chriskulbaba2025/vantage-platform`.
- Branch: `main`.
- Latest remote application commit: `90916e94f6feba73e7e60df54bd641bb2362454c` — `test(prysm): repair CI regression baselines`.
- GitHub Actions run `33171616359`, job `98849897567` (`verify`): COMPLETED / SUCCESS. All configured CI steps passed.
- CI regression 1 closed: `dataforseo-onpage-representative-evidence.test.js` now pins `contentParsingPageLimit: 20` inside the bounded regression scenario while the production default remains 50. Focused result: 4/4 PASS.
- CI regression 2 closed: intentional branded Report v2 output was re-frozen in `render-report-v2-conversion.test.js`. Focused result: 47/47 PASS.
- Primary production baseline remains TBK audit `9714c206-8ed3-4686-8fe2-ceeca0ca0f82` for `https://www.tbkcreative.com/`.
- Verified audit metrics remain: Conversion Readiness 65/100; Evidence Confidence 95/100; Evidence Coverage 100%; 12/13 evidence capabilities; 10/10 modules assessed; Conversion Path 100/100; Performance & Experience 71/100; browser conversion validation 6/6 selected pages; final Narrative v2 Judge pass 3 score 97 / PASS.
- The complete governed TBK audit prefix was copied read-only from S3 into the local fixture at `C:\Users\kulba\Desktop\vantage-platform\services\worker\test-fixtures\report-replay\audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82\governed`.
- Offline replay command succeeded with no provider/model calls and no production mutation: 1/1 PASS, Viewer 2.2.0, 4 findings, baseline MATCH, replay SHA256 prefix `e002f1570296`.
- Permanent local report copy: `C:\Users\kulba\Desktop\vantage-platform\services\worker\test-fixtures\report-replay\audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82\TBK-PRYSM-LOCAL.html`.
- Visual review reproduced the target defect exactly: Executive Scorecard still labels missing meta descriptions as the primary root cause and first action despite strong governed conversion-path evidence. The offline replay therefore proves the problem is in current report-process interpretation/prioritization, not stale production data.

Current environment / branch / version:
- Application remote: `main` at `90916e94f6feba73e7e60df54bd641bb2362454c`.
- Governed viewer: Viewer v2.2.0.
- Local worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Frozen replay audit: `9714c206-8ed3-4686-8fe2-ceeca0ca0f82`.
- Before the first new-chat source edit, verify local HEAD/tree once; do not repeat CI/architecture investigation unless the source has materially changed.

Completed:
- Browser/conversion evidence robustness work remains closed for this baseline.
- Narrative final-pass recovery remains closed for this baseline.
- The two known CI debts are closed and full GitHub `verify` is green.
- Latest TBK governed production artifacts are frozen locally as immutable replay inputs.
- Offline replay reproduces the saved production report exactly.
- CF-01 architecture diagnosis/design is complete enough to begin the governed implementation sequence. The core deficiency is that PRYSM does not carry one shared conversion-influence decision view from canonical evidence through foundation, executive priority, Writer/Judge, and competitor consumers. Those consumers independently reinterpret state and importance, which permits contradictory and technical-first client output.
- Scoring judgment: do not change scoring weights for CF-01. The current problem is downstream hierarchy/lineage/consumer interpretation, not a proven scoring-weight defect.

In progress:
Conversion-First v4.2 CF-01 implementation. The target hierarchy is the governed hierarchy in `CONVERSION_FIRST_V4_2.md`: offer/audience clarity; trust/proof; conversion path/action; friction/experience; buyer-question/decision support; acquisition/discoverability; technical causes/resilience, with a proven foundation blocker allowed to override only when evidence proves the buyer cannot discover, understand, complete, or safely execute the primary action.

Blocked:
None.

Important constraints:
- GitHub context is authoritative.
- Do not re-run a production audit or recollect evidence for CF-01.
- Do not call paid providers/models or mutate production configuration without explicit approval.
- Treat frozen raw/normalized/canonical/governed TBK artifacts as immutable inputs.
- Do not change scoring weights merely to alter report ordering.
- Preserve evidence-status semantics and Narrative v2 evidence-fidelity/quality gates.
- Technical findings remain visible; the repair changes their client-facing influence and hierarchy, not the truth of the evidence.
- Preserve Viewer v2.2.0 unless a separate deliberate migration is approved.
- Preserve the 250-page provider crawl ceiling, 20 priority-URL ceiling, and production content-parsing default of 50.
- Follow `REPAIR_BOUNDARY_PROTOCOL.md` and `WORKFLOW_INSTRUCTIONS.md`: the CF-01 repair boundary is already mapped; do not redo the architecture audit unless new source evidence invalidates it. Implement one governed source-file unit at a time, exact lines/anchors, bottom-up for multiple edits, and one proving test before moving on.
- Same observable failure: maximum three unsuccessful repair attempts before deeper diagnosis.

Expected CF-01 implementation sequence:
1. `services/worker/src/report/action-priority.js` — extend the shared derived conversion-first influence/ranking contract to the full v4.2 hierarchy.
2. `services/worker/src/report/foundation-readiness.js` — consume the governed conversion observation consistently so browser-validated conversion cannot coexist with a false “no CTA/form” foundation conclusion.
3. `services/worker/src/scoring/report-model.js` — preserve competitor qualification/evidence status and reconcile the audited-site conversion state with the same governed evidence used by the main report.
4. `services/worker/src/report/render-report-v2.js` — make executive “holding back” and “do first” consume the same conversion-first influence view and suppress competitor noise appropriately.
5. `services/worker/src/narrative-v2/writer-input.js` and `writer-findings.js` — expose the derived influence/order without mutating the persisted FindingSet.
6. `services/worker/src/narrative-v2/writer-prompt.js` — impose the governed v4.2 client hierarchy on synthesis.
7. `services/worker/src/narrative-v2/judge-contract.js` — enforce hierarchy/cross-view consistency while preserving the existing quality/evidence-fidelity gates.
- Do not modify `services/worker/src/report/sections-conversion.js` unless active Report v2 reachability is directly proven first.

Exact next action:
In the new chat, read the authoritative context files and `HANDOFF_CF01_REPORT_PROCESS_REPAIR_2026-08-28.md`, verify local `main` is clean and at `90916e94f6feba73e7e60df54bd641bb2362454c` once, then begin the first governed source-file unit in `services/worker/src/report/action-priority.js`. Do not repeat the completed CF-01 architecture investigation unless current source evidence materially contradicts the documented map.

Last verified:
2026-08-28 America/Toronto
