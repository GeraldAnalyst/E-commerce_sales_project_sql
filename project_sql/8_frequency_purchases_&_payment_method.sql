/*
Creating query to detemine the frequency of purchase of customer i.e. weekly, Bi-weekly, monthly,
quarterly, annualy and every 3 months. 
Determine the most preferred method of payments by customers.
*/


--1. Preferred payment method.
SELECT
    payment_method,
    COUNT(*) as payment_method_count
    ---frequency_of_purchases
FROM 
    customer_details
GROUP BY
    payment_method
ORDER BY 
    payment_method_count DESC;


--2. Frequency of purchases by customers. 

SELECT
    frequency_of_purchases,
    COUNT(*)as Frequency_of_purchase_count
FROM customer_details
GROUP BY
    frequency_of_purchases
ORDER BY
    Frequency_of_purchase_count DESC;

