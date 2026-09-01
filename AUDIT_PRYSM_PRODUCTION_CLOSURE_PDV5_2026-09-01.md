# Independent Audit — PDV5

Date: 2026-09-01
Application branch: `repair/prysm-production-closure`
Application SHA: `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`
Verdict: **FAIL**

## Independent audit rerun

The exact candidate is synchronized locally and remotely, and the worktree is clean. `npm run test:narrative-v2` passes 114/114 and `npm run verify:prysm-whole-app` passes 87 checks with P-B01 through P-B15 named and covered. Direct review of the changed validator and its negative/positive regressions found no remaining commercial-outcome false-positive in the active root.

### PDV5-AUD-003 — authoritative branch matrix is stale

- Category: `BRANCH_COVERAGE_DEFECT`; severity: `MAJOR`.
- Evidence: `PRYSM_WHOLE_APP_BRANCH_MATRIX.md` remains `ACTIVE / PDV4 REPAIR OPEN`; P-B14 and P-B15 exact-SHA verification cite `ce62cce60e7deb2bd2ff0bc49ce014acd1b21800`, while the audited candidate is `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`.
- Impact: the durable matrix does not prove that required branch rows were verified on the exact audited SHA, despite the fresh gate output. The mandatory branch protocol forbids PASS while exact current verification is stale or materially unknown.
- Required correction: Builder updates the matrix status/current PDV and reconciles P-B01..P-B15 exact-SHA verification to the fresh gate evidence, without changing application code; then resubmits the same frozen application SHA.

This is a proof/governance setup defect, not a new application root. The active root remains `PDV5.WRITER_COMMERCIAL_OUTCOME_CONTEXT_FALSE_POSITIVE`; no fourth repair is requested against the exhausted prior root.

## Evidence reviewed

- Local application `HEAD`, `origin/repair/prysm-production-closure`, and the claimed candidate all equal `b46e8e54016b82c2aa87e6b07aa4b8610a2e1aa4`. The application tree was clean, `git diff --check` passed, and branch divergence was `0/0`.
- Candidate `b46e8e5` changes only the Writer semantic-fidelity causal-certainty exception and its direct tests.
- `npm run test:narrative-v2` passed: 112 tests, 0 failures, on the audited SHA.
- `npm run verify:prysm-whole-app` passed on the audited SHA. It records controlled transports, zero live provider calls, and branch IDs `P-B01` through `P-B15`.
- `PRYSM_MODEL_BEARING_GATE_STATE.json` records the required real corpus sample/completion evidence as PASS, with the independent semantic challenge still pending.
- The Auditor independently invoked the exact candidate's `validateWriterSemanticFidelity` with the same production semantic boundary, outside the application worktree.

## Material finding

### PDV5-AUD-002 — Conversion-action exception permits unsupported commercial outcomes

- Category: `CONTRACT_MIGRATION_DEFECT`
- Severity: `CRITICAL`
- Affected boundary: PDV5 Writer semantic fidelity; current Writer validation before Judge/finalization; model-bearing Writer outputs on P-B07 through P-B09.
- Evidence: in `services/worker/src/narrative-v2/writer-output.js`, candidate `b46e8e5` exempts any sentence containing `action`, `path`, `route`, `cta`, or `form` from causal/commercial validation unless it includes only a limited downstream-word list. Direct execution of the exact candidate returned no errors for both `The conversion form confirmed revenue.` and `The conversion action established increased traffic.`
- Why current proof misses it: `PDV5-WRITER-OUT-07` and `PDV5-WRITER-OUT-08` cover valid observed-action wording only. Neither is a negative sibling pairing an observed conversion-action term with a prohibited commercial result. The deterministic Whole-App gate proves composition but does not activate this semantic counterexample.
- Required correction: constrain the exception to statements that assert only an observed assessed action/path, or otherwise retain rejection whenever any commercial/outcome claim is present. Add positive and negative direct regressions for conversion-action/form wording, including revenue, traffic, and other governed commercial terms, then rerun the required exact-SHA deterministic and model-bearing evidence as applicable.
- Owning tranche: PDV5.

## Verdict

PDV5 does not pass. The active root `PDV5.WRITER_JUDGE_SEMANTIC_SUPPORT_MISMATCH` remains the correct repair boundary. No merge, deployment, or fresh live audit is authorized by this verdict.
