# PDV5-AUD-002 level-3 repair proof failure

Date: 2026-09-01
Application SHA: `2877686b3f21251280179173efa558c9dbf3636d`
Root defect: `PDV5.WRITER_JUDGE_SEMANTIC_SUPPORT_MISMATCH`
Repair attempt: 2
Verdict: **REPAIR_PROOF_FAILED**

The repair replaced the broad conversion-action exception with a compound-removal check and added negative siblings for revenue, traffic, sales, and conversions. The focused Writer suite passed 24/24, Narrative v2 passed 113/113, and the exact-SHA Whole-App gate passed with P-B01 through P-B15.

The governed proof then normalized and replayed all 11 real Writer outputs previously accepted for the PDV5 model-bearing sample against the exact repaired validator and frozen TBK/Stripe WriterInputs. Ten passed. One historically valid TBK output reached and failed the repaired semantic assertion:

`Browser validation confirmed a visible, interactable, unobstructed action on all assessed conversion pages.`

The sentence is an evidence-supported observation of an assessed action, not a commercial outcome assertion. The compound-only repair was therefore too narrow because valid action language may separate `action` from a contextual `conversion` modifier. This is an actual same-root product/contract proof failure, not proof setup. No fourth same-root repair is authorized; the external controller owns the governed block transition.
