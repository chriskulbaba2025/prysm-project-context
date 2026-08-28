# PRYSM Handoff — CF-01 Browser Review Repair

Date: 2026-08-28
Status: Active handoff

## Repository authority

Context repository:
`chriskulbaba2025/prysm-project-context`

Application repository:
`chriskulbaba2025/vantage-platform`

Application branch:
`main`

Latest remote application checkpoint:
`90916e94f6feba73e7e60df54bd641bb2362454c`
`test(prysm): repair CI regression baselines`

No CF-01 application commit/push has been authorized or performed. The current application working tree contains local/uncommitted CF-01 edits and must be verified before further work.

## Read first

Read the authoritative files before substantive work:

```text
PROJECT.md
GITHUB_PROJECT_MEMORY_PROTOCOL.md
REPAIR_BOUNDARY_PROTOCOL.md
DIAGNOSTIC_EVIDENCE_PROTOCOL.md
WORKFLOW_INSTRUCTIONS.md
TERMINOLOGY.md
CURRENT_STATE.md
CONSTRAINTS.md
DECISIONS.md
CONVERSION_FIRST_V4_2.md
HANDOFF_CF01_BROWSER_REVIEW_REPAIR_2026-08-28.md
```

Treat GitHub as authoritative. Do not reconstruct state from older chats.

## Frozen audit / report baseline

TBK audit:
`9714c206-8ed3-4686-8fe2-ceeca0ca0f82`

Target:
`https://www.tbkcreative.com/`

Verified metrics:
- Conversion Readiness: 65/100
- Evidence Confidence: 95/100
- Evidence Coverage: 100%
- 12/13 evidence capabilities
- 10/10 modules assessed
- Conversion Path: 100/100
- Performance & Experience: 71/100
- Browser conversion validation: 6/6 selected pages
- Persisted Narrative v2 final Judge: pass 3, score 97, PASS

Frozen governed fixture:
`C:\Users\kulba\Desktop\vantage-platform\services\worker\test-fixtures\report-replay\audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82\governed`

Permanent local report path:
`C:\Users\kulba\Desktop\vantage-platform\services\worker\test-fixtures\report-replay\audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82\TBK-PRYSM-LOCAL.html`

## CF-01 work already completed locally

The mapped CF-01 implementation was applied locally across:

```text
services/worker/src/report/action-priority.js
services/worker/src/report/foundation-readiness.js
services/worker/src/scoring/report-model.js
services/worker/src/report/render-report-v2.js
services/worker/src/narrative-v2/writer-input.js
services/worker/src/narrative-v2/writer-prompt.js
services/worker/src/narrative-v2/judge-contract.js
services/worker/src/narrative-v2/contract-closure.test.js
services/worker/src/report/render-report-v2-conversion.test.js
```

Verified implementation results before visual review:
- foundation uses governed browser conversion evidence — PASS
- report-model conversion + competitor projection — PASS
- Executive consumers share derived action hierarchy — PASS
- Writer receives derived hierarchy without mutating findings — PASS
- Writer prompt contains Conversion-First v4.2 hierarchy — PASS
- Judge requires governed hierarchy grounding — PASS
- Judge closure tests — PASS
- CR-43 render golden re-freeze — PASS
- final selected regression suite: 72/72 PASS, 0 fail, 520.8619 ms
- offline TBK replay: 1/1 PASS, Viewer 2.2.0, 4 findings, baseline DIFF, replay SHA prefix `b1cdbe026a3e`
- `git diff --check`: clean

These results are **not acceptance of CF-01 completion**.

## Why completion was reopened

The browser-rendered TBK report exposed real client-facing contradictions that the automated tests did not catch.

### Defect 1 — technical-first Executive/action hierarchy persists

The rendered report still shows:
- Primary root cause: `Missing meta descriptions`
- Executive first action: `Missing meta descriptions`
- Section E priority 1: `VAN-TECH-001 — Missing meta descriptions`
- Client Action Plan first item: the same technical hygiene issue

At the same time, the report shows:
- Conversion Path: 100/100
- Trust & Proof: 75/100
- buyer-question content opportunity exists

The temporary CR-04 compatibility repair added a confidence tier in `action-priority.js` that places deterministic/strongly-supported findings ahead of supported findings before conversion influence is compared. This makes deterministic technical hygiene outrank supported conversion/content business-impact work and therefore conflicts with the intended Conversion-First v4.2 hierarchy.

Do not preserve that temporary confidence-first behavior merely because the old CR-04 test expected it.

Target behavior:
- evidence confidence remains a gate;
- directional/insufficient evidence cannot become the client lead;
- supported evidence remains eligible to lead when it belongs to a stronger conversion/business-impact class than deterministic technical hygiene;
- proven foundation blockers retain the explicit governed override;
- numeric priority only orders within comparable business-impact class.

### Defect 2 — competitor noise persists

The browser report renders a very large list of SERP/candidate URLs as `Insufficient Evidence` and then creates huge comparative tables/columns for them.

Only a small number of competitors have usable assessed evidence (for TBK, RedRhino and ZOO Media Group are the obvious assessed comparison rows in the rendered output).

Client-facing competitor rendering must suppress unqualified/insufficient-evidence candidate noise rather than exposing dozens of unusable comparison columns. Preserve evidence truth/status in the model; change the client projection/rendering so insufficient-evidence candidates cannot dominate the comparison.

### Defect 3 — audited-site comparative conversion state is inconsistent

Main report:
- Conversion Path 100/100
- browser conversion validation 6/6
- primary conversion path Clear / PASS

Competitor comparative overview:
- `This site` Buyer action clarity = `Not Assessed`
- `This site` Conversion path = `Not Assessed`

The audited-site comparison projection is therefore not consuming the same governed conversion state as the main report.

Repair this cross-view inconsistency without inventing competitor evidence or changing scoring.

### Narrative caveat — persisted narrative is stale for CF-01 prompt validation

The offline replay reused the already-persisted Narrative v2 Writer/Judge artifacts from the frozen audit. Those narrative sections still describe meta descriptions/search messaging as the root cause.

That does **not** prove the new Writer prompt/input/Judge hierarchy failed or passed because no new Writer/Judge generation occurred.

Do not call Writer/Judge/models merely to refresh the test report. First make the deterministic/browser-rendered report internally consistent. Fresh narrative generation requires separate explicit approval.

## Hard boundaries

Do not change:
- evidence collection
- provider/adaptor behavior
- raw/normalized/canonical evidence semantics
- scoring weights or scoring version
- lifecycle/state transitions
- storage
- auth
- n8n
- production configuration
- provider/model execution
- audit orchestration
- provider crawl ceiling 250
- priority URL ceiling 20
- production content parsing default 50
- Viewer v2.2.0
- evidence status semantics

Do not mutate persisted FindingSet. Conversion influence/order remains a derived client-facing decision view.

Do not run a production audit.
Do not call paid providers/models.
Do not push/commit application changes until the corrected report passes browser review and the user authorizes repository action.

Same observable defect: maximum three failed repair attempts before deeper diagnosis.

## Mandatory local test-report workflow

For visual report review, do **not** tell the user to open the `.html` file directly and do not hand back a raw text/HTML viewing path.

Serve the report directory using Python, for example:

```powershell
python -m http.server 8080 --directory "C:\Users\kulba\Desktop\vantage-platform\services\worker\test-fixtures\report-replay\audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82"
```

Then review in the browser at:

```text
http://localhost:8080/TBK-PRYSM-LOCAL.html
```

Browser-rendered review is an acceptance gate. Automated test/replay PASS alone is insufficient for report hierarchy and interpretation changes.

## Exact next action

Before editing:

```powershell
cd C:\Users\kulba\Desktop\vantage-platform
git status --short
git rev-parse HEAD
```

Do not discard or overwrite current local CF-01 work.

Then inspect the **current local** versions of:

```text
C:\Users\kulba\Desktop\vantage-platform\services\worker\src\report\action-priority.js
C:\Users\kulba\Desktop\vantage-platform\services\worker\src\report\render-report-v2-conversion.test.js
```

First repair the action-ranking contract so `SUPPORTED` conversion-leading/business-impact findings can outrank deterministic technical hygiene under Conversion-First v4.2, while `DIRECTIONAL`/insufficient evidence cannot lead and proven foundation blockers still override.

Use the governed manual workflow:
- exact full path;
- exact lines/anchors;
- multiple edits bottom-up;
- one proving check;
- stop for result.

After that is green, repair competitor-noise rendering and audited-site comparative conversion state one source-file unit at a time. Then regenerate the offline TBK report, serve it with Python, and review it in the browser before any commit/push.
