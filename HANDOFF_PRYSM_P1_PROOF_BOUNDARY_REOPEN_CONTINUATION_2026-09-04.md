# PRYSM P1 — Proof Boundary Reopen Continuation Handoff

Date: 2026-09-04

## Authoritative repositories

Governance:
`chriskulbaba2025/prysm-project-context`

Application:
`chriskulbaba2025/vantage-platform`

GitHub is authoritative. Do not reconstruct current state from the prior chat.

## Active workstream

P1 — Cross-Report Contradiction Integrity

The P1 product repair itself was completed on:

- branch: `p1/bounded-build-cross-report-integrity`
- candidate SHA: `de509c30c808115f22fda3688a18dfaa85e9db50`

Existing deterministic proof:

- 77/77 PASS
- Viewer v2 render freeze matrix 48/48 PASS

Brad has NOT begun the final independent P1 OUTCOME_REVIEW.

## Current blocker

The semantic process gate correctly stopped before Brad review with:

`P1 PROOF BOUNDARY REOPEN REQUIRED`

Reason:

The frozen candidate has aggregate render-hash coverage and deterministic test results, but the existing render/test harness does not expose or persist the materialized HTML for each material P1 render-matrix scenario. The requested per-scenario HTML artifacts, exact hashes, provenance manifest, and scenario-to-obligation mapping cannot be produced from the existing frozen candidate without modifying the test/proof-export harness.

At the latest stop:

- no application source changed;
- no production/runtime behavior changed;
- no test changed;
- no new application candidate was created;
- no governance state was changed by that stopped attempt;
- both repositories were clean;
- the prior CRLF/LF issue was confirmed to be advisory conversion warnings only, not a dirty working tree.

## Chris decision

Chris authorizes the minimum P1 proof-boundary reopening required to make the existing product repair independently auditable.

Authorized scope only:

1. Modify the minimum test/proof-export infrastructure necessary to persist the exact rendered HTML for each material P1 scenario.
2. Produce a deterministic manifest containing scenario ID, artifact path, SHA-256, application SHA, renderer/test provenance, and P1 obligation(s) exercised.
3. Produce an explicit scenario-to-obligation coverage matrix.
4. Rerun the exact P1 deterministic tests and render matrix.
5. Prove production/runtime report semantics did not change.
6. Commit the bounded proof-harness change on the existing P1 application branch.
7. Record the new exact application SHA.
8. Refreeze the candidate and update governance proof bindings, `P1_EXECUTION_GATE.env`, and `CURRENT_STATE.md`.
9. Commit/push the governed proof package.
10. Rerun the canonical P1 process gate and continue until the legitimate Brad OUTCOME_REVIEW boundary.

Not authorized:

- production/runtime report changes;
- scoring changes;
- evidence acquisition changes;
- Writer/Judge behavior changes;
- Narrative semantic changes;
- unrelated refactors;
- provider/model calls;
- deployment;
- merge to application `main`;
- P2 work;
- destructive Git operations;
- force push/history rewrite.

Because a proof/test-harness change will create an application commit, `de509c30c808115f22fda3688a18dfaa85e9db50` is now the parent candidate, not the eventual final frozen SHA.

## Chris terminal contract — Windows

Use the normal VS Code PowerShell terminal.

Governance repo:

```powershell
cd C:\Users\kulba\Desktop\prysm-project-context
```

Resume the active Codex session autonomously:

```powershell
codex -p prysm-auto resume 01a06e4f-9bf0-71c0-8a83-f55b3332e5a4
```

Do routine governed work inside Codex.

Do NOT run the PRYSM launcher from inside an already-running Codex prompt.

When the governed P1 launcher itself must be run, return to the normal PowerShell prompt and run:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\prysm\start-prysm-p.ps1 P1
```

Do not manually patch PATH and do not nest Codex inside Codex.

## Brad terminal contract — macOS

Use the normal VS Code integrated Terminal.

From the governance repo:

```bash
bash tools/prysm/start-prysm-p.sh P1
```

The Bash launcher is canonical. The Windows PowerShell wrapper exists only for Windows shell/PATH mechanics and delegates to the same governed launcher.

## Autonomous execution rule

Chris does not want to babysit routine permission prompts.

Routine investigation, bounded authorized edits, tests, proof generation, Git status/diff/fetch, bounded commits/pushes, and governed gate reruns should continue without stopping Chris.

Stop only for a genuine decision/safety boundary, including:

- destructive Git operation;
- force push/history rewriting;
- secrets/authentication/security permission change;
- paid/provider/model execution;
- production deployment or application-main merge;
- production/runtime P1 semantic change;
- scope expansion beyond the authorized proof-export boundary;
- genuine security/data-loss risk;
- authoritative evidence that cannot be reconciled deterministically.

## Exact next action

From authoritative GitHub state, continue the existing Codex session with:

```powershell
cd C:\Users\kulba\Desktop\prysm-project-context
codex -p prysm-auto resume 01a06e4f-9bf0-71c0-8a83-f55b3332e5a4
```

Perform only the authorized minimum proof-export/test-harness change, generate the scenario-level rendered HTML/provenance proof, rerun deterministic verification, create the new candidate SHA, refreeze and update governance bindings, then rerun the canonical P1 gate.

Do not begin Brad OUTCOME_REVIEW until that gate passes.