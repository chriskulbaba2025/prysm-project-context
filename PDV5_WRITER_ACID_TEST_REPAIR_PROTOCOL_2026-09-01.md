# PDV5 Writer Acid-Test Repair Protocol — 2026-09-01

Status: ACTIVE / BUILDER AUTHORIZED

## Purpose

PDV5 exists because a fresh TBK production audit (`aab3c6f9-0cfd-44fb-a263-5c02f6834d8d`) reached `narrative_pending` and failed on Writer pass 1 even after PDV4 repository-controlled gates had passed. This proves that the previous verification surface gave false confidence about the live Writer/Narrative path.

The objective is not to patch one visible validation string. The objective is to make the Writer process survive production-shaped evidence, expose blind spots deterministically, improve the proof mechanism that allowed this escape, and refuse closure until the repaired system survives repeated adversarial verification.

## Owner authorization

The owner has explicitly removed cost minimization as a constraint for PDV5 Writer/Judge validation. Paid Writer/Judge calls are authorized when they materially improve diagnosis or verification. Do not avoid a necessary Writer/Judge call merely to save cost.

This authorization does NOT mean blindly rerun full production audits. Reuse already-persisted production evidence and Writer inputs whenever that isolates the narrative path more efficiently. A fresh full production crawl/audit should occur only when the repaired Writer path has passed its governed acid tests and a live end-to-end validation is materially useful.

## Governing execution method

Use the existing PRYSM Production Closure autorun controller:

`tools/autorun/PRYSM-AUTORUN.ps1`

Do not replace the governed Builder/Auditor loop with an ad-hoc standalone Codex workflow.

## Phase 1 — recover exact state

Before any edit:

- fetch application and governance remotes;
- record branch, HEAD, origin/main, upstream, ahead/behind, tracked and untracked changes;
- preserve legitimate dirty work;
- never reset --hard, clean, force-push, or discard unrelated work;
- prove current application and governance state from GitHub.

## Phase 2 — reproduce the real Writer failure

For audit `aab3c6f9-0cfd-44fb-a263-5c02f6834d8d`:

- discover exact persisted artifact paths from source/storage; do not guess;
- read the exact governed WriterInput;
- read the exact parsed Writer pass-1 provider response persisted before normalization/validation;
- preserve provenance and SHA-256 hashes;
- run the exact production normalization/validation boundary against those bytes;
- capture the complete validation error list, not the truncated lifecycle/UI reason.

If the exact stored failure cannot be reproduced, stop source repair and find the replay/production mismatch first.

## Phase 3 — prove production runtime identity

Separately prove which Railway PRYSM worker revision executed the failed audit. Do not infer it from GitHub main or Vercel UI deployment.

Return either:

- `PROVEN SHA <sha>`; or
- `UNPROVEN`.

If deployment identity is unreliable, treat that as an independent release-proof defect.

## Phase 4 — map root causes before editing

Trace:

DecisionEvidence/findings/scores -> WriterInput/referenceIndex -> prompt -> structured output/schema -> provider response -> raw/parsed persistence -> normalization -> Writer validator -> semantic validator -> orchestrator/lifecycle.

Test for at least:

- prompt/validator disagreement;
- schema/validator disagreement;
- missing WriterInput information;
- valid-but-semantically-irrelevant evidence refs;
- normalization drift;
- false-positive validation;
- false-negative validation;
- broad regex behavior;
- stale prompt/output contract/runtime versions;
- production-vs-test loader drift;
- mocks bypassing the failing seam;
- cross-section contradictions;
- redundant report prose;
- action-plan/root-cause disagreement;
- certainty stronger than evidence warrants;
- verification branches that existed only nominally and did not traverse production-shaped data.

Materially distinct roots remain distinct for repair accounting.

## Phase 5 — real production corpus

Build a permanent offline corpus from persisted real production artifacts.

Minimum targets:

1. `aab3c6f9-0cfd-44fb-a263-5c02f6834d8d` — current Writer failure.
2. `688e0cd2-7e09-4b2c-8e20-d05e507f5b7d` — prior TBK run that traversed Writer/Judge and later exposed PDV4 finalization defects.
3. At least one additional real persisted Writer run that historically progressed successfully, if one actually exists.

Do not fabricate a successful fixture.

Preserve audit ID, WriterInput, exact parsed Writer response, required governed evidence, expected outcome, and artifact hashes.

Real persisted artifacts are the primary benchmark. Synthetic fixtures are supplemental.

## Phase 6 — smallest coherent architecture repair

Only after reproduction/root-cause proof:

- create/recover the governed PDV5 repair branch;
- fix the actual producer/contract/consumer boundary;
- fix the verification escape that allowed the defect through;
- do not weaken a correct validator merely to accept bad Writer prose;
- if the validator is wrong, fix only the proven false-positive and add negative siblings;
- if schema/prompt permit output that runtime forbids, align them;
- if WriterInput cannot support the required claim, repair WriterInput/reference semantics.

## Phase 7 — real Writer/Judge shaping verification

Cost is not the blocker.

After the deterministic root is proven and a candidate repair exists, run bounded real Writer/Judge calls against stored production-shaped inputs when useful to prove the shaping process itself.

Requirements:

- use stored evidence/WriterInput rather than recrawling when possible;
- record model, prompt/schema versions, pass number, output artifact hashes, validation outcome, Judge outcome, and cost;
- do not accept one lucky model output as proof;
- require repeated successful shaping against the same production-shaped input and multiple corpus inputs where available;
- if model variability exposes another material failure mode, classify and repair it rather than masking it.

## Phase 8 — permanent Writer acid tests

Create a permanent production-shaped suite covering all of the following.

### A. Exact failed production replay

Persisted WriterInput + persisted Writer output must traverse production normalization and production validation. Run independently at least twice and require deterministic results.

### B. Historical real-positive replay

Historically valid production-shaped outputs remain valid.

### C. Structural adversarial cases

Reject for the intended reason:

- missing required fields;
- unknown fields;
- invalid statement class;
- wrong OPPORTUNITY/INTERPRETATION class;
- empty/unknown/duplicate evidence refs;
- duplicate priorities;
- URLs, HTML, Markdown in prose;
- invalid/conflicting limitation status;
- excessive word length.

### D. Epistemic adversarial cases

Reject:

- UNKNOWN -> absence;
- UNAVAILABLE -> zero;
- PARTIAL -> whole-site assertion;
- NOT ASSESSED -> zero/failure;
- unsupported `no/missing/absent` claims;
- unsupported causality;
- guaranteed commercial outcomes;
- fabricated observations/competitive claims;
- unavailable denominator converted into a ratio;
- positive numerator turned into a whole-site rate without a valid denominator.

### E. Semantic citation relevance

A valid ref ID is not sufficient. Prove that cited evidence semantically supports the claim. Reject domain-mismatched citations such as AI-search claims citing unrelated performance evidence.

### F. Bounded-language positives

Pass truthful equivalents including:

- `assessed pages ...`;
- `within the available assessment ...`;
- `not detected in the assessed sample ...`;
- `available evidence does not establish ...`;
- `unassessed pages remain unknown ...`.

Equivalent unqualified whole-site claims must fail. Do not overfit one exact phrase.

### G. Cross-section consistency

Check executive conclusion, root cause, conversion, SEO, AI search, technical, limitations, action plan, and executive decision for material contradictions.

### H. Redundancy/non-repetition

Detect repeated claims that add no new decision value. Do not punish legitimate references to the same root cause, but reject meaningless repetition across sections.

### I. Prompt/schema/validator parity

Create a deterministic mapping for every material hard runtime rule:

RULE -> WRITER INSTRUCTION -> SCHEMA/STRUCTURAL CONSTRAINT -> VALIDATOR -> POSITIVE TEST -> NEGATIVE TEST.

Any unexplained material mismatch is FAIL.

## Phase 9 — five semantic quality areas

Score the real Writer outputs in exactly five areas, 20 points each:

1. Evidence Fidelity.
2. Semantic Traceability.
3. Decision Quality.
4. Coherence and Non-Redundancy.
5. Client Actionability.

Required closure threshold:

- >= 97/100 overall;
- no area below 19/20;
- zero critical evidence-integrity defects.

Every deduction names the exact output path and reason. Do not inflate scores.

When behavior changes, record before and after scores.

## Phase 10 — brutal red-team pass

After the candidate first passes, assume it is wrong and attempt to invalidate it.

Search for:

- overfitted regexes;
- TBK-specific hardcoding;
- happy-path fixtures;
- stale data;
- mocks at the wrong layer;
- tests that never traverse production normalization/validation/WriterInput;
- hidden source-state conversions;
- valid-but-irrelevant citations;
- cross-section contradictions;
- nondeterminism;
- missing material branches;
- deployment/runtime mismatch;
- stale prompt/schema versions;
- fixture preprocessing that production does not perform;
- dirty/untracked evidence.

For every claimed PASS ask: `What concrete counterexample would make this false?` Construct and test that counterexample where practical.

## Phase 11 — failure injection

Create production-shaped injected failures for at least:

- malformed WriterInput;
- structurally valid but semantically incomplete WriterInput;
- malformed provider output;
- structurally valid but semantically unsupported output;
- valid refs in wrong semantic domain;
- partial/unknown overclaim;
- contradictory sections;
- action hierarchy disagreement;
- limitation-status disagreement;
- oversized prose;
- invalid opportunity classification;
- normalization edge cases.

Each must be caught at the intended boundary.

## Phase 12 — improvement loop

For the same proven root, maximum three repair attempts.

Each attempt:

1. diagnose exact root;
2. smallest coherent correction;
3. run one direct proving test first;
4. if direct proof passes, run the PDV5 acid suite;
5. re-score the five semantic areas;
6. red-team again.

A genuinely new root receives separate accounting.

## Phase 13 — whole-app exact-SHA proof

Only after Writer acid tests pass:

- freeze one exact candidate SHA;
- map and execute PDV5 material branches in Whole-App Branch Coverage;
- run complete applicable worker regression;
- run Narrative v2 and report integration/finalization regressions;
- run build/type/lint/scope gates as applicable;
- run `git diff --check`;
- require clean worktree including untracked files;
- candidate SHA must remain unchanged throughout verification.

N/N tests are insufficient if a material branch is unexecuted.

## Phase 14 — test everything again

After the system first appears complete, start a second clean verification from original persisted production artifacts.

Repeat:

- exact failed replay;
- real historical positive replays;
- structural adversarial suite;
- epistemic suite;
- citation relevance suite;
- bounded language suite;
- cross-section consistency;
- redundancy checks;
- prompt/schema/validator parity;
- five-area semantic scoring;
- relevant Whole-App branches.

If the second run differs materially from the first, FAIL and diagnose nondeterminism/contamination.

## Phase 15 — independent Auditor

The independent Auditor inspects the exact frozen candidate and diff and deliberately looks for validator weakening, evidence-integrity loss, branch omissions, production/test mismatch, stale fixtures, citation laundering, overfitting, hidden normalization, deployment uncertainty, and missing negative siblings.

Material defect = FAIL.

## Definition of PDV5 PASS

Do not call the Writer fixed/working/production-ready unless all are true:

1. real production failure reproduced;
2. root cause(s) proven;
3. worker runtime identity proven or explicitly UNPROVEN;
4. runtime defect repaired;
5. verification escape repaired;
6. exact real failed artifact path has the intended repaired behavior;
7. historical valid real artifacts remain valid;
8. structural adversarial suite passes;
9. epistemic suite passes;
10. semantic citation suite passes;
11. bounded positive suite passes;
12. cross-section consistency passes;
13. prompt/schema/validator parity passes;
14. five-area score >=97/100;
15. every area >=19/20;
16. zero critical evidence-integrity defects;
17. red-team finds no material escape;
18. failure-injection suite passes;
19. bounded real Writer/Judge shaping verification passes when used;
20. Whole-App exact-SHA gate passes;
21. full applicable regressions pass;
22. clean worktree;
23. second clean verification passes;
24. independent Auditor passes the same candidate SHA.

Only then may the controller stop at `READY_FOR_ONE_AUTHORIZED_LIVE_VALIDATION` if a fresh full production audit has not yet been used as the final validation.

## Final report

Return:

- root causes;
- production artifacts and hashes;
- worker SHA/provenance status;
- files changed;
- verification escapes found;
- blind spots found;
- fixes made;
- real corpus results;
- Writer/Judge shaping results and call counts/cost if used;
- acid-test counts;
- failure-injection results;
- five semantic scores before/after;
- Whole-App result;
- full regression result;
- red-team result;
- second verification result;
- independent Auditor result;
- exact candidate SHA;
- GitHub sync state;
- remaining uncertainty;
- final verdict.
