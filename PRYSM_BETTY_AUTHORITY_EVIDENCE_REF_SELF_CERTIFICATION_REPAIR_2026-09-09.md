# PRYSM Betty Authority Evidence-Reference Self-Certification Repair Checkpoint

Date: 2026-09-09
Status: BETTY REAL PROGRESS — NO / BOUNDED REPAIR REQUIRED

## Failed authority candidate

Application repository: `chriskulbaba2025/vantage-platform`

Review branch: `review/prysm-solution-directive-authority-betty`

Exact failed candidate SHA: `3a048b46d0d03279984b7cfa1219cd5280fff216`

Accepted generator parent SHA: `8f3896fed40f7825a6f2a1d6a17a47a25d397cd2`

## Betty verdict

`RESULT: REAL PROGRESS — NO`

`REASON: Authority records can self-certify an otherwise unresolved evidence reference using persisted: true, bypassing the required persisted-evidence resolution boundary.`

`CONFIDENCE: HIGH`

## Verified root cause

Exact-code inspection at failed SHA `3a048b46d0d03279984b7cfa1219cd5280fff216` confirms Betty's stated defect.

In `services/worker/src/solution/solution-directive-authority.js`, `buildEvidenceIndex(findings, decisionEvidence, authorityMap)` correctly collects explicit references from governed finding evidence and `decisionEvidence`, but then also loops over `authorityMap` and adds an authority-supplied evidence reference when that reference object declares `persisted: true`.

Later, `assertReferenceList(..., evidenceIndex, "evidence")` treats membership in that same index as proof that the authority evidence reference resolves.

Therefore an authority record can introduce an otherwise unknown evidence ID and make it resolve solely by asserting `persisted: true`. The authority record is acting as both claimant and verifier. This violates the fail-closed authority-resolution boundary and the requirement that authority references resolve against independently governed persisted evidence.

## Smallest bounded repair

Repair only the evidence-reference trust boundary in the existing Solution Directive Authority tranche.

Required behavior:

1. `buildEvidenceIndex` must derive trusted evidence IDs only from independently governed inputs already supplied to the authority boundary: finding evidence and `decisionEvidence`.
2. `authorityRecords` must not add, certify, or otherwise expand the trusted evidence index.
3. An authority `evidenceRefs` entry with an unresolved ID must fail `AUTH-EVIDENCE-REF` even when the authority object includes `persisted: true`.
4. A reference that genuinely resolves through governed finding evidence or `decisionEvidence` must continue to pass; an authority-side `persisted` property must be irrelevant to trust resolution.

Expected application change boundary remains exactly:

- `services/worker/src/solution/solution-directive-authority.js`
- `services/worker/src/solution/solution-directive-authority.test.js`

Do not modify the accepted generator, validator/contract, production path, renderer, scoring, evidence production, Writer/Judge, lifecycle, persistence, or production configuration.

## Required proof

The repair candidate must include focused regression coverage that proves the exact Betty counterexample fails closed and that a genuinely resolved evidence reference still passes.

Then rerun the same required focused and existing regression suites used for the failed authority candidate, produce a proof artifact, commit only the authorized authority repair, push the exact candidate to the non-production review branch, record the exact SHA, and stop for Betty.

## Governance effect

Canonical production-path integration remains blocked.

This checkpoint does not advance Solution Directive Authority to accepted status.

No renderer integration, merge to application `main`, deployment, provider/model call, audit rerun, production mutation, scoring change, evidence change, lifecycle change, persistence change, or Writer/Judge change is authorized.

## Exact next action

Starting from failed authority SHA `3a048b46d0d03279984b7cfa1219cd5280fff216` on `review/prysm-solution-directive-authority-betty`, implement only the bounded evidence-index trust repair and its focused regression in the two authorized authority files; run required verification; produce proof; commit and push the repaired non-production candidate; record its exact SHA; then stop for Betty's next `REAL PROGRESS` verdict.