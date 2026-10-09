# PRYSM — Intake, Buyer Intent and Adam Update Discussion

Date: 2026-10-09
Status: DISCUSSION / PROPOSED — NOT an approved execution tranche or product release
Record type: Planning reference, not governing product truth
Application repository: `chriskulbaba2025/prysm-staging-isolated`
Context repository: `chriskulbaba2025/prysm-project-context`

## 1. Proposed New Audit form

Chris reviewed a visual HTML mockup derived from the existing staging New Website Audit page. It is a standalone visual prototype, **not** a coded/staging implementation or frozen approved design.

Preserve existing intake capabilities: website URL, live/staging/development status, primary site type, site characteristics, business name, services/offers, primary market, competitive scope, up to three explicitly supplied competitors, and existing audit functionality.

Proposed additions and presentation:
- Site-type-specific **primary** conversion goal (required).
- **Secondary** and **tertiary** conversion goals (optional, with None).
- **Primary target audience** (proposed required short free-text field).
- **Important business context** (proposed optional free-text field).
- Rename the present "Competing audience" label to "Competitive market scope" without silently changing its meaning or dropping persisted fields.
- Group form visually into: (1) website/basic details; (2) site type/characteristics; (3) audience/context; (4) conversion goals; (5) competitive context.
- These additions are design proposals only; reconcile with actual current validation and storage contracts before approval.

Formal intent taxonomy proposed by Chris:

- **Service / Lead Gen:** Generate enquiries or leads; Book appointment/consultation; Request quote/estimate/proposal; Call/contact directly; Find/visit location; Other.
- **Ecommerce:** Purchase a product; Find/visit location; Subscribe/membership; Create account; Other.
- **SaaS / B2B:** Book demo/sales conversation; Start trial/create account; Generate leads; Subscribe; Download/request resource; Other.
- **Content / Publisher:** Grow readership; Newsletter signup; Subscribe/become member; Donate/contribute; Other.
- **Marketplace / Directory:** Find/compare/connect; Create listing/profile; Create account; Purchase/book; Other.

**Proposed reasoning chain:** site type → business goal (primary, secondary, tertiary) → visitor/buyer intent → buyer questions → relevant evidence/checks → governed findings → recommendations. Business goals are not the same as visitor needs. Buyer questions are hypotheses to assess, NOT universal mandatory checklists or automatic negative findings.

## 2. Code-read findings (read-only, branch inspected on 2026-10-09)

Branch inspected: `repair/prysm-audit-intelligence-t1-t3-20261007`; latest GitHub branch commit observed: `ce003b86d62337f06cb948e74a0eac9244eb2123` (commit identity does not certify deployment).

- `app/audits/new/page.tsx`: existing React/Next.js form; site type, status, modifiers and primary conversion goal already present. Standalone HTML must be translated into that component, not dropped into the application verbatim.
- `lib/audit-request.ts`: existing validation/payload shape, with a `primaryGoal` string and no declared secondary/tertiary goal or target audience fields.
- `services/worker/src/application/intake-contract.js`: governed intake validation.
- `services/worker/src/application/audit-service.js`: explicitly builds persisted `auditRequest`; new fields require deliberate pass-through.
- `services/worker/src/contracts/audit-request.schema.json`: `additionalProperties: false`; undeclared fields are rejected.
- `services/worker/src/trust/buyer-decision-context.js`: existing governed buyer-decision questions and materiality/provenance contract; must be reused/reconciled rather than bypassed.
- `services/worker/src/narrative-v2/writer-business-context.js`: explicit allow-list of Writer context fields; new information will not automatically reach the narrative.
- Current UI `audienceScope`/“Competing audience” state was not included in the submitted `buildAuditPayload` path at inspection; investigate its intended authority before changing it.
- `services/worker/src/report/snapshot-v1.js`: projects NDP priorities and has generic client-facing text/fallback logic; do not patch presentation as a substitute for an upstream semantics repair.
- `services/worker/src/report/action-priority.js`: conversion-first influence and evidence-confidence ranking already exist.

No application code edits, model/provider calls, fresh audits, staging deployments, or production operations resulted from this discussion or code read.

## 3. “Adam update” — 14-report Snapshot quality audit

Chris refers to the supplied “PRYSM Snapshot Cross-Report Audit” as the **Adam update**. Its 14-report observations (not independently revalidated against the latest staging runtime) include:
- 42/42 priority pairs repeat evidence under “Why it matters”.
- 14/14 Snapshots recommend generic structured-data work.
- 9/14 performance priorities lack useful diagnostic detail.
- 13/14 show “no additional strengths” even next to high scores.
- Other categories: weak business-specific advice; detectable technical issues over business consequence; vague CTA-obstruction evidence; mechanical metadata prescriptions; unclear labels; score/strength/priority contradictions; competitor role confusion.

Direction: evidence-specific observation → distinct buyer/business consequence → qualified action → diagnostic starting point → verified outcome. Preserve source evidence, explicit unknown/unavailable/partial truth, canonical scores, NDP authority, authorized competitor inputs, client report architecture and approved-report immutability.

**Do not treat the entire Adam audit as currently reproducible defects.** Read-only gap analysis must classify which observations remain in current staging, which have already been addressed, and which are report-only vs evidence, scoring, classification, prioritization, or NDP problems. Fix generalized owning boundaries, not 14 named client fixtures. Keep Snapshot concise and Executive report deep; do not add report pages automatically.

## 4. Rough work / time estimates — NOT acceptance evidence

Chris challenged generic 2–4-week estimates based on much faster observed governed Codex throughput. GitHub commit chronology from 2026-10-07 shows tightly grouped changes; commit spacing is not validated end-to-end elapsed execution time.

Working forecast for discussion only:
- Intake layout and persisted fields: roughly **1.5–3 hours**.
- Intent intelligence and remaining Adam repairs: roughly **4–9 hours**.
- Final testing/currentness/staging: roughly **1.5–3 hours**.
- Overall provisional planning range: **8–16 active hours**, with uncertainty until actual gaps, constraints and acceptance gates are established.

Do not imply a runtime or release PASS from these estimates.

## 5. Execution boundaries and next consideration

- No implementation has been authorized in this conversation. Visual mockup is for discussion.
- Treat UI, data contract/persistence, intent intelligence and Adam report-quality repairs as separable bounded tranches; do not automatically proceed between them.
- Diagnose current code and real report outputs before scope/fix freeze.
- Production read-only without explicit approval. No GENSEN changes.
- Do not assume branch SHA equals Vercel/Railway deployment SHA. Confirm service, repository, branch, commit, environment and alias separately when runtime/currentness is relevant.
- Do not silently overwrite earlier frozen presentation contracts, canonical evidence, score authority, NDP authority or report publication semantics.

**Exact proposed next discussion action:** Confirm the final New Audit page and required/optional fields, then authorize a bounded *read-only* compatibility/gap diagnosis before the first intake implementation tranche. Independent urgent production recovery/status must be resolved separately; this planning note is not a deployment authorization.
