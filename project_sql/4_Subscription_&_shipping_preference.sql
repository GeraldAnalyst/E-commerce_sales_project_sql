/*
This section we would like to determine the number of customers with the subscription 
out of 3900  customers and the preferred shipping method. 

Question: How many customers have subscribed?
         Which shipping type(express, free shipping) is preferred?
*/

--1. The number of subscribed customers
SELECT
    subscription_status,
    COUNT(*) AS subscribed_customers
FROM customer_details
GROUP BY  
    subscription_status
ORDER BY 
    subscribed_customers;

---2. The subscribed customers by gender
SELECT
    gender,
    COUNT(*) AS subscribed_customers
FROM
     customer_details
WHERE subscription_status = TRUE
GROUP BY  
    gender
ORDER BY 
    subscribed_customers;

---3. the preferred shipping type

SELECT
    shipping_type,
    COUNT(*) as shipping_type_count
FROM 
    customer_details
---WHERE location = 'New Jersey'
---WHERE season = 'Fall' AND category = 'Clothing'
GROUP BY
    shipping_type
ORDER BY 
    shipping_type_count DESC;


