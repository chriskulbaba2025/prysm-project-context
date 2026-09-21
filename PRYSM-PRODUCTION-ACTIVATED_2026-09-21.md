# PRYSM Production Activation — 2026-09-21

Result: `PRYSM_PRODUCTION_ACTIVATED`

Exact authorized candidate:
`aa9383bdab9047cfbaf3316d5dbca5cd2a0cb355`

## GitHub

- Repository: `chriskulbaba2025/vantage-platform`
- `main` was fast-forwarded without force from `0e4a97e68f19b974e7ef3dfdd1480cbc390d090b` to exact candidate `aa9383bdab9047cfbaf3316d5dbca5cd2a0cb355`.
- No merge commit changed the validated candidate SHA.
- No unrelated source mutation was made during activation.

## Vercel production

- Project: `prysm`
- Project ID: `prj_o4dQkuESOoTphZkOwVKG49BaLQT9`
- Deployment: `dpl_7tmqe4jbEs8YZoA2vpTRDBgERE7K`
- Target: production
- Status: READY
- Git branch: `main`
- Git SHA: `aa9383bdab9047cfbaf3316d5dbca5cd2a0cb355`
- Production alias `https://prysm.omnipressence.com` is attached to this deployment.
- Read-only smoke: `https://prysm.omnipressence.com/login` returned HTTP 200 and rendered the expected Prysm login page from deployment `dpl_7tmqe4jbEs8YZoA2vpTRDBgERE7K`.
- Immediate exact-deployment Vercel production error/fatal log query returned no entries.

## Railway production

- Project: GENSEN process
- Project ID: `9dfaead1-79d7-4582-9c58-0999a1d07b84`
- Environment: production
- Environment ID: `75916b16-007b-442c-bfba-5ef063d5ca4d`
- Service: `vantage-platform`
- Service ID: `d6012de3-a174-4a59-bf8f-db4e9b01d91f`
- Deployment: `dea7f7ce-be91-43a4-92e8-1e863552a67b`
- Status: SUCCESS / online
- Git branch: `main`
- Git SHA: `aa9383bdab9047cfbaf3316d5dbca5cd2a0cb355`
- Replica state: 1 running / 0 crashed.
- Startup confirms production S3 artifact-store connectivity, PostgreSQL lifecycle/identity repository initialization, governed API v1 initialization, and Prysm worker listening on port 8080.
- No separate Railway running-container digest is exposed; no digest-equality claim is made.

## Activation caveat recorded, not hidden

At startup, Railway logged stranded historical audit recovery errors for several older audits with missing persisted AuditRequest data, plus one recovery sweep failure caused by unavailable competitor allowlist data. The active service nevertheless reached SUCCESS/online with 1/1 replica, PostgreSQL/S3 initialization succeeded, and Railway reported zero current service warnings/critical issues and zero recent failed deployments.

These messages are treated as historical stranded-audit recovery debt, not an activation failure. No repair was attempted because the production activation authority did not authorize unrelated recovery changes.

## Safety / scope

- No production credential or secret changes.
- No production Cognito mutation.
- No production PostgreSQL or S3 mutation outside normal service startup connectivity.
- No new production audit.
- No paid provider call.
- No Writer/Judge/model execution.
- No force push.
- No unrelated code change.

Rollback references preserved:
- Pre-activation GitHub main: `0e4a97e68f19b974e7ef3dfdd1480cbc390d090b`.
- Previous Railway production rollback deployment: `d8f7a3f3-8812-465d-8460-c5b11b3dd37c` at `60169bf23eec37c29683937d459d7d96f82aba73`.

Final production identity:
GitHub main = Vercel production = Railway production = `aa9383bdab9047cfbaf3316d5dbca5cd2a0cb355`.

Next action: human production use/observation. Any new defect should be captured as a new bounded change, not folded back into this closed activation.
