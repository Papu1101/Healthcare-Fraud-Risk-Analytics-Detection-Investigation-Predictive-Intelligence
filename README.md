# Healthcare-Fraud-Risk-Analytics-Detection-Investigation-Predictive-Intelligence
Healthcare Fraud Risk Analytics is an end-to-end data analytics project that leverages Python, PostgreSQL, Machine Learning, and Power BI to detect fraudulent healthcare claims, identify high-risk providers, analyze fraud patterns, quantify financial losses, and build predictive models. The project achieved a fraud detection ROC-AUC score of 0.9987

## Project Overview

Healthcare fraud is a major challenge for insurance providers and healthcare systems, resulting in significant financial losses and operational inefficiencies. This project analyzes healthcare insurance claims to identify fraudulent patterns, quantify fraud risk, prioritize investigations, and develop predictive models capable of detecting suspicious claims.

The project combines Python, Machine Learning, PostgreSQL, and Power BI to deliver an end-to-end fraud analytics solution, transforming raw claims data into actionable business intelligence.

---

## Business Problem

Fraudulent healthcare claims are often hidden within large volumes of legitimate transactions, making them difficult to detect through manual review alone. Insurance providers require data-driven approaches to:

* Detect potentially fraudulent claims
* Reduce financial losses
* Improve investigation efficiency
* Prioritize high-risk providers
* Monitor fraud trends over time
* Support compliance and audit teams

---

## Dataset Description

The dataset contains **18,764 healthcare insurance claims** designed to simulate real-world healthcare billing and fraud patterns.

### Key Features

#### Claim Information

* Claim Amount
* Approved Amount
* Claim Status
* Insurance Type

#### Patient Information

* Patient Age
* Patient Gender
* State
* Chronic Condition Flag
* Prior Visits (Last 12 Months)

#### Provider Information

* Provider ID
* Provider Specialty
* Monthly Provider Claim Volume

#### Medical Coding

* Diagnosis Codes
* Procedure Codes

#### Temporal Information

* Claim Submission Date
* Days Between Service and Claim

#### Target Variable

* Is_Fraud

  * 0 = Legitimate Claim
  * 1 = Fraudulent Claim

---

## Project Objectives

* Analyze healthcare fraud patterns
* Identify key fraud drivers
* Discover high-risk claim characteristics
* Segment providers based on fraud exposure
* Evaluate patient-level fraud risk
* Build predictive fraud detection models
* Generate stakeholder-focused SQL insights
* Develop interactive Power BI dashboards

---

## Tools & Technologies

### Python

* Pandas
* NumPy
* Matplotlib
* Seaborn
* SciPy
* Scikit-Learn

### Database

* PostgreSQL
* pgAdmin 4

### Business Intelligence

* Power BI

### Machine Learning Models

* Logistic Regression
* Random Forest

---

# Python Analytics

## Data Cleaning

* Missing value treatment
* Data type corrections
* Date conversion
* Duplicate checks
* Outlier detection

---

## Exploratory Data Analysis (EDA)

### Univariate Analysis

* Distribution of fraud vs non-fraud claims
* Claim amount analysis
* Patient demographics
* Provider behavior

### Bivariate Analysis

* Fraud vs claim amount
* Fraud vs approval amount
* Fraud vs provider activity
* Fraud vs insurance type

### Outlier Analysis

* Claim Amount
* Approved Amount
* Provider Monthly Volume
* Prior Visits

---

## Fraud Driver Analysis

Key fraud indicators identified:

### Claim Amount

Fraudulent claims had significantly higher claim amounts than legitimate claims.

* Non-Fraud Mean: 583.17
* Fraud Mean: 1,161.80

### Submission Delay

Fraudulent claims were submitted much faster.

* Legitimate Claims Median: 15 Days
* Fraudulent Claims Median: 4 Days

### Provider Volume

High-volume providers exhibited elevated fraud exposure.

---

## Statistical Hypothesis Testing

### Mann-Whitney U Test

Variable Tested:

* Days Between Service and Claim

Results:

* Statistic = 4,241,369.5
* P-Value = 0.0

Conclusion:

A statistically significant difference exists between fraudulent and legitimate claim submission delays.

---

## Risk Factor Discovery

### Claim Amount Risk

| Claim Band | Fraud Rate |
| ---------- | ---------- |
| Low        | 2.77%      |
| Medium     | 4.95%      |
| High       | 9.64%      |
| Very High  | 17.29%     |

### Submission Delay Risk

| Delay Band | Fraud Rate |
| ---------- | ---------- |
| Fast       | 30.41%     |
| Medium     | 5.68%      |
| Slow       | 1.31%      |

### Provider Volume Risk

| Provider Volume | Fraud Rate |
| --------------- | ---------- |
| Low             | 7.10%      |
| Very High       | 12.91%     |

---

## Provider Risk Segmentation

Providers were segmented into risk categories based on fraud rates.

| Segment       | Providers |
| ------------- | --------- |
| Low Risk      | 4,901     |
| Medium Risk   | 115       |
| High Risk     | 76        |
| Critical Risk | 769       |

Key Insight:

Critical-risk providers should be prioritized for audits and fraud investigations.

---

## Patient Risk Segmentation

Patient characteristics demonstrated limited influence on fraud occurrence.

Analyzed Factors:

* Age Groups
* Prior Visits
* Chronic Conditions

Finding:

Fraud was driven primarily by provider and claim behavior rather than patient demographics.

---

## Feature Engineering

Created features including:

* Claim Band
* Delay Band
* Provider Volume Band
* Provider Risk Segment
* Approval Ratio
* Claim Difference
* High-Risk Claim Flag

---

## Machine Learning

### Logistic Regression

Performance:

* Accuracy: 98%
* Precision: 86%
* Recall: 98%
* F1 Score: 92%
* ROC-AUC: 0.9987

### Random Forest

Performance:

* Accuracy: 94%
* Precision: 98%
* Recall: 31%
* F1 Score: 47%
* ROC-AUC: 0.9646

### Final Model Selection

Logistic Regression was selected as the final model due to its superior fraud detection capability and exceptionally high recall.

---

# SQL Business Intelligence Analysis

PostgreSQL was used to answer stakeholder-focused business questions.

### Fraud Loss Analysis

* Total Fraud Loss
* Fraud Loss by State
* Fraud Loss by Insurance Type
* Fraud Loss by Provider Specialty

### Provider Analysis

* Highest Fraud Loss Providers
* Highest Fraud Rate Providers
* Investigation Prioritization

### State Analysis

* State Fraud Exposure
* State Fraud Loss Rankings

### Medical Coding Analysis

* Top Diagnosis Codes
* Top Procedure Codes

### Trend Analysis

* Monthly Fraud Claims
* Monthly Fraud Loss

### Executive Reporting

* Fraud KPIs
* Fraud Rate Monitoring
* Risk Monitoring Metrics

---

# Power BI Dashboard

## Page 1 – Executive Overview

* Fraud KPIs
* Fraud vs Non-Fraud Distribution
* Top States by Fraud Loss
* Provider Specialty Analysis
* Insurance Type Analysis

## Page 2 – Fraud Loss & Risk Analysis

* Fraud Loss by State
* Fraud Loss by Specialty
* Fraud Rate by Insurance Type
* Claim Status Analysis
* Visit Type Analysis

## Page 3 – Provider Investigation Dashboard

* Top Providers by Fraud Loss
* Top Providers by Fraud Frequency
* Provider Fraud Scatter Analysis
* Audit Prioritization

## Page 4 – Fraud Trends & Medical Coding Analysis

* Monthly Fraud Trends
* Fraud Loss Trends
* Top Diagnosis Codes
* Top Procedure Codes
* Age Group Analysis

---

# Key Findings

* Overall Fraud Rate: 8.66%
* Fraudulent claims are nearly 2x larger than legitimate claims.
* Claims submitted within 5 days show a 30.41% fraud rate.
* Fast-submitted claims are 23x more likely to be fraudulent.
* Very high claim amounts exhibit a 17.29% fraud rate.
* Critical-risk providers represent the highest fraud exposure group.
* Logistic Regression achieved a ROC-AUC score of 0.9987.

---

# Business Recommendations

* Prioritize fast-submitted claims for investigation.
* Apply enhanced monitoring to high-value claims.
* Conduct audits on critical-risk providers.
* Implement predictive fraud scoring during claim processing.
* Use fraud risk segmentation to allocate investigative resources efficiently.

---

# Conclusion

This project demonstrates how healthcare fraud can be detected using a combination of statistical analysis, machine learning, SQL-based business intelligence, and interactive dashboards. The solution provides actionable insights for fraud investigators, compliance teams, and executive stakeholders while supporting proactive fraud prevention strategies.
