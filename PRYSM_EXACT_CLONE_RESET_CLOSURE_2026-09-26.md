# PRYSM Exact Clone Reset Closure — 2026-09-26

## Result

`PRYSM_EXACT_CLONE_RESET_BLOCKED`

## Verified reset

The staging main branch was advanced without force-push from the forensic hybrid state to `af787bbf8ce6019702d2a76b4e82f5d874fb6ad6`. Its complete tracked tree matched production SHA `26fb91d29559cb189064c301cdf89ff69f330492` exactly: tree `c65a41686e3d45f77d7f1d937da2ba6a4068c3b8`, 1,110 tracked files, and equal path/blob mappings.

Railway deployment `f3e520ff-aa41-48cd-8010-c9502c83d257` succeeded with the exact reset SHA. Vercel deployment `dpl_6EnFNNH3bw6Q6X8gvfCkVGoEMWXp` was READY and reported the same Git SHA for the isolated staging project.

## Bounded test audit

Exactly one fresh audit was created: `d0911546-80ea-49d4-94cc-afc5e57892d7` (execution `e047b383-1d0b-4d8c-b12b-09405dc974c4`). It reached `draft_rendered`; 44 governed objects were recovered. The report manifest contained 16 pages.

The audit exposed defects in the approved production source/configuration boundary: SERP could not resolve `London, Ontario`, and PageSpeed remained `NOT_CONNECTED` because the source path required `PAGESPEED_API_KEY` rather than consuming the configured staging key path. The fail-closed rule prohibits repairing these defects in the clone-reset tranche and prohibits a second audit.

## Proof

`C:\Users\kulba\Downloads\PRYSM-EXACT-CLONE-RESET-2026-09-26\`
