-- Q1: How are customers distributed across risk categories?

select Approved_Flag,
	count(*) As Total_customers,
    Round(count(*)*100.0/sum(count(*)) over(),1) as percentage
from master_credit
group by Approved_Flag
Order by Approved_Flag;

-- Q2: What is the average credit score per risk category?
SELECT Approved_Flag,
       ROUND(AVG(Credit_Score), 1) AS avg_credit_score,
       MIN(Credit_Score) AS min_score,
       MAX(Credit_Score) AS max_score
FROM master_credit
GROUP BY Approved_Flag
ORDER BY avg_credit_score DESC;

-- Q3: Which loan type has the most missed payments?
SELECT
    'Auto'     AS loan_type, 
    ROUND(AVG(CASE WHEN Auto_TL > 0 THEN Tot_Missed_Pmnt END), 2) AS avg_missed
FROM master_credit
UNION ALL
SELECT 'Gold',     ROUND(AVG(CASE WHEN Gold_TL > 0 THEN Tot_Missed_Pmnt END), 2) FROM master_credit
UNION ALL
SELECT 'Personal', ROUND(AVG(CASE WHEN PL_TL > 0 THEN Tot_Missed_Pmnt END), 2)  FROM master_credit
UNION ALL
SELECT 'Home',     ROUND(AVG(CASE WHEN Home_TL > 0 THEN Tot_Missed_Pmnt END), 2) FROM master_credit
UNION ALL
SELECT 'Credit Card', ROUND(AVG(CASE WHEN CC_TL > 0 THEN Tot_Missed_Pmnt END), 2) FROM master_credit
ORDER BY avg_missed DESC;

-- Q4: How does income vary across risk tiers?
SELECT Approved_Flag,
       ROUND(AVG(NETMONTHLYINCOME), 0) AS avg_income,
       ROUND(MIN(NETMONTHLYINCOME), 0) AS min_income,
       ROUND(MAX(NETMONTHLYINCOME), 0) AS max_income
FROM master_credit
WHERE NETMONTHLYINCOME > 0 AND NETMONTHLYINCOME != -99999
GROUP BY Approved_Flag
ORDER BY avg_income DESC;

-- Q5: Do customers with more recent loan enquiries get riskier ratings?
SELECT Approved_Flag,
       ROUND(AVG(enq_L6m), 2) AS avg_enquiries_last_6m,
       ROUND(AVG(enq_L12m), 2) AS avg_enquiries_last_12m
FROM master_credit
WHERE enq_L6m != -99999
GROUP BY Approved_Flag
ORDER BY avg_enquiries_last_6m DESC;

-- Q6: What is the risk profile by education level?
SELECT EDUCATION,
       COUNT(*) AS total,
       SUM(CASE WHEN Approved_Flag = 'P1' THEN 1 ELSE 0 END) AS P1_best,
       SUM(CASE WHEN Approved_Flag = 'P4' THEN 1 ELSE 0 END) AS P4_risky,
       ROUND(SUM(CASE WHEN Approved_Flag = 'P4' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_risky
FROM master_credit
GROUP BY EDUCATION
ORDER BY pct_risky DESC;

-- Q7: Rank customers by missed payments within each risk category
SELECT PROSPECTID, Approved_Flag, Tot_Missed_Pmnt, Credit_Score,
       RANK() OVER (PARTITION BY Approved_Flag ORDER BY Tot_Missed_Pmnt DESC) AS risk_rank
FROM master_credit
WHERE Tot_Missed_Pmnt > 0
ORDER BY Approved_Flag, risk_rank
LIMIT 20;

-- Q8: What % of customers have zero missed payments per risk tier?
SELECT Approved_Flag,
       COUNT(*) AS total,
       SUM(CASE WHEN Tot_Missed_Pmnt = 0 THEN 1 ELSE 0 END) AS zero_missed,
       ROUND(SUM(CASE WHEN Tot_Missed_Pmnt = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_clean
FROM master_credit
GROUP BY Approved_Flag
ORDER BY pct_clean DESC;