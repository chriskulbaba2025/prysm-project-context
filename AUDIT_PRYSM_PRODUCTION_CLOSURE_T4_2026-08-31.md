# PRYSM T4 Independent Audit - 2026-08-31

Verdict: **FAIL**

- Application branch: `repair/prysm-production-closure`
- Application SHA: `7baa716ac162c7ce33bdf5dfa051fb4f52cd82ec`
- Exact local/remote equality: verified; ahead/behind `0/0`
- Application tree: clean apart from Windows long-path status warnings; `git diff --check` passed and HEAD was unchanged
- Whole-App Gate: independently rerun and passed (82 assembled acceptance checks; five governed test families; zero live provider/model calls)

## AUD-T4-002 - Whole-App Gate does not exercise current replay through the changed CLI

- Category: `FALSE_PASS_PROOF_DEFECT`
- Severity: **MAJOR**
- Evidence: Candidate `7baa716` repairs AUD-T4-001 by adding `scripts/replay-report-cli.test.js`, but both subprocess cases point only to the historical offline fixture. The other gate replay family, `scripts/replay-report.test.js`, imports `buildV2Model()` directly. It bypasses `main()`, argument parsing, fixture discovery/loading, `assertReplayContracts()`, the newly selected `score-current.schema.json`, and renderer/recovery. Independently invoking `node scripts/replay-report.js test-fixtures/report-replay` found no valid current replay set (0/5 PASS; five fixtures are absent/old `1.0.0` artifacts), while the Whole-App Gate remained green.
- Why current proof misses it: the T4 production change makes current replay fail closed on ScoreSet `2.0.0` and persisted hierarchy and routes current artifacts through the CLI loader and renderer. No exact-gate scenario supplies a valid current persisted artifact set to that path. A regression that bypassed or broke current validation/replay can therefore remain green alongside the historical rejection tests.
- Required correction: add a deterministic zero-cost CLI-level current-artifact regression using a valid persisted ScoreSet `2.0.0`, hierarchy, Writer/Judge, and report artifacts. It must prove the default CLI completes current validated replay/render and prove one current-contract violation fails closed. Include it in `scripts/prysm-whole-app-gate.js`, then rerun the exact-SHA gate and synchronization checks.
- Owning tranche: **T4**. No later tranche may begin until repaired and independently audited.

## Audit conclusion

Candidate identity, scope, synchronization, diff hygiene, historical default rejection, and explicit compatibility-only labeling were independently verified. The repair closes AUD-T4-001 but not the full T4 current replay proof boundary. No application files were modified by this audit.
