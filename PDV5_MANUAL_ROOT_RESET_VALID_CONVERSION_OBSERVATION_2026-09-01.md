# PDV5 manual root reset — valid conversion observation false positive

Date: 2026-09-01
Application candidate: `2877686b3f21251280179173efa558c9dbf3636d`
Prior exhausted root: `PDV5.WRITER_JUDGE_SEMANTIC_SUPPORT_MISMATCH`
New root: `PDV5.WRITER_COMMERCIAL_OUTCOME_CONTEXT_FALSE_POSITIVE`
Classification: **VERIFIED_ROOT_CAUSE / NEW ROOT**
Repair attempt: **0**

## Protected outcome

A normal PRYSM audit must reliably complete the governed Writer/Judge Narrative path and produce a completed/renderable report without weakening evidence integrity.

## Evidence

The level-3 candidate passed 24/24 focused Writer tests, 113/113 Narrative tests, and the exact-SHA Whole-App Branch Coverage Gate P-B01 through P-B15. Normalized replay of 11 governed real Writer outputs then rejected one historically valid TBK observation:

`Browser validation confirmed a visible, interactable, unobstructed action on all assessed conversion pages.`

Direct inspection of `services/worker/src/narrative-v2/writer-output.js` at candidate `2877686...` proves the causal-certainty validator treats `conversion` as a commercial-outcome token anywhere in the sentence and treats `confirmed` as establishment language. Its current observed-conversion-action exception only removes compound phrases such as `conversion action`; it does not remove contextual uses such as `action ... on ... conversion pages`. The sentence therefore remains matched as an asserted commercial outcome even though it reports only an observed interface/action condition.

This is not another Writer/Judge semantic-support shaping failure. The Writer output is historically valid and evidence-supported. The newly proven defect is in the validator's lexical classification of contextual conversion language as a commercial outcome.

## New root boundary

`PDV5.WRITER_COMMERCIAL_OUTCOME_CONTEXT_FALSE_POSITIVE`

The validator must distinguish:

1. evidence-supported observations about conversion interfaces/actions/pages/paths; from
2. asserted downstream commercial outcomes such as increased conversions, leads, revenue, sales, traffic, engagement, or other unmeasured business results.

## Smallest coherent repair boundary

- `services/worker/src/narrative-v2/writer-output.js`
- the direct semantic-fidelity regression file(s) governing this validator
- prompt/contract text only if direct evidence shows the Writer is instructed inconsistently with the corrected validator boundary

Do not broaden into scoring, crawling, presentation, provider routing, or unrelated Narrative behavior.

## Required direct regressions

The repaired validator must PASS the exact historically valid sentence above and equivalent evidence-supported observations where `conversion` is contextual rather than an asserted outcome.

It must continue to FAIL unmeasured commercial-outcome assertions, including materially equivalent claims such as:

- `The change increased conversions.`
- `The visible action generated more leads.`
- `This conversion path improved sales.`
- `The assessed action drove revenue.`

The repair must remain fail-closed for actual causal/commercial claims while no longer rejecting observed interface/action conditions.

## Governed continuation

This manual diagnostic reset satisfies the controller's post-level-3 intervention requirement. Reset the root counter to attempt 0 / Luna for the new root. After the bounded repair:

`targeted regression -> Narrative suite -> exact-SHA Whole-App P-B01..P-B15 -> required real Writer/Judge model-bearing proof -> independent Auditor`

No paid Writer/Judge call is required before the deterministic validator repair is proven.
