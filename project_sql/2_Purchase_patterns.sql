/* 
Purchase pattern
Here we are trying to understand our purchase pattern by determining the most purchased items,
seasons with the highest sales and colors or sizes most purchased. 
Questions: 1. What are the most popular items purchased?
           2. which season sees the highest sales?
           3. Do certain colors or sizes perform better than the others?
*/

--1. most popular itesms purchased 
SELECT
    item_purchased,
    count(*) as purchase_count
    
FROM 
    customer_details
Group BY
    item_purchased
ORDER BY 
    purchase_count DESC;



--2. which category is most bought 

SELECT
    category,
    COUNT(*) as category_count,
    SUM(purchased_amount) as category_sales_revenue
FROM customer_details
GROUP BY 
    category
ORDER BY
    category_count DESC;

---3.Season with the highest sales

SELECT
    season,
    COUNT(*) as season_count,
    Sum(purchased_amount) as Season_revenue
FROM 
    customer_details
GROUP BY
    season
ORDER BY
    season_revenue DESC;

/* Lets delve into specific/ more detailed purchased patterns by infusing size, color
with category, gender etc.
*/

---4 a. which size performes better in each category
SELECT  
    Size,
    COUNT(*) as size_count,
    SUM(purchased_amount) as Revenue_by_size
FROM 
    customer_details
--WHERE category = 'Clothing' --AND  gender = 'Female'
GROUP BY
    SIZE
ORDER BY
    Revenue_by_size DESC;

/* here is the results
"size","size_count","revenue_by_size"
"M","1755","105167"
"L","1053","61667"
"S","663","40468"
"XL","429","25779"

*/

---Accessories category
SELECT  
    Size,
    COUNT(*) as size_count,
    SUM(purchased_amount) as Revenue_by_size
FROM 
    customer_details
WHERE category = 'Accessories'
GROUP BY
    SIZE
ORDER BY
    Revenue_by_size DESC;

---Footwear category
SELECT  
    Size,
    COUNT(*) as size_count,
    SUM(purchased_amount) as Revenue_by_size
FROM 
    customer_details
WHERE category = 'Footwear' --AND gender = 'Male' 
GROUP BY
    SIZE
ORDER BY
    Revenue_by_size DESC;

---Outerwear category
SELECT  
    Size,
    COUNT(*) as size_count,
    SUM(purchased_amount) as Revenue_by_size
FROM 
    customer_details
WHERE category = 'Outerwear' 
GROUP BY
    SIZE
ORDER BY
    Revenue_by_size DESC;

---5. which 10 color performs highest

SELECT 
    color,
    COUNT(*) AS color_count,
    SUM(purchased_amount) as revenue_by_color
FROM 
    customer_details
GROUP BY
    Color 
ORDER BY 
    revenue_by_color DESC
   --- color_count DESC
LIMIT 10


