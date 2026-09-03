# Independent Audit — PDV VAN-SCHEMA Mixed Status

Date: 2026-09-03  
Application branch: `repair/prysm-van-schema-mixed-status`  
Exact candidate SHA: `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec`  
Root defect: `VAN-SCHEMA-001-MIXED-STATUS-PROVENANCE`

## Verdict

**PASS** — no open material product, contract, persistence, proof, branch-coverage, or release-control defect.

## Independent evidence

- Local application HEAD equals `origin/repair/prysm-van-schema-mixed-status` at the exact candidate SHA.
- Application worktree is clean; `git diff --check` passes.
- Focused scoring suite passes **31/31**, including the permanent mixed-status regression proving an AVAILABLE `schema.structured_data` capability remains AVAILABLE despite broader site PARTIAL status.
- Whole-App Tranche Gate passes **87/87** and explicitly names `P-B01` through `P-B16`; assembled lifecycle, persisted artifacts, validated reload, current Narrative path, replay boundary, finalization regressions, and zero-cost controls execute successfully.
- Composite closure gate passes its worker regression families.
- No live provider/model calls were made.
- The candidate changes only the shared finding-evidence status derivation and its regression test. The implementation preserves required PARTIAL behavior, suppresses unusable required capabilities, and retains site-level status for findings without requirements.
- The governed branch matrix and permanent PDV1–PDV4 escape regressions remain represented in the checked-in governance evidence; this PDV does not alter those branch identities.

## Audit conclusion

The repaired producer-to-finding evidence boundary is exercised on the exact pushed SHA, and the regression activates the production scoring path rather than a synthetic leaf validator. Required current status provenance is preserved through the governed scoring output. No finding requires Builder repair or disposition.

Protected actions were not performed: no merge, deployment, production mutation, fresh production audit, paid provider call, paid model call, force push, or destructive reset.

Next action: Builder records this PDV PASS and advances only to the next boundary authorized by durable current state.
