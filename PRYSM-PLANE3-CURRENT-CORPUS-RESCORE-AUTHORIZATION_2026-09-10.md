# PRYSM Plane 3 Current Corpus Rescore Authorization

Date: 2026-09-10 America/Toronto
Status: AUTHORIZED

Chris explicitly authorized one isolated deterministic current-scoring reconstruction of the approved TBK and Reboot audits from their existing persisted canonical evidence, using the current PRYSM scoring path and current WriterInput 1.2.0 construction boundary.

This authorization permits only:

- isolated deterministic current-scoring reconstruction of TBK and Reboot;
- reuse of existing persisted canonical evidence only;
- current production scoring/validation functions;
- current WriterInput 1.2.0 construction;
- derivative scratch persistence only;
- strict semantic-equivalence comparison against historical authority;
- stopping immediately if any material scoring conclusion changes.

This authorization does NOT permit:

- provider recollection;
- Writer calls;
- Judge calls;
- any provider/model-bearing call;
- modification of historical artifacts;
- deployment;
- merge;
- production mutation;
- GA4 conversion-authority expansion;
- continuation past a material semantic difference.

Authorized application checkpoint:
- semantic candidate: d7ce3cfe69d5ada8f6d4541c8a9603f17e932a97
- tooling HEAD: 5f2c1a27cbb6eaf022fb9d61dc9a2d6c37a9c3eb

Next governed gate: execute the isolated deterministic reconstruction and semantic-equivalence comparison only, with zero provider/model calls.
