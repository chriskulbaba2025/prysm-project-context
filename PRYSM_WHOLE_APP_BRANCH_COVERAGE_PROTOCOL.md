# PRYSM Whole-App Branch Coverage Protocol

Protocol ID: PRYSM-WHOLE-APP-BRANCH-COVERAGE-01
Status: ACTIVE / MANDATORY
Effective: 2026-08-31

## Purpose

Prevent a false Whole-App PASS in which the assembled application works for one golden path while a materially different production branch is never exercised against the current downstream contracts.

The Whole-App Tranche Gate remains mandatory. This protocol strengthens it by requiring a governed inventory and deterministic coverage matrix for materially distinct production branches.

## Core rule

> A Whole-App gate is not complete merely because its named scenarios pass. For every exact candidate SHA, every materially distinct currently implemented production branch must be either (a) mapped to one or more deterministic whole-app scenarios that execute and PASS at that exact SHA, or (b) explicitly classified as not currently implemented. A required implemented branch that is unmapped, unexecuted, or cannot be proven makes the gate FAIL/BLOCKED, not PASS.

A count such as `6/6 PASS` proves only that six scenarios passed. It does not prove branch completeness unless the current branch matrix proves those scenarios cover all required implemented branch IDs.

## What counts as a materially distinct production branch

Inventory a branch when it changes one or more of these material behaviours:

- producer output shape or required release-critical fields;
- contract/schema/semantic validation requirements;
- persistence, reload, recovery, or replay behaviour;
- lifecycle/state transition path;
- scoring eligibility or alternate scoring model;
- evidence-status semantics;
- decision hierarchy/root-cause construction;
- Writer/Judge call sequence or terminal outcome;
- publication/finalization/retrieval behaviour;
- report/view-model/render projection.

Do **not** inventory every `if` statement or cosmetic condition. The unit is a production path whose omission could permit an integration defect to survive component tests.

## Governed branch matrix

`PRYSM_WHOLE_APP_BRANCH_MATRIX.md` is the durable coverage inventory.

Each required branch row must record:

- stable branch ID;
- production condition/path;
- material contract or handoff affected;
- current implementation status;
- deterministic whole-app scenario/test IDs that exercise it;
- exact-SHA execution status;
- last verified SHA/date;
- known escape/regression provenance where applicable.

One whole-app scenario may cover multiple branch IDs. A branch may require more than one scenario when different downstream handoffs must be proven.

## Contract-at-every-handoff rule

A mapped whole-app scenario must assert current contracts after every material boundary it traverses. As applicable:

`producer -> persisted artifact -> validated reload -> consumer -> next persisted/projection boundary`

For PRYSM this includes, where the branch reaches them:

`AuditRequest -> SourceResults -> DecisionEvidence -> CapabilityEvidence -> scoreAudit -> FindingSet/ScoreSet -> reload -> decision hierarchy/root-cause -> WriterInput -> Writer validation -> Judge validation -> release/finalization -> publication -> retrieval -> Viewer render -> recovery/replay`

A test that reaches the end while silently skipping an intermediate current contract is insufficient for that handoff.

## Required branch classes

The branch inventory must cover currently implemented variants in these classes when they materially change the path:

1. source/evidence status and crawl viability, including viable and non-viable scoring branches;
2. PARTIAL/UNKNOWN/UNAVAILABLE honesty across persistence and consumers;
3. zero-finding/empty-hierarchy and non-empty hierarchy paths;
4. single- and multi-finding hierarchy/root-cause parity where materially distinct;
5. Narrative first-round PASS, governed REVISE/second-round, and HUMAN_REVIEW/final-authorization paths where implemented;
6. valid persisted recovery and invalid/stale fail-closed recovery;
7. publication/retrieval/render and current replay identity.

The matrix, not this prose list, is the authoritative current inventory.

## Gate evolution rule

Any application change that adds, removes, splits, or materially changes a production branch must update the matrix in the same governed work package before PASS.

If a changed or adjacent production branch is absent from deterministic Whole-App coverage, extend the gate first or in the same coherent tranche. PASS by omission is prohibited.

## Coverage escape rule

A **branch coverage escape** is a material defect discovered in UAT/live/production that would have been caught had a materially distinct production branch been represented in the deterministic matrix.

For every coverage escape:

1. record the escaped branch and root defect;
2. add or correct the branch row in the matrix;
3. add a permanent deterministic whole-app regression for that branch;
4. rerun the exact-SHA Whole-App gate;
5. do not run another paid/live validation merely to rediscover the same class before deterministic proof is green.

Live production validation is confirmation, not the primary mechanism for discovering repository-controlled branch wiring defects.

## Exact-SHA PASS contract

After this protocol becomes effective, Whole-App PASS requires all of the following on one exact SHA:

- branch matrix is current for the candidate architecture;
- every required implemented branch is mapped;
- every mapped required scenario executed on the exact SHA;
- all required branch scenarios PASS;
- current contracts are asserted at material handoffs;
- no prohibited live/paid provider/model calls are used;
- gate output records branch IDs covered, not only scenario counts;
- exact HEAD remains unchanged through verification.

Any `UNMAPPED`, `UNEXECUTED`, or materially `UNKNOWN` required implemented branch forbids PASS.

## Anti-analysis-paralysis rule

The goal is complete coverage of materially distinct production behaviour, not exhaustive control-flow enumeration.

Stop inventory expansion when every currently implemented path that can materially change persisted state, contract acceptance, lifecycle, decision semantics, Narrative sequence, publication, recovery, or client-facing output has a governed branch ID and deterministic assembled-system proof.
