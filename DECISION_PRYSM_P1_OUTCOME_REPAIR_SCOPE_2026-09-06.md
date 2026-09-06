# Decision — PRYSM P1 Outcome Repair Scope

Date: 2026-09-06
Status: ACTIVE

## Decision

The next P1 repair package is outcome-first and is **not artificially limited to report-page styling or the current report-only implementation boundary**.

The repair must do whatever is structurally necessary to eliminate the confirmed P1 outcome failures, while preserving evidence truth and existing production safety gates.

An external n8n flow is explicitly permitted if the repair design shows that it improves orchestration, client-language generation, Writer/Judge separation, contradiction checking, replayability, or auditability.

n8n is optional, not mandatory. It must not become the authoritative evidence store or bypass deterministic governance.

## Reason

Brad's completed P1 review found seven material roots and confirmed that the dominant defect class is not broad evidence acquisition failure. PRYSM often preserves evidence states correctly, then weakens integrity when those states are classified, interpreted, summarized, prioritized, or projected into client-facing language.

Local wording patches are unlikely to eliminate this repeat failure class.

## Required repair-design principles

1. Solve the seven confirmed material roots as a system, not as isolated page edits.
2. Establish one authoritative evidence-to-client interpretation boundary or equivalent architecture so repeated report surfaces cannot independently reinterpret the same evidence into contradictory states.
3. Preserve canonical evidence and provenance as the source of truth.
4. Prefer client-facing business meaning over internal audit terminology.
5. Enforce fail-closed behavior globally: unavailable/partial/failed evidence must not become reassurance, PASS, absence, or `NOT APPLICABLE` without evidence supporting that state.
6. Preserve assessed absence vs unavailable evidence.
7. Preserve conversion mechanism vs conversion-path quality.
8. Preserve lab performance vs real-user performance.
9. Protect recommendation integrity; incomplete/generated placeholder output must never reach the client.
10. Keep priority logic understandable in business terms.
11. Separate normal client presentation from raw technical provenance where useful.
12. Use n8n where it helps, but keep deterministic validation and replayable evidence boundaries.

## Scope permission

The repair-design phase may consider changes across:

- deterministic interpretation/classification logic;
- report projection and summary logic;
- recommendation generation/qualification;
- Writer input/prompt/output contracts;
- Judge/contradiction checks;
- report rendering/client-language surfaces;
- n8n orchestration;
- client-vs-technical evidence presentation architecture;
- deterministic cross-report validation.

This decision does **not** pre-authorize implementation edits in all of those areas. The next chat must first produce a governed repair design, dependency map, expected file/test boundary, and verification plan.

## Evidence/scoring safeguard

Do not reopen evidence acquisition, provider/adaptor behavior, canonical evidence plumbing, or scoring simply because the report is wrong.

If repair analysis proves an evidence or scoring defect, that change may be proposed, but only after direct evidence and dependency-impact analysis under the existing diagnostic/data-governance protocols.

## Production safeguards remain active

This decision does not authorize:

- paid/live provider or model calls;
- production deployment;
- merge to application `main`;
- starting P2;
- Betty Final Audit before a repaired candidate is ready;
- destructive reset/cleanup of user work;
- bypassing Whole-App, model-bearing, or other applicable release gates.

## Implication

The next governed action is **P1 repair design**, not another report review and not immediate coding.

The design should explicitly decide whether the best implementation is:

- a central deterministic client-fact/qualification layer;
- a revised Writer/Judge path;
- an n8n-orchestrated language/validation flow;
- a combination of these;
- or another evidence-backed architecture that closes all seven roots more cleanly.

The chosen architecture must be judged by whether it prevents recurrence across the whole report, not by whether it is the smallest local patch.
