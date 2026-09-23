# Decision: Hosted hybrid semantic validation HOLD

Date: 2026-09-23
Status: HOLD

Candidate: `6d1d99d63e607ebf328cfc661391747dee6592ae`.

The final hosted validation tranche stopped at the read-only Production Spine
audit. The exact candidate's hosted Ask route calls `queryAskPrysm` without an
embedding adapter, and the worker contains no configured embedding provider
adapter. Railway staging reports `PRYSM_LLM_MODE=offline` and exposes no
embedding configuration. Vercel Preview environment variables are branch
specific; no mapping for the candidate branch was present, and recent Preview
deployments were ERROR. Consequently exact hosted SHA identity, real semantic
model retrieval, staging pgvector runtime, authenticated Ask acceptance,
Production Path Equivalence, and Production Identity Continuity cannot be
proven.

No staging deployment, live embedding call, or production mutation was made in
this run. AWS SSO preflight succeeded for account `814462560475`; credentials
were not persisted or written to proof.

Exact next action: provide or explicitly authorize an existing governed staging
embedding provider/model configuration and wire the hosted route to the
replaceable adapter, then rerun the complete exact-SHA hosted tranche. Do not
create a new paid provider account. Prior local implementation PASS remains
valid but is not a hosted/release PASS.
