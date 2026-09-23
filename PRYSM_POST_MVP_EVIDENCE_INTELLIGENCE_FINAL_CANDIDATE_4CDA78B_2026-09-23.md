# PRYSM post-MVP evidence-intelligence candidate `4cda78b`

Date: 2026-09-23

## Candidate

- Repository: `chriskulbaba2025/vantage-platform`
- Branch: `repair/prysm-post-mvp-evidence-intelligence-2026-09-22`
- Exact candidate SHA: `4cda78b`
- Frozen base: `aa9383bdab9047cfbaf3316d5dbca5cd2a0cb355`
- GitHub push: PASS

## What changed

Added a deterministic named arbitrary-site acceptance matrix at the URL
discovery, canonical evidence, persistent graph, and Ask PRYSM query
boundaries. The matrix explicitly covers sitemap/robots/HTML/llms discovery,
redirect and canonical normalization, source incompleteness, duplicate and
independent evidence, device/scope/history conflict, stable graph identity,
causal fail-closed behavior, ownership boundaries, and cross-audit Ask PRYSM
retrieval.

## Verification

- Targeted arbitrary-site matrix: 14 PASS, 0 FAIL, 0 SKIP.
- Full worker regression: 1,076 PASS, 0 FAIL, 0 SKIP.
- Exact Railway staging local-upload deployment: `36118d86-13cb-4019-8680-d574240054e3`, SUCCESS.
- Exact Vercel Preview deployment: `dpl_9Nj8js3JhDmUsvwUSJHMybSSm5vi`, READY.
- Vercel Preview Protection blocked the browser harness before application login for this deployment; exact hosted browser identity/report continuity is not claimed.
- Production: untouched.

## Deferred / hold

- Re-run exact-candidate hosted browser identity/report proof with authorized
  Preview Protection access.
- Resolve or re-authorize bounded DataForSEO live validation; the prior
  authorized attempt ended at network transport before a provider task result.
- Run model-bearing Ask PRYSM validation only under explicit paid-run
  authorization; no such authorization was present.
- Collect longitudinal business outcomes after real operation; implementation
  cannot create those outcomes.

Overall status: HOLD. This checkpoint supersedes the prior candidate for
source and deterministic acceptance evidence, but does not claim full product
closure.
