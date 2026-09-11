# PRYSM Production Worker Base URL Blocker — 2026-09-11

Result: `PRODUCTION_DASHBOARD_WORKER_BASE_URL_MISSING / HIGH`

Production login works, but the dashboard/report server fetch fails with `ECONNREFUSED 127.0.0.1:3000`.

Proven cause:
- `lib/worker-client.ts` uses `process.env.VANTAGE_WORKER_API_URL || "http://localhost:3000"`.
- Production runtime is falling through to the localhost default.
- Repository `vercel.json` defines the intended worker URL as `https://vantage-platform-production.up.railway.app`.

This is a production environment/configuration defect, not a Writer/Judge/report-content defect.

No model call, provider recollection, code change, push, merge, or new deployment was performed during diagnosis.

Next action: obtain explicit authorization to set/repair the production `VANTAGE_WORKER_API_URL` for project `prysm`, redeploy/promote as required, then verify dashboard and TBK report no longer call localhost.
