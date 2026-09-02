# P0 Evidence Log

## Direct proof

At application baseline plus bounded trace change, `node --test src/adapters/dataforseo-onpage/dataforseo-onpage-representative-evidence.test.js --test-name-pattern='EVIDENCE-01|deep parsing merges|unavailable sitemap'` passed 4/4.

The EVIDENCE-01 proof demonstrates:

- 26 selected URLs remain preserved;
- 20 URLs are requested under the budget;
- 6 overflow URLs are `UNASSESSED`;
- selected URLs carry `must_have_priority` and deterministic page classes;
- returned nested provider body is `RETURNED`;
- downstream modules are explicitly named as `content.body` and `programmaticSeo`.

## Proof note

The first implementation attempt classified the nested fixture body as empty. This was a proof/setup-to-contract shape mismatch in the new trace helper, corrected before broad verification; no repair escalation is consumed because the governed defect boundary was not changed.

## Remaining proof

Affected adapter/evidence suites passed 100/100 on exact application candidate `acfc5c1393261bb7733837289bc3adc1062e64d5`. The controlled P0 branch scenarios cover P0-B01 through P0-B05; no production/live provider call was made.
