/*
Customer segmentation 
Question: How can we group customers based on their demographics( age, gender, and location)?
Are there distinct customers segments with varying purchasing behaviors?
*/

--the first step is to write a query to depict distinct age groups, gender, location and average purchases

SELECT
    CASE
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,

    gender,
    location,
    COUNT(*) AS customer_count,
   ROUND (AVG(purchased_amount)) AS average_purchased_amount

FROM 
    customer_details
GROUP BY 
    age_group, gender, location;


/*
Lets explore further by looking at the 
1.Number of customer by age_group and sum of AVERAGE purchased amount
*/

WITH customer_segmentation AS(
    SELECT
    CASE
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,

    gender,
    location,
    COUNT(*) AS customer_count,
   ROUND (AVG(purchased_amount)) AS average_purchased_amount

FROM 
    customer_details
GROUP BY 
    age_group, gender, location
)

SELECT 
    age_group,
    SUM(customer_count) as Total_customers,
    SUM(average_purchased_amount) as Total_average_purchased_amount
FROM customer_segmentation
GROUP BY
    age_group
ORDER BY 
    age_group;

/*
Here's the result 
[
  {
    "age_group": "18-24",
    "total_customers": "486",
    "total_average_purchased_amount": "6022"
  },
  {
    "age_group": "25-34",
    "total_customers": "755",
    "total_average_purchased_amount": "6037"
  },
  {
    "age_group": "35-44",
    "total_customers": "729",
    "total_average_purchased_amount": "5896"
  },
  {
    "age_group": "45-54",
    "total_customers": "752",
    "total_average_purchased_amount": "6021"
  },
  {
    "age_group": "55-64",
    "total_customers": "751",
    "total_average_purchased_amount": "5942"
  },
  {
    "age_group": "65+",
    "total_customers": "427",
    "total_average_purchased_amount": "5900"
  }
]
*/


/*
2. Number of customer by location 
*/

WITH customer_segmentation AS(
    SELECT
    CASE
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,

    gender,
    location,
    COUNT(*) AS customer_count,
   ROUND (AVG(purchased_amount)) AS average_purchased_amount

FROM 
    customer_details
GROUP BY 
    age_group, gender, location
)
SELECT  
    sum(customer_count) as Total_customer_per_region,
    SUM(average_purchased_amount) as Total_average_purchased_amount_per_region,
    location 
FROM 
    customer_segmentation
GROUP BY 
    location
ORDER BY
    --Total_average_purchased_amount_per_region DESC;
    Total_customer_per_region DESC;

--3. Number of customers by Gender 

WITH customer_segmentation AS(
    SELECT
    CASE
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,

    gender,
    location,
    COUNT(*) AS customer_count,
   ROUND (AVG(purchased_amount)) AS average_purchased_amount

FROM 
    customer_details
GROUP BY 
    age_group, gender, location
)
SELECT
    gender,
    SUM(customer_count) AS customer_count_by_gender,
    SUM(average_purchased_amount) as average_purchased_per_gender
FROM 
    customer_segmentation
GROUP BY 
    gender;

/* Here's the result
[
  {
    "gender": "Female",
    "customer_count_by_gender": "1248",
    "average_purchased_per_gender": "17853"
  },
  {
    "gender": "Male",
    "customer_count_by_gender": "2652",
    "average_purchased_per_gender": "17965"
  }
]
*/

