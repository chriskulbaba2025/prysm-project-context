# Independent Audit — P1 Cross-report contradiction integrity

Date: 2026-09-02
Verdict: FAIL — repair required

## Exact candidate

- Application: `repair/prysm-report-improvement`
- SHA: `32884562276daacce83a46d5f75bb417925ac54c`
- Working tree: clean; local branch equals `origin/repair/prysm-report-improvement`
- Governance pre-audit SHA: `c16a88c4c715ac88e4e62cc7f9ef8a7486eab773`
- Direct worker regression: 964/964 PASS
- Whole-App Tranche Gate: 87/87 PASS; P-B01 through P-B15 reported covered
- Live provider/model calls: 0; Model-Bearing Release Gate: N/A

## Finding

`P1-CROSS-REPORT-DERIVATION-001` remains open. The candidate adds and hydrates `crossReportInterpretation`, but `render-report-v2.js` calls `buildCrossReportInterpretation(...)` again from its own inputs rather than consuming the persisted hydrated projection. `sections-conversion.js` also has fallback derivations when the projection is absent. Consequently a persisted, tampered, stale, or omitted projection can be silently replaced by a newly derived interpretation, and the exact single-lineage/persistence-to-consumer contract is not proven. The Whole-App gate does not test this seam, so its green result is insufficient for P1 PASS.

## Required disposition

Builder must make the persisted `crossReportInterpretation` the sole source consumed by all affected report consumers, with explicit fail-closed behavior (or a governed contract proving absence is not accepted) and direct tampered/missing projection coverage through the assembled path. Re-run exact-candidate direct proof, Whole-App gate, branch evidence, clean-tree and local/remote SHA reconciliation before resubmission.

Classification: `REPAIR_PROOF_FAILED`
Root defect: `P1-CROSS-REPORT-DERIVATION-001`
