# PRYSM Narrative v2 Uncertain-Transport Recovery Implementation Authorization

Date: 2026-09-09

Chris explicitly approved moving to the next stage after the Terra High recovery-contract design gate returned `CURRENT_TBK_CASE_UNRECOVERABLE_BUT_GENERAL_REPAIR_READY`.

This authorization permits implementation and verification of the bounded Narrative v2 uncertain-transport recovery contract only.

## Authorized
- implement the frozen recovery contract primarily in `services/worker/src/narrative-v2/live-binding.js`;
- touch `orchestrator.js`, `production-path.js`, and the live/release persistence composition boundary only if directly required by the approved contract;
- add/update directly affected tests defined by the design gate;
- preserve immutable reservation semantics, sanitized transport-cause persistence, durable release-call ledger state, explicit uncertain-transport recovery authorization, one-recovery limit, semantic pass lineage, conservative budget accounting, and total call ceilings;
- prohibit memory-only stores for live release execution or otherwise fail closed according to the approved design;
- run deterministic/local tests and full relevant regressions with mocked/non-provider execution only;
- create proof artifacts in Downloads.

## Not authorized
- no Writer/Judge/model/provider call;
- no retry or resume of the failed TBK Writer pass 2;
- no new TBK model-backed orchestration;
- no audit-provider rerun;
- no deployment or production promotion;
- no production mutation;
- no main merge;
- no change to canonical remediation authority, scoring/evidence semantics, Writer/Judge semantic contracts, provider/model selection, automatic semantic pass ceiling, report renderer, or client report architecture.

## Required stop
After implementation and deterministic verification are complete, stop. A separate explicit human authorization is required before any new model-backed TBK release-candidate orchestration.
