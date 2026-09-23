# Decision — PRYSM Hybrid Retrieval + Decision Routing Checkpoint

Date: 2026-09-23
Status: HOLD — change-only candidate; no hosted release claim

Decision:

Accept local implementation candidate `10eafc716284168f222bb5e195b9cba82cd4e421`
on `repair/prysm-hybrid-retrieval-decision-routing-2026-09-23` for the bounded
hybrid retrieval change. The implementation adds PostgreSQL-native durable
retrieval rows without introducing a new dependency or paid provider, keeps
canonical evidence authoritative, scopes retrieval before return, bounds graph
expansion, and preserves deterministic Ask PRYSM fallback.

Evidence: targeted hybrid suite 26/26 PASS; full worker regression 1,081/1,081
PASS; independent exact-candidate challenge PASS; production touched NO; paid
calls 0; Laya qualification NO-GO and not integrated.

Implication:

This is not a staging or production readiness claim. Production path
equivalence and production identity continuity must be directly re-proven for
this candidate before any release-critical hosted confirmation. pgvector remains
an explicit future qualification rather than an unverified dependency.
