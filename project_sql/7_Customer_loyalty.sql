/*
Let's create a query to segment customers and identify the New customers and loyal customers.
Then calculate relevant metrics. Reason is to determine the average purchase amount
and average review rating by both New and loyal customers for business insight. 
*/

WITH customer_frequency AS (
    SELECT
        customer_id,
        purchased_amount,
        review_rating,
        previous_purchases,
        CASE 
            WHEN previous_purchases = 1 THEN 'New customer'
            ELSE 'Loyal customers'
            END AS customer_segment
    FROM customer_details

)
SELECT
    customer_segment,
    AVG(purchased_amount) AS Average_purchased_amount,
    AVG(review_rating) AS Average_review_rating
FROM 
    customer_frequency
GROUP BY
    customer_segment;

 /*
 Here's the result 
 [
  {
    "customer_segment": "New customer",
    "average_purchased_amount": "58.4698795180722892",
    "average_review_rating": "3.8433734939759036"
  },
  {
    "customer_segment": "Loyal customers",
    "average_purchased_amount": "59.7925072046109510",
    "average_review_rating": "3.7479172124705266"
  }
]
*/
