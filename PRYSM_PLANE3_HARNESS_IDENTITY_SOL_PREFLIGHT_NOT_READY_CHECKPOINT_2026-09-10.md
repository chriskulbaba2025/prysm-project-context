# PRYSM Plane 3 Harness Identity Sol Preflight Checkpoint

Date: 2026-09-10
Status: NOT_READY / HIGH

Application repository: `chriskulbaba2025/vantage-platform`

Published semantic base: `a16430aa6c000afadcaade3e692e41f0f08ed903`

Local tooling candidate reviewed: `61303af4d7d567c2d77eb61379b98dff6f1974aa`

Branch: `review/prysm-solution-directive-authority-betty` — historical name only; Betty is not an active gate.

## Finding

Independent Sol High preflight found a self-reference defect in the Plane 3 Writer-only harness candidate identity contract.

The harness constant was changed to expect published base `a16430aa6c000afadcaade3e692e41f0f08ed903`, but executable `main()` derives the current repository HEAD and passes that HEAD as the candidate identity. At local candidate `61303af4d7d567c2d77eb61379b98dff6f1974aa`, direct execution therefore compares `61303af4...` to `a16430aa...` and fails closed before Writer execution.

The focused test missed this because it injects the published-base SHA directly rather than exercising the `main()` HEAD-derived path.

## Identity contract decision

Do not attempt to hard-code the executing commit's own SHA inside that same commit. That is self-referential and will stale whenever the harness source changes.

The next repair must explicitly distinguish:

- **semantic application candidate/base**: the governed application semantics being model-bearing tested; and
- **tooling HEAD**: the exact commit carrying the non-production harness/test overlay.

The guard must remain fail-closed. It must prove the tooling HEAD is a clean, authorized bounded overlay on the semantic base and must not allow arbitrary SHA input, wildcard, environment bypass, guard removal, or unbounded application changes.

Expected repair scope remains only:
- `services/worker/scripts/plane3-writer-only.mjs`
- `services/worker/scripts/plane3-writer-only.test.js`

If broader changes are required, stop and re-scope.

## Preserved facts

- Approved TBK/Reboot whitelist: unchanged.
- Writer/Judge prompts/contracts/model routing/cost controls/persistence/evidence/scoring/provider/lifecycle/report/rendering/pass ceilings: unchanged.
- Focused harness test at reviewed candidate: 9/9 PASS, but insufficient for direct-execution identity behavior.
- Prior regressions remain green.
- Writer calls: 0.
- Judge calls: 0.
- Model/provider application calls: 0.
- Application changes during preflight: NONE.
- Push/deployment/production mutation/main merge: NONE.

## Exact next gate

Authorize a bounded two-file harness identity-contract repair. Implement a non-self-referential fail-closed distinction between semantic candidate/base identity and tooling HEAD, add deterministic coverage of the real `main()`/HEAD-derived path and bounded-overlay rejection cases, run focused and relevant regressions with zero model/provider calls, commit locally, and stop for another independent preflight before publication or Plane 3 execution.
