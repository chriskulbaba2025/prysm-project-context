# P1 Diagnostic — Cross-report contradiction integrity

Date: 2026-09-02
Classification: VERIFIED_DESIGN_GAP
Root defect: P1-CROSS-REPORT-DERIVATION-001
Application candidate inspected: `repair/prysm-report-improvement` @ `acfc5c1393261bb7733837289bc3adc1062e64d5`

## Requirement preservation

The report must not present materially opposing conclusions across sections unless it explicitly explains that the sections measure different constructs. Every material cross-report assertion must have one authoritative interpretation lineage.

Non-goals: changing canonical evidence, scoring policy, provider acquisition, Writer/Judge prompts, n8n, production state, or the locked report design.

## Shortest diagnostic and direct evidence

The same semantic area is derived independently in multiple consumers:

| Consumer | Current derivation | Risk |
| --- | --- | --- |
| `services/worker/src/report/sections-conversion.js` | Offer clarity from `site.services.length`; CTA clarity from `site.ctas.length`; conversion paths from `model.conversionPaths`. | Raw count labels can disagree with governed path state. |
| `services/worker/src/report/render-report-v2.js` | Offer clarity from service count; trust from `model.bands.trust`; CTA/path clarity from a second aggregation of `model.conversionPaths`. | Same report family has a second interpretation of related constructs. |
| `services/worker/src/scoring/report-model.js` | Conversion path status/blockers and readiness rows from scored evidence/capabilities. | This is the available authoritative semantic lineage, but consumers do not uniformly use it. |

The focused controlled regression suite completed **964/964 PASS**, including the existing contradiction gate and current consumer-parity checks. That suite proves the existing performance/evidence contradictions are blocked and that current model hydration identity is preserved; it does not assert cross-section parity for offer/CTA/path interpretations. Therefore the finding is a design gap, not a demonstrated historical production defect.

## Controlled contradiction mechanism

With a site having multiple services but no observed CTA, the legacy consumer can label offer clarity from service count while separately labeling CTA/path clarity from CTA/path evidence. With a site having a visible CTA but an assessed weak path, a raw CTA-count label can read as positive while the governed path label reads weak. The constructs may legitimately differ, but the current output does not consistently state the distinction or expose a shared lineage.

## Required bounded correction

Introduce one deterministic cross-report interpretation projection after scoring and before rendering. Consumers must read that projection for material offer, CTA, conversion-path, buyer-question, trust, mobile, and indexability assertions. Legitimate construct differences must carry explicit construct labels/meaning rather than being silently compared as one verdict.

## Reopen conditions

Reopen diagnosis if the projection requires changing canonical evidence, score formulas, model-bearing prompts, provider behavior, n8n, or the locked renderer assets; or if a required consumer cannot be migrated without a broader architectural change.

