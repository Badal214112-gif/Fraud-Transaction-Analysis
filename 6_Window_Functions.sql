/*
==============================================
WINDOW FUNCTIONS
Project: UPI Fraud Detection Case Study
Tool: Google BigQuery
Dataset: upi

Purpose:
Perform advanced SQL analysis using
window functions
==============================================
*/


------------------------------------------------
-- 1. RANK USERS BY TOTAL SPENDING
------------------------------------------------

SELECT

user_id,

SUM(amount) AS total_spending,

RANK() OVER(
ORDER BY SUM(amount) DESC
)

AS spending_rank

FROM upi.transactions

GROUP BY user_id;



------------------------------------------------
-- 2. DENSE RANK USERS
------------------------------------------------

SELECT

user_id,

SUM(amount) AS total_spending,

DENSE_RANK() OVER(
ORDER BY SUM(amount) DESC
)

AS dense_rank

FROM upi.transactions

GROUP BY user_id;



------------------------------------------------
-- 3. ROW NUMBER FOR USER TRANSACTIONS
------------------------------------------------

SELECT

transaction_id,
user_id,
amount,

ROW_NUMBER() OVER(
PARTITION BY user_id
ORDER BY amount DESC
)

AS transaction_number

FROM upi.transactions;



------------------------------------------------
-- 4. HIGHEST TRANSACTION OF EACH USER
------------------------------------------------

SELECT *

FROM(

SELECT

transaction_id,
user_id,
amount,

ROW_NUMBER() OVER(

PARTITION BY user_id

ORDER BY amount DESC

)

AS rn

FROM upi.transactions

)

WHERE rn=1;



------------------------------------------------
-- 5. RUNNING TOTAL OF TRANSACTIONS
------------------------------------------------

SELECT

transaction_timestamp,
amount,

SUM(amount)

OVER(

ORDER BY transaction_timestamp

)

AS running_total

FROM upi.transactions;



------------------------------------------------
-- 6. PREVIOUS TRANSACTION VALUE
------------------------------------------------

SELECT

user_id,
transaction_timestamp,
amount,

LAG(amount)

OVER(

PARTITION BY user_id

ORDER BY transaction_timestamp

)

AS previous_transaction

FROM upi.transactions;



------------------------------------------------
-- 7. NEXT TRANSACTION VALUE
------------------------------------------------

SELECT

user_id,
transaction_timestamp,
amount,

LEAD(amount)

OVER(

PARTITION BY user_id

ORDER BY transaction_timestamp

)

AS next_transaction

FROM upi.transactions;



------------------------------------------------
-- 8. DIFFERENCE BETWEEN CURRENT AND PREVIOUS
------------------------------------------------

SELECT

user_id,
amount,

amount-

LAG(amount)

OVER(

PARTITION BY user_id

ORDER BY transaction_timestamp

)

AS difference

FROM upi.transactions;



------------------------------------------------
-- 9. FRAUD RANKING BY USER
------------------------------------------------

SELECT

user_id,

COUNT(*) AS fraud_count,

RANK()

OVER(
ORDER BY COUNT(*) DESC
)

AS fraud_rank

FROM upi.transactions

WHERE is_fraud=1

GROUP BY user_id;



------------------------------------------------
-- 10. MOVING AVERAGE
------------------------------------------------

SELECT

transaction_timestamp,
amount,

AVG(amount)

OVER(

ORDER BY transaction_timestamp

ROWS BETWEEN 2 PRECEDING
AND CURRENT ROW

)

AS moving_average

FROM upi.transactions;



/*
==============================================
END OF WINDOW FUNCTIONS
==============================================
*/
