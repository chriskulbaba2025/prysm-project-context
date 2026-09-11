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

No model call, provider recollection, code change, push, merge, or new deployment occurred during diagnosis.

## Exact next action

Obtain explicit authorization to repair the production `VANTAGE_WORKER_API_URL` configuration for Vercel project `prysm`, redeploy/promote only as required for that environment change, then verify the dashboard and TBK report successfully reach the Railway worker and no longer call localhost.

Last verified: 2026-09-11 America/Toronto
