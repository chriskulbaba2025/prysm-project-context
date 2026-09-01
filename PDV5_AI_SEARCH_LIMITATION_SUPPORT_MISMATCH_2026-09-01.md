# PDV5 new root evidence — AI-search bounded non-assessment mismatch

Candidate before repair: `f5a75ce6c44ca1a38772e6d1843e618568d888b5`

## Governed real Writer proof

The restarted model-bearing proof completed five independent Writer validations on the frozen primary TBK input. The first Writer generation on the additional persisted Stripe WriterInput then reached the production semantic validator and failed at:

`writerOutput.aiSearch.answerability.text converts non-AI evidence into an established AI-search limitation`

The parsed response is preserved outside the application repository in `C:\Users\kulba\Desktop\prysm-pdv5-evidence\real-model-ledger\candidate-f5a75ce6-1788277119293-additional-writer-1`.

The rejected text was: `Answerability was not directly assessed sufficiently to establish a limitation.` It is the bounded non-assessment wording expressly instructed by the Writer prompt. The validator's bounded-AI pattern accepted `not assessed` but not its prompt-authorized passive variant `not directly assessed`.

## Root cause and repair

This is a prompt/validator congruence defect, distinct from `PDV5.WRITER_UNMEASURED_CAUSAL_CERTAINTY`: it concerns truthful AI-search non-assessment wording, not causal commercial certainty.

New root ID: `PDV5.WRITER_AI_SEARCH_LIMITATION_SUPPORT_MISMATCH`.

Candidate `0dd829152bf9ce44bb2ceb5665c8888a61497cbd` expands the bounded-AI validator pattern to accept `not directly assessed` and adds a permanent direct regression for the exact rejected form. It does not relax rejection of unsupported established AI-search limitations.

Direct verification: `node --test src/narrative-v2/writer-output.test.js` — 19/19 PASS.

Required next: run the exact-SHA Whole-App Gate, then restart the entire PDV5 governed Writer/Judge model-bearing sample on this new candidate.
