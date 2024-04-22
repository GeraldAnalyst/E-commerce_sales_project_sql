/*
Discount usage and promo code
Question: How often do customers use discount or promo codes?
            Do promo codes impact purchase behaviour?
To determine how often customers use discount or promo codes we count the total number of distinct customers
and count the number of distinct customers who used discount
*/

--1. How often do customers use discount or promo code 

SELECT
    COUNT(DISTINCT customer_id) as total_customers,
    COUNT(DISTINCT CASE WHEN discount_applied = TRUE THEN customer_id END) as customers_with_discount,
    CAST(COUNT(DISTINCT CASE WHEN discount_applied = TRUE THEN customer_id END) AS DECIMAL)/ COUNT(DISTINCT customer_id) as discount_usage_ratio
FROM 
    customer_details;

/* 
here is the result
[
  {
    "total_customers": "3900",
    "customers_with_discount": "1677",
    "discount_usage_ratio": "0.43000000000000000000"
  }
]
the discount usage ratio gives an idea of how often the discount is applied by customers, 
in our case 43% of our customers use discount. 
*/

--2. Do promo codes impact purchase behaviour

  
SELECT
    SUM(CASE WHEN promo_code_used ='TRUE' THEN purchased_amount ELSE 0 END) as Total_amount_with_promo_code,
    SUM (purchased_amount) as Total_amount_without_promo_code,
    SUM(CASE WHEN promo_code_used ='TRUE' THEN purchased_amount ELSE 0 END)/ SUM (purchased_amount) AS
    promo_code_ratio
FROM (
    SELECT
        purchased_amount,
        customer_id,
        SUM(purchased_amount) AS total_purchase_amount,
        promo_code_used
    FROM 
        customer_details
    GROUP BY 
        customer_id, promo_code_used
) subquery;

