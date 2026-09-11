# PRYSM Production Worker URL Repair Authorization

Date: 2026-09-11 America/Toronto

Chris explicitly authorized setting the PRYSM production `VANTAGE_WORKER_API_URL` to `https://vantage-platform-production.up.railway.app` and redeploying/promoting production only as required to apply that environment configuration and verify the dashboard and TBK report work.

Scope exclusions: no unrelated code changes, model calls, provider recollection, GitHub push, or main merge.

Known root cause: production server-side worker requests fall back to `http://localhost:3000` because `VANTAGE_WORKER_API_URL` is absent at runtime, causing `ECONNREFUSED 127.0.0.1:3000`.

Authorized next action: repair the production Vercel environment variable for project `prysm`, redeploy production only as needed to pick up the new environment, and verify dashboard plus TBK report connectivity to the Railway worker.