/*
==============================================
FRAUD ANALYSIS
Project: UPI Fraud Detection Case Study
Tool: Google BigQuery
Dataset: upi

Purpose:
Analyze fraud patterns and risky behavior
==============================================
*/


------------------------------------------------
-- 1. TOTAL FRAUD VS NON-FRAUD
------------------------------------------------

SELECT

is_fraud,
COUNT(*) AS total_transactions

FROM upi.transactions

GROUP BY is_fraud;



------------------------------------------------
-- 2. FRAUD TRANSACTION AMOUNT
------------------------------------------------

SELECT

ROUND(
SUM(amount),2
)

AS fraud_transaction_volume

FROM upi.transactions

WHERE is_fraud=1;



------------------------------------------------
-- 3. FRAUD BY PAYMENT APP
------------------------------------------------

SELECT

payment_app,

COUNT(*) AS fraud_count

FROM upi.transactions

WHERE is_fraud=1

GROUP BY payment_app

ORDER BY fraud_count DESC;



------------------------------------------------
-- 4. FRAUD BY DEVICE TYPE
------------------------------------------------

SELECT

device_type,

COUNT(*) AS fraud_count

FROM upi.transactions

WHERE is_fraud=1

GROUP BY device_type

ORDER BY fraud_count DESC;



------------------------------------------------
-- 5. FRAUD BY CITY
------------------------------------------------

SELECT

u.city,

COUNT(*) AS fraud_count

FROM upi.transactions t

LEFT JOIN upi.users u

ON t.user_id=u.user_id

WHERE t.is_fraud=1

GROUP BY u.city

ORDER BY fraud_count DESC;



------------------------------------------------
-- 6. FRAUD BY KYC STATUS
------------------------------------------------

SELECT

u.kyc_status,

COUNT(*) AS fraud_count

FROM upi.transactions t

LEFT JOIN upi.users u

ON t.user_id=u.user_id

WHERE t.is_fraud=1

GROUP BY u.kyc_status

ORDER BY fraud_count DESC;



------------------------------------------------
-- 7. FRAUD BY HOUR OF DAY
------------------------------------------------

SELECT

EXTRACT(HOUR FROM transaction_timestamp)
AS transaction_hour,

COUNT(*) AS fraud_count

FROM upi.transactions

WHERE is_fraud=1

GROUP BY transaction_hour

ORDER BY fraud_count DESC;



------------------------------------------------
-- 8. NIGHT FRAUD ANALYSIS
------------------------------------------------

SELECT

is_night_transaction,

COUNT(*) AS fraud_count

FROM upi.transactions

WHERE is_fraud=1

GROUP BY is_night_transaction;



------------------------------------------------
-- 9. TOP USERS WITH HIGHEST FRAUD
------------------------------------------------

SELECT

user_id,

COUNT(*) AS fraud_cases

FROM upi.transactions

WHERE is_fraud=1

GROUP BY user_id

ORDER BY fraud_cases DESC

LIMIT 10;



------------------------------------------------
-- 10. FRAUD RATE %
------------------------------------------------

SELECT

ROUND(
COUNTIF(is_fraud=1)*100.0
/
COUNT(*)
,2)

AS fraud_rate

FROM upi.transactions;



/*
==============================================
END OF FRAUD ANALYSIS
==============================================
*/
