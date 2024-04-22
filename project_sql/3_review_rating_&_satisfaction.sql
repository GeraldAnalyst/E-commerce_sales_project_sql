/*
Review rating and satisfaction 
Questions: 1. Is there a correlation between review rating and purchase amounts?
           2. How satisfied are customers overall?
*/

SELECT
   AVG(review_rating) AS avg_review_rating,
   AVG(purchased_amount) as avg_purchase_amount, 
   CORR(review_rating, purchased_amount) as correalation
FROM customer_details 
--WHERE color = 'Green' and size = 'M'


---overall customer satisfaction
SELECT
    ROUND(AVG(review_rating), 2) as average_review_rating
FROM customer_details

/*
the overall rating result is 
3.75
*/