# Decision: STAGING_READY embedding-provider diagnosis HOLD

Date: 2026-09-23
Status: HOLD

Candidate: `6d1d99d63e607ebf328cfc661391747dee6592ae`.

A second governed read-only diagnosis confirmed no authorized staging embedding
credential is accessible. Railway staging is `PRYSM_LLM_MODE=offline` and has
no embedding-provider/model configuration. Vercel Preview has no embedding
credential. Existing OpenAI references are narrative/n8n infrastructure, not a
worker embedding adapter. The hosted Ask path therefore cannot reach a real
semantic model, and staging deployment would not prove the required spine.

No application files changed, no deployment was attempted, no live embedding
call was made, and production was untouched.

Exact next action: Chris must provide or authorize one existing staging
`OPENAI_API_KEY` for the worker's bounded embedding validation. Then implement
the smallest governed adapter/configuration and Preview mapping, push a new
exact SHA, and rerun all hosted gates. No new provider account or key creation
is authorized.
