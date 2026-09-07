# S03 Repair Plan — Conversion Journey

Date: 2026-09-07
Section: `S03 — Conversion Journey`
RSIP stage: `REPAIR_PLAN`
Status: **APPROVED — BUILD AUTHORIZED**
Approved by: Chris

## Proven source ownership

Current local source inspection established that:

- `services/worker/src/report/render-report-v2.js` owns the S03 `conversionPathSection`;
- the same file owns S03 primary markup and client wording;
- the same file owns the journey SVG;
- the same file owns embedded presentation CSS used by S03;
- no additional application source file is required.

## Authorized application source boundary

Only this source file may be edited for the S03 repair:

- `services/worker/src/report/render-report-v2.js`

The authorized source change is presentation-only and must implement the frozen `S03_CONTRACT.md`.

## Authorized direct test boundary

The source-boundary inspection proved that the S03 presentation repair will make existing presentation assertions stale in these files. Chris authorizes updating only the directly stale S03/presentation expectations in:

- `services/worker/src/report/render-report-v2.test.js`
  - current stale marker around line 181: `/Conversion path architecture/`
- `services/worker/src/report/render-report-v2-sections.test.js`
  - current stale marker around line 347: `/Conversion path architecture/`
- `services/worker/src/report/karen-style-regression.test.js`
  - current S03 conversion-path benchmark markers around lines 305 and 335
- `services/worker/src/report/render-narrative-v2.test.js`
  - current stale marker around line 472: `Conversion path architecture`
- `services/worker/src/report/render-report-v2-conversion.test.js`
  - CR-43 full-render presentation golden hashes only, if and only if they change solely because of the authorized S03 presentation repair

No other test file is authorized. If another test file becomes necessary, STOP and return the exact file/assertion before editing it.

## Required S03 repair

Modify only the primary S03 presentation to achieve the frozen contract:

1. Use one clear hierarchy:
   - kicker: `Conversion Journey`
   - H2: `Can visitors move easily from interest to action?`
   - prominent verdict: `The assessed path to action is clear.`
2. Replace/simplify the current small technical journey SVG with one larger, easier-to-scan client-language visual derived only from the governed assessed path.
3. Remove the redundant primary `Important path status` table when it duplicates the same conclusion/path.
4. Consolidate separate empty-result sections such as hesitation/findings into one concise bounded client statement.
5. Retain one concise `What is working` block.
6. Retain one limitation note only where materially required by the governed evidence.
7. Preserve technical path evidence in Supporting Detail.

## Evidence-integrity requirements

The repair must not:

- convert an assessed clear path into a site-wide claim;
- convert visible actions into completed enquiries or conversions;
- convert no material obstacle established into a claim that visitors never hesitate;
- remove or upgrade PARTIAL/UNKNOWN/UNAVAILABLE evidence;
- change scoring, evidence, Client Truth, action order, Writer/Judge objects, navigation, Supporting Detail assignments, canonical artifacts, or production semantics.

## Locked cross-report preservation

Must preserve:

- S01 Executive Scorecard `PASS_LOCKED` at 98/100;
- S02 Priority Fixes `PASS_LOCKED` at 97/100;
- mobile loading as governed Priority #1;
- the conversion route itself as a strength to preserve;
- six-item peer navigation plus subordinate Supporting Detail.

## Verification sequence

1. Preserve and record the current intentional dirty worktree.
2. Edit only the authorized source file and directly stale test expectations above.
3. Run the smallest focused S03/render test first.
4. Run the complete relevant S03 regression set.
5. Run `git diff --check`.
6. Verify normalized dirty scope and no unexpected paths.
7. Verify S01 and S02 locked surfaces remain unchanged.
8. Verify scoring/evidence/Client Truth/canonical inputs remain unchanged.
9. Rerender the same TBK audit offline from unchanged canonical inputs using the existing governed replay path.
10. Return the new S03 HTML and bounded-build proof for HUMAN_REVIEW.

Audit ID:
`8d22e6b9-9246-4fb2-9f65-4cfc97a5b9e3`

Target outputs:

- `C:\Users\kulba\Downloads\PRYSM-S03-TBK-CURRENT-REVIEW.html`
- `C:\Users\kulba\Downloads\PRYSM-S03-BOUNDED-BUILD-PROOF.txt`

## Stop conditions

STOP before expanding scope if:

- another application source file is required;
- another test file contains a directly stale assertion;
- a failure indicates a semantic/evidence/scoring/Client Truth regression rather than a stale presentation assertion;
- S01 or S02 locked output changes unexpectedly.

## Authorization

The bounded S03 BUILD is authorized within the exact source/test boundaries above.

Do not PASS_LOCK S03 until deterministic verification and final human review pass at >=95/100 with zero hard gates.
