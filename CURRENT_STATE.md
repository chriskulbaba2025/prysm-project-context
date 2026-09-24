# Current State

Project: PRYSM. Updated: 2026-09-24 America/Toronto.

## Frozen production baseline — VERIFIED

Authoritative historical baseline commit:
`aa9383bdab9047cfbaf3316d5dbca5cd2a0cb355`

Authoritative historical tree:
`0dc8e2b40ae40909ec0ebc08527307396d78eef3`

Current rollback commit on `main`:
`a68dd235a3ca09977c84313536b5b884e3694782`

Current rollback tree:
`0dc8e2b40ae40909ec0ebc08527307396d78eef3`

GitHub source equivalence:
0 file differences between the historical baseline and current rollback tree.

Durable freeze branch:
`freeze/prysm-known-good-aa9383-20260924`

Vercel production:
`dpl_BNrya7rMYmdJj8cp9wgufpqQREVB` — READY — rollback SHA.

Railway production:
`b3e5b09f-74aa-4316-9534-ae32083f1157` — SUCCESS — rollback SHA.

Production smoke:
login HTTP 200; auth gate active; worker health PASS; PostgreSQL and S3 initialization PASS.

## Reboot Business Coaching baseline acceptance — FROZEN

A clean production audit on the frozen rollback baseline completed far enough to produce the accepted report used for human comparison.

Accepted/frozen audit:
`77eb823c-91f9-4a79-9865-c79122b84e2b`

Accepted Content Opportunities output:
the user-designated "1" version, 7-page output.

Comparison result against prior "0" version:
- evidence basis comparable;
- shared buyer questions comparable;
- shared business goal comparable;
- shared recommendations materially preserved;
- evidence guardrails preserved;
- later opportunity set remains represented in summary/funnel planning;
- version 1 intentionally ranks/expands the strongest five instead of giving equal detail to all opportunities;
- no material unexplained analytical drift identified in the compared Content Opportunities page.

This accepted Content Opportunities behavior is now frozen. Do not redesign or expand it unless explicitly reopened.

## CA14 GACM repair branch — IN VERIFICATION

Read-only diagnosis against the frozen rollback baseline identified two generalized defects already proven by historical CA14 evidence and still present in the frozen code:

1. sitemap same-site admission treated `www.ca14.biz` and `ca14.biz` as different origins, dropping valid apex sitemap coverage for a www target;
2. a valid governed zero-findings result was not representable end-to-end because solution/narrative/report contracts required non-empty findings and a non-null rootCauseRuleId.

The later Writer HTTP 400 regression is NOT present in the frozen baseline schema and is not part of this repair.

Governed repair branch:
`repair/prysm-ca14-gacm-20260924`

Candidate head:
`64d84cfbaa3c72b55ce1b935e55e8fefe4688d1a`

Draft PR:
`#82 — GACM: CA14 generalized crawl + zero-findings repair`

Scope:
- bounded www/apex sitemap normalization only;
- governed zero-findings support across solution authority, directive, generator, Writer output/schema, prompt, and report view-model;
- permanent regression tests;
- no CA14/domain/audit-specific conditionals;
- production remains frozen at rollback baseline.

Current verification:
GitHub Actions worker verification is running on the candidate. Vercel feedback check passed. No promotion is authorized until the full closure gate passes.

Exact next action:
wait for full candidate CI; if green, independently inspect the exact diff and then run a clean CA14 audit on a hosted non-production candidate before any production promotion.

---

## CA14 incident — ACTIVE GACM DIAGNOSIS

The rollback baseline and accepted Reboot behavior are the frozen authority.

CA14 is now a separate incident. Do not alter the frozen baseline merely to make one CA14 fixture pass.

Known CA14 failed audits include:
- `490fe40e-5c7d-428f-a45b-c27b0613f6a4`
- `6633116f-6d58-4016-bdf0-305094151ac8`

The second audit proved collection/evidence/scoring completed and the then-current Narrative Writer request failed with HTTP 400. Those failures occurred on post-baseline code and must not be assumed to reproduce on the frozen rollback baseline.

Immediate next action:
perform a read-only GACM incident audit of CA14 against the frozen baseline; identify the first CA14-specific or environment/data divergence before making any source change. Then repair only the generalized owning boundary and re-prove with a clean CA14 production audit.

No piecemeal production patching is authorized.

---

## Human browser acceptance gate — AWAITING_HUMAN_UAT

All machine-verifiable validation for application candidate
`83734f413553c98c4f83d95780b0a88c323eb422` is complete. Vercel Preview is
READY as `dpl_6YJyDNMucCk8273XYFtf1HsEyuAP`; Railway staging deployment
`395eae96-ca3e-4911-a141-fc72363ae1d9` is SUCCESS; the worker health endpoint
identifies `prysm-worker`; and startup proves PostgreSQL repositories, staging
S3, and the embedding adapter/model initialized.

Lack of an automated/connected browser is not a technical HOLD. Chris must
perform human UAT at
`https://prysm-abc251cns-chriskulbabas-projects.vercel.app/` using the approved
staging Cognito identity. Run deterministic, lexical, paraphrase/semantic,
graph-dependent, conflict/UNKNOWN, and evidence-trace Ask PRYSM questions;
verify tenant/audit/site scope, canonical citations, trace provenance, and zero
cross-scope or secret disclosure; then return redacted PASS/FAIL evidence.

Do not claim Production Path Equivalence or Production Identity Continuity
until human evidence is reconciled. The prior staging secret-output governance
issue remains separately disclosed. Exact next action: Chris performs the
numbered browser sequence in the hosted closure proof and returns the exact
PASS/FAIL evidence.

## STAGING_READY hosted wiring repair — HOLD

The current application candidate is `83734f413553c98c4f83d95780b0a88c323eb422`
on `repair/prysm-hybrid-retrieval-decision-routing-2026-09-23`, parent
`6d1d99d63e607ebf328cfc661391747dee6592ae`. The governed repair adds the
replaceable OpenAI-compatible embedding adapter and injects it into the real
worker request listener. Local focused acceptance is 32/32 PASS, full worker
regression is 1,090/1,090 PASS, and the root/Vercel build is PASS.

Vercel Preview deployment `dpl_6YJyDNMucCk8273XYFtf1HsEyuAP` is READY. Railway
staging deployment `395eae96-ca3e-4911-a141-fc72363ae1d9` is now SUCCESS and
the public health endpoint identifies `prysm-worker`. Startup logs prove
PostgreSQL lifecycle/identity initialization, staging S3 connectivity, and
embedding retrieval enabled with `openai-compatible/text-embedding-3-small`.
The Railway image digest is recorded only in the sanitized closure proof.

Authenticated browser acceptance remains blocked because no connected browser
was available in the continuation session, and the prior staging reviewer
session/reset boundary remains unresolved. Exact hosted worker SHA continuity,
real semantic validation, hosted isolation/fallback, Production Path
Equivalence, and Production Identity Continuity therefore remain BLOCKED. No
live embedding call was made and production was untouched. A diagnostic Railway
variable-list command previously emitted staging secret values to tool output;
values are omitted from durable context and were not rotated under the current
authorization.

Result: `HOLD`.

Exact next action: Chris must review the staging credential exposure and
authorize the appropriate security response, then provide an available
authenticated staging browser session through the approved browser surface for
complete exact-head hosted validation from
`83734f413553c98c4f83d95780b0a88c323eb422`.

## STAGING_READY embedding-provider diagnosis — HOLD

The exact candidate remains `6d1d99d63e607ebf328cfc661391747dee6592ae` with
parent `10eafc716284168f222bb5e195b9cba82cd4e421`. A second governed,
read-only STAGING_READY diagnosis confirmed that no authorized staging
embedding credential is accessible: Railway staging reports
`PRYSM_LLM_MODE=offline` and has no embedding-provider/model variable; Vercel
Preview has no embedding credential; and the existing OpenAI references belong
to narrative/n8n infrastructure rather than a worker embedding adapter.

Result: `HOLD`. No application files changed, no deployment was attempted, no
live embedding call was made, and production was untouched.

Exact next action: Chris must provide or authorize one existing staging
`OPENAI_API_KEY` scoped to the worker for the bounded embedding validation.
Then implement the smallest governed adapter/configuration and candidate-branch
Preview mapping, push a new exact SHA, and rerun the complete hosted tranche.
Do not create a new provider account or key.

## Final hosted semantic validation checkpoint — HOLD

The exact candidate remains `6d1d99d63e607ebf328cfc661391747dee6592ae` on
`repair/prysm-hybrid-retrieval-decision-routing-2026-09-23`, with parent
`10eafc716284168f222bb5e195b9cba82cd4e421`.

The authorized final hosted-validation run stopped during the read-only
Production Spine audit before staging mutation. Direct evidence showed that
the hosted Ask PRYSM route invokes `queryAskPrysm` without an embedding adapter,
the worker has no configured production embedding provider/model adapter, and
Railway staging reports `PRYSM_LLM_MODE=offline` with no embedding-related
configuration. Recent Vercel Preview deployments for the branch were ERROR and
there was no exact-candidate READY deployment identity.

Result: `HOLD`. No staging deployment, live embedding call, browser acceptance,
or production mutation occurred in this run. Production Path Equivalence and
Production Identity Continuity are BLOCKED/unproven.

Exact next action: provide or explicitly authorize an existing governed staging
embedding provider/model configuration and wire the hosted Ask route to the
replaceable adapter. Then invalidate this run's hosted evidence and repeat the
full exact-SHA hosted tranche. Do not create a new paid provider account.

## Hybrid semantic retrieval repair checkpoint

Application repository `chriskulbaba2025/vantage-platform` has a pushed
change-only repair candidate on branch
`repair/prysm-hybrid-retrieval-decision-routing-2026-09-23` at exact SHA
`6d1d99d63e607ebf328cfc661391747dee6592ae`, based on repair start SHA
`10eafc716284168f222bb5e195b9cba82cd4e421` and frozen parent
`4cda78b433de86da53d8bbe5efb8512b4366833c`.

The repair replaces the false-pass application-memory deterministic hash
semantic label with governed PostgreSQL `pgvector`: `vector(1536)` storage,
replaceable embedding adapter, SQL tenant/audit/site scope predicates before
vector candidates are returned, independent lexical retrieval,
canonical-evidence citation joining, bounded graph expansion, and
deterministic fallback when vector capability is unavailable. Content hashes
and embedding identity/version remain persisted metadata; unchanged content
reuses its embedding and changed content invalidates it.

Isolated pgvector 0.8.6 qualification and assembled acceptance PASS. Focused
repair suite is 16/16 PASS. Full worker regression is 1,085/1,085 PASS with
zero failures/skips. Production touched: NO. New paid/live model calls: 0.
Laya NO-GO remains unchanged and was not reopened.

Disposition: `PRYSM_HYBRID_SEMANTIC_RETRIEVAL_CHANGE_PASS` for the authorized
local change-only tranche. Real embedding-model semantic quality, staging,
production path equivalence, production identity continuity, and real-world
outcome validation remain unproven and must not be claimed.

## Hybrid retrieval decision-routing checkpoint

Application repository `chriskulbaba2025/vantage-platform` has a new pushed
change-only candidate on branch
`repair/prysm-hybrid-retrieval-decision-routing-2026-09-23` at exact SHA
`10eafc716284168f222bb5e195b9cba82cd4e421`, based exactly on
`4cda78b433de86da53d8bbe5efb8512b4366833c`.

Completed: additive tenant/audit/site-scoped hybrid retrieval contract,
deterministic/replaceable embedding adapter, PostgreSQL JSONB retrieval index,
bounded graph expansion, context pack and retrieval trace, Ask PRYSM hybrid
composition with deterministic fallback, generalized/security coverage, and
Laya read-only qualification NO-GO. Targeted hybrid suite is 26/26 PASS and
full worker regression is 1,081/1,081 PASS with zero failures/skips.

Production touched: NO. New paid calls: 0. New provider/account: NO. Report
design and canonical evidence authority remain protected.

Current disposition: HOLD for release-critical hosted reproof. This change-only
candidate has not been run through a new staging/browser production-shaped
path, so production path equivalence and production identity continuity for
this candidate are not claimed.

## Production status

STATUS: `PRYSM_PRODUCTION_ACTIVATED`

Exact production candidate:
`aa9383bdab9047cfbaf3316d5dbca5cd2a0cb355`

GitHub `main`, authoritative Vercel production, and Railway production are now aligned to that exact SHA.

## Final validated candidate evidence

- Authoritative audit: `6dca53ed-ae00-484c-bf77-b59c059eef51`.
- Worker regression: 1,030/1,030 PASS, zero failures/skips.
- `npm run verify:prysm-closure`: PASS.
- Whole-App P-B01–P-B17: PASS.
- Hosted Vantage Worker CI and PRYSM MVP Hosted Verification: PASS at the exact candidate.
- Authenticated seven-page browser acceptance: PASS.
- Fresh browser PDF acceptance: PASS, 44 populated pages.
- `PRODUCTION PATH EQUIVALENCE: PASS`.
- `PRODUCTION IDENTITY CONTINUITY: PASS`.
- Final independent challenge: PASS, CRITICAL 0, MAJOR 0, open MINOR 0.

## GitHub production identity

- Repository: `chriskulbaba2025/vantage-platform`.
- `main` was fast-forwarded without force from `0e4a97e68f19b974e7ef3dfdd1480cbc390d090b` to exact candidate `aa9383bdab9047cfbaf3316d5dbca5cd2a0cb355`.
- No merge commit altered the validated SHA.
- Repair branch remains `repair/prysm-mvp-client-readiness-2026-09-21` at the same exact candidate.

## Vercel production

- Project: `prysm`
- Project ID: `prj_o4dQkuESOoTphZkOwVKG49BaLQT9`
- Deployment: `dpl_7tmqe4jbEs8YZoA2vpTRDBgERE7K`
- Status: READY
- Target: production
- Branch: `main`
- Git SHA: `aa9383bdab9047cfbaf3316d5dbca5cd2a0cb355`
- Production aliases include `https://prysm.omnipressence.com`.
- Read-only production smoke: `/login` returned HTTP 200 and rendered the expected Prysm login page from the exact deployment.
- Immediate exact-deployment production error/fatal log query returned no entries.

## Railway production

- Project: GENSEN process
- Project ID: `9dfaead1-79d7-4582-9c58-0999a1d07b84`
- Environment: production
- Environment ID: `75916b16-007b-442c-bfba-5ef063d5ca4d`
- Service: `vantage-platform`
- Service ID: `d6012de3-a174-4a59-bf8f-db4e9b01d91f`
- Deployment: `dea7f7ce-be91-43a4-92e8-1e863552a67b`
- Status: SUCCESS / online
- Branch: `main`
- Git SHA: `aa9383bdab9047cfbaf3316d5dbca5cd2a0cb355`
- Replica state: 1 running / 0 crashed.
- Startup confirms production S3 artifact-store connectivity, PostgreSQL lifecycle/identity repository initialization, governed API v1 initialization, and worker listening on port 8080.
- Railway does not expose a separate running-container digest; no digest-equality claim is made.

## Known non-blocking operational debt

The new Railway production startup logged stranded historical audit recovery errors for several older audits with missing persisted AuditRequest records, plus a recovery sweep failure related to unavailable competitor allowlist data.

This did not block activation:
- deployment reached SUCCESS;
- service is online;
- 1/1 replica is running;
- PostgreSQL/S3 initialization succeeded;
- Railway reports zero current service warnings/critical issues and zero recent failed deployments.

No repair was attempted under the production activation authority. Treat this as a separate bounded operational-recovery item if Chris chooses to address it later.

## Safety / scope

Production activation did not:
- change production credentials or secrets;
- change Cognito configuration;
- mutate production PostgreSQL or S3 outside normal application startup/reads;
- start a new production audit;
- call paid providers;
- run Writer/Judge/model execution;
- force-push;
- introduce unrelated source changes.

Rollback references:
- Pre-activation GitHub main: `0e4a97e68f19b974e7ef3dfdd1480cbc390d090b`.
- Previous Railway rollback deployment: `d8f7a3f3-8812-465d-8460-c5b11b3dd37c` at `60169bf23eec37c29683937d459d7d96f82aba73`.

## Durable records

- `PRYSM-PRODUCTION-ACTIVATION-AUTHORIZATION_2026-09-21.md`
- `PRYSM-PRODUCTION-ACTIVATED_2026-09-21.md`
- `AUDIT_PRYSM_MVP_CLIENT_READINESS_FINAL_CLOSURE_2026-09-21.md`
- `PRYSM_MVP_CLIENT_READINESS_CLOSURE_TELEMETRY_2026-09-21.json`

The local proof folder remains:
`C:\Users\kulba\Downloads\PRYSM-MVP-CLOSURE-2026-09-21\`

## Post-MVP hosted acceptance update

The exact candidate `f80b3e3aecba8807d58fdac426232d14052095b9` has now passed
the authorized staging production-shaped browser path and identity continuity
through persisted audit reload, seven-page report rendering, and terminal PDF
generation. Vercel Preview deployment `dpl_7R6UueJYCoCMe361bq6ZDgHQDBBX` and
Railway staging deployment `2118daeb-15e7-408c-876d-7e8d133b9b6f` were matched
to the candidate. Production remains untouched. Full arbitrary-site
generalization, provider/model validation, and longitudinal outcomes remain
deferred; overall candidate disposition is HOLD. See
`PRYSM_POST_MVP_EVIDENCE_INTELLIGENCE_HOSTED_ACCEPTANCE_2026-09-23.md`.

## Exact next action

Chris must review the staging credential exposure and authorize the appropriate
security response, then provide an available authenticated staging browser
session through the approved browser surface for complete exact-head hosted
validation from `83734f413553c98c4f83d95780b0a88c323eb422`.

Last verified: 2026-09-21 America/Toronto

## Staging Narrative v2 capability update — 2026-09-24

- Candidate under staging acceptance: `b67d1f979a81d3b20c55fdcde0c64095e300a34a` on `repair/prysm-ca14-gacm-20260924`.
- Proven staging root cause: Narrative v2 live-binding variables were absent and `PRYSM_LLM_MODE` was `offline`; the worker correctly rejected requested Narrative v2.
- Staging-only repair applied to Railway environment `9d541fe0-5103-4134-98dc-332dae65de7b`; existing staging OpenAI credential reused without recording its value.
- Exact redeployment `cc1b4ebb-0958-4b09-a400-512c5faa75a7` is SUCCESS at the candidate SHA. No production configuration, deployment, data, or audit was changed.
- Machine capability configuration now validates: enabled/live, governed Writer `gpt-5.6-terra`, Judge `gpt-5.6-sol`, HTTPS provider, valid price table, token limits, and budgets.
- Generic authenticated browser smoke and clean CA14 acceptance remain BLOCKED because no browser surface was available. No CA14 audit was created and no model call was made.
- Proof: `C:\Users\kulba\Downloads\PRYSM-STAGING-NARRATIVE-V2-GACM-2026-09-24\11-FINAL-GACM-CLOSURE-PROOF.txt`.
- Exact next action: connect an authenticated browser surface, run generic disposable staging smoke, then run the clean CA14 acceptance only if that gate passes.

## Full staging runtime qualification update — 2026-09-24

- Candidate remains `b67d1f979a81d3b20c55fdcde0c64095e300a34a`; no source changes were required.
- Railway staging deployment `b3e60d9f-07ed-4b27-a4dc-dbc9cbfe6f20` now starts the full WP12 runtime after correcting malformed Narrative price-table JSON.
- Startup proves S3 connectivity, PostgreSQL lifecycle/identity initialization, production adapters loading, and `WP12 production runtime initialized`.
- Protected audit routes now reach authentication (401 without auth), not the previous WP11 501.
- Full machine qualification remains HOLD because staging lacks DataForSEO credentials and a PageSpeed credential. Production credentials were not copied.
- No browser UAT or CA14 audit was started. Production remains untouched.
- Proof: `C:\Users\kulba\Downloads\PRYSM-STAGING-FULL-RUNTIME-GACM-2026-09-24\14-FINAL-STAGING-RUNTIME-CLOSURE-PROOF.txt`.
- Exact next action: provision staging-owned DataForSEO and PageSpeed credentials through the authorized staging secret path, redeploy, rerun machine readiness, then request one browser smoke.
