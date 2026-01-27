# Analysis Question

## Question
Once a practice has a borrower who goes delinquent on their loan but then pays it back (a "cured delinquency"), does that predict worse future loan performance at the practice?

In other words: Is a cured delinquency an early warning signal for future practice risk, or is it just noise?

## Context
- A "cured delinquency" = a loan that went 30+ DPD at some point but eventually was paid off (not charged off)
- We want to compare practices AFTER they experience their first cured delinquency vs. before (or vs. practices that never had one)
- Key outcome metric: charge-off rate or delinquency rate on FUTURE loans at that practice

## Controls Required
1. **Credit score of future borrowers** - Higher credit borrowers default less regardless of practice history. Use `risk_score` from `raw.mariadb_fivetran_application_service_master.application`
2. **Existing portfolio performance** - A practice with already-bad performance will have worse future performance. Control for their historical charge-off/delinquency rate before the cured delinquency event

## Suggested Approach
1. Identify practices that have experienced at least one "cured delinquency" and the date it occurred
2. For those practices, compare loan performance BEFORE vs AFTER that event
3. Also compare to practices that NEVER had a cured delinquency (control group)
4. Control for borrower credit scores and practice vintage/maturity

## Key Tables (reference data_context.md for details)
- `raw.mariadb_fivetran_loan_service_master.loan` - loan data
- `prod.risk_marts.daily_loan_xf` - delinquency tracking (but note: doesn't have all loans, only ~20-25% with delinquency events)
- `raw.mariadb_fivetran_application_service_master.application` - for risk_score (credit score)
- `prep.core_staging.stg_merchants` - merchant to organization mapping

## Success Criteria
- Clear definition of "cured delinquency" operationalized in SQL
- Proper control for credit scores (e.g., compare within credit score bands)
- Proper control for existing portfolio health
- Statistical comparison with sample sizes
- Clear conclusion: predictive signal or not?

## Caveats to Address
- Selection bias: practices with cured delinquencies may be systematically different
- Time effects: control for loan vintage / economic conditions
- Sample size: ensure enough practices with cured delinquencies to draw conclusions
