# Decision: Hybrid semantic retrieval contract repair

Date: 2026-09-23
Status: CHANGE PASS — local change-only tranche; no hosted release claim

Accept application candidate `6d1d99d63e607ebf328cfc661391747dee6592ae` on
`repair/prysm-hybrid-retrieval-decision-routing-2026-09-23` as the bounded
repair for `SEMANTIC_RETRIEVAL_CONTRACT_FALSE_PASS`.

Evidence: isolated PostgreSQL `pgvector` 0.8.6 qualification PASS; additive
`vector(1536)` storage behind a replaceable embedding adapter; SQL tenant,
audit, and optional website scope before vector return; controlled paraphrase
retrieval beyond lexical overlap; canonical-evidence citation join; preserved
currentness/conflict/UNKNOWN/PARTIAL, bounded graph, trace, and deterministic
fallback semantics; focused repair tests 16/16 PASS; full worker regression
1,085/1,085 PASS.

No paid/live embedding or model call was made. Semantic model quality beyond
the controlled injected adapter is `NOT_AVAILABLE`. Production and staging
were not touched; production path equivalence and production identity
continuity are not claimed. Laya remains NO-GO and was not reopened.

Next action: preserve production frozen. Hosted or real-model validation
requires separate authorization and its own production-spine, path-equivalence,
identity-continuity, and model-bearing gates.
