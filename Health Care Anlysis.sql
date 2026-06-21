CREATE TABLE healthcare_fraud_detection (
    provider_id VARCHAR(20),
    claim_id VARCHAR(20) PRIMARY KEY,
    patient_age INT,
    patient_gender VARCHAR(20),
    diagnosis_code VARCHAR(20),
    procedure_code BIGINT,
    claim_amount NUMERIC(12,2),
    approved_amount NUMERIC(12,2),
    insurance_type VARCHAR(50),
    claim_submission_date DATE,
    days_between_service_and_claim INT,
    number_of_claims_per_provider_monthly INT,
    provider_specialty VARCHAR(100),
    patient_state VARCHAR(50),
    claim_status VARCHAR(20),
    is_fraud INT,
    length_of_stay INT,
    visit_type VARCHAR(50),
    chronic_condition_flag INT,
    prior_visits_12m INT
);
SELECT * FROM healthcare_fraud_detection;

--What is the total financial loss associated with fraudulent claims?
SELECT 
   ROUND(SUM(claim_amount),2) AS Total_Fraud_Loss
FROM healthcare_fraud_detection
WHERE is_fraud = 1;
---
SELECT 
   COUNT(*) AS Fraud_Claim_Count,
   ROUND(SUM(claim_amount),2) AS Total_Fraud_Loss,
   ROUND(AVG(claim_amount),2) AS Avg_Fraud_Loss,
   ROUND(MAX(claim_amount),2) AS Maximum_Fraud_Loss
FROM healthcare_fraud_detection
WHERE is_fraud = 1;

---Which providers generated the highest fraud loss??
SELECT
    provider_id,
	ROUND(SUM(claim_amount),2) AS Total_Fraud_Loss 
FROM healthcare_fraud_detection
WHERE is_fraud = 1
GROUP BY provider_id
ORDER BY Total_Fraud_Loss DESC
LIMIT 1;

---Which provider specialties have the highest fraud rates?
SELECT
    provider_specialty,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_claims,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_rate
FROM healthcare_fraud_detection
GROUP BY provider_specialty
ORDER BY fraud_rate DESC;
---Which insurance types experience the highest fraud losses?
SELECT 
    insurance_type,
	ROUND(SUM(claim_amount),2) AS Total_Fraud_loss
FROM healthcare_fraud_detection
WHERE is_fraud = 1
GROUP BY insurance_type
ORDER BY Total_Fraud_loss DESC;

--Which states contribute the most to fraudulent claim amounts?
SELECT 
    patient_state,
	COUNT(*) AS Fraud_Claims,
	ROUND(SUM(claim_amount),2) AS Total_Fraud_Loss
FROM healthcare_fraud_detection
WHERE is_fraud = 1
GROUP BY patient_state
ORDER BY Total_Fraud_Loss DESC;

--What is the monthly trend of fraud claims and fraud losses?
SELECT 
   DATE_TRUNC('month',claim_submission_date) AS Month,
   COUNT(*) AS Fraud_Claim_Count,
   ROUND(SUM(claim_amount),2) AS Total_Fraud_Loss
FROM healthcare_fraud_detection
WHERE is_fraud = 1
GROUP BY DATE_TRUNC('month',claim_submission_date)
ORDER BY month;
--What percentage of total claims are fraudulent?
SELECT 
   COUNT(*) AS Total_claims,
   SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END ) AS Fraud_Claims,
   ROUND(
       100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END )
	   / COUNT(*),2
   ) AS Fraud_Percentage
FROM healthcare_fraud_detection;
--Which visit types account for the largest share of fraud losses?
SELECT 
   visit_type,
   ROUND(SUM(claim_amount),2) AS Total_Fraud_Loss
FROM healthcare_fraud_detection
WHERE is_fraud =1 
GROUP BY visit_type
ORDER BY Total_Fraud_Loss DESC;
---What is the average claim amount for fraud vs non-fraud claims?
SELECT 
    CASE 
	   WHEN is_fraud = 1 THEN 'Fraud'
	   ELSE 'Not_Fraud'
	END AS Claim_Type,
	COUNT(*) AS Total_Claims,
	ROUND(AVG(claim_amount),2) AS Avg_Claim_Amount
FROM healthcare_fraud_detection
GROUP BY is_fraud
ORDER BY is_fraud;
---Which providers should investigators prioritize based on fraud amount and fraud frequency?
WITH provider_fraud AS (
    SELECT
        provider_id,
        COUNT(*) AS fraud_claim_count,
        ROUND(SUM(claim_amount), 2) AS fraud_loss
    FROM healthcare_fraud_detection
    WHERE is_fraud = 1
    GROUP BY provider_id
)
SELECT
    provider_id,
    fraud_claim_count,
    fraud_loss,
    RANK() OVER (
        ORDER BY fraud_loss DESC,
                 fraud_claim_count DESC
    ) AS investigation_priority_rank
FROM provider_fraud
ORDER BY investigation_priority_rank;
---Which claim statuses are most associated with fraudulent claims?
SELECT
    claim_status,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_claims,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_rate
FROM healthcare_fraud_detection
GROUP BY claim_status
ORDER BY fraud_rate DESC;
---What are the top diagnosis codes found in fraudulent claims?
SELECT
    diagnosis_code,
    COUNT(*) AS fraud_claim_count,
    ROUND(SUM(claim_amount), 2) AS fraud_loss
FROM healthcare_fraud_detection
WHERE is_fraud = 1
GROUP BY diagnosis_code
ORDER BY fraud_claim_count DESC
LIMIT 10;
---What are the top procedure codes found in fraudulent claims?
SELECT
    procedure_code,
    COUNT(*) AS fraud_claim_count,
    ROUND(SUM(claim_amount), 2) AS fraud_loss
FROM healthcare_fraud_detection
WHERE is_fraud = 1
GROUP BY procedure_code
ORDER BY fraud_claim_count DESC;
---Which age groups generate the highest fraud losses?
SELECT
    CASE
        WHEN patient_age <= 18 THEN '0-18'
        WHEN patient_age BETWEEN 19 AND 35 THEN '19-35'
        WHEN patient_age BETWEEN 36 AND 50 THEN '36-50'
        WHEN patient_age BETWEEN 51 AND 65 THEN '51-65'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS fraud_claim_count,
    ROUND(SUM(claim_amount), 2) AS fraud_loss
FROM healthcare_fraud_detection
WHERE is_fraud = 1
GROUP BY age_group
ORDER BY fraud_loss DESC;
---Which provider specialties should receive enhanced audits based on fraud exposure?
SELECT
    provider_specialty,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_claims,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_rate,
    ROUND(
        SUM(
            CASE WHEN is_fraud = 1
            THEN claim_amount
            ELSE 0
            END
        ),
        2
    ) AS fraud_loss
FROM healthcare_fraud_detection
GROUP BY provider_specialty
ORDER BY fraud_rate DESC, fraud_loss DESC;