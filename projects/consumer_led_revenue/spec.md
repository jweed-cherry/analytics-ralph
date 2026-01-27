# Consumer-Led Revenue Analysis - Requirements Spec

## Objective
Quantify how much of Cherry's growth is driven by **consumer behavior** vs **provider-led flows**, across three dimensions:
1. Revenue mix from consumer-initiated (passive) applications, broken down by industry
2. Revenue from repeat consumers (>1 loan across same or different providers)
3. Revenue from cross-industry consumers (loans across 2+ industries)

## Key Definitions

### Consumer-Initiated ("Passive") Applications
- **Field:** `SOURCE_TYPE = 'passive'` in `PROD.CORE_MARTS.APPLICATIONS_LOANS_XF`
- **Includes:** practice website, provider finder, social media (instagram, facebook, tik tok, snapchat, cherrytree), link aggregation, search, practice portal, unknown passive
- **Excludes:** `SOURCE_TYPE = 'active'` (dashboard text, QR code, apply with patient, email, SMS, preapproval, appointment reminder) — these are provider-initiated
- **NULL source_type:** Will be reported separately as "Unknown/Unattributed" — ~414K loans with ~$97M revenue, too large to ignore

### Revenue Metric
- **Primary:** `REVENUE` from `PROD.CORE_MARTS.LOAN_INFO_XF` (= merchant_fee + forecasted_interest + forecasted_fees)
- **Secondary:** `MERCHANT_FEE` (actual realized fee) and `GROSS_AMOUNT` (loan volume)
- All three will be reported to give a complete picture

### Repeat Consumer
- Same `BORROWER_ID` with 2+ funded loans (`FUNDED_AT IS NOT NULL`)
- Across ANY provider (same or different merchant)

### Cross-Industry Consumer
- Same `BORROWER_ID` with funded loans at providers in 2+ distinct `INDUSTRY` values
- Using `INDUSTRY` from `PROD.CORE_MARTS.PRACTICE_INFO_XF` joined via `PRIMARY_MERCHANT_ID`

### Industry
- **Field:** `INDUSTRY` from `PROD.CORE_MARTS.PRACTICE_INFO_XF`
- Joined to loans via `PRIMARY_MERCHANT_ID`

### Loan Filter
- Only funded loans: `FUNDED_AT IS NOT NULL` from applications_loans_xf, or `LOAN_STATUS = 'FUNDED'` from loan_info_xf
- All time (2019-08 through 2026-01-27) for totals; also break out by year for trend analysis

## Methodology

### Metric 1: Passive Revenue by Industry
- Join `applications_loans_xf` (for source_type) to `loan_info_xf` (for revenue) on LOAN_ID
- Join to `practice_info_xf` on PRIMARY_MERCHANT_ID for industry
- Group by: SOURCE_TYPE, INDUSTRY
- Metrics: loan_count, gross_amount, merchant_fee, revenue
- Include: % of total for each source type
- Also show yearly trend (funded year) for passive share

### Metric 2: Repeat Consumer Revenue
- Identify repeat borrowers: BORROWER_ID with COUNT(DISTINCT LOAN_ID) >= 2
- Tag each loan as "first loan" or "repeat loan" using ROW_NUMBER by BORROWER_ID ordered by FUNDED_AT
- Calculate revenue from repeat loans (2nd+ loan per borrower)
- Also calculate revenue from repeat borrowers (all loans from borrowers who have 2+ loans)
- Break down by repeat frequency bucket (2, 3, 4-5, 6-10, 10+)

### Metric 3: Cross-Industry Consumer Revenue
- Identify cross-industry borrowers: BORROWER_ID with COUNT(DISTINCT INDUSTRY) >= 2
- Calculate all revenue from these borrowers
- Show the most common industry crossover pairs
- Break down by number of industries (2, 3+)

## Controls / Caveats to Document
1. **NULL source_type (~414K loans, ~$97M revenue):** Report separately; do NOT lump into passive or active
2. **NULL industry:** Some merchants lack industry classification; report separately
3. **Demo loans:** Should already be excluded by FUNDED status, but verify
4. **Alle loans:** Do not special-case; treat as normal loans
5. **Revenue field:** Uses forecasted revenue, not realized; note this caveat
6. **Time period:** Report all-time totals AND yearly breakdowns

## Success Criteria
- Three clear output tables/queries answering each question
- All numbers cross-foot (passive + active + unknown = total)
- Revenue totals sanity-check against known portfolio (~$764M total revenue, ~2.2M loans)
- Clear percentage breakdowns showing consumer-driven share
- Yearly trend showing if consumer-led share is growing

## Out of Scope
- Provider-level granularity (not breaking down by individual merchant)
- Cohort-based retention analysis
- Profitability analysis beyond contribution margin
- Causal attribution (whether "passive" truly means consumer found Cherry independently vs. provider put link on website)
