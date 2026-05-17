/*
==============================================
DATA CLEANING
Project: UPI Fraud Detection Case Study
Tool: Google BigQuery
Dataset: upi

Purpose:
Identify and inspect data quality issues
before analysis
==============================================
*/


------------------------------------------------
-- 1. CHECK TRANSACTIONS WITH NULL VALUES
------------------------------------------------

SELECT *
FROM upi.transactions
WHERE transaction_id IS NULL
OR user_id IS NULL
OR amount IS NULL;



------------------------------------------------
-- 2. CHECK USERS WITH NULL IDs
------------------------------------------------

SELECT *
FROM upi.users
WHERE user_id IS NULL;



------------------------------------------------
-- 3. CHECK MERCHANTS WITH NULL IDs
------------------------------------------------

SELECT *
FROM upi.merchants
WHERE merchant_id IS NULL;



------------------------------------------------
-- 4. FIND DUPLICATE TRANSACTION IDS
------------------------------------------------

SELECT
transaction_id,
COUNT(*) AS duplicate_count

FROM upi.transactions

GROUP BY transaction_id

HAVING COUNT(*) > 1;



------------------------------------------------
-- 5. CHECK INVALID AMOUNT VALUES
------------------------------------------------

SELECT *
FROM upi.transactions
WHERE amount <= 0;



------------------------------------------------
-- 6. CHECK PAYMENT APP INCONSISTENCY
------------------------------------------------

SELECT DISTINCT payment_app
FROM upi.transactions
ORDER BY payment_app;



------------------------------------------------
-- 7. CHECK DEVICE TYPE VALUES
------------------------------------------------

SELECT DISTINCT device_type
FROM upi.transactions
ORDER BY device_type;



------------------------------------------------
-- 8. CHECK KYC STATUS VALUES
------------------------------------------------

SELECT DISTINCT kyc_status
FROM upi.users
ORDER BY kyc_status;



------------------------------------------------
-- 9. CHECK MERCHANT CATEGORY VALUES
------------------------------------------------

SELECT DISTINCT category
FROM upi.merchants
ORDER BY category;



------------------------------------------------
-- 10. CHECK TIMESTAMP FORMAT
------------------------------------------------

SELECT
transaction_timestamp
FROM upi.transactions
LIMIT 20;



/*
==============================================
END OF DATA CLEANING
==============================================
*/
