# PRYSM Model Routing and Whole-System Preflight Protocol

Date: 2026-09-09
Status: GOVERNING DEVELOPMENT PROTOCOL — ACTIVE

## Purpose

Reduce rework, token burn, and repeated one-defect-at-a-time external review by matching model capability to task difficulty and requiring whole-system invariant closure before external Betty review.

This protocol does not weaken any evidence, release, production, or independent-review boundary.

## Model routing

### Terra High — default for semantic/governance work
Use Terra High for:
- architecture diagnosis;
- authority tracing;
- cross-file semantic audits;
- whole-system invariant audits;
- repair-boundary selection;
- consolidated governance-sensitive implementation;
- interpretation of hidden/indirect client-facing behavior;
- adversarial self-review when Sol is not being used.

PRYSM Solution Depth work currently defaults to Terra High because the dominant risks are semantic authority leakage, evidence-policy preservation, and cross-renderer behavior rather than mechanical code generation.

### Luna Medium — mechanical work only
Use Luna Medium only when all of the following are already frozen:
- root cause;
- file boundary;
- acceptance conditions;
- preservation boundary;
- direct proving tests.

Appropriate Luna work includes narrow mechanical edits, fixture updates, repetitive test additions, and low-ambiguity refactors that do not decide architecture or evidence semantics.

Do not use Luna Medium as the primary auditor for unresolved authority/governance problems.

### Sol High — adversarial preflight / hardest unresolved problems
Use Sol High when available for:
- final adversarial review of a consolidated candidate before external Betty;
- unresolved architectural ambiguity after a Terra High diagnosis;
- high-risk release-preflight reasoning where a false positive would be expensive.

Sol is not the default Builder. It is an escalation and independent preflight layer.

## Whole-system invariant rule

Do not use the sequence:

`visible defect -> micro-repair -> Betty -> next visible defect -> micro-repair -> Betty`

for a class of defects that clearly shares one architectural invariant.

Instead use:

`whole-system invariant diagnosis -> exhaustive surface inventory -> consolidated bounded repair -> permanent invariant tests -> adversarial preflight -> Betty`

## Required invariant audit

When an authority/governance defect is found, the diagnosis must inspect every reachable implementation surface governed by the same invariant before implementation starts.

For the current Solution Depth authority closure, the invariant is:

**Canonical solutions are the sole source of client remediation anywhere in the final client artifact.**

The audit must inspect all final HTML emitters and all supporting helpers that can produce action-like client copy, not only the file named in the latest defect.

Every client-facing instruction/recommendation/action must be classified as one of:
1. canonical remediation derived from a stable canonical solution record;
2. canonical summary/reference tied to the same solution ID;
3. non-remedial evidence/context/limitation;
4. competing remediation authority that must be removed or replaced.

## Permanent invariant tests

A consolidated repair is not complete until tests prove the class of defect cannot easily recur.

For remediation authority this includes, where applicable:
- canonical solution IDs required for client action blocks;
- mutation invariance: changing WriterOutput, legacy Finding recommendation/businessImpact/verificationMethod/affectedUrls, or other non-canonical remedy prose cannot change client remediation while canonicalSolutions are fixed;
- no hidden/CSS-only remediation escape hatch;
- no hard-coded imperative/action list can become an independent remedy source;
- cross-page summaries preserve canonical ID/order/evidence/prescription semantics;
- unsupported/missing canonical authority fails closed instead of falling back.

Keyword scans may assist discovery but are never sufficient proof by themselves.

## External Betty cadence

During the active solo-development exception, do not spend an external Betty checkpoint on every micro-repair in the same defect class.

Use Terra High to close the full invariant, then run a separate adversarial preflight (Sol High when available; otherwise a fresh Terra High review context) over the complete candidate and diff.

Return to external Betty at the next material architecture checkpoint and before any release-governance advancement.

External Betty remains required before merge to application main, deployment, production promotion, provider/model execution for release, production audit rerun, or other production mutation.

## Prompt-size discipline

Do not repeatedly paste the entire project history into Codex.

New execution prompts should point to authoritative GitHub files and include only:
- repo / branch / exact SHA;
- task mode and selected model/effort;
- exact current objective;
- explicit file boundary or diagnosis scope;
- preservation rules that materially affect the current task;
- required proof artifact;
- exact stop condition.

The reusable governance files carry the durable rules.

## Proof discipline

Any Codex run longer than 10 lines must write a Downloads proof artifact containing:
- result;
- starting and ending SHA when code changed;
- exact changed files;
- pass/fail/skipped counts;
- durations;
- diff check;
- provider/model/deploy/production mutation declarations;
- next gate.

## Release boundary

This protocol accelerates development only. It does not authorize:
- application main merge;
- deployment;
- production promotion;
- provider/model execution for release;
- audit rerun;
- production data mutation;
- weakening evidence/scoring/Writer/Judge/lifecycle/persistence/report contracts.
