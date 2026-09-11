# Current State

Project: PRYSM

## Current objective

Restore production dashboard/report connectivity. Production login works, but server-side worker requests are falling back to localhost.

## Production-live checkpoint

- Frozen semantic candidate: `354d01eaaa1eb7eac096ab1997ada9b2c9d4359f`
- Tooling/application HEAD: `608b7193e6a38c61cff91a8367d232ad52965de2`
- Production deployment ID: `dpl_AFV2hrhjY96VGTGsQ6xynUuQwgu6`
- Production status: READY
- Live domain: `https://prysm.omnipressence.com`
- Login works.

## Current production blocker

Checkpoint: `PRYSM-PRODUCTION-WORKER-BASE-URL-BLOCKER_2026-09-11.md`

Result: `PRODUCTION_DASHBOARD_WORKER_BASE_URL_MISSING / HIGH`.

Vercel runtime shows `fetch failed` caused by `ECONNREFUSED 127.0.0.1:3000` on the live app. `lib/worker-client.ts` falls back to `http://localhost:3000` when `VANTAGE_WORKER_API_URL` is absent. The repository-declared worker URL is `https://vantage-platform-production.up.railway.app`.

## Production repair authorization

Checkpoint: `PRYSM-PRODUCTION-WORKER-URL-REPAIR-AUTHORIZATION_2026-09-11.md`

Chris explicitly authorized setting production `VANTAGE_WORKER_API_URL` to `https://vantage-platform-production.up.railway.app` and redeploying/promoting production only as required to apply that environment configuration and verify the dashboard and TBK report.

Not authorized: unrelated code changes, model calls, provider recollection, GitHub push, or main merge.

## Exact next action

Set or update the production Vercel environment variable `VANTAGE_WORKER_API_URL` for project `prysm` to `https://vantage-platform-production.up.railway.app`, redeploy production only as required for the environment change to take effect, then verify the dashboard and TBK report no longer call localhost and successfully reach the Railway worker.

Last verified: 2026-09-11 America/Toronto
