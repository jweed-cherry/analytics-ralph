# Consumer-Led Revenue Analysis

**Date:** January 27, 2026
**Data Range:** All time (Aug 2019 - Jan 27, 2026)
**Total Portfolio:** 2.2M funded loans | $4.4B gross volume | $764M total revenue (forecasted)

---

## Executive Summary

| Consumer Behavior Metric | Revenue | % of Total Revenue |
|---|---|---|
| Consumer-initiated (passive) applications | $184M | 24.2% |
| Repeat consumer revenue (all loans from 2+ loan borrowers) | $235M | 30.8% |
| Cross-industry consumer revenue | $34M | 4.5% |

**Key takeaway:** Consumer behavior drives meaningful revenue. ~24% of revenue comes from consumers who found Cherry on their own (passive), ~31% comes from repeat borrowers, and these shares are **growing over time**.

---

## Metric 1: Consumer-Initiated (Passive) Revenue by Industry

### How we define "consumer-initiated"
Cherry's `SOURCE_TYPE` field classifies each application:
- **Passive (consumer-initiated):** Consumer found and started the application independently — via practice website, provider finder, social media, search, etc.
- **Active (provider-initiated):** Provider sent the application — via dashboard text, QR code, in-office "apply with patient," email, SMS, preapproval, appointment reminder
- **Unknown:** Source not attributed (~19% of loans, largely pre-2022 data)

### Overall Source Mix

| Source Type | Loans | Gross Volume | Merchant Fee | Revenue | % of Loans | % of Revenue |
|---|---|---|---|---|---|---|
| Active (provider-led) | 1,201,466 | $2.77B | $209M | $481M | 54.7% | 63.1% |
| **Passive (consumer-led)** | **580,747** | **$995M** | **$66M** | **$184M** | **26.4%** | **24.2%** |
| Unknown | 414,758 | $638M | $39M | $97M | 18.9% | 12.7% |
| **Total** | **2,196,971** | **$4.40B** | **$314M** | **$763M** | **100%** | **100%** |

**Among attributed loans only (excl. unknown): passive = 27.7% of revenue.**

### Passive Revenue by Industry (Top 15)

| Industry | Passive Loans | Passive Gross $ | Passive Revenue | % of Passive Rev |
|---|---|---|---|---|
| Medspa | 321,644 | $340M | $59.5M | 32.3% |
| General Dentistry | 100,943 | $238M | $44.9M | 24.4% |
| Cosmetic Surgery | 24,991 | $148M | $29.6M | 16.1% |
| Plastic Surgery | 21,612 | $105M | $20.5M | 11.1% |
| Oral Surgery | 8,820 | $25M | $4.6M | 2.5% |
| Day Spa | 17,297 | $20M | $3.8M | 2.0% |
| Permanent Makeup | 16,933 | $18M | $3.4M | 1.8% |
| Veterinary | 22,635 | $20M | $3.2M | 1.7% |
| Salon | 10,858 | $12M | $2.3M | 1.2% |
| Bariatric Surgery | 1,147 | $8.6M | $2.3M | 1.2% |
| Periodontics | 2,728 | $10.8M | $1.7M | 0.9% |
| Surgical Hair Transplants | 1,605 | $10.7M | $1.7M | 0.9% |
| Veterinary Hospital | 8,563 | $8.0M | $1.4M | 0.8% |
| Orthodontics | 1,653 | $4.9M | $0.8M | 0.5% |
| Holistic/Regen Medicine | 3,546 | $5.2M | $0.8M | 0.5% |

Medspa and General Dentistry together drive **56.6%** of all passive revenue.

### Passive Share: Yearly Trend

| Year | Active Revenue | Passive Revenue | Unknown Revenue | Passive % of Total | Passive % of Attributed |
|---|---|---|---|---|---|
| 2021 | $297K | $402K | $3.3M | 10.0% | 57.5% |
| 2022 | $6.5M | $5.1M | $7.2M | 27.2% | 44.2% |
| 2023 | $31.0M | $18.4M | $11.4M | 30.3% | 37.3% |
| 2024 | $132.0M | $49.4M | $25.7M | 23.8% | 27.2% |
| 2025 | $288.9M | $102.2M | $46.0M | 23.4% | 26.1% |
| 2026 (Jan) | $22.9M | $9.0M | $3.0M | 25.7% | 28.2% |

**Trend:** Passive share of attributed revenue has stabilized at ~26-28% since 2024, after higher early readings when attribution was less complete. The absolute dollar volume from passive is growing rapidly ($5M in 2022 -> $102M in 2025).

---

## Metric 2: Repeat Consumer Revenue

### Definition
A **repeat consumer** is a borrower (same `BORROWER_ID`) who has funded 2+ Cherry loans, regardless of which provider.

### Overall Repeat vs Single-Loan Split

| Borrower Type | Unique Borrowers | Total Loans | Gross Volume | Revenue | % of Loans | % of Revenue |
|---|---|---|---|---|---|---|
| **Repeat (2+ loans)** | **372,637** | **1,059,278** | **$1.41B** | **$235M** | **48.2%** | **30.8%** |
| Single-loan | 1,138,263 | 1,138,263 | $2.99B | $528M | 51.8% | 69.2% |

**24.7% of all borrowers are repeat borrowers**, but they generate **48.2% of all loans** and **30.8% of all revenue**.

### Loan-Level View: First Loan vs Subsequent

| Category | Borrowers | Loans | Revenue | % of Revenue |
|---|---|---|---|---|
| Single-loan borrower | 1,137,967 | 1,137,967 | $528M | 69.2% |
| Repeat borrower - 1st loan | 372,549 | 372,549 | $95M | 12.5% |
| **Repeat borrower - subsequent loans** | **372,549** | **686,455** | **$140M** | **18.3%** |

Revenue from the 2nd+ loans alone (pure "repeat" revenue) = **$140M (18.3%)**.

### Frequency Breakdown

| Frequency | Borrowers | Loans | Gross Volume | Revenue | % of Rev | Avg Loan Size |
|---|---|---|---|---|---|---|
| 1 loan | 1,138,263 | 1,138,263 | $2.99B | $528M | 69.2% | $2,630 |
| 2 loans | 230,152 | 460,304 | $768M | $131M | 17.2% | $1,668 |
| 3 loans | 72,778 | 218,334 | $275M | $46M | 6.0% | $1,258 |
| 4-5 loans | 47,261 | 204,612 | $215M | $34M | 4.5% | $1,053 |
| 6-10 loans | 19,834 | 140,603 | $127M | $20M | 2.6% | $902 |
| 10+ loans | 2,612 | 35,425 | $28M | $4M | 0.5% | $791 |

**Note:** Average loan size decreases as frequency increases — heavy repeat borrowers take out smaller loans on average ($791 vs $2,630).

### Repeat Revenue: Yearly Trend

| Year | Repeat Loans | Total Loans | Repeat Loan % | Repeat Revenue | Total Revenue | Repeat Rev % |
|---|---|---|---|---|---|---|
| 2021 | 2,830 | 15,734 | 18.0% | $415K | $4.0M | 10.3% |
| 2022 | 18,570 | 81,800 | 22.7% | $2.6M | $18.8M | 13.8% |
| 2023 | 66,445 | 220,748 | 30.1% | $10.7M | $60.7M | 17.6% |
| 2024 | 159,451 | 527,042 | 30.3% | $35.0M | $207.1M | 16.9% |
| 2025 | 400,419 | 1,235,818 | 32.4% | $83.7M | $437.1M | 19.2% |
| 2026 (Jan) | 38,722 | 114,278 | 33.9% | $7.3M | $34.9M | 20.8% |

**Strong upward trend:** Repeat loans as % of total have grown from 18% (2021) to 34% (2026 YTD), and repeat revenue share from 10% to 21%.

---

## Metric 3: Cross-Industry Consumer Revenue

### Definition
A **cross-industry consumer** is a borrower who has funded loans at providers in 2+ different industries (e.g., dental AND medspa).

### Overall Cross-Industry Summary

| Industry Bucket | Borrowers | Loans | Gross Volume | Revenue | % of Borrowers | % of Revenue |
|---|---|---|---|---|---|---|
| 1 industry | 1,471,813 | 2,071,237 | $4.21B | $728M | 97.6% | 95.5% |
| **2 industries** | **34,723** | **113,571** | **$176M** | **$32M** | **2.3%** | **4.2%** |
| **3+ industries** | **1,456** | **8,049** | **$11M** | **$2.1M** | **0.1%** | **0.3%** |

**36,179 cross-industry borrowers (2.4%)** generate **$34.3M revenue (4.5%)** — they over-index on revenue relative to their population share.

### Top Industry Crossover Pairs

| Industry 1 | Industry 2 | Borrowers | % of Cross-Industry |
|---|---|---|---|
| General Dentistry | Medspa | 6,793 | 18.8% |
| Cosmetic Surgery | Medspa | 4,355 | 12.0% |
| Day Spa | Medspa | 4,117 | 11.4% |
| Medspa | Plastic Surgery | 3,652 | 10.1% |
| Medspa | Permanent Makeup | 2,764 | 7.6% |
| Medspa | Salon | 1,711 | 4.7% |
| General Dentistry | Oral Surgery | 1,343 | 3.7% |
| Holistic/Regen Med | Medspa | 860 | 2.4% |
| Cryotherapy | Medspa | 764 | 2.1% |
| Dermatology | Medspa | 751 | 2.1% |

**Medspa is the hub** — it appears in 8 of the top 10 crossover pairs. The #1 cross-industry pathway is General Dentistry <-> Medspa (6,793 borrowers).

### Cross-Industry Revenue: Yearly Trend

| Year | Cross-Industry Loans | Total Loans | CI Loan % | CI Revenue | CI Rev % |
|---|---|---|---|---|---|
| 2021 | 899 | 15,734 | 5.7% | $209K | 5.2% |
| 2022 | 6,224 | 81,800 | 7.6% | $1.2M | 6.6% |
| 2023 | 16,285 | 220,748 | 7.4% | $3.7M | 6.0% |
| 2024 | 32,356 | 527,042 | 6.1% | $9.5M | 4.6% |
| 2025 | 61,066 | 1,235,818 | 4.9% | $18.1M | 4.2% |
| 2026 (Jan) | 4,847 | 114,278 | 4.2% | $1.6M | 4.4% |

**Note:** Cross-industry % has actually declined slightly from early highs (7.6% in 2022 to 4-5% in 2025-26). This may reflect portfolio composition shifts as Cherry scales — more single-industry borrowers are being added faster than cross-industry ones.

---

## Caveats & Methodology Notes

1. **Revenue = Forecasted Revenue:** The `REVENUE` field in `loan_info_xf` = merchant_fee + forecasted_interest + forecasted_fees. This is a projection, not realized revenue. Actual revenue may differ based on prepayments, defaults, etc.

2. **Unknown source_type (~19% of loans):** 414K loans (mostly pre-2023) have NULL source attribution. These are excluded from passive/active classification. Among attributed loans, passive share is ~27-28%.

3. **"Passive" does not mean "unprompted":** A "passive" source (e.g., practice website link) may still be prompted by the provider telling the patient to go to their website. The SOURCE_TYPE field tracks the application entry point, not whether the consumer discovered Cherry independently.

4. **Cross-industry uses current industry classification:** If a merchant's industry changed, the current classification is used for all their loans. This should have minimal impact.

5. **Borrower identity:** Repeat/cross-industry analysis uses `BORROWER_ID` as the consumer identifier. If the same person creates multiple borrower accounts, they would be counted separately.

6. **All-time analysis:** Trends include all years, but early years (2019-2021) have very small loan counts and may not be representative.

---

## SQL Queries Used

All queries join `PROD.CORE_MARTS.APPLICATIONS_LOANS_XF` (source attribution) to `PROD.CORE_MARTS.LOAN_INFO_XF` (revenue) on `LOAN_ID`, with `PROD.CORE_MARTS.PRACTICE_INFO_XF` (industry) joined via `PRIMARY_MERCHANT_ID`. Filters: `FUNDED_AT IS NOT NULL` and `LOAN_STATUS = 'FUNDED'`.
