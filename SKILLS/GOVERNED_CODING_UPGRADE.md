# Governed Coding Upgrade — PRYSM Invocation Rule

**Required skill:** `governed-coding-upgrade`  
**Required version baseline:** 2.1.0 or later compatible governed version  
**Canonical repository:** `chriskulbaba2025/governed-coding-upgrade-skill`

## Mandatory use

For every PRYSM task that changes source code, tests, schemas, dependencies, executable configuration, infrastructure-as-code, migrations, jobs, integrations, build/release logic, or runtime behavior, load and obey the canonical Governed Coding Upgrade skill before editing.

Read-only inspection does not require the full lifecycle unless repository governance requires it.

## PRYSM-specific authority

The active PRYSM `CONSTRAINTS.md`, `DECISIONS.md`, approved specifications, current user instruction, and application-repository governance remain authoritative over lower-level implementation procedure.

## Minimum execution boundary

Before editing:

- verify repository root;
- verify branch;
- verify exact starting SHA;
- verify working tree;
- identify active PR when relevant;
- read governing PRYSM context;
- freeze permitted/prohibited scope;
- define direct proof before implementation.

For the current report rebuild, preserve the page-by-page approval sequence in `SPECS/PRYSM_FINAL_REPORT_PAGE_BY_PAGE_HANDOFF.md` and do not broaden report-layer work into evidence, scoring, lifecycle, storage, Writer/Judge, orchestration, or n8n changes.

## Completion rule

Do not claim a coding change complete from prose, confidence, or green CI alone. Verify the exact changed boundary, required tests, scope, and repository state according to the canonical governed-coding skill and PRYSM constraints.
