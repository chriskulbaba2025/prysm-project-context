# PRYSM T2 Independent Audit - FAIL

- Candidate: `repair/prysm-production-closure` @ `0bc6cfa758b7c6c20efd2f01ae3b3485ea540fbe`
- Candidate identity: local `HEAD` equals `origin/repair/prysm-production-closure`; divergence is `0/0`; application tree is clean. `git diff --check HEAD^..HEAD` is clean.
- Whole-App Gate: independently rerun on this unchanged SHA - **PASS**: 82 assembled acceptance checks, 10 WriterInput checks, 10 Narrative v2 production-path checks, and 2 replay checks. Controlled transports were used; the gate reported zero live provider calls and a $0 Narrative ledger.

## AUD-T2-002 - Base current consumer silently drops decision evidence

- Category: `DUPLICATE_SOURCE_OF_TRUTH`
- Severity: `MAJOR`
- Evidence: `services/worker/src/report-view-model/build-view-model.js:204` calls `hydrateCurrentReportModel({ scoreSet: scoringModel, findings: scoringModel.findings, evidence })`. The hydrator's actual contract in `services/worker/src/report-model/current-model.js:7` destructures `decisionEvidence` and `capabilityEvidence`, then returns the governed decision artifact as `evidence: decisionEvidence` at line 35. JavaScript ignores the supplied `evidence` property, so this current base-renderer consumer gets `current.evidence === undefined` and `current.capabilityEvidence === undefined` even when the persisted artifacts were supplied to its caller.
- Impact: the T2 canonical boundary does not preserve the same current persisted semantic object for every stated consumer. A release-critical decision/status field used by the base renderer can be silently absent at this path while Narrative v2 and replay retain it. This is the exact independent-projection/field-loss class T2 is meant to close.
- Why proof missed it: the rerun gate executes assembled default rendering, Narrative v2 production-path tests, WriterInput tests, and the two replay unit tests. It does not execute a current-contract `buildReportViewModel` scenario or assert the base/V2/replay hydrated semantic artifacts are identical. The replay test also invokes `buildV2Model` with synthetic direct arguments rather than persisted base-renderer composition.
- Required bounded correction: pass `decisionEvidence` and `capabilityEvidence` by their canonical names at the base current consumer, and add one production-shaped parity proof which supplies the persisted artifacts and asserts their governed hierarchy/root-cause/status identity through base rendering, Narrative v2, and replay. Include that proof in the exact-SHA Whole-App Gate. Preserve historical compatibility separation and zero-cost boundaries.
- Owning tranche: `T2`.

## Bounded challenge results

- The previous replay duplication defect is repaired: `services/worker/scripts/replay-report.js` imports and calls `hydrateCurrentReportModel`; its two new tests are executed by the gate.
- Current replay still has historical Judge-version handling, but it is explicitly limited to the legacy 1.0.0/2.0.0 pair and is not counted as current release proof.
- No application files were modified by this audit.

## Verdict

`FAIL`. One open MAJOR finding prevents automatic advancement. Builder must repair `AUD-T2-002` in the same T2 tranche, freeze a new pushed exact SHA, rerun the gate and applicable proof on that SHA, then resubmit for independent audit.
