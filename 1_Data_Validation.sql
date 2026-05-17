/*
==============================================
DATA VALIDATION
Project: UPI Fraud Detection Case Study
Tool: Google BigQuery
Purpose:
Validate raw data before cleaning and analysis
==============================================
*/


------------------------------------------------
-- 1. TOTAL RECORD COUNT
------------------------------------------------

SELECT COUNT(*) AS total_users
FROM upi.users;

SELECT COUNT(*) AS total_transactions
FROM upi.transactions;

SELECT COUNT(*) AS total_merchants
FROM upi.merchants;

SELECT COUNT(*) AS total_fraud_records
FROM upi.fraud;



------------------------------------------------
-- 2. CHECK NULL VALUES IN TRANSACTIONS
------------------------------------------------

SELECT
COUNTIF(transaction_id IS NULL) AS null_transaction_id,
COUNTIF(user_id IS NULL) AS null_user_id,
COUNTIF(amount IS NULL) AS null_amount,
COUNTIF(transaction_timestamp IS NULL) AS null_timestamp,
COUNTIF(payment_app IS NULL) AS null_payment_app

FROM upi.transactions;



------------------------------------------------
-- 3. CHECK DUPLICATE TRANSACTIONS
------------------------------------------------

SELECT
transaction_id,
COUNT(*) AS duplicate_count

FROM upi.transactions

GROUP BY transaction_id

HAVING COUNT(*) > 1;



------------------------------------------------
-- 4. CHECK INVALID AMOUNTS
------------------------------------------------

SELECT *

FROM upi.transactions

WHERE amount<=0;



------------------------------------------------
-- 5. FRAUD DISTRIBUTION
------------------------------------------------

SELECT
is_fraud,
COUNT(*) AS total_transactions

FROM upi.transactions

GROUP BY is_fraud;



------------------------------------------------
-- 6. TRANSACTION TYPE DISTRIBUTION
------------------------------------------------

SELECT
receiver_type,
COUNT(*) AS total_transactions

FROM upi.transactions

GROUP BY receiver_type;



------------------------------------------------
-- 7. PAYMENT APP USAGE
------------------------------------------------

SELECT
payment_app,
COUNT(*) AS total_transactions

FROM upi.transactions

GROUP BY payment_app

ORDER BY total_transactions DESC;



------------------------------------------------
-- 8. DEVICE TYPE ANALYSIS
------------------------------------------------

SELECT
device_type,
COUNT(*) AS total_transactions

FROM upi.transactions

GROUP BY device_type

ORDER BY total_transactions DESC;



------------------------------------------------
-- 9. KYC STATUS DISTRIBUTION
------------------------------------------------

SELECT
kyc_status,
COUNT(*) AS total_users

FROM upi.users

GROUP BY kyc_status;



------------------------------------------------
-- 10. MERCHANT CATEGORY DISTRIBUTION
------------------------------------------------

SELECT
category,
COUNT(*) AS total_merchants

FROM upi.merchants

GROUP BY category

ORDER BY total_merchants DESC;



/*
==============================================
END OF DATA VALIDATION
==============================================
*/
