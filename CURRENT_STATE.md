# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

Current objective:
Execute the frozen pre-run report-integrity repair package discovered during the TBK Narrative v2 failure investigation. The diagnostic phase is complete at approximately 98% confidence across the material report path. Do not rerun the blind-spot investigation unless current source evidence materially contradicts the frozen package. Repair the deterministic evidence/finding/report/Narrative boundaries first, then rebuild the TBK report from frozen evidence and run one fresh governed Narrative v2 identity only after the deterministic gates are green and the paid-call step is explicitly authorized.

Verified checkpoint:
- Application repository: `chriskulbaba2025/vantage-platform`.
- Branch: `main`.
- Remote `main` verified on 2026-08-28 at `90916e94f6feba73e7e60df54bd641bb2362454c` — `test(prysm): repair CI regression baselines`.
- Local worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Uploaded local preflight diff confirms local HEAD is also exactly `90916e94f6feba73e7e60df54bd641bb2362454c`.
- Current local modified application files are:
  - `src/narrative-v2/contract-closure.test.js`
  - `src/narrative-v2/judge-contract.js`
  - `src/narrative-v2/live-binding.js`
  - `src/narrative-v2/writer-input.js`
  - `src/narrative-v2/writer-prompt.js`
  - `src/report/action-priority.js`
  - `src/report/foundation-readiness.js`
  - `src/report/render-report-v2-conversion.test.js`
  - `src/report/render-report-v2.js`
  - `src/scoring/report-model.js`
- Current untracked local items include `PRYSM-PREFLIGHT-LOCAL.diff` and local replay/refresh fixture directories. Do not delete, reset, clean, or overwrite them.
- Frozen TBK production audit remains `9714c206-8ed3-4686-8fe2-ceeca0ca0f82` for `https://www.tbkcreative.com/`.
- Frozen governed fixture remains `C:\Users\kulba\Desktop\vantage-platform\services\worker\test-fixtures\report-replay\audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82\governed`.
- Verified baseline metrics remain: Conversion Readiness 65/100; Evidence Confidence 95/100; Evidence Coverage 100%; 12/13 capabilities; 10/10 modules; Conversion Path 100/100; Performance & Experience 71/100; browser conversion validation 6/6 selected pages.
- Local CF-01 fixes already applied and tested include Conversion-First action influence, browser conversion-foundation reconciliation, deterministic competitor row suppression, audited-site comparative conversion consistency, Writer conversion hierarchy propagation, and Writer/Judge prompt/contract hierarchy grounding.
- Latest Writer/Judge contract closure test after prompt corrections: 5/5 PASS, 0 fail, duration 473.3933 ms.
- Fresh refresh `ea9a3b49-d393-4633-956b-d6cb1a2a3fc8` consumed the full six-call ceiling and ended `HUMAN_REVIEW_REQUIRED`, Judge 3 score 91. No further call is permitted on that identity.
- Fresh refresh `9c87448a-c1a1-41eb-a0e5-a8dd63cf8da4` completed two automatic passes and ended `HUMAN_REVIEW_REQUIRED`, Judge decision `REVISE`, score 94.5. Its remaining MAJOR defect was PARTIAL buyer-question evidence being described as an established content gap.
- The deeper preflight review proved the repeated Narrative failures are symptoms of upstream deterministic evidence-semantic inconsistencies, not merely weak prompt wording.
- The preflight repair package PF-01 through PF-18 is frozen in `HANDOFF_PF_REPORT_INTEGRITY_REPAIR_2026-08-28.md`.

Current environment / branch / version:
- Application remote and local HEAD: `main` at `90916e94f6feba73e7e60df54bd641bb2362454c`.
- Application working tree: intentionally dirty with the verified local CF-01/Narrative changes listed above plus local replay fixtures.
- Governed viewer: Viewer v2.2.0.
- Narrative Writer model for approved live runs: `gpt-5.6-terra`.
- Narrative Judge model: `gpt-5.6-sol`.
- Automatic Narrative maximum: 2 passes / 4 calls; absolute governed maximum after explicit final-pass authorization: 3 passes / 6 calls.

Completed:
- CF-01 architecture investigation is complete; do not redo it.
- Browser review exposed ranking, competitor, and cross-view contradictions; the direct deterministic ranking/competitor/cross-view fixes are locally implemented.
- Fresh Narrative regeneration exposed repeated evidence-fidelity defects around PARTIAL evidence semantics.
- Three-attempt diagnostic threshold was reached and a deeper architecture sweep was completed before further repair attempts.
- Full preflight sweep covered capability evidence, scoring/finding generation, Conversion-First ordering, WriterInput/Writer/Judge contracts, deterministic report sections, competitor projection, accessibility/performance rendering, finalization gate, persistence/replay/release boundaries, and the exact local uncommitted diff.
- The material defect families are frozen as PF-01 through PF-18. The discovery phase is considered complete at approximately 98% confidence; confidence is not a completion claim and each repair still requires direct proof.

In progress:
Pre-run integrity repair. The first implementation boundary is deterministic scoring/finding semantics in `services/worker/src/scoring/score-components.js`, specifically the shared root causes behind PF-01/PF-02/PF-03. The repair must separate PARTIAL from complete assessment, prevent cross-capability unknown→negative scoring, and prevent unqualified absence findings from partial coverage.

Blocked:
- Do not spend on another Writer/Judge refresh until the deterministic repair package is proven by targeted tests and offline TBK reconstruction.
- Do not render or release a fresh Narrative v2 report unless final Judge decision is PASS and the deterministic release gates pass.
- Do not commit/push/deploy application changes until the repair package and browser report review are complete and repository action is explicitly authorized.

Important constraints:
- GitHub context is authoritative.
- Preserve the current dirty local working tree. Never reset, clean, checkout-overwrite, or discard the known local CF-01/Narrative changes or replay fixtures.
- Frozen TBK raw/normalized/canonical evidence remains immutable. The integrity repair may rebuild derived findings/scores/report inputs locally from frozen evidence; it must not recollect providers or mutate production artifacts.
- Do not change scoring weights or scoring version merely to alter report results. Repair evidence eligibility/semantics only where proven.
- Do not weaken the Narrative quality gate, 92 release threshold, evidence-fidelity requirement, dimension floors, hard gates, major-defect protections, pass limits, or human-authorization boundary.
- No fourth pass on an exhausted six-call Narrative identity.
- No paid provider/model call, production audit, deployment, configuration mutation, application push, or production persistence mutation without the applicable explicit approval.
- Preserve Viewer v2.2.0, provider crawl ceiling 250, provider priority-URL ceiling 20, and production content-parsing default 50.
- Follow `REPAIR_BOUNDARY_PROTOCOL.md`, `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`, and `WORKFLOW_INSTRUCTIONS.md`.
- Work one governed source-file unit at a time; exact path/current lines/anchors; multiple edits bottom-up; complete replacement blocks; one highest-information proving test; stop for result before moving on.
- Same observable failure: maximum three unsuccessful attempts before deeper diagnostic reset.
- Browser-served report review remains an acceptance gate. Automated PASS alone is insufficient for final report interpretation acceptance.

Exact next action:
Start a new chat. Read the governing context files plus `HANDOFF_PF_REPORT_INTEGRITY_REPAIR_2026-08-28.md`. Verify `git status --short` and `git rev-parse HEAD` once without cleaning the tree. Then perform the Mandatory Pre-Edit Gate for the first governed source-file unit `C:\Users\kulba\Desktop\vantage-platform\services\worker\src\scoring\score-components.js`, bounded to PF-01/PF-02/PF-03. Inspect the exact current file and relevant existing tests, freeze the smallest observable repair contract, then give the first manual edit and one proving test. Do not rerun the broad investigation and do not call Writer/Judge.

Last verified:
2026-08-28 America/Toronto
