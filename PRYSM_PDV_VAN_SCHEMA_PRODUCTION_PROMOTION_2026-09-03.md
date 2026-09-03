# PRYSM VAN-SCHEMA exact-candidate promotion record

Date: 2026-09-03

Audited/promoted application SHA: `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec`

Application promotion:
- `origin/main` fast-forwarded from `08734785c0a0fc415e331ac216e22e64545a533e` to the exact candidate SHA.
- No merge commit or candidate-content modification was used.

Deployment identity and health:
- Railway deployment: `cb1fd075-5220-4453-9184-b8bda483ed73`
- Railway status: `SUCCESS`
- Railway metadata `commitHash`: `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec`
- Railway production URL: `https://vantage-platform-production.up.railway.app`
- Read-only `GET /health`: HTTP `200`, `{"status":"ok","service":"prysm-worker","version":"0.2.0"}`
- Vercel production deployment: `prysm-geon9sa8z-chriskulbabas-projects.vercel.app`
- Vercel status: `READY`
- Vercel production alias health: HTTP `200`

Scope confirmation: no fresh live/paid provider or model call was made. No production configuration was changed.
