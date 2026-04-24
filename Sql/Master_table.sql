USE credit_risk_db;

select count(*) from internal_bank;
select count(*) from external_cibil;

#--Master Joined Table--------#

CREATE TABLE master_credit AS
SELECT
    b.*,
    c.time_since_recent_payment,
    c.num_times_delinquent,
    c.max_delinquency_level,
    c.num_deliq_6mts,
    c.num_deliq_12mts,
    c.num_times_30p_dpd,
    c.num_times_60p_dpd,
    c.MARITALSTATUS,
    c.EDUCATION,
    c.AGE,
    c.GENDER,
    c.NETMONTHLYINCOME,
    c.Time_With_Curr_Empr,
    c.Credit_Score,
    c.tot_enq,
    c.enq_L6m,
    c.enq_L12m,
    c.last_prod_enq2,
    c.first_prod_enq2,
    c.Approved_Flag
FROM internal_bank b
JOIN external_cibil c ON b.PROSPECTID = c.PROSPECTID;

-- Verify
SELECT COUNT(*) FROM master_credit;  -- Should show 51336