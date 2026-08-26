# PRYSM Terminology

**Status:** Governing terminology for current product and implementation discussions

Use these terms consistently in code review, diagnostics, tests, reports, and handoffs.

## Discovered footprint
The broad set of URLs PRYSM discovers from sitemap/site-footprint evidence before paid provider acquisition. This may be very large and is not equivalent to pages actually assessed.

## Retained footprint
The bounded set of discovered URLs retained by the footprint-discovery layer after its own safety caps, normalization, and filtering. A retained footprint may still be much larger than the assessed sample.

## Material family
A deterministic cluster of URLs representing a meaningful repeated page pattern or commercial/content family. A material family can be represented by a small number of URLs without exhaustively crawling every member.

## Must-have URL
A commercially or conversion-important URL protected in the priority-selection plan before repetitive families consume the available priority budget. Typical roles include homepage, conversion, pricing, service-match, services, company, and proof pages.

## Representative URL
A selected URL used to stand in for a material page family or repeated pattern for bounded assessment purposes.

## Supplemental URL
A lower-priority URL selected only after must-have and representative requirements have been satisfied within the bounded priority plan.

## Priority URL
A URL sent to the provider through DataForSEO `priority_urls`. The governed provider-supported maximum is 20. Priority URLs are crawled first but do not, by themselves, guarantee representative ordering of every remaining page in the provider crawl.

## Priority selection plan
The deterministic contract produced by footprint intelligence that records must-have, representative, supplemental, represented-family, and unrepresented-family truth before provider acquisition.

## Assessed sample
The bounded set of pages actually acquired/assessed for the audit. It must never be described as an exhaustive full-site crawl when the discovered footprint is larger.

## Provider crawl ceiling
The hard maximum number of pages a paid On-Page provider task may acquire. Current governed ceiling: **250 pages**. Site size does not raise this ceiling.

## Incomplete footprint
A footprint result where discovery was bounded, partially unavailable, or otherwise could not establish exhaustive site coverage. This is a limitation to disclose, not a reason to fail the audit or expand provider crawl volume without approval.

## Representative acquisition
The overall product strategy: understand a broad footprint, classify material families, protect important commercial/conversion URLs, select representative examples, and acquire a bounded sample for assessment.

## Large-site success criterion
A large site succeeds when PRYSM can produce a truthful, useful bounded audit with explicit limitations and coverage—not when every discovered URL has been crawled.

## Reporting rule
Always distinguish:

- discovered footprint;
- retained footprint when relevant;
- assessed sample;
- material families represented/unrepresented;
- provider crawl ceiling;
- limitations/incomplete discovery.

Never imply that a 250-page assessed sample equals exhaustive coverage of a site with a larger footprint.
