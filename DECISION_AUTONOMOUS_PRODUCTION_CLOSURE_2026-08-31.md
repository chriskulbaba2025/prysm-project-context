# Decision: Autonomous PRYSM Production Closure workflow

Date: 2026-08-31
Status: Active for Production Closure package

## Decision

Use the governed external Codex Builder/Auditor autorun loop for the current PRYSM Production Closure package.

For this package only, the user explicitly authorizes the autonomous Builder to:
- inspect and reconcile the current local dirty application state;
- create/recover `repair/prysm-production-closure` without discarding local work;
- directly edit application source/tests/contracts/scripts required by the closure roadmap;
- run deterministic local diagnostics/tests/gates;
- create coherent local commits;
- normally push the dedicated repair branch;
- update, commit, push, and verify PRYSM governance/project memory;
- continue across fresh Codex invocations until the repository-controlled roadmap is exhausted or a governed stop/block condition is reached.

Every application-changing tranche requires an independent Auditor pass at the same exact pushed application SHA before the next tranche may start.

## Reason

The prior manual one-file-at-a-time workflow was optimized for bounded report edits. New direct evidence shows the current defect class spans scoring producers, persisted contracts, read boundaries, duplicated report-model projections, Narrative Writer/Judge contracts, replay compatibility, false-PASS tests, CI coverage, and release controls.

Continuing with manual one-test/one-file repair cycles caused repeated downstream failures and false closure claims. A durable external controller with fresh-run recovery and independent tranche audits is a better match for the actual system boundary.

The pattern is adapted from the COMPAS2 VS Code Codex autorun system that used:
- an external PowerShell loop;
- `-MaxRuns 0` for unlimited fresh invocations;
- structured `CONTINUE / STOP / BLOCKED / COMPLETE` results;
- Git/GitHub durable state;
- exact-SHA whole-app gates;
- recovery-first execution;
- local/remote reconciliation;
- independent post-run auditing.

PRYSM adds automatic Builder -> Auditor -> Builder role switching per tranche.

## Implication

During this Production Closure package, this specific decision supersedes older manual-chat-only implementation mechanics where they conflict with autonomous execution.

The older evidence-integrity rules, repair-boundary rules, no-destructive-working-tree rules, no-guessing rules, diagnostic evidence requirements, Narrative quality gates, and authorization boundaries remain active.

The autonomous workflow does NOT by itself authorize:
- force push;
- merge of the repair branch to application `main`;
- deployment;
- Railway/Vercel/AWS production mutation;
- live/paid provider calls;
- live/paid Writer/Judge calls;
- starting a fresh production audit.

Those remain explicit user authorization boundaries unless a later durable decision changes them.

## Governing files

- `AUDIT_PRYSM_SYSTEMIC_PRODUCTION_CLOSURE_2026-08-31.md`
- `PRYSM_PRODUCTION_CLOSURE_ROADMAP_2026-08-31.md`
- `PRYSM_WHOLE_APP_TRANCHE_GATE.md`
- `PRYSM_POSTRUN_AUDIT_PROTOCOL.md`
- `PRYSM_AUTORUN_STATE.json`
- `PRYSM_POSTRUN_AUDIT_STATE.json`
- `tools/autorun/PRYSM-AUTORUN.ps1`
- `tools/autorun/PRYSM-BUILDER-AUTORUN-PROMPT.md`
- `tools/autorun/PRYSM-AUDITOR-AUTORUN-PROMPT.md`
