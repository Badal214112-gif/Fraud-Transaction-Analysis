/*
==============================================
JOINS AND AGGREGATIONS
Project: UPI Fraud Detection Case Study
Tool: Google BigQuery
Dataset: upi

Purpose:
Combine users, merchants and
transactions for business insights
==============================================
*/


------------------------------------------------
-- 1. TRANSACTION WITH USER DETAILS
------------------------------------------------

SELECT

t.transaction_id,
t.user_id,
u.city,
u.kyc_status,
t.amount

FROM upi.transactions t

LEFT JOIN upi.users u

ON t.user_id=u.user_id

LIMIT 20;



------------------------------------------------
-- 2. TOTAL TRANSACTIONS BY CITY
------------------------------------------------

SELECT

u.city,
COUNT(*) AS total_transactions

FROM upi.transactions t

LEFT JOIN upi.users u

ON t.user_id=u.user_id

GROUP BY u.city

ORDER BY total_transactions DESC;



------------------------------------------------
-- 3. TOTAL TRANSACTION AMOUNT BY CITY
------------------------------------------------

SELECT

u.city,

ROUND(
SUM(t.amount),2
)

AS transaction_volume

FROM upi.transactions t

LEFT JOIN upi.users u

ON t.user_id=u.user_id

GROUP BY u.city

ORDER BY transaction_volume DESC;



------------------------------------------------
-- 4. TRANSACTIONS BY KYC STATUS
------------------------------------------------

SELECT

u.kyc_status,
COUNT(*) AS total_transactions

FROM upi.transactions t

LEFT JOIN upi.users u

ON t.user_id=u.user_id

GROUP BY u.kyc_status

ORDER BY total_transactions DESC;



------------------------------------------------
-- 5. TOP USERS BY TRANSACTION VALUE
------------------------------------------------

SELECT

t.user_id,

ROUND(
SUM(t.amount),2
)

AS total_spending

FROM upi.transactions t

GROUP BY t.user_id

ORDER BY total_spending DESC

LIMIT 10;



------------------------------------------------
-- 6. TRANSACTIONS BY MERCHANT CATEGORY
------------------------------------------------

SELECT

m.category,

COUNT(*) AS total_transactions

FROM upi.transactions t

LEFT JOIN upi.merchants m

ON t.receiver_id=m.merchant_id

GROUP BY m.category

ORDER BY total_transactions DESC;



------------------------------------------------
-- 7. TRANSACTION VOLUME BY MERCHANT CATEGORY
------------------------------------------------

SELECT

m.category,

ROUND(
SUM(t.amount),2
)

AS total_volume

FROM upi.transactions t

LEFT JOIN upi.merchants m

ON t.receiver_id=m.merchant_id

GROUP BY m.category

ORDER BY total_volume DESC;



------------------------------------------------
-- 8. AVERAGE TRANSACTION BY CITY
------------------------------------------------

SELECT

u.city,

ROUND(
AVG(t.amount),2
)

AS avg_transaction

FROM upi.transactions t

LEFT JOIN upi.users u

ON t.user_id=u.user_id

GROUP BY u.city

ORDER BY avg_transaction DESC;



------------------------------------------------
-- 9. USERS WITH HIGHEST FRAUD CASES
------------------------------------------------

SELECT

user_id,

COUNT(*) AS fraud_count

FROM upi.transactions

WHERE is_fraud=1

GROUP BY user_id

ORDER BY fraud_count DESC

LIMIT 10;



------------------------------------------------
-- 10. MERCHANTS WITH HIGHEST TRANSACTION COUNT
------------------------------------------------

SELECT

m.merchant_name,

COUNT(*) AS total_transactions

FROM upi.transactions t

LEFT JOIN upi.merchants m

ON t.receiver_id=m.merchant_id

GROUP BY m.merchant_name

ORDER BY total_transactions DESC

LIMIT 10;



/*
==============================================
END OF JOINS AND AGGREGATIONS
==============================================
*/
