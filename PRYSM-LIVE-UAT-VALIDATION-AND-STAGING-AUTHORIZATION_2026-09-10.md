# PRYSM Live UAT Validation + Staging Authorization

Date: 2026-09-10 America/Toronto

## Authorized application candidate

- Application repository: `chriskulbaba2025/vantage-platform`
- Branch: `review/prysm-solution-directive-authority-betty` (historical branch name only; Betty is not a PRYSM gate)
- Exact application HEAD: `6a87037c3c94a13d5c42ca505d6c6557eb962664`
- Writer prompt version: `2.4.0`
- Current WriterInput version: `1.2.0`
- Current ScoreSet contract: `2.0.0`
- Current TBK audit: `9714c206-8ed3-4686-8fe2-ceeca0ca0f82`

## Chris authorization

Chris explicitly authorized exactly one fresh current-format TBK Writer -> Judge validation against the exact candidate above using Writer `gpt-5.6-terra`, Judge `gpt-5.6-sol`, Writer prompt version `2.4.0`, and the approved current TBK UAT fixture.

If and only if that validation passes all governed gates, Chris also explicitly authorized deployment of that exact validated candidate to the PRYSM staging/UAT environment for live human testing.

## Boundaries

Authorized:
- exactly one fresh current-format TBK Writer call;
- exactly one Judge call if Writer validation passes;
- current budget gates and permanent PRYSM model-bearing release gate;
- staged/UAT deployment of exact candidate `6a87037c3c94a13d5c42ca505d6c6557eb962664` only if the validation passes;
- capture of exact staging/UAT deployment URL and deployment identifier.

Not authorized:
- production deployment;
- main merge;
- provider recollection;
- additional robustness sampling;
- replacement validation sample if the authorized run fails;
- any different application candidate;
- GA4 conversion-authority expansion;
- unrelated production mutation.

## Required flow

1. Verify exact HEAD/worktree/fixture/routes/config/budgets.
2. Execute one current-format TBK Writer -> Judge validation with no automatic revision.
3. Stop on any Writer/Judge/semantic/transport/budget failure.
4. If and only if PASS, deploy exact validated candidate to PRYSM staging/UAT.
5. Verify deployment readiness and produce exact live UAT URL and human test steps.

No further authorization is required for the staging/UAT deployment if the single validation passes, because it is included in this checkpoint.
