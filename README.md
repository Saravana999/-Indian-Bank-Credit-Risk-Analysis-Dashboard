# -Indian-Bank-Credit-Risk-Analysis-Dashboard
# 🏦 Indian Bank Credit Risk Analysis
### Identifying High-Risk Borrowers Before Default Occurs

---

## The Business Problem
Indian banks lose crores annually to loan defaults and 
NPAs. The core challenge is not detecting defaults after 
they happen — it is predicting which customers will default 
before they do, so the bank can intervene early.

This project analyses 51,336 real customer records combining 
internal bank loan behaviour with external CIBIL bureau data 
to answer one question:

**What signals identify a high-risk borrower — and what 
decisions should the bank make from them?**

---

## Tools Used
MySQL · Python (Pandas, Seaborn, Matplotlib) · Power BI

---

## Dataset
Leading Indian Bank & CIBIL Real-World Dataset — Kaggle
- Internal Bank Data: 51,336 rows, 26 columns (loan types,
  missed payments, trade lines)
- External CIBIL Data: 51,336 rows, 62 columns (credit score,
  income, enquiries, demographics)
- Joined on PROSPECTID | Target column: Approved_Flag (P1–P4)

---

## Data Cleaning Decisions

| Problem Found | Decision Made | Reason |
|---|---|---|
| -99999 sentinel values in 12 columns | Replaced with median | Industry standard for missing bureau data |
| CC_utilization: 92.8% missing | Column dropped | Too sparse to be meaningful |
| PL_utilization: 86.6% missing | Column dropped | Too sparse to be meaningful |
| Income outliers up to ₹25 lakhs | Capped using IQR | Prevents skewed segment averages |

---

## Key Findings & Business Decisions

### 1. Portfolio Risk Exposure
- **Finding:** 5,882 customers (11.5%) are P4 high-risk
- **Decision:** Immediate enhanced monitoring, restrict new
  credit for P4 segment to prevent NPA buildup

### 2. Credit Score Threshold
- **Finding:** No P1 customer scored below 700. 70-point gap
  between P1 (avg 716) and P4 (avg 646)
- **Decision:** Set 700 as hard minimum threshold. Below 650
  requires collateral or guarantor

### 3. Gold Loans Are the Riskiest Product
- **Finding:** Gold loans have highest missed payments (0.97)
  despite being asset-backed — more than personal loans (0.84)
- **Decision:** Mandatory early intervention for Gold loan
  customers at first missed payment

### 4. Income Does Not Predict Risk
- **Finding:** Only ₹1,679 income difference between P1 and P4
  customers — less than 6%
- **Decision:** Remove income as primary screening criterion.
  Focus on behavioural signals instead

### 5. Credit Hunger = Strongest Early Warning Signal
- **Finding:** P4 customers made 7.66 enquiries in 12 months
  vs 1.58 for P1 — nearly 5x more
- **Decision:** Flag customers with 4+ enquiries in 6 months
  as high-risk before any default occurs

### 6. Professionals Are the Safest Lending Segment
- **Finding:** Professional borrowers have only 5.9% P4 rate
  vs 13% for graduates
- **Decision:** Design preferential loan products to attract
  this low-risk segment

### 7. Single Metrics Cannot Be Trusted
- **Finding:** P1 customers have LOWEST zero-missed-payment
  rate (55%) — lower than P2, P3, P4
- **Decision:** Validate multi-factor credit scoring model.
  No single metric alone should drive approval decisions

---

## Dashboard
[3-page interactive Power BI dashboard screenshots]

![Overview](dashboard/screenshots/page1_overview.png)
![Risk Deep Dive](dashboard/screenshots/page2_risk_deepdive.png)
![Segments](dashboard/screenshots/page3_segment_analysis.png)

---

## Business Recommendation Summary
Three signals together identify the highest-risk borrowers:
1. CIBIL score below 660
2. More than 4 loan enquiries in 6 months  
3. Gold or Personal loan with even one missed payment

Customers matching all three criteria should be flagged 
immediately for relationship manager intervention — before 
default appears in the system.
