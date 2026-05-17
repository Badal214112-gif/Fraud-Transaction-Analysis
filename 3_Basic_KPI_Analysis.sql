/*
==============================================
BASIC KPI ANALYSIS
Project: UPI Fraud Detection Case Study
Tool: Google BigQuery
Dataset: upi

Purpose:
Generate important business KPIs
for dashboard and analysis
==============================================
*/


------------------------------------------------
-- 1. TOTAL TRANSACTIONS
------------------------------------------------

SELECT
COUNT(*) AS total_transactions

FROM upi.transactions;



------------------------------------------------
-- 2. TOTAL TRANSACTION VOLUME
------------------------------------------------

SELECT
ROUND(SUM(amount),2)
AS total_transaction_volume

FROM upi.transactions;



------------------------------------------------
-- 3. AVERAGE TRANSACTION VALUE
------------------------------------------------

SELECT
ROUND(AVG(amount),2)
AS avg_transaction_amount

FROM upi.transactions;



------------------------------------------------
-- 4. MAXIMUM TRANSACTION VALUE
------------------------------------------------

SELECT
MAX(amount)
AS highest_transaction

FROM upi.transactions;



------------------------------------------------
-- 5. MINIMUM TRANSACTION VALUE
------------------------------------------------

SELECT
MIN(amount)
AS lowest_transaction

FROM upi.transactions;



------------------------------------------------
-- 6. TOTAL FRAUD TRANSACTIONS
------------------------------------------------

SELECT
COUNT(*)
AS fraud_transactions

FROM upi.transactions

WHERE is_fraud=1;



------------------------------------------------
-- 7. FRAUD PERCENTAGE
------------------------------------------------

SELECT

ROUND(
COUNTIF(is_fraud=1)*100.0
/
COUNT(*)
,2)

AS fraud_percentage

FROM upi.transactions;



------------------------------------------------
-- 8. TRANSACTIONS BY PAYMENT APP
------------------------------------------------

SELECT

payment_app,
COUNT(*) AS total_transactions

FROM upi.transactions

GROUP BY payment_app

ORDER BY total_transactions DESC;



------------------------------------------------
-- 9. TOP USERS BY TRANSACTION COUNT
------------------------------------------------

SELECT

user_id,
COUNT(*) AS total_transactions

FROM upi.transactions

GROUP BY user_id

ORDER BY total_transactions DESC

LIMIT 10;



------------------------------------------------
-- 10. DAILY TRANSACTION TREND
------------------------------------------------

SELECT

DATE(transaction_timestamp)
AS transaction_date,

COUNT(*) AS total_transactions

FROM upi.transactions

GROUP BY transaction_date

ORDER BY transaction_date;



/*
==============================================
END OF BASIC KPI ANALYSIS
==============================================
*/
