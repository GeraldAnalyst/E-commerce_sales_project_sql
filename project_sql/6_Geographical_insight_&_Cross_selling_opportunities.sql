/*
Geographical insight
Questions: Which location has the highest sales in termes of revenue?
           Are there regional preferences for specific product? 
*/

--1. location with the highest sales
    SELECT
    Location,
    SUM(Purchased_amount) AS Total_Sales
FROM
    customer_details
GROUP BY
    Location
ORDER BY
    Total_Sales DESC;

--2. Regional prefernces for specific products
SELECT
    Location,
    Category,
    COUNT(*) AS Total_Products_Sold
FROM
    customer_details
GROUP BY
    Location,
    Category
ORDER BY
    Location,
    Total_Products_Sold DESC;

/*
Cross selling opportunities 
 How we can encourage our customers to explore other categories and 
 recommend related products based on previous purchases
 */

SELECT
    Category,
    Item_Purchased,
    COUNT(*) AS Purchase_Count
FROM
    customer_details
GROUP BY
    Category,
    Item_Purchased
ORDER BY
    Category,
    Purchase_Count DESC;



   