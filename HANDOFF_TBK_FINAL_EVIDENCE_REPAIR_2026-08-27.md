# PRYSM Handoff — TBK Final Evidence Repair

Date: 2026-08-27

## Start Here

Treat `chriskulbaba2025/prysm-project-context` as authoritative project memory.

Read first:
- `PROJECT.md`
- `GITHUB_PROJECT_MEMORY_PROTOCOL.md`
- `REPAIR_BOUNDARY_PROTOCOL.md`
- `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`
- `WORKFLOW_INSTRUCTIONS.md`
- `TERMINOLOGY.md`
- `CURRENT_STATE.md`
- `CONSTRAINTS.md`
- `DECISIONS.md`
- `EFFICIENCY_METRICS.md`

Do not reconstruct state from previous chat history.

## Application Baseline

Repository: `chriskulbaba2025/vantage-platform`
Branch: `main`
Current GitHub checkpoint used for this investigation: `43188fd6700c1ca95cec4ae55a93144819ffa51e`
Message: `fix(prysm): prioritize conversion impact and clean report URLs`

Before substantive work run:

```powershell
cd C:\Users\kulba\Desktop\vantage-platform
git status --short
git rev-parse HEAD
```

If the local tree or SHA differs, diagnose the state first. Do not discard or overwrite unrelated work.

## Current Production Audit

Site: `https://www.tbkcreative.com/`
Audit: `dcaee3bd-c38b-4443-9563-eead4a5f3685`

Current production result:
- 250 structural pages returned.
- 37/37 selected deep-content pages completed.
- 8/13 capabilities assessed.
- 8/10 modules assessed.
- 76% assessed scoring weight.
- 95/100 evidence confidence.
- Conversion Readiness score: 58.
- Readiness: Provisional.

This is a major improvement over the earlier failed state and proves the timeout and representative deep-content repairs materially worked.

## Before / After Evidence Progress

Initial failed audit `ca8a1171-0d57-4eda-910e-3efe54967af8`:
- 45/100 confidence.
- 10% evidence coverage.
- 1/13 capabilities.
- 0/10 modules.
- No useful overall score.

Post-timeout audit `f1b85910-039e-4fcb-b164-8b1bb3417609`:
- 250 pages crawled.
- 20/20 deep pages.
- 5/13 capabilities.
- 4/10 modules.
- 30% assessed weight.
- 96/100 evidence confidence.
- Still insufficient evidence for overall score.

Current audit `dcaee3bd-c38b-4443-9563-eead4a5f3685`:
- 250 pages crawled.
- 37/37 deep pages.
- 8/13 capabilities.
- 8/10 modules.
- 76% assessed weight.
- 95/100 evidence confidence.
- Score 58 / Provisional.

Do not reopen the timeout or representative deep-content repairs unless new direct evidence contradicts these production results.

## Remaining Suppressed Modules

### 1. Conversion Paths

Suppression reason:
- `conversion.cta` UNAVAILABLE.
- `conversion.form` UNAVAILABLE.

Current `conversion.path` capability:
- status: UNAVAILABLE.
- kind: inferred.
- validated: false.
- limitation includes: `Browser validation not enabled for this run`.

### Proven root cause — production browser flag is lost

The persisted current AuditRequest was inspected directly:

```text
HasCrawlProperty : False
CrawlIsNull      : True
CrawlJson        : <null>
```

The real production path uses `services/worker/src/application/production-runtime.js`, which has its own `createAudit()` implementation. It only adds `auditRequest.crawl` when incoming UI input already contains a crawl object.

The orchestrator only permits the real browser when:

```js
auditRequest.crawl?.pathValidationLiveBrowser === true
```

Therefore a normal UI request with no crawl override reaches the validator as `allowLiveBrowser: false`, which produces the exact observed message: `Browser validation not enabled for this run`.

`audit-service.js` contains the intended production default logic, but the actual `production-runtime.js` request builder does not currently mirror it.

Playwright/Chromium installation is not the diagnosed defect: the worker Dockerfile installs Chromium through Playwright.

### Second conversion defect — evidence bridge

Enabling Playwright alone is not enough.

The validator can observe CTA visibility/interactability, forms, destination loading, mobile behavior, and obstruction. Current capability derivation upgrades `conversion.path` from path validation but does not correspondingly bridge actual browser observations into `conversion.cta` and `conversion.form`.

The `conversion_paths` scoring module is gated by `conversion.cta` + `conversion.form`.

Therefore the repair must ensure actual browser observations can support CTA/form/path capabilities without converting unknown evidence into false absence.

Browser failure remains NOT_ASSESSED and non-penalizing.

### 2. Risk Reduction

Suppression reason:
- `technical.headers` UNAVAILABLE.

DataForSEO On-Page does not provide the required response-header evidence in the current production path.

Do not remove the evidence gate and do not treat unknown headers as absent or healthy.

The repair must collect genuine response headers through a bounded, read-only path, preferably during the governed browser/HTTP observation, and populate `technical.headers` only from collected evidence.

## Approved Repair Order

### Repair 1 — Production browser activation

Primary file:

`C:\Users\kulba\Desktop\vantage-platform\services\worker\src\application\production-runtime.js`

Required behavior:
- normal production audit: browser validation ON;
- explicit `pathValidationLiveBrowser: false`: preserved;
- `PRYSM_DISABLE_LIVE_BROWSER`: forces OFF;
- unrelated crawl settings survive.

Use one focused production-shaped test proving the real runtime request boundary, not only `audit-service.js`.

Once it passes, move on. Do not stack redundant checks.

### Repair 2 — Browser evidence bridge

Likely boundaries:
- `services/worker/src/evidence/capability-evidence.js`
- scoring only if the evidence contract proves it is still required after capability repair.

Required behavior:
- browser-observed CTA evidence can support `conversion.cta`;
- browser-observed form evidence can support `conversion.form`;
- browser path observations support `conversion.path`;
- only genuinely assessed observations are score-bearing;
- unknown remains unknown;
- NOT_ASSESSED never lowers the score.

Use one focused behavioral proof that browser evidence makes Conversion Paths legitimately assessable.

### Repair 3 — Real response-header evidence

Collect genuine response headers through a bounded, read-only observation path.

Existing security-header evidence includes checks such as:
- Content-Security-Policy
- X-Frame-Options
- X-Content-Type-Options
- Referrer-Policy

Populate `technical.headers` only from actually collected response-header evidence.

Use one focused behavioral proof that genuine header evidence makes Risk Reduction legitimately assessable.

## Verification Rule

Default rule: one check that directly proves the change, then move on.

Do not automatically stack:
- syntax check;
- focused test;
- regression suite;
- diff check;
- repeated inspection.

Choose the highest-information proof. Add a second check only when a separate material risk cannot be proven by the first.

Maximum three failed solve/verify attempts on the same observable defect before a deeper diagnostic reset.

## Editing Method

User applies application source edits manually unless explicitly changing workflow.

For every manual edit provide:
- exact Windows path first;
- exact current line range;
- anchor text;
- complete replacement block;
- if multiple edits are in one file, present them bottom-up, highest line number first.

For small files, whole-file replacement is acceptable when safer.

Do not ask the user to recover code from earlier chat messages.

## Commit / Deploy Strategy

After all three repairs have individually passed their focused proof:

1. inspect intended working-tree changes;
2. create one coherent commit when practical;
3. push once;
4. deploy once;
5. run one final paid TBK audit only after the complete repair is live.

Do not spend paid production audits testing partial fixes.

Suggested commit message:

```text
fix(prysm): complete production evidence coverage
```

## Final Production Success Criteria

Target architecture:

`250 structural pages → up to 50 representative deep-content pages → up to 6 browser-validated conversion pages → real response-header evidence → governed capabilities → scoring → findings → report`

Final TBK proof should establish:
- browser validation actually ran;
- CTA/form/path capabilities are backed by real browser observations where assessed;
- Conversion Paths is not incorrectly suppressed;
- genuine response-header evidence exists;
- `technical.headers` is supported only by real header evidence;
- Risk Reduction is not incorrectly suppressed when evidence exists;
- unknown evidence stays unknown;
- governance is not weakened.

The goal is not forced 10/10 coverage. The goal is correct assessment of every module for which sufficient evidence can actually be obtained.

## n8n Boundary

n8n is not part of the active core PRYSM audit engine for this repair.

Keep the core path code-driven and directly testable:

`collect → normalize → validate evidence → derive capabilities → score → generate report → persist`

Do not introduce n8n into browser validation, evidence acquisition, scoring, governance, or report generation.

n8n may be useful later as an optional outer automation/integration layer for:
- CRM/intake-triggered audits;
- scheduled audits;
- completion notifications;
- report distribution;
- follow-up task creation;
- external-system synchronization.

Long-term boundary:
- PRYSM = governed product engine.
- n8n = optional workflow/integration layer around it.

## Exact First Action in New Chat

Run:

```powershell
cd C:\Users\kulba\Desktop\vantage-platform
git status --short
git rev-parse HEAD
```

Then compare the current local state to the authoritative GitHub/context checkpoint before editing anything.
