# PRYSM Autonomous Production Closure Handoff

Date: 2026-08-31
Status: ACTIVE NEW-CHAT / CODEX HANDOFF

## Repository authority

Governance/project memory:
`chriskulbaba2025/prysm-project-context`

Application:
`chriskulbaba2025/vantage-platform`

GitHub governance is authoritative durable project memory. The exact local application working tree remains authoritative for known uncommitted governed repair work until T0 safely reconciles it.

## Verified remote application checkpoint

Remote application `main`:
`e7e8477819f8bff0a7e3f0c5969637df9fb787a3`

Commit:
`fix(prysm): close governed report integrity repairs`

Important:
- remote `main` is unprotected;
- required status checks are not enforced;
- `main` is therefore not sufficient release proof by itself.

## Local application state

Normal local application path:
`C:\Users\kulba\Desktop\vantage-platform`

Worker:
`C:\Users\kulba\Desktop\vantage-platform\services\worker`

The local application working tree is intentionally dirty with governed repair work from the prior interactive session.

Do not:
- reset hard;
- clean;
- checkout-overwrite;
- discard local changes;
- reconstruct local source from GitHub because remote main does not contain all current repairs.

T0 of the autonomous roadmap owns exact local recovery and safe branch establishment.

Intended repair branch:
`repair/prysm-production-closure`

Do not manually switch/reset before autorun. Builder must create/recover the branch without losing the current dirty tree.

## Why prior closure was reopened

A deep whole-system audit proved that the repeated `one more test` sequence was caused by a contract migration and proof-coverage design defect, not isolated bugs.

Do not redo that audit.

Read:
`AUDIT_PRYSM_SYSTEMIC_PRODUCTION_CLOSURE_2026-08-31.md`

It records SYS-01 through SYS-22, including:
- incomplete `npm test` coverage;
- CI omission of application production-path tests;
- WriterInput DecisionEvidence migration gaps;
- synthetic/empty fixtures that skipped hierarchy parity;
- Judge version/reference drift;
- `rootCauseRuleId` producer/persistence/consumer loss;
- incomplete/permissive ScoreSet contract;
- scores/findings current-read validation gaps;
- three independent current report-model reconstructions;
- semantic default/imputation risk;
- render-time hierarchy becoming canonical without persisted versioned authority;
- historical/current replay and WriterInput version collisions;
- ReportContent uncertainty/status mutation risk;
- stale authoritative memory;
- weak exact-head release controls.

Historical PF/CF/CONTRACT-CLOSURE PASS records remain evidence for the exact boundaries they proved, but no longer establish current whole-system release readiness where the systemic audit produced contradictory direct evidence.

## Known local repair checkpoint - preserve

Before the autonomous closure run, the interactive session already repaired locally:

1. Narrative production WriterInput receives `decisionEvidence` at both applicable production calls.
2. Application Narrative production test Writer fixture derives governed action finding/rank/effort/references rather than hardcoding stale values.
3. Application Narrative production test Judge fixture uses current Judge prompt/version and required `analysis:conversionInfluence` grounding.
4. ScoreSet local projection carries `rootCauseRuleId`.
5. Base orchestration projection locally carries `rootCauseRuleId`.
6. Narrative v2 current model projection locally carries `rootCauseRuleId`.

Do not revert these merely because remote main lacks them.

Focused proof already obtained:
- `NV2-PROD-02`: 1/1 PASS after full local root-cause identity propagation.
- `NV2-PROD-06`: 1/1 PASS for invalid persisted terminal Narrative state fail-closed/no-extra-spend behavior.
- `npm test`: 959/959 PASS, 0 fail, but explicitly NOT accepted as full release proof.

The exact local diff must still be inspected directly in T0; this handoff is not a substitute for local source truth.

## New governing autonomous system

Read in this order:

1. `PROJECT.md`
2. `GITHUB_PROJECT_MEMORY_PROTOCOL.md`
3. `CURRENT_STATE.md`
4. `CONSTRAINTS.md`
5. `DECISIONS.md`
6. `DECISION_AUTONOMOUS_PRODUCTION_CLOSURE_2026-08-31.md`
7. `AUDIT_PRYSM_SYSTEMIC_PRODUCTION_CLOSURE_2026-08-31.md`
8. `PRYSM_PRODUCTION_CLOSURE_ROADMAP_2026-08-31.md`
9. `PRYSM_WHOLE_APP_TRANCHE_GATE.md`
10. `PRYSM_POSTRUN_AUDIT_PROTOCOL.md`
11. `PRYSM_AUTORUN_STATE.json`
12. `PRYSM_POSTRUN_AUDIT_STATE.json`
13. `tools/autorun/README.md`

The roadmap is T0-T7:
- T0 exact local recovery + dependency/proof map freeze;
- T1 persisted versioned Conversion-First hierarchy/ScoreSet closure;
- T2 one canonical current report-model hydration boundary;
- T3 WriterInput/Writer/Judge current-contract migration;
- T4 replay/ReportContent/semantic-coherence closure;
- T5 false-PASS elimination + one composite machine gate + CI coverage;
- T6 deterministic full current V2 production spine;
- T7 independent final audit/release controls/readiness state.

Every application-changing tranche requires:
`Builder -> exact-SHA Whole-App Gate -> applicable composite verification -> commit/push/sync -> independent Auditor -> PASS -> next tranche`

Auditor has no application-write authority.

Audit FAIL returns the same tranche to Builder automatically.

Maximum three evidence-based repair attempts against the same root defect. The controller must not thrash.

## COMPAS2 autorun pattern ported

This PRYSM system intentionally ports the proven VS Code pattern used for COMPAS2:
- external PowerShell controller;
- each Codex invocation is fresh;
- structured `CONTINUE / STOP / BLOCKED / COMPLETE` response;
- `-MaxRuns 0` means unlimited controller iterations;
- Git/GitHub state is durable between invocations;
- recovery first on every run;
- per-run logs outside repositories;
- Windows `codex.cmd` shim rather than the failed `codex.ps1` piping path;
- `danger-full-access` only because governed Windows Git metadata writes require it, with authority constrained by the prompts;
- path locks prevent concurrent controller use of the same app/governance worktrees;
- automatic Windows notification at terminal states.

PRYSM adds automatic Builder/Auditor role switching.

## Autonomous authorization boundary

For this Production Closure package, the user has authorized autonomous:
- local diagnosis;
- application edits required by T0-T7;
- deterministic tests/gates;
- local commits;
- normal fast-forward pushes to `repair/prysm-production-closure`;
- governance/project-memory updates, commits, pushes, and verification.

This authorization does NOT by itself permit:
- application merge to `main`;
- repair commits directly to application `main`;
- force push;
- deployment;
- Railway/Vercel/AWS production mutation;
- live/paid provider calls;
- live/paid Writer/Judge calls;
- starting a fresh production audit.

Unless a later explicit durable authorization expands that boundary, expected unattended terminal checkpoint is:
`READY_FOR_AUTHORIZED_PRODUCTION_PROMOTION`

That means the repository-controlled repair is independently gated and ready for the owner to authorize merge/deploy/fresh audit. It does not mean production was silently mutated.

## Launch from VS Code / PowerShell

Use a local clone of the governance repository. Do not copy the controller manually from chat if the GitHub file is available.

If governance is not cloned:

```powershell
git clone https://github.com/chriskulbaba2025/prysm-project-context.git
cd prysm-project-context
```

If already cloned:

```powershell
cd <local-prysm-project-context-path>
git pull --ff-only
```

Do not blindly pull/reset the application repository before T0.

### Preflight

```powershell
$App = "C:\Users\kulba\Desktop\vantage-platform"
$Gov = (Get-Location).Path

.\tools\autorun\PRYSM-AUTORUN.ps1 `
  -AppRepo $App `
  -GovernanceRepo $Gov `
  -StartRole Builder `
  -PreflightOnly
```

Do not start the loop unless the final line is:
`PREFLIGHT PASS`

Dirty application status at initial preflight is expected and must not be cleaned away.

### Unlimited autonomous run

```powershell
.\tools\autorun\PRYSM-AUTORUN.ps1 `
  -AppRepo $App `
  -GovernanceRepo $Gov `
  -StartRole Builder `
  -MaxRuns 0
```

Leave the terminal open. The controller automatically starts fresh Codex runs and switches Builder/Auditor roles until STOP, BLOCKED, COMPLETE, Ctrl+C, or controller failure.

## Exact next action

Pull the latest `prysm-project-context` governance state locally, run PRYSM autorun preflight against the existing dirty `C:\Users\kulba\Desktop\vantage-platform`, and if the final line is `PREFLIGHT PASS`, start the same controller with `-MaxRuns 0`.

Do not manually edit, replay, reset, or run another ad hoc test first.
