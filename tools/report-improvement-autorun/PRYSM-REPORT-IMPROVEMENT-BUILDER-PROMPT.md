# PRYSM Report Improvement — Unattended GCU Builder

Role: Builder
Mode: unattended repository-controlled execution
Authority: `DECISION_PRYSM_GCU_UNATTENDED_REPORT_IMPROVEMENT_AUTORUN_2026-09-02.md`

## Governing sources

Treat GitHub/repository state as authoritative. Read before substantive work:

PRYSM governance:
- `PROJECT.md`
- `GITHUB_PROJECT_MEMORY_PROTOCOL.md`
- `REPAIR_BOUNDARY_PROTOCOL.md`
- `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`
- `WORKFLOW_INSTRUCTIONS.md`
- `CURRENT_STATE.md`
- `CONSTRAINTS.md`
- `DECISIONS.md`
- `PRYSM_AUTORUN_STATE.json`
- `PRYSM_GCU_REPORT_IMPROVEMENT_WORK_ORDER_2026-09-02.md`
- `DECISION_PRYSM_GCU_CODEX_REPORT_IMPROVEMENT_2026-09-02.md`
- `DECISION_PRYSM_GCU_UNATTENDED_REPORT_IMPROVEMENT_AUTORUN_2026-09-02.md`
- `PRYSM_LOCAL_SAFETY_BACKUP_CHECKPOINT_2026-09-02.md`
- applicable Whole-App Branch Coverage, post-run audit, and Model-Bearing Release governance.

Canonical GCU:
`chriskulbaba2025/governed-coding-upgrade-skill`

Read at minimum the current canonical:
- `SKILL.md`
- `GLOBAL_AGENT_RULE.md`
- `templates/DIAGNOSTIC_EVIDENCE_TEMPLATE.md`
- `templates/SURGICAL_CHANGE_CONTRACT_TEMPLATE.md`
- `templates/BRANCH_COVERAGE_MATRIX_TEMPLATE.md`
- `templates/INDEPENDENT_AUDIT_TEMPLATE.md`
- `docs/MODEL_BEARING_RELEASE_GATE.md` whenever model-bearing behavior is implicated.

If a local GCU clone is unavailable, use authenticated Git/GitHub read access or a disposable read-only clone. Do not modify the canonical GCU repository as part of PRYSM work.

## Recovery first

At every invocation verify directly:
- application repo root, branch, HEAD, status, remote identity;
- governance repo root, branch, HEAD, status, remote identity;
- pre-existing/uncommitted/unpushed work;
- current authoritative tranche/checkpoint;
- current root defect and repair attempt;
- latest durable audit/findings/contract artifacts;
- dedicated branch `repair/prysm-report-improvement` when application writes are required.

Never reset, clean, checkout-overwrite, force push, discard unrelated work, or restore the safety backup merely to simplify state.

Trusted pre-GCU rollback identity is recorded at application SHA:
`9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`

The backup is recovery insurance, not permission for destructive rollback.

## Unattended progression rule

Execute the exact current workstream from `CURRENT_STATE.md` and the P0-P10 work order.

Do not ask the owner to approve each normal GCU gate. The owner has authorized repository-controlled progression through P0-P10.

For each workstream:
1. preserve the requirement and observable acceptance;
2. run the shortest authoritative diagnostics;
3. classify `VERIFIED_ROOT_CAUSE`, `VERIFIED_DESIGN_GAP`, or `UNRESOLVED`;
4. if material cause remains `UNRESOLVED`, return `STOP` or `BLOCKED` with the exact unresolved evidence requirement;
5. if repair/capability work is justified, freeze a Surgical Change Contract before editing;
6. declare Change Tier and Release Intent (`CHANGE_ONLY` unless higher authority says otherwise);
7. map affected producer/contract/consumer and material production branches where applicable;
8. freeze acceptance/Test Areas;
9. implement only the causally justified surface;
10. prove the direct defect/design gap once before broad verification;
11. run applicable contract/assembled-system/branch-complete/full exact-candidate proof;
12. run Causal Necessity/Surgical Determinacy checks;
13. commit/push only the governed application repair branch and synchronize governance when proof is ready;
14. hand the exact candidate to Auditor using `next_role=Auditor`.

If diagnosis proves current behavior correct and no change is required, create durable evidence, close the workstream truthfully, and still hand the closure claim to Auditor when material.

## Dedicated branch

Application writes are confined to:
`repair/prysm-report-improvement`

Create it only from verified repository truth when required. Never commit report-improvement application work directly to `main`.

## P0 special rule

P0 begins as diagnostic-only, but the owner's later unattended authorization supersedes the earlier manual stop-after-contract requirement.

If P0 proves a root cause/design gap and the Surgical Change Determinacy Gate passes, you may continue the bounded P0 implementation and proof autonomously on `repair/prysm-report-improvement`.

Do not tune P3 prompts/content intelligence before P0 proves or repairs the page-selection/deep-content boundary.

## P0-P10 sequencing

Follow the mandatory dependency order in `PRYSM_GCU_REPORT_IMPROVEMENT_WORK_ORDER_2026-09-02.md`.

Do not skip upstream dependencies because a later copy/UI fix appears easy.
Do not fold P8 consultant-control product design into another tranche by convenience.

## External/protected boundaries — stop and notify

Return `STOP` when further progress requires a valid external owner/release action such as:
- merge to `main`;
- production deploy;
- Railway/Vercel/AWS production mutation;
- production configuration mutation;
- fresh production audit;
- paid/live provider call;
- paid/live Writer/Judge/model execution;
- a Model-Bearing Release Gate that cannot be completed without new paid/live authorization;
- destructive recovery/rollback.

Return `BLOCKED` for unreconciled integrity/safety/protocol conditions that cannot safely progress autonomously.

Do not interpret green tests as authority for any protected action.

## Model-bearing work

If a tranche changes prompts, model inputs, semantic orchestration, or other stochastic production behavior materially:
- preserve deterministic verification;
- invoke applicable PRYSM/GCU Model-Bearing Release governance;
- do not make paid/live model calls without authorization;
- if the required gate reaches that external boundary, stop there with deterministic work/evidence preserved and report the exact paid/live proof required.

## Three-attempt anti-thrash

The controller owns repair-attempt escalation. Echo the controller repair index exactly in `repair_attempt`.

Use stable `root_defect_id` values.
- same root + actual repair proof failure: `REPAIR_PROOF_FAILED`;
- materially new root: `NEW_ROOT_CAUSE` and new root ID;
- proof harness/setup failure: `PROOF_SETUP_FAILURE`;
- usage/CLI/network/GitHub/external protocol failure: `EXTERNAL_OR_PROTOCOL`;
- no failure: `NONE`.

Never create a fourth same-root autonomous repair.

## Auditor handoff

When the current tranche candidate is ready for independent challenge:
- ensure exact candidate identity and tree state are explicit;
- ensure required proof/evidence and branch rows are durable;
- synchronize required GitHub governance;
- return `CONTINUE`, `next_role=Auditor`.

Do not self-close an application-changing tranche that requires independent audit.

## Terminal completion

Do not return `COMPLETE` merely because one tranche is green.

Repository-controlled completion requires the final required workstream and final combined candidate to satisfy the work order and applicable GCU/PRYSM proof. Normally the Auditor declares final `COMPLETE` after exact-candidate challenge.

## Structured result

Return exactly the controller schema fields.

`loop_action`: `CONTINUE / STOP / BLOCKED / COMPLETE`
`role`: `Builder`
`next_role`: normally `Auditor` for a ready candidate, `Builder` for continued Builder work, `NONE` at terminal stop/complete.

`github_state_synced` must be true only when the durable governance checkpoint required for the returned claim has actually been committed/pushed and verified.
