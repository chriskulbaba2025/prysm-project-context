# PRYSM Production Closure T4 Independent Audit

Application candidate: `repair/prysm-production-closure` @ `50a3ecf938e18a7b80a7dc1d98e38a3758126667`
Verdict: **FAIL**

## Previously failed finding AUD-T4-003 — corrected

- Category: `PERSISTENCE_OR_RELOAD_DEFECT`
- Severity: `MAJOR`
- Root defect: `T4.V2_PUBLICATION_RETRIEVAL_CONTRACT`
- Resolution evidence: `services/worker/src/storage/report-store.js` now writes and verifies `report-v2/approved/index.html` in both local and S3 stores; `services/worker/src/application/production-runtime.js` uses `readPublishedV2Page` for current v2 retrieval. This removes the production-path mismatch identified on the prior candidate.

## Finding AUD-T4-004

- Category: `FALSE_PASS_PROOF_DEFECT`
- Severity: `MAJOR`
- Root defect: `T4.V2_PUBLICATION_RETRIEVAL_CONTRACT`
- Evidence: candidate diff `0b10e67..50a3ecf` adds only two v2 assertions to `services/worker/scripts/acceptance-prysm.js`: it checks a `verifiedArtifacts` filename, then compares runtime retrieval with `reportStore.readPublishedV2Page`. Both values use the same helper and the test leaves the draft `report-v2/pages/index.html` equal to the approved page. It never distinguishes, removes, or tampers with the draft artifact. The only direct publication test, `services/worker/src/application/publication-path.test.js`, constructs legacy `report/pages/*` artifacts and explicitly passes the 16-page `Map` to approval, so it exercises the v1 path rather than the repaired current-v2 branch. Independent execution on the exact SHA: `node scripts/acceptance-prysm.js` PASS (84/84); `node --test src/application/publication-path.test.js` PASS (2/2). Those results confirm the gap rather than close it.
- Why current proof misses it: an implementation that reads `report-v2/pages/index.html` from inside `readPublishedV2Page` would make both compared values the same draft bytes and retain the correct-looking publication metadata. The new checks would still PASS while the escaped draft-versus-approved retrieval defect recurs. This is exactly the failure class AUD-T4-003 required the regression to detect.
- Required bounded correction: add a production-composition current-v2 regression that makes the approved and draft bytes observably different (or removes/tampers with the draft) after approval, asserts published retrieval returns the verified approved bytes, and separately asserts tampering/removing the approved artifact fails closed. Run that regression as part of the exact-SHA Whole-App Gate. Preserve the existing v1 16-page publication test.
- Owning tranche: T4.

## Evidence executed

- Candidate identity: local `HEAD`, `origin/repair/prysm-production-closure`, and claimed candidate are `50a3ecf938e18a7b80a7dc1d98e38a3758126667`; application divergence is 0/0. `git diff --check` passes and the application HEAD remained unchanged after audit diagnostics.
- Builder evidence: exact-SHA Whole-App Gate PASS, controlled transports only, zero live paid provider/model calls.
- Independent diagnostics: `node scripts/acceptance-prysm.js` PASS (84/84); `node --test src/application/publication-path.test.js` PASS (2/2).
- No application files were modified by the Auditor.

## Verdict rationale

The production implementation repair is coherent, including its local and S3 contract. Its permanent regression is not: the exact escaped condition remains unactivated, so the Whole-App Gate can issue a false PASS if draft retrieval returns through the same helper. This is a required T4 proof boundary.
