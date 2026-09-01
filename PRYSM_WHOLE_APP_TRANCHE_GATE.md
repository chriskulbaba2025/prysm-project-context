# PRYSM Whole-App Tranche Gate

Gate ID: PRYSM-WHOLE-APP-TRANCHE-GATE-01
Status: ACTIVE / MANDATORY
Effective: 2026-08-31

## Purpose

Prevent another false PASS in which targeted/unit tests succeed while the assembled PRYSM production Narrative/report path is broken at a later persistence, projection, recovery, replay, or render boundary.

## Hard rule

For every application-changing Production Closure tranche:

> Targeted tests and broad regression are necessary but insufficient. The exact candidate SHA must also PASS the deterministic PRYSM Whole-App Tranche Gate before that tranche may be audited, frozen, reported PASS, or advanced.

If the gate is missing, cannot execute, does not exercise the changed production path, or fails, the tranche is not PASS.

## Exact-SHA order

1. diagnose the complete affected Producer -> Contract/Persistence -> Loader -> Consumer path;
2. implement the bounded tranche change;
3. run tranche-specific targeted proofs;
4. commit a coherent freeze candidate on `repair/prysm-production-closure`;
5. record exact HEAD;
6. run the PRYSM Whole-App Tranche Gate on that exact HEAD;
7. run the tranche's required composite/local verification on that same exact HEAD;
8. prove `git diff --check` and clean working tree;
9. prove HEAD did not change after the gates;
10. push the repair branch;
11. prove local SHA = remote SHA and ahead/behind = 0/0;
12. only then hand the exact SHA to the independent Auditor.

Any application SHA change after step 6 invalidates the gate and requires rerun.

## What whole-app means for PRYSM

The gate must exercise the current assembled deterministic production composition available at the tested SHA, not merely call leaf validators.

At full closure it must traverse, as applicable:

`AuditRequest -> source execution boundary with controlled transports -> persisted SourceResults -> DecisionEvidence -> CapabilityEvidence -> scoreAudit -> FindingSet/ScoreSet persistence -> validated reload -> current Conversion-First decision hierarchy/root-cause binding -> WriterInput -> controlled Writer -> Writer validation -> controlled Judge -> Judge validation -> release candidate persistence -> finalization gate -> Viewer v2 render -> report persistence -> reload/recovery/current replay`

Use real production composition boundaries wherever the repository exposes them, including `createProductionRuntime` and the actual Narrative v2 production wrapper.

## Production-boundary requirements

The gate must fail on:

- a current release-critical field produced but not persisted;
- a persisted current field not validated on reload;
- a model/report projection dropping a governed field;
- base render, Narrative v2, UAT rerender, and current replay using incompatible semantic model reconstructions;
- current root-cause identity disagreeing with the persisted governed Conversion-First hierarchy;
- Writer action order/rank/effort differing from the persisted governed hierarchy;
- Writer/Judge current prompt/contract version mismatch;
- synthetic test-only fields that production persistence does not provide when those fields are needed for PASS;
- stale historical artifact accepted as current release proof;
- source status contradiction across current governed artifacts;
- UNKNOWN / UNAVAILABLE / PARTIAL / not-deeply-parsed becoming absence, false, zero, empty, complete, or fully assessed;
- invalid persisted terminal Narrative artifacts being retried with another Writer/Judge spend;
- current recovery/reload consuming malformed or incompatible ScoreSet/FindingSet/WriterInput state;
- a changed production path not being exercised by the gate.

## Zero-cost rule

The Whole-App Tranche Gate is deterministic and local.

Authorized inside the gate:
- frozen fixtures;
- controlled provider transports;
- memory/local artifact stores where they preserve the real production service composition;
- controlled Writer/Judge executors with measured invocation counters;
- local filesystem output.

Not authorized inside the gate:
- live/paid DataForSEO/PageSpeed/other provider calls;
- live/paid Writer/Judge calls;
- AWS/Vercel/Railway mutation;
- deployment;
- starting a fresh production audit;
- production persistence mutation.

If a current production path cannot be proven without a prohibited external action, the affected tranche is BLOCKED until a deterministic seam proves the repository-controlled composition. Do not substitute a leaf unit test.

## Minimum golden scenarios

The gate must maintain a small stable current-contract scenario set.

### G1 - Complete current V2 production path
A controlled current audit reaches `DRAFT_RENDERED` through current production composition and Viewer v2.

### G2 - Partial/unknown evidence honesty
A controlled PARTIAL/unknown evidence case proves the state survives persistence, scoring, WriterInput, Narrative, finalization, and report surfaces without becoming absence/zero/false/complete.

### G3 - Conversion-First hierarchy parity
At least two governed findings produce a non-empty current hierarchy. The same root-cause rule identity, ordered finding IDs, rank, influence, and governed effort survive scoring -> persistence -> reload -> WriterInput -> Writer validation -> finalization -> render.

### G4 - Persisted release-candidate recovery
A valid current persisted release candidate can reload/recover/render without another Writer/Judge execution set.

### G5 - Invalid/stale terminal fail-closed
An invalid current terminal Narrative artifact or incompatible current-contract artifact fails closed and produces zero additional Writer/Judge executions.

### G6 - Current replay identity
Current-release replay consumes the same validated current semantic model boundary and produces governed Viewer v2 output without a second hierarchy/root-cause derivation.

Historical compatibility replay is excluded from G6 and cannot satisfy this gate.

## Gate evolution

The gate is governed verification infrastructure.

When a tranche changes a production boundary the gate does not exercise, extend the gate first or as part of the same tranche. PASS by omission is prohibited.

Golden scenarios are cumulative unless a later versioned architecture deliberately replaces a scenario.

## Required evidence per tranche

Every tranche PASS must record:
- exact application branch and SHA;
- gate version/command;
- golden scenarios executed;
- PASS/FAIL counts;
- duration where available;
- Writer/Judge controlled invocation counts where applicable;
- confirmation live paid provider/model calls = 0;
- targeted proof result;
- applicable broad/composite verification result;
- `git diff --check` result;
- clean-tree result;
- unchanged-HEAD proof;
- local/remote application SHA equality and ahead/behind 0/0 before independent audit.

## Independent Auditor rule

The independent Auditor must reject an application-changing tranche that lacks exact-SHA Whole-App Tranche Gate evidence even when targeted tests, `npm test`, build, or other suites are green.

The Auditor must also inspect whether the gate itself actually executes the changed production path rather than trusting the gate name or a PASS label.

## Final closure rule

The final Production Closure candidate must run this gate again after all T1-T6 application changes are combined at one exact SHA. Independent earlier tranche PASSes do not prove the combined final application.

---

## Whole-App Branch Coverage Amendment — mandatory after 2026-08-31

`PRYSM_WHOLE_APP_BRANCH_COVERAGE_PROTOCOL.md` and `PRYSM_WHOLE_APP_BRANCH_MATRIX.md` are now part of this gate.

The six golden scenarios above are a stable baseline, not a declaration that six scenarios exhaust the assembled application. A result such as `6/6 PASS` is insufficient for a new application-changing PASS unless the current matrix proves that all materially distinct currently implemented production branches are mapped to executed deterministic scenarios on the same exact SHA.

Before the gate may report PASS it must additionally prove:

1. the branch matrix is reconciled to the candidate architecture;
2. every required implemented branch ID is mapped to one or more whole-app scenarios/tests;
3. every required mapped branch executed on the exact candidate SHA;
4. all required branch scenarios passed;
5. current contracts are asserted at each material producer/persistence/reload/consumer handoff traversed by the scenario;
6. gate evidence records the branch IDs covered, not only scenario counts;
7. no required implemented branch remains `UNMAPPED`, `UNEXECUTED`, or materially `UNKNOWN`.

If the application or a tranche introduces or exposes a materially distinct branch that is not represented, extending the branch matrix and deterministic Whole-App coverage is part of the same repair boundary. The result is FAIL/BLOCKED until that coverage exists.

Any material defect found in UAT/live production that escaped because a materially distinct branch was omitted becomes a permanent branch-matrix row and permanent deterministic whole-app regression before another production validation of that class.
