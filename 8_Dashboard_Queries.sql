/*
==============================================
DASHBOARD QUERIES
Project: UPI Fraud Detection Case Study
Tool: Google BigQuery
Dataset: upi

Purpose:
Create dashboard-ready datasets and KPIs
for Looker Studio visualizations
==============================================
*/


------------------------------------------------
-- 1. KPI SCORECARDS
------------------------------------------------

SELECT
COUNT(*) AS total_transactions,

ROUND(SUM(amount),2)
AS total_transaction_volume,

ROUND(AVG(amount),2)
AS avg_transaction_amount,

COUNTIF(is_fraud=1)
AS total_fraud_transactions,

ROUND(
COUNTIF(is_fraud=1)*100.0/
COUNT(*)
,2)

AS fraud_rate

FROM upi.transactions;



------------------------------------------------
-- 2. DAILY TRANSACTION TREND
------------------------------------------------

SELECT

DATE(transaction_timestamp)
AS transaction_date,

COUNT(*) AS transaction_count,

ROUND(
SUM(amount),2
)

AS transaction_volume

FROM upi.transactions

GROUP BY transaction_date

ORDER BY transaction_date;



------------------------------------------------
-- 3. FRAUD TREND
------------------------------------------------

SELECT

DATE(transaction_timestamp)
AS transaction_date,

COUNT(*) AS fraud_cases

FROM upi.transactions

WHERE is_fraud=1

GROUP BY transaction_date

ORDER BY transaction_date;



------------------------------------------------
-- 4. PAYMENT APP ANALYSIS
------------------------------------------------

SELECT

payment_app,

COUNT(*) AS transaction_count,

ROUND(
SUM(amount),2
)

AS transaction_volume

FROM upi.transactions

GROUP BY payment_app

ORDER BY transaction_count DESC;



------------------------------------------------
-- 5. DEVICE TYPE ANALYSIS
------------------------------------------------

SELECT

device_type,

COUNT(*) AS total_transactions,

COUNTIF(is_fraud=1)
AS fraud_transactions

FROM upi.transactions

GROUP BY device_type

ORDER BY total_transactions DESC;



------------------------------------------------
-- 6. CITY ANALYSIS
------------------------------------------------

SELECT

u.city,

COUNT(*) AS total_transactions,

ROUND(
SUM(t.amount),2
)

AS total_volume,

COUNTIF(
t.is_fraud=1
)

AS fraud_cases

FROM upi.transactions t

LEFT JOIN upi.users u

ON t.user_id=u.user_id

GROUP BY u.city

ORDER BY total_volume DESC;



------------------------------------------------
-- 7. KYC ANALYSIS
------------------------------------------------

SELECT

u.kyc_status,

COUNT(*) AS total_transactions,

COUNTIF(
t.is_fraud=1
)

AS fraud_cases

FROM upi.transactions t

LEFT JOIN upi.users u

ON t.user_id=u.user_id

GROUP BY u.kyc_status;



------------------------------------------------
-- 8. MERCHANT CATEGORY ANALYSIS
------------------------------------------------

SELECT

m.category,

COUNT(*) AS total_transactions,

ROUND(
SUM(t.amount),2
)

AS transaction_volume

FROM upi.transactions t

LEFT JOIN upi.merchants m

ON t.receiver_id=m.merchant_id

GROUP BY m.category

ORDER BY transaction_volume DESC;



------------------------------------------------
-- 9. TOP USERS
------------------------------------------------

SELECT

user_id,

COUNT(*) AS total_transactions,

ROUND(
SUM(amount),2
)

AS spending

FROM upi.transactions

GROUP BY user_id

ORDER BY spending DESC

LIMIT 10;



------------------------------------------------
-- 10. HOURLY TRANSACTION ANALYSIS
------------------------------------------------

SELECT

EXTRACT(
HOUR FROM transaction_timestamp
)

AS transaction_hour,

COUNT(*) AS transaction_count,

COUNTIF(is_fraud=1)
AS fraud_count

FROM upi.transactions

GROUP BY transaction_hour

ORDER BY transaction_hour;



/*
==============================================
END OF DASHBOARD QUERIES
==============================================
*/
