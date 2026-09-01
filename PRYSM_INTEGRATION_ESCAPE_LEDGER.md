# PRYSM Integration Escape Ledger

Status: ACTIVE / APPEND-ONLY
Effective: 2026-08-31

## Purpose

Track material defects that escaped the deterministic verification surface and were discovered later in UAT/live/production so PRYSM can measure whether assembled-system verification is improving.

This ledger measures the development process. It does not weaken product acceptance criteria.

## Definitions

**Integration escape** — a material defect missed by targeted/component proof but caught by deterministic Whole-App verification or independent audit before production promotion.

**Post-freeze / production escape** — a material repository-controlled defect discovered after a governed candidate had already been reported PASS/frozen/promoted and that should reasonably have been caught by deterministic assembled-system verification.

**Branch coverage escape** — a post-freeze/production escape whose defect class existed because a materially distinct production branch was not represented or not asserted at the required handoff in the Whole-App Branch Matrix.

## Targets

- branch coverage escapes: downward trend toward **0**;
- post-freeze material escapes attributable to known deterministic verification gaps: **0**;
- every branch coverage escape receives a permanent matrix row/regression before the next dependent release.

Never convert unknown counts to zero.

## Current escape record

| Escape ID | Date | Discovery boundary | Root defect | Class | Deterministic verification gap | Permanent correction |
|---|---|---|---|---|---|---|
| PDV1 | 2026-08-31 | live production Narrative | Writer semantic validator rejected prompt-compliant bounded AI-search negation | post-freeze / branch coverage escape | prompt-authorized bounded-negation wording was not paired against the deterministic semantic validator in assembled production-shaped proof | permanent Writer bounded-negation regression + P-B matrix retention |
| PDV2 | 2026-08-31 | live production Judge pass 2 | strict provider Judge schema allowed `defects[].section` values later rejected by deterministic Judge validator | post-freeze / branch coverage escape | provider structured-output contract and deterministic Judge contract were not asserted as one handoff branch | permanent strict `WRITER_SECTION_FIELDS` regression + P-B matrix retention |
| PDV3 | 2026-08-31 | live production governed scoring | Not-Assessed model omitted current required `decisionHierarchy` | post-freeze / branch coverage escape | non-viable/Not-Assessed scoring producer was not exercised against current ScoreSet persistence/reload contract | P-B03 + permanent Not-Assessed assembled-system scoring regression required |

## Recording rule

Append one row for every future material escape. Record:

- exact discovery boundary;
- root defect ID;
- whether targeted, Whole-App, audit, UAT, staging, or production found it;
- which materially distinct branch/handoff was missing or weak;
- permanent regression/matrix correction;
- whether the defect was discovered before or after production promotion.

Do not delete historical escapes after repair. The objective is a falling escape rate, not a rewritten history.
