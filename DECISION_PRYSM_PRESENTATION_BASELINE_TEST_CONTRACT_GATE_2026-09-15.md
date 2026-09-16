# Decision — PRYSM Presentation Baseline Test-Contract Gate

**Date:** 2026-09-15  
**Status:** Active

## Decision

Before any future PRYSM presentation-layer Builder stage, run the exact required presentation verification suite against the frozen application baseline first.

Every baseline failure must be classified and explicitly dispositioned before implementation begins. A stale wording, markup, golden, matrix, fixture, or presentation-contract expectation must be reconciled as a separately governed test-contract change; it must not be discovered only after product implementation.

## Reason

During the 2026-09-15 finishing-touch package, Step 4 implementation reached verification with 17 failures. GACM comparison proved all 17 failures already existed at the frozen baseline and were stale presentation/test-contract mismatches rather than regressions introduced by the finishing-touch product changes. The later bounded reconciliation produced 135 PASS / 0 FAIL without altering scoring, evidence, lifecycle, persistence, orchestration, Writer/Judge governance, fixtures, or other protected plumbing.

The process weakness was timing: baseline test-contract reconciliation happened after the Builder stage instead of before it.

## Required pre-Builder gate

For future PRYSM presentation work:

1. Verify repository, branch, frozen SHA, and worktree.
2. Run the exact presentation suite that will govern the planned change against the frozen baseline.
3. Record every baseline PASS/FAIL result.
4. Classify every failure as product defect, stale presentation contract, fixture/golden mismatch, or unrelated failure using direct evidence.
5. Reconcile or explicitly disposition every stale contract before Builder implementation.
6. Require a green baseline, or an explicitly governed and documented non-green baseline, before product editing begins.
7. Preserve the baseline classification as proof for later candidate comparison.
8. Golden/matrix refreshes require direct deterministic provenance and independent verification; tests may not be weakened merely to obtain a PASS.

## Implication

A presentation candidate may not be blamed for a failure that has not first been compared with the frozen baseline. Builder work must start from a known test contract. This gate is additive to GCU v2.1.0, the PRYSM agent-role process, evidence-integrity rules, and existing production/authorization boundaries.

This decision does not authorize application-main merge, push, deployment, production mutation, provider/model execution, or audit execution.