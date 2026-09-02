# P0 Diagnostic Evidence — Deep-content/page-selection trace

**GCU protocol:** 2.4.0  
**Change ID:** `P0_DEEP_CONTENT_PAGE_SELECTION_TRACE`  
**Candidate/base SHA:** `acfc5c1393261bb7733837289bc3adc1062e64d5` / `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`  
**Owner:** PRYSM unattended report-improvement work order

## Protected outcome

Determine whether a report's content-dependent reasoning received the intended commercial/representative page sample, while preserving page identity from selection through body acquisition and its direct analysis consumers.

## Observed condition

The controlled TBK evidence artifact for audit `97d6b2c7-03b9-4530-8ea7-16557502c638` retains five content-parsing URL observations but no selection/reason/class/request-to-response ledger. Its canonical artifact therefore cannot prove why those URLs, rather than another eligible commercial or representative page, were selected. This is a provenance design gap, not proof that the historical selection was wrong.

## Executing boundary

`crawlWithDataforseo` in `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js` normalizes crawled pages, invokes deterministic `selectImportantPages`, merges must-have and material-family representatives with `mergeDeepPageUrls`, requests the bounded `cpUrls` set, normalizes results by URL, then supplies `contentParsing` plus its acquisition ledger to `analyzeProgrammaticSeo`. `content.body` capability consumers and report consumers receive the resulting aggregate evidence, not an invented per-page result.

## Evidence

| Evidence ID | Source/artifact | Exact identity | What it proves |
|---|---|---|---|
| P0-D01 | Frozen TBK canonical evidence fixture | audit `97d6b2c7-03b9-4530-8ea7-16557502c638`, raw On-Page artifact SHA-256 `edd1be0ca0815d42325a76f15254a01fe7e62861f663222349e8dd4ff5eecf75` | Five requested content-parsing observations exist (`/`, `/about`, `/services`, `/home`, `/insights`), but their historical selection rationale/class and request-to-body trace are absent. Each retained body observation is empty; this is unavailable content, not a negative content finding. |
| P0-D02 | Exact candidate code path | application SHA `acfc5c1` | Selection is deterministic; URL-scoped deep acquisition uses the merged governed set; failed, empty-returned, and unassessed states remain distinct. |
| P0-D03 | Deterministic direct proof | `dataforseo-onpage-representative-evidence.test.js`, `important-page-selector.test.js`, `programmatic-seo-analysis.test.js` | 19/19 PASS. Proves role/must-have selection, request budgeting, trace retention, and non-substitution behavior on the candidate. |
| P0-D04 | Exact-candidate assembled proof | `npm run verify:prysm-whole-app` at `acfc5c1` | PASS: 87/87, P-B01–P-B15 covered, no live provider/model calls. |

## P0 acceptance trace

Historical TBK rows (selection reason and page class are deliberately `NOT_RECORDED` rather than reconstructed):

| Selected URL | Selection reason | Page class | Body requested | Body returned/status | Downstream modules |
|---|---|---|---|---|---|
| `https://rebootbusinesscoaching.com/` | `NOT_RECORDED` | `NOT_RECORDED` | yes | `EMPTY_RETURNED` (historical body text empty) | `content.body` capability; `programmaticSeo` aggregate |
| `https://rebootbusinesscoaching.com/about` | `NOT_RECORDED` | `NOT_RECORDED` | yes | `EMPTY_RETURNED` | `content.body`; `programmaticSeo` |
| `https://rebootbusinesscoaching.com/services` | `NOT_RECORDED` | `NOT_RECORDED` | yes | `EMPTY_RETURNED` | `content.body`; `programmaticSeo` |
| `https://rebootbusinesscoaching.com/home` | `NOT_RECORDED` | `NOT_RECORDED` | yes | `EMPTY_RETURNED` | `content.body`; `programmaticSeo` |
| `https://rebootbusinesscoaching.com/insights` | `NOT_RECORDED` | `NOT_RECORDED` | yes | `EMPTY_RETURNED` | `content.body`; `programmaticSeo` |

The candidate adds the forward trace contract for every selected URL: `url`, `selectionReason`, `pageClass`, `bodyRequested`, `bodyReturned`, `bodyStatus`, and `downstreamModules`. The deterministic proof includes must-have commercial roles, an unassessed budget-overflow sibling, and URL-keyed returned-body status.

## Facts versus unresolved questions

### Observed facts

- Utility/error URLs are excluded from important-page selection by its successful-response gate; commercial roles do not take editorial URLs.
- The historical TBK fixture cannot establish a selection defect because it lacks the original selection ledger.
- Current pre-candidate behavior did not preserve sufficient provenance to make that determination on a future controlled run.
- The candidate does not alter selection priority, report copy, prompt/model behavior, provider calls, or historical evidence.

### Unresolved

- No new paid/live provider call is authorized; therefore no fresh TBK acquisition is available to populate the new trace for that historical audit.

## Highest-information diagnostic

Read the frozen canonical/raw TBK evidence together with the exact candidate selection/acquisition path, then execute the targeted deterministic adapter/selector/analysis tests. This directly distinguishes a missing provenance contract from an unsupported claim that historical selection was incorrect.

## Cause classification

`VERIFIED_DESIGN_GAP`

The missing persisted trace prevented verification of selection rationale, page class, body-request alignment, and returned/unavailable status for the controlled audit.

## Ownership

Application On-Page adapter acquisition ledger and its deterministic regression boundary.

## Repair-attempt accounting

Same-root evidence-based repair attempts before this checkpoint: `1`.

## Gate result

`PASS`
