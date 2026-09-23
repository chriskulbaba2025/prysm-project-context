# PRYSM CA14 crawl production activation

Date: 2026-09-23

Status: PRODUCTION ACTIVATED

Target repair: CA14 crawl discovery / www-apex sitemap same-site normalization.

Exact application SHA: `aea98ed497827c89ce030a7670ce834611681d0b`

GitHub:
- Repository: `chriskulbaba2025/vantage-platform`
- `main` fast-forwarded from `f5c512150ac31849c4d042c631493168bd1ac378` to `aea98ed497827c89ce030a7670ce834611681d0b`
- No force push.
- Candidate was exactly two commits ahead of main: generalized code/test repair plus governance closure record.

Vercel production:
- Project: `prysm`
- Deployment: `dpl_BcpCrBnCkg72i5WDFQHpKmhkQLJc`
- Status: READY
- Target: production
- Branch: `main`
- Git SHA: `aea98ed497827c89ce030a7670ce834611681d0b`
- Production aliases include `prysm.omnipresence.com`.

Railway production:
- Project: GENSEN process
- Environment: production
- Service: `vantage-platform`
- Deployment: `7105c147-6d38-4c26-8b09-10cc8d8528a9`
- Status: SUCCESS
- Branch: `main`
- Git SHA: `aea98ed497827c89ce030a7670ce834611681d0b`
- Startup confirmed PostgreSQL lifecycle/identity initialization, governed API v1, production adapters, S3 artifact-store connectivity, and worker listening on port 8080.

Known existing operational debt remained visible in startup logs for stranded historical audits with missing persisted AuditRequest records and one recovery-sweep ReportViewModel validation failure. These were not introduced by the CA14 sitemap repair and were not modified during this activation.

Repair provenance:
- Root cause: literal origin comparison rejected valid apex sitemap URLs when the target used `www`.
- Repair: bounded `www`/apex hostname normalization inside sitemap footprint same-site filtering.
- No CA14-specific logic.
- Targeted tests: 90/90 PASS.
- Full worker regression: 1053/1053 PASS.
- Generalization: PASS.
- Adversarial: PASS.
- Independent verification: PASS.
- Paid calls during repair/activation: 0.

Production promotion was explicitly authorized by Chris in chat on 2026-09-23.
