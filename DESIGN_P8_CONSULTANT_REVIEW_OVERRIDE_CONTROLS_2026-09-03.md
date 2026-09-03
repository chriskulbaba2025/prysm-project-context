# P8 Design — Consultant Review / Override Controls

Date: 2026-09-03  
Status: Design-only candidate; no application implementation authorized  
Application candidate inspected: `2e4f40d97a4a197e20948b26fb73c639ba913864`  
Production remains protected at: `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`

## Requirement preservation

### Requested future outcome

Provide a governed consultant review surface that can suppress an irrelevant client-facing signal, mark a URL utility/non-commercial, confirm or reject a competitor, elevate or deprioritize a recommendation, and add a professional note.

### Faithful interpretation

These are presentation/review decisions layered over an immutable evidence snapshot. They may change what is shown or ranked for the reviewed report version, but they must never rewrite, delete, or reinterpret canonical evidence, acquisition status, source provenance, or the underlying analytical observation.

### Explicit exclusions

No application code, schema, persistence migration, API, UI, report renderer, prompt/model behavior, scoring behavior, provider call, n8n workflow, deployment, production mutation, or merge is authorized by P8 in this package. P8 is not a justification for suppressing evidence during acquisition or for converting uncertainty into confirmed absence.

## Diagnostic/design evidence

| ID | Evidence | Finding |
|---|---|---|
| P8-D-01 | Work order §P8 and `CURRENT_STATE.md` | P8 is explicitly future capability and design-only unless separately authorized. |
| P8-D-02 | `services/worker/src/audit/review-gate.js` at application SHA above | Existing review records already support reviewer identity, timestamps, reasons, previous/replacement values, append-only overrides, review lifecycle, and approval references. |
| P8-D-03 | `services/worker/src/audit/review-gate.js` and `competitor-review.test.js` | Existing competitor decisions are bounded to known qualified candidates and produce auditable transitions; this is not evidence that URL utility, signal suppression, recommendation priority, or professional-note projection controls exist. |
| P8-D-04 | P7 independent audit `INDEPENDENT_AUDIT_P7_PERFORMANCE_TECHNICAL_CLIENT_LANGUAGE_CLEANUP_PASS_2026-09-03.md` | The current exact candidate is independently passed and has no open material defect requiring P8 implementation. |

Classification: `VERIFIED_DESIGN_GAP` for the future P8 capability contract; not a production defect.  
Repair attempts: `0`.  
Correction owner: future separately authorized product/API/persistence/UI tranche.

## Proposed future contract (not implemented)

### Override record

Every decision should be an append-only record containing: stable review/audit ID, immutable evidence snapshot ID/hash, target kind and stable target ID/path, operation, previous effective value, replacement value, reviewer identity, authorization/role result, reason or professional note, created timestamp, and supersession/reversal reference when applicable.

The effective presentation view is derived by replaying valid records against the frozen report snapshot. Canonical evidence and its hash remain byte-for-byte unchanged. A later reversal appends a new record; it does not edit history.

### Allowed operations

- `suppress_signal`: presentation only; requires a stable signal ID and reason.
- `classify_url`: `utility` or `commercial`; requires URL target, reason, and confirmation that canonical URL evidence is unchanged.
- `competitor_decision`: `confirmed` or `rejected`; requires a known candidate, reason, and preserved prior state.
- `recommendation_priority`: `elevate` or `deprioritize`; requires a stable recommendation ID and reason; must not bypass evidence/status gates or foundation-blocker ordering.
- `professional_note`: additive note attached to a stable target or report; must be clearly labeled as consultant-authored, not evidence.

Unknown targets, invalid transitions, missing reasons, stale snapshot IDs, duplicate active decisions, unauthorized roles, and attempts to change canonical evidence must fail closed with no persisted mutation.

### Separation of truth

The report should expose, where relevant, both the machine-derived observation and the consultant disposition. A suppressed signal remains discoverable in audit history. A consultant classification must not be rendered as provider-observed fact. Recommendation priority changes must preserve the original analytical priority and explain the consultant disposition.

### Lifecycle and replay

Overrides are accepted only for an existing immutable audit/report version, after authorization and optimistic concurrency checks. Persistence must validate on write and on reload. Report regeneration for the same evidence snapshot must deterministically replay the same valid override history. A new evidence snapshot must not silently inherit overrides unless an explicit, target-safe migration rule exists.

## Acceptance/Test Area Map for a future implementing tranche

| Area | Status | Required proof |
|---|---|---|
| Structure / contract | ACTIVE | Schema rejects unknown operations, unknown targets, stale snapshot, empty reason, invalid transition, and evidence mutation. |
| Persistence / recovery | ACTIVE | Append-only history survives write/reload; tampering, truncation, and hash mismatch fail closed. |
| Authorization / security | ACTIVE | Authorized consultant succeeds; missing/invalid identity and disallowed role produce no mutation. |
| Integration / real path | ACTIVE | UI/API → validation → persistence → validated reload → effective presentation projection. |
| Positive/negative acceptance | ACTIVE | Each five operation types has a positive path; each has an evidence-immutability negative path; reversal and no-op behavior are covered. |
| Branch coverage | ACTIVE for implementation | Inventory report versions, normal/Not-Assessed, partial/unavailable, competitor-qualified/excluded, and approval/re-review paths before coding. |
| Model / semantic robustness | N/A for this design | No prompts or model inputs are changed by this design. Reclassify if a later implementation changes Narrative inputs. |
| External call / cost | N/A | No provider or paid/live model calls are needed for deterministic control tests. |

## Surgical boundary for future authorization

Expected causal surface: review-control contract, validation/service boundary, append-only persistence, validated reload, effective presentation projection, authorization checks, and deterministic tests. Protected by default: canonical evidence acquisition, scoring semantics, provider policy, Writer/Judge prompts, Narrative semantics, n8n, deployment, and production data.

The future tranche must freeze a new Surgical Change Contract and branch matrix before editing. This design artifact is not permission to implement the controls.

## Design gate result

`PASS — design-only candidate ready for independent Auditor challenge`  
Whole-App gate: `NOT_APPLICABLE` (no application change; prior P7 exact-candidate PASS remains unchanged).  
Model-Bearing Release Gate: `N/A`.  
External/protected actions: none taken.
