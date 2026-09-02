# Surgical Change Contract — P4 Competitor Qualification

Date: 2026-09-02
Status: FROZEN FOR BUILDER IMPLEMENTATION
Application branch: `repair/prysm-report-improvement`
Diagnostic: `DIAGNOSTIC_P4_COMPETITOR_QUALIFICATION_2026-09-02.md`

## Outcome

Prevent supplied or discovered URLs from being silently promoted as qualified competitors when the available evidence does not establish service/business similarity, geographic relevance, audience similarity, and commercial overlap.

## Change tier and release intent

Change Tier: **2 — bounded evidence-contract/runtime qualification change**

Release Intent: **CHANGE_ONLY**. No production-readiness, deployment, merge, fresh audit, paid provider call, or model-bearing claim.

## Permitted surface

- `services/worker/src/evidence/competitor-opportunity-layer.js`
- its focused deterministic tests and, only if required by the changed contract, the existing competitor evidence normalization contract tests/fixtures
- durable Whole-App branch matrix/evidence rows required to prove the changed producer-to-consumer contract

## Prohibited surface

No n8n, prompts/models, Writer/Judge behavior, consultant controls, production artifacts, deployment/configuration, scoring values, or unrelated report copy changes.

## Contract

Qualification must use observed candidate evidence and explicit uncertainty. Missing service, geographic, audience, or commercial-overlap evidence must not be treated as a positive match. A candidate lacking enough evidence may be retained as `COMPARATOR_CONFIRMATION_REQUIRED` or excluded with structured reasons; it must not enter the qualified competitor set silently. Existing approval remains a separate downstream control and must continue to fail closed for pending/rejected candidates.

## Direct proof required

1. A known directory/non-competitor supplied candidate with no qualifying evidence is not in `candidates.qualified` and carries bounded state/reasons.
2. A candidate with explicit matching service, market, audience/page, and commercial evidence can qualify.
3. Missing/partial evidence remains uncertainty, not a negative finding or zero score.
4. Pending/rejected approval still produces no client-facing gap.
5. Existing excluded page types and deterministic output behavior remain intact.

## Branch and downstream proof

Map and exercise supplied-candidate and SERP-candidate producer branches, evidence envelope normalization, persistence/read-back, current model hydration, approval validation, benchmark rendering, and Narrative/reference parity. Run focused tests, worker regression, Narrative v2, and Whole-App branch-complete proof at the exact candidate. No live provider/model calls.

## Determinacy

The smallest coherent repair is to stop synthesizing positive qualification metadata for supplied candidates and to make qualification checks evidence-based with explicit bounded uncertainty. No other report-generation or control surface is causally required.
