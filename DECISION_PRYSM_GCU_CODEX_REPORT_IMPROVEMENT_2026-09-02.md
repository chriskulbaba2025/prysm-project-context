# Decision: PRYSM report improvement will use Codex under Governed Coding Upgrade

Date: 2026-09-02
Status: Active

## Decision

The next PRYSM report-improvement package will be executed through Codex using the canonical `governed-coding-upgrade` protocol from:

`chriskulbaba2025/governed-coding-upgrade-skill`

Protocol target at adoption:

`GCU v2.4.0 — Verification Integrity`

Codex is the execution agent. GCU is the governing change protocol. PRYSM GitHub governance remains the authoritative project state.

The work package is governed by:

`PRYSM_GCU_REPORT_IMPROVEMENT_WORK_ORDER_2026-09-02.md`

## Reason

The September 1 TBK report and team review show a mixture of:

- report-language and presentation improvements;
- cross-report consistency requirements;
- actionability/output-contract improvements;
- upstream evidence-selection and competitor-selection questions;
- possible schema/entity mapping defects;
- model-bearing content-strategy improvements;
- future consultant-control capabilities.

Treating all of these as one report rewrite would create unacceptable scope and false-PASS risk. GCU provides the required evidence-first discipline: preserve the requested outcome, prove root cause or design gap, freeze the smallest justified change surface, verify the actual defect, prove assembled-system branches, invalidate stale proof after candidate changes, apply model-bearing release proof when stochastic behavior is materially changed, and independently audit the exact candidate.

## Operating model

1. Codex must read PRYSM authoritative governance before substantive work.
2. Codex must read the canonical GCU `SKILL.md` and `GLOBAL_AGENT_RULE.md` before editing.
3. The team review is requirements/evidence input, not automatic authorization to implement every suggestion.
4. Each workstream is a separately governed tranche.
5. Each tranche begins with Requirement Preservation and the Diagnostic Evidence Gate.
6. A material `UNRESOLVED` cause blocks code edits.
7. Every implementing tranche freezes a Surgical Change Contract before editing.
8. Discovery of adjacent defects does not create permission to change them.
9. No tranche may be called PASS from targeted tests alone when branch-complete assembled-system proof is applicable.
10. Any model/prompt-bearing tranche must satisfy the PRYSM Model-Bearing Release Gate and applicable GCU model-bearing proof before production-readiness claims.
11. Exact-candidate proof becomes stale if governed candidate content changes afterward.
12. Independent post-run audit is required before a tranche or combined candidate is closed when the governing PRYSM package requires independence.
13. Three failed evidence-based repairs against the same root defect require a diagnostic reset before a fourth repair.
14. Merge to `main`, deployment, production configuration mutation, paid provider/model execution, and a new production audit remain owner/release-authority actions and are not inferred from green verification.

## Architectural boundary

Report improvements remain inside the existing PRYSM production path.

Do not create a second report-generation source of truth in n8n or another external workflow.

Do not modify n8n merely to restructure, rewrite, clarify, or visually improve report output.

When a team note points to an upstream evidence or capability problem, diagnose that upstream boundary and repair it only if direct evidence proves the defect/design gap and the tranche is explicitly authorized under GCU.

## Protected product invariants

The following must be preserved unless a later explicit decision supersedes them:

- evidence humility: unavailable/partial evidence is not converted into failure;
- ranked Priority Fix architecture;
- explicit limitations;
- restrained business-consequence language;
- canonical evidence immutability;
- current scoring semantics unless a separately proven scoring defect requires change;
- Writer/Judge quality gates;
- no unsupported market, revenue, compliance, or causal claims;
- existing production lifecycle, storage, authentication, and audit identity unless causally required by an explicitly authorized tranche.

## Implication

The previous manual one-source-file-at-a-time report-edit method is not the execution mechanism for this package. Codex may perform bounded multi-file changes when the frozen Surgical Change Contract proves they are causally required, but it must remain within the workstream boundary and pass the full GCU proof sequence.

The exact starting application `main` SHA at adoption is:

`9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`

Codex must re-verify local/remote identity and working-tree state before beginning; this recorded SHA is not permission to overwrite a newer state.