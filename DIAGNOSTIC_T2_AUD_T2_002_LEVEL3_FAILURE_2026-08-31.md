# T2 AUD-T2-002 Level-3 Repair Proof Failure

- Application branch/SHA before uncommitted repair: `repair/prysm-production-closure` / `0bc6cfa758b7c6c20efd2f01ae3b3485ea540fbe`.
- Focused proof: `node --test src/report-model/current-model.test.js src/report-model/current-consumer-parity.test.js scripts/replay-report.test.js` — PASS, 5/5.
- Assembled proof: `node scripts/acceptance-prysm.js` — FAIL.
- Direct failure: the governed lifecycle reached `RENDER_FAILED`; `buildReportViewModel` reported two additional-property schema errors after the current ScoreSet contract activated canonical hydration in the base renderer.
- Root boundary: the base consumer previously avoided canonical hydration by reconstructing a ScoreSet-shaped object without `contractVersion` and `decisionHierarchy`. Preserving the current persisted object activates current `rootCauseRuleId`/`decisionHierarchy` output, but the locked ReportViewModel v1 schema has no fields for those current semantics.
- Preserved work: canonical `decisionEvidence`/`capabilityEvidence` arguments, persisted ScoreSet preservation, base model capability evidence, three-consumer parity test, schema addition for capability evidence, and Whole-App Gate inclusion remain uncommitted in the application tree.
- Governance result: repair attempt 3 / BLOCKED. No fourth autonomous repair is permitted. An owner-guided versioned ReportViewModel migration versus explicit compatibility-adapter decision is required.
