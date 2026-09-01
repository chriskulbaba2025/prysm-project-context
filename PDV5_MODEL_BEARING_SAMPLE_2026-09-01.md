# PDV5 model-bearing sample — 2026-09-01

Candidate: `292a5527a9d31d159fe1534e6d4801f442c24c4c`

The exact candidate passed the Narrative v2 regression (108/108) and the assembled Whole-App Branch Coverage Gate with P-B01..P-B15.

Five independent fresh executions were run against the frozen TBK WriterInput using the governed live binding. Four reached `RELEASE_CANDIDATE` with Writer/Judge PASS and scores 97, 100, 98, and 100, with zero Judge defects. One execution reached `HUMAN_REVIEW_REQUIRED` after Judge `REVISE` (score 90.5) with three semantic findings:

- the headline concluded targeted remediation rather than a broad technical rebuild;
- a differentiator claimed assessed conversion-action clarity was confirmed;
- the do-next statement identified a confirmed enquiry action.

Ledgers and orchestration outputs remain outside the application repository under `C:\Users\kulba\AppData\Local\Temp\prysm-pdv5-evidence\`.

The run does not fail the repaired AI-search non-assessment boundary. The Judge findings expose a materially distinct active root: `PDV5.WRITER_JUDGE_SEMANTIC_SUPPORT_MISMATCH`. Required additional real-input Writer stress and a clean 3/3 complete-run proof remain open.
