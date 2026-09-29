# Decision — PRYSM Generalized Semantic Process Repair Freeze

Date: 2026-09-29
Status: Active
Applies to: isolated-staging semantic/process repair before the next human retest

## Decision

Freeze the current isolated-staging application at:

- Application repository: `chriskulbaba2025/prysm-staging-isolated`
- Branch: `repair/prysm-bulk-closure-20260927`
- PR: #6
- Baseline SHA: `ca3dabf0f59f8fe62e4c2a73766d6f12e9999e01`
- Production: untouched / read-only

This SHA is the governed before-state for the next repair series.

The next repair series must improve PRYSM's generalized decision process. It must not implement named-site fixes, fixture-specific branches, or report-specific exceptions.

Named regression sites are evidence only. They are used to prove generalized behavior before and after repair.

## Process-level defect families

### P1 — Evidence classification and semantic taxonomy

Problem:
Observed evidence can exist while the system's semantic classification still produces a broader client-facing absence claim.

Examples of the class:
- experience evidence present but generic `Expertise` reported absent;
- completed-work evidence present but downstream wording says completed work/outcomes were not observed;
- proof-form evidence present while a trust conclusion says proof is missing.

Required process improvement:
Create explicit typed distinctions for:
- formal credential;
- operating experience;
- named expertise/leadership;
- testimonial/review;
- completed work;
- customer result/outcome;
- detailed case study;
- proof placement/timing;
- unavailable/partial evidence.

A downstream conclusion may not collapse these distinctions into a broader false-negative label.

### P2 — Cross-surface reconciliation before report projection

Problem:
Different report surfaces can consume or interpret the same governed evidence differently, producing internally inconsistent conclusions.

Required process improvement:
Add a deterministic reconciliation gate before client-facing projection. The gate must compare material claims derived from the same canonical evidence and fail closed when two surfaces would assert incompatible facts.

The gate must preserve:
- observed vs not observed;
- weak vs missing;
- incomplete vs absent;
- unavailable vs negative;
- detailed case study absent vs completed-work evidence present.

### P3 — Existing-content reconciliation before Content Opportunity generation

Problem:
The system can infer `buyer question exists -> create content` without first determining whether the assessed site already answers that question.

Required process improvement:
Every content recommendation must execute this decision chain:

`buyer question -> existing coverage retrieval -> coverage sufficiency -> action`

Permitted actions:
- PRESERVE;
- IMPROVE;
- EXPAND;
- CONSOLIDATE;
- CREATE;
- NO_ACTION;
- UNAVAILABLE.

A content asset type may be recommended only after the system proves that the existing site does not already satisfy the same function.

### P4 — Canonical own-site evidence contract across comparison and core report logic

Problem:
The competitor projection can report `Not enough evidence` for audited-site offer or next-step clarity while the core report has enough governed evidence to score and characterize those same constructs.

Required process improvement:
The audited-site side of comparative analysis must consume the same canonical own-site evidence contract as the core report, or an explicitly narrower comparison contract whose limitations are surfaced client-facing.

Silent evidence-standard drift is prohibited.

### P5 — Evidence scope/provenance continuity through recommendation generation

Problem:
A measured finding can be attached to one page/scope while downstream action guidance points to another page or broader scope.

Required process improvement:
Every material finding and recommendation must retain:
- source evidence identity;
- source URL/page scope;
- assessed scope;
- transformation/classification path;
- final action scope.

A recommendation may broaden scope only when additional evidence explicitly supports the broader action.

### P6 — Business-meaning classification of observed site-quality defects

Problem:
PRYSM may observe placeholder/demo/template/lorem-ipsum or equivalent low-quality live content without promoting its commercial meaning.

Required process improvement:
Add a business-meaning classification layer for observed evidence that can materially affect:
- credibility;
- professionalism;
- trust;
- conversion;
- usability;
- search quality.

The system must distinguish `technical observation` from `commercially material site-quality defect` using governed rules.

### P7 — Score, label, and conclusion interpretability contract

Problem:
Scores, labels, and client-facing conclusions can be individually valid yet collectively difficult to reconcile.

Examples of the class:
- a dimension labeled strong while another surface says support is missing without explaining the difference;
- a low Trust score coexisting with `no material trust gap` without explaining what the missing score represents;
- Snapshot constructs using labels close enough to Executive dimensions that clients can interpret different scores as contradictions.

Required process improvement:
Every score/label family must define:
- what construct it measures;
- the source evidence;
- whether it maps directly to another product surface;
- how it relates to material findings;
- when a low score can coexist with no material defect.

Closely named constructs may not use materially different scores unless the distinction is explicit to the client.

### P8 — Priority hierarchy governance

Problem:
Different products/surfaces can present different `top` findings without a governed rule explaining whether they are ranked by severity, conversion impact, commercial legibility, confidence, or product purpose.

Required process improvement:
Create one explicit ranking contract with product-specific projection rules. Snapshot may intentionally select a different subset than Executive only when the selection objective is governed and the client-facing wording does not imply the same ranking semantics.

### P9 — Client-language semantic QA

Problem:
Mechanically malformed, awkward, or semantically nonsensical phrases can survive into client-facing output.

Required process improvement:
Introduce deterministic and/or governed semantic QA before publication for:
- truncated terms;
- malformed phrase composition;
- broken noun/verb combinations;
- unresolved template fragments;
- impossible or nonsensical client-facing asset titles.

This is a final quality gate, not a substitute for correcting upstream classification.

## Protected behavior

The repair series must preserve existing improvements already demonstrated by regression evidence, including:
- schema not treated as direct visitor friction;
- competitor difference not automatically converted into a client defect;
- explicit evidence limitations for lab performance vs field/CrUX evidence;
- stable conversion-path reasoning where current evidence is coherent;
- Snapshot simplification when it faithfully preserves the governed full-report meaning;
- retired report paths fail closed;
- Executive V2 remains designVersion `2.0.0`.

## GACM tranche sequence

### Tranche G0 — Freeze and map the decision pipeline

Intent: CHANGE_ONLY

Tasks:
- recover exact baseline SHA and current governance;
- map Producer -> canonical evidence -> classification -> reconciliation -> score -> prioritization -> report projection -> Snapshot projection;
- identify every producer/consumer contract that can create P1-P9;
- freeze permitted/prohibited repair boundaries and regression fixtures;
- no product code changes.

Acceptance:
- complete owning-boundary map;
- no unresolved ambiguity about where each defect family is created;
- exact baseline preserved.

### Tranche G1 — Canonical evidence taxonomy and trust/proof reconciliation

Targets: P1 + P2

Tasks:
- repair typed evidence taxonomy;
- separate credentials, experience, completed work, outcomes, case studies, testimonials and placement;
- add deterministic reconciliation preventing downstream false-negative contradictions;
- generalize across arbitrary valid evidence.

Acceptance:
- same evidence cannot produce both `observed` and `not observed` for the same semantic fact;
- completed-work vs detailed-case-study distinction propagates to every client-facing consumer;
- experience cannot be erased by absence of formal credentials;
- negative-path UNKNOWN/PARTIAL/UNAVAILABLE semantics preserved.

### Tranche G2 — Existing-content reconciliation engine

Targets: P3

Tasks:
- make coverage reconciliation mandatory before recommendation generation;
- classify existing coverage sufficiency;
- choose PRESERVE/IMPROVE/EXPAND/CONSOLIDATE/CREATE/NO_ACTION/UNAVAILABLE;
- prevent duplicate asset recommendations when an equivalent page/function exists.

Acceptance:
- buyer-question presence alone cannot create a recommendation;
- asset type is context-sensitive, not template-prescribed;
- recommendations cite the evidence/coverage state that justified them.

### Tranche G3 — Shared own-site evidence contract for comparison

Targets: P4

Tasks:
- trace comparator audited-site inputs;
- bind comparator to canonical own-site evidence or an explicit narrower typed contract;
- eliminate silent `Not enough evidence` drift where canonical evidence is sufficient.

Acceptance:
- comparator and core report cannot silently disagree about audited-site Offer/Next-step evidence state;
- any narrower comparison standard is explicit and client-readable.

### Tranche G4 — Provenance and action-scope continuity

Targets: P5 + P6

Tasks:
- carry URL/scope provenance from measurement through finding and recommendation;
- block recommendations that target a different page without supporting evidence;
- classify placeholder/demo/template content for commercial meaning and materiality.

Acceptance:
- action scope is traceable to source evidence;
- scope broadening requires explicit supporting evidence;
- live placeholder/demo content is surfaced when materially relevant rather than buried as incidental technical evidence.

### Tranche G5 — Score/label semantics and priority governance

Targets: P7 + P8

Tasks:
- define canonical constructs and cross-product mappings;
- reconcile dimension scores with material-finding semantics;
- govern Snapshot vs Executive score labels and ranking selection;
- prevent near-identical labels from representing materially different constructs without explanation.

Acceptance:
- client can understand why a score and finding state coexist;
- Snapshot vs Executive mappings are either identical or explicitly differentiated;
- `top/biggest/priority` wording reflects the governed ranking contract.

### Tranche G6 — Client-language semantic QA

Targets: P9

Tasks:
- add publication-stage malformed-language detection;
- block obvious truncation, malformed composition, template leakage and nonsensical generated titles;
- preserve source terminology unless transformation is semantically valid.

Acceptance:
- known malformed-language classes fail closed before publication;
- QA cannot silently rewrite evidence meaning;
- upstream semantic defects still fail rather than being cosmetically hidden.

### Tranche G7 — Whole-system semantic regression and challenge

Intent: STAGING_READY

Tasks:
- rerun generalized semantic fixtures and whole-app regression;
- adversarially test P1-P9 across strong, middle and weak evidence cases;
- include at least the current regression sites as fixtures, but do not tune to them;
- verify Snapshot and Executive projections from the same governed evidence;
- independently challenge for cross-surface contradictions, stale evidence, wrong-page actions and already-covered recommendations;
- verify exact-head identity.

Acceptance:
- targeted semantic suites PASS;
- full regression PASS;
- generalized fixtures PASS;
- no protected behavior regresses;
- no unresolved material P1-P9 defect remains in code-level/system-level verification;
- exact staging candidate frozen for human retest.

### Tranche G8 — Human retest and closure

Owner: Chris

Tasks:
- run fresh manual staging review in signed-in browser;
- compare outputs against the frozen baseline and regression evidence;
- record observed PASS/FAIL without coding during review;
- if defects remain, open a new bounded defect tranche rather than patching during acceptance.

Acceptance:
- human acceptance complete;
- final observed defects either zero or explicitly registered;
- production remains untouched until separate authorization.

## Execution rules

- One Builder/write owner per tranche.
- Read-only Scout/Planner/Verifier/Challenger/Auditor roles.
- Maximum three failed repairs in one defect family before diagnosis reset.
- Named regression sites are fixtures, never implementation targets.
- No production mutation.
- No Codex browser acceptance.
- Long runs require the established Downloads proof folder and desktop/audible completion notification.
- Do not mark a tranche complete from targeted tests alone: run the required integration/full regression/generalization/challenge/exact-head checks for that tranche.
