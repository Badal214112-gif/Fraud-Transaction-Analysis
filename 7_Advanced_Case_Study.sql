/*
==============================================
ADVANCED CASE STUDY
Project: UPI Fraud Detection Case Study
Tool: Google BigQuery
Dataset: upi

Purpose:
Solve business problems and identify
suspicious behavior patterns
==============================================
*/


------------------------------------------------
-- 1. USERS WITH VERY HIGH TRANSACTION FREQUENCY
------------------------------------------------

SELECT

user_id,

COUNT(*) AS total_transactions

FROM upi.transactions

GROUP BY user_id

HAVING COUNT(*) > 20

ORDER BY total_transactions DESC;



------------------------------------------------
-- 2. USERS WITH HIGH FAILED ATTEMPTS
------------------------------------------------

SELECT

user_id,

SUM(failed_attempts)

AS total_failed_attempts

FROM upi.transactions

GROUP BY user_id

ORDER BY total_failed_attempts DESC

LIMIT 10;



------------------------------------------------
-- 3. HIGH VALUE FRAUD TRANSACTIONS
------------------------------------------------

SELECT *

FROM upi.transactions

WHERE is_fraud=1
AND amount>10000

ORDER BY amount DESC;



------------------------------------------------
-- 4. USERS WITH NIGHT FRAUD ACTIVITY
------------------------------------------------

SELECT

user_id,

COUNT(*) AS night_fraud_cases

FROM upi.transactions

WHERE is_fraud=1
AND is_night_transaction=1

GROUP BY user_id

ORDER BY night_fraud_cases DESC;



------------------------------------------------
-- 5. DETECT POSSIBLE VELOCITY FRAUD
------------------------------------------------

SELECT

user_id,

COUNT(*) AS transaction_count

FROM upi.transactions

WHERE transaction_velocity='High'

GROUP BY user_id

ORDER BY transaction_count DESC;



------------------------------------------------
-- 6. USERS WITH MULTIPLE PAYMENT APPS
------------------------------------------------

SELECT

user_id,

COUNT(DISTINCT payment_app)

AS app_count

FROM upi.transactions

GROUP BY user_id

HAVING app_count>2

ORDER BY app_count DESC;



------------------------------------------------
-- 7. USERS WITH UNUSUAL SPENDING
------------------------------------------------

SELECT

user_id,

ROUND(
AVG(amount),2
)

AS avg_spending

FROM upi.transactions

GROUP BY user_id

ORDER BY avg_spending DESC

LIMIT 10;



------------------------------------------------
-- 8. FRAUD RATE BY DEVICE
------------------------------------------------

SELECT

device_type,

ROUND(
COUNTIF(is_fraud=1)
*100.0/
COUNT(*)
,2)

AS fraud_rate

FROM upi.transactions

GROUP BY device_type

ORDER BY fraud_rate DESC;



------------------------------------------------
-- 9. MERCHANTS WITH HIGHEST FRAUD
------------------------------------------------

SELECT

m.merchant_name,

COUNT(*) AS fraud_cases

FROM upi.transactions t

LEFT JOIN upi.merchants m

ON t.receiver_id=m.merchant_id

WHERE t.is_fraud=1

GROUP BY m.merchant_name

ORDER BY fraud_cases DESC

LIMIT 10;



------------------------------------------------
-- 10. HIGH-RISK USER PROFILE
------------------------------------------------

SELECT

u.user_id,
u.city,
u.kyc_status,

COUNT(t.transaction_id)
AS total_transactions,

SUM(t.failed_attempts)
AS total_failed_attempts,

COUNTIF(t.is_fraud=1)
AS fraud_cases

FROM upi.users u

LEFT JOIN upi.transactions t

ON u.user_id=t.user_id

GROUP BY

u.user_id,
u.city,
u.kyc_status

ORDER BY fraud_cases DESC;



/*
==============================================
END OF ADVANCED CASE STUDY
==============================================
*/
