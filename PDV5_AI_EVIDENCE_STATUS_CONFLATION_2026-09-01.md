# PDV5 New Root Evidence â€” AI-evidence-status conflation

Candidate: `9ee10587caf2c7b49a339ca490fa0a7be501dfb0`  
Frozen proof execution: `candidate-9ee10587-1788266130237`

## Observed result

The causal-certainty repair passed 5/5 independent real Writer calls on the primary TBK WriterInput. Two real Writer calls on the additional persisted Stripe WriterInput also passed. The third additional Writer call reached the live Writer semantic validator and failed with:

`writerOutput.aiSearch.answerability.text converts non-AI evidence into an established AI-search limitation`

The failed parsed-output SHA-256 is `c5d6fee3d122d170698566e2454bf19fcc113d5390367ee33ec3e7e4cd7ebcc1`. The five passing primary output hashes and all raw/parsed ledger artifacts are retained outside the application repository at `C:\Users\kulba\Desktop\prysm-pdv5-evidence\real-model-ledger`.

## Classification

This assertion was reached and rejected actual Writer behavior. It is not a harness failure. It is materially distinct from unmeasured causal certainty: it concerns cross-domain evidence-status attribution in the AI-search section. New root ID: `PDV5.WRITER_AI_EVIDENCE_STATUS_CONFLATION`.

No application files were changed in this proof run. Required Writer and full-Narrative samples restart after a bounded root-cause repair.
