# CONTENT

* Introduction
* Background
* Customer segmentation
* Purchase patterns
* Review rating & satisfaction
* Subscription & Shipping preference
* Discount & Promo code usage
* Geographical insight & Cross_selling opportunities
* Customer loyalty
* Frequency of purchase & payment method
* Summary
* Conclusion

## INTRODUCTION

The e-commerce sales🛒💳 project is a business insight💡project that aims to investigate the demographic characteristics and behaviour of our customers, the purchase patterns for our products and possible strategies neccesary for the business based on the reviews, frequency of purchases and promotional offers provided by the business📊.

🔍SQL queries? Check them out here: [project_sql folder](/project_sql/)

## BACKGROUND

Driven by the need to improve the operational performance of the business, the project aim to provide insight on the current situation/operation level for the purpose of strategizing and formulating improved decisions for the business. The project is investigating customer segmentation, purchase patterns, geographical operation, and customers behaviour in general.

Data description: The data used has 18 columns with 3900 rows. These columns are: customer_id column, Age, item purchased, gender, product category, purchase amount, location, size, color, season, review rating, subscription, shipping type, promo code, discount usage, payment method, previous purchases and frequency of purchases. [e-commerce_data](/CSV_file/customer_details.csv)

## Tools I used

In this project, I harnessed the power of these tools:

**SQL**: The backbone of my analysis allowing me to query the database and provide actionable insights.

**Postgresql**: The ideal database management system for handling my data.

**Visual Studio Code**: My preferred database management and excuting SQL queries.

**Microsoft excel**: Preferred tool for cleaning and viewing my data.

**Git and GitHub**: Essential platform for storing, managing and share repositories of my work to the public, and allows issue tracking, code review, pull request and project management.

**Tableau**: Useful data visualization tool for the project.

## ANALYSIS

This section displays queries that addresses several business insight aspects of my project. Here's my approach.

### 1. Customer segmentation

The ideal question was on how we can group customers based on their demographic (age group, gender and location) to understand our customer segements. Secondly, determining whether there are distinct customers segments with varying purchasing behaviour.
The first step was writing a query to depict distinct age group, gender, location and average purchases:
Here's the query:

```sql
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
```

Then we now determine the number of customer by age group and their average purchased amount.

***a. Customer segement by age group***

Here's the query

```sql
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
```

Here's the result
| age_group | total_customers | total_average_purchased_amount |
| --------- | --------------- | ------------------------------ |
| 18-24     | 486             | 6022                           |
| 25-34     | 755             | 6037                           |
| 35-44     | 729             | 5896                           |
| 45-54     | 752             | 6021                           |
| 55-64     | 751             | 5942                           |
| 65+       | 427             | 5900                           |

💡Insight

The **25-34 age group** has the highest number of customers (755) and slightly higher average purchased amount($6037).

The **18-24 age group** has a relatively high average purchased amount  but still contributes significantly to the customer base.

The **45-54 age group** also shows strong engagement with a high average purchased amount.

The **65+ age group** has the lowest number of customers but a respectable average purchased amount.

These patterns are useful for tailoring marketing strategies, product offerings, and customer engagement efforts for each age group 📊.

***b. customers segment by location***

Here's the query

```sql
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
```

The top 5 states with the highest number of customers are Montana (96 customers and $744 average purchased amount), California (95, $699), Idaho (93, $745), Illinois (92, $751), Alabama (89, $708).
For more figures here is the visualized map area with the details.

Here's the map ![Customer by location](Assets\customerbylocation.png)
*Location map showing the number of customers and average purchased amount per state, generated by Tableau*.

***c. Customer segement by gender***

To count the distinct number of male and female customers👫, here is the query.

```SQL
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
```

Here's the result.

| gender | customer_count_by_gender | average_purchased_per_gender |
| ------ | ------------------------ | ---------------------------- |
| Female | 1248                     | 17853                        |
| Male   | 2652                     | 17965                        |

There are **1,248 female** customers and **2,652 male** customers.
The average purchase amount for female customers is approximately **$17,853**.
The average purchase amount for male customers is approximately **$17,965**.

💡**Insight**

The number of male customers is higher than female customers.
However, the average purchase amount is nearly identical for both genders.
This suggests that while there are more male customers, their spending behavior is similar to that of female customers.
The marketing team should tailor marketing strategies based on this insights to maximize revenue from both male and female customers💰.

## 2. Purchase patterns

This sections displays the purchasing patterns of our customers by determining the most purchased items, season with the highest sales and colors or the sizes most purchased.

Questions?: What are the most popular items purchased? Which season sees the highest sales?
 Do certain colors or sizes perform better than the others?

***a. Most popular item purchased***

Here's the query

```sql

SELECT
    item_purchased,
    count(*) as purchase_count
    
FROM 
    customer_details
Group BY
    item_purchased
ORDER BY 
    purchase_count DESC;
```

Here's the results breakdown.
| item_purchased | purchase_count |
| -------------- | -------------- |
| Jewelry        | 171            |
| Pants          | 171            |
| Blouse         | 171            |
| Shirt          | 169            |
| Dress          | 166            |
| Sweater        | 164            |
| Jacket         | 163            |
| Sunglasses     | 161            |
| Belt           | 161            |
| Coat           | 161            |
| Sandals        | 160            |
| Socks          | 159            |
| Skirt          | 158            |
| Shorts         | 157            |
| Scarf          | 157            |
| Hat            | 154            |
| Handbag        | 153            |
| Hoodie         | 151            |
| Shoes          | 150            |
| T-shirt        | 147            |
| Sneakers       | 145            |
| Boots          | 144            |
| Backpack       | 143            |
| Gloves         | 140            |
| Jeans          | 124            |

 It’s evident that **jewelry**, **pants**, and **blouses** are popular choices, while **jeans** seem to have a lower purchase count. This helps the business owners to understand customer preferences and guide inventory management decisions. Therefore, the business owner can consider tailoring marketing strategies and stock level🛍️💼👗.

***b. Category most bought***

The sql query

```sql
SELECT
    category,
    COUNT(*) as category_count,
    SUM(purchased_amount) as category_sales_revenue
FROM customer_details
GROUP BY 
    category
ORDER BY
    category_count DESC;
```

Here is the result of the most bought category and its sales revenue.

![Category chart](Assets\categorycount.png)

*Bar garph showing the number of most bought category of mechandise and the sum of sale revenue received from each category. Bargraph generated by **Power BI***

***Insight***

**Clothing** category has the highest number of items  bought (1737). However, in terms of revenue, it generates a moderate amount compared to the other categories ($104264).

The **Accessories** category has a lower item count than Clothing. Its revenue is also moderate, falling between Clothing and Footwear.

**Footwear** has a relatively lower item count compared to Clothing and Accessories.
However, it contributes significantly to the total revenue.

**Outerwear** has the lowest item count among the four categories.
Despite this, it generates a substantial revenue.

While Clothing dominates in terms of the number of items, Footwear and Outerwear stand out in revenue generation. The disparity between category count and sales revenue, emphasizing the importance of understanding both aspects for effective business decisions📊.

***c. Season with highest revenue sales***

Here's the query

```sql
SELECT
    season,
    COUNT(*) as season_count,
    Sum(purchased_amount) as Season_revenue
FROM 
    customer_details
GROUP BY
    season
ORDER BY
    Season_reveue DESC;
```

Here's the breakdown of the result for the season with the highest revenue sale.

| season | season_count | season_revenue |
| ------ | ------------ | -------------- |
| Fall   | 975          | 60018          |
| Spring | 999          | 58679          |
| Winter | 971          | 58607          |
| Summer | 955          | 55777          |

The interesting pattern here is that;

**Spring** has the highest item count (999), but its revenue is slightly lower than **Fall**.

**Fall** generates the highest revenue ($60,018) despite having a lower item count.

**Summer** has the lowest revenue, even though its item count is not significantly different from **Winter**.

***d. Size that perform better in each category***📏💵

Here's the query

```sql
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
```

Results breakdown:

**Medium size** items have the highest revenue, despite having a relatively higher item count.

**Small size** items generate moderate revenue, considering their lower count.

**Extra Large** items contribute the least revenue, even though their count is lower📏💵.

It's noted that when filtering the query with condition **WHERE** either category or gender, the order of performance remains the same.

![Size with highest revenue](Assets\SaleRevenuePersale.png)
*Bar chart showing the sale revenue generated by each size category. The chart is generated by Tableau public*

***e. Which 10 color performs highest***🎨💰

```sql
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
LIMIT 10;
```

Here's the results breakdown.

| color  | color_count | revenue_by_color |
| ------ | ----------- | ---------------- |
| Green  | 169         | 11104            |
| Teal   | 172         | 10459            |
| Yellow | 174         | 10308            |
| Olive  | 177         | 10292            |
| Cyan   | 166         | 10274            |
| Violet | 166         | 10245            |
| Gray   | 159         | 9936             |
| Silver | 173         | 9832             |
| Black  | 167         | 9753             |
| Maroon | 158         | 9405             |

Green items have a higher revenue despite a moderate count, while Black & silver items generate less revenue despite a similar and higher count🎨💰.

### 3. Review Rating and Satisfaction

This section investigates whether there is a correlation between customer review rating and purchased amount, and how satisfied are customers overall.

Here's the query.

```sql
SELECT
   AVG(review_rating) AS avg_review_rating,
   AVG(purchased_amount) as avg_purchase_amount, 
   CORR(review_rating, purchased_amount) as correalation
FROM customer_details 
--WHERE color = 'Green' and size = 'M';
```

Here's the breakdown of the result.

| avg_review_rating | avg_purchase_amount | correalation |
| ----------------- | ------------------- | ------------ |
| 3.75              | 59.76               | 0.030775923  |

The **average review rating** is **3.75.**
This value represents the overall rating given by customers (customer satisfaction), likely on a scale from 1 to 5.

The **average purchase amount** is **$59.76**.
This indicates the typical amount spent by customers per transaction.

The **correlation coefficient** between review ratings and purchase amounts is **0.0308**.
A correlation close to zero suggests a very weak positive relationship between these two variables.

In practical terms, this means that while higher review ratings are slightly associated with higher purchase amounts, the correlation is not strong enough to make meaningful predictions.

### 4. Subscription & shipping preference

Subscription and shipping preference section investigates the number of customers with the subscription and the shipping method our customers prefers.

🔍Queries

***a. Number of subscribers***

```sql
SELECT
    subscription_status,
    COUNT(*) AS subscribed_customers
FROM customer_details
GROUP BY  
    subscription_status
ORDER BY 
    subscribed_customers;
```

| subscription_status | subscribed_customers |
| ------------------- | -------------------- |
| YES                 | 1053                 |
| NO                  | 2847                 |

There are 1053 customers who engage with subscription services🔑. The rest of customers (2847) has no engagement with the subscription activities. The key pattern noted in this is that the subscribed customers are only male gender, which is important for business to understand when tailoring her marketing strategies.

Here's the query

```sql
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
```

| gender subscribed_customers |
| --------------------------- |
| Male 1053                   |
|                             |

***b. The preferred shipping type***

Here's the query.

```sql
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
```

There's the btreakdown of the result.

**Free Shipping**:
The most popular shipping option is Free Shipping, with **675** customers opting for it. Offering free shipping can attract more customers and encourage higher order values.

**Standard Shipping**:
Standard Shipping is also widely used, with **654** customers selecting this option.
It provides a reliable and cost-effective delivery method.

**Store Pickup**:
Store Pickup is chosen by **650** customers. This option allows customers to collect their orders directly from a nearby store, enhancing convenience.

**Next Day Air**:
Next Day Air is preferred by **648** customers. It caters to urgent delivery needs, ensuring prompt service.

**Express Shipping**:
Express Shipping has **646** takers.
Customers value faster delivery times with this option.

**2-Day Shipping**:
2-Day Shipping is selected by **627** customers.
It strikes a balance between speed and affordability.

![Preferred Shipping](Assets\Shippingtype.png)

*Pie chart displaying the number of customer count by shipping type both in numbers and percentage of the total customers.* *The pie chart is generated from the Power BI*

## 5. Discount and Promo Code usage

To investigate how often customers use discount or promo code, and whether promo code has impact on purchase behaviour, the project provide answers to the following questions.

**- How often do customers use discount or promo codes?**

**- Do promo codes impact purchase behaviour?**

Here's the query

***a. How often do customers use discount and promo code***

```sql
SELECT
    COUNT(DISTINCT customer_id) as total_customers,
    COUNT(DISTINCT CASE WHEN discount_applied = TRUE THEN customer_id END) as customers_with_discount,
    ROUND(CAST(COUNT(DISTINCT CASE WHEN discount_applied = TRUE THEN customer_id END) AS DECIMAL)/ COUNT(DISTINCT customer_id), 2) as discount_usage_ratio
FROM 
    customer_details;
```

Here's the result breakdown

| total_customers | customers_with_discount | discount_usage_ratio |
| --------------- | ----------------------- | -------------------- |
| 3900            | 1677                    | 0.43                 |

**Total Customers**: There are 3900 customers in total.

**Customers with Discount**: Out of the total, 1677 customers utilize discounts.

**Discount Usage Ratio**: The discount usage ratio is approximately 43%.

This means that 43% of the customers applied the discount during purchases.
The availability of discounts often encourages customers to make purchases. By offering discounts, the business may attract more buyers and increase the overall sales volume. The 1677 customers who utilized discounts likely contributed to this boost in sales.

Customer Retention: Discounts can also foster customer loyalty. When customers perceive value through discounts, they are more likely to return for future purchases.

***b. Do promo code impact purchase behaviour***

```sql
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
```

Here's the breakdown of the result.

| total_amount_with_promo_code | total_amount_without_promo_code | promo_code_ratio |
| ---------------------------- | ------------------------------- | ---------------- |
| 99411                        | 233081                          | 0.426508381      |
|                              |                                 |                  |

Total Amount with Promo Code: The total amount of transactions involving a promo code is $99,411.
Total Amount without Promo Code: Transactions without any promo code amount to $233,081.
Promo Code Ratio: The promo code usage ratio is approximately 42.65%.

Promo codes likely incentivize customers to complete their purchases. The $99,411 attributed to promo code transactions represents additional revenue that might not have occurred without these discounts.

## 6. Geographical Insight & Cross selling opportunities

To provide geographical insight we investigated which region has the highest sales revenue and regional preferences for specific product in order to strategize the marketing trajectories.

Here is the query.

***a. Location with the highest sales***

```sql
SELECT
    Location,
    SUM(Purchased_amount) AS Total_Sales
FROM
    customer_details
GROUP BY
    Location
ORDER BY
    Total_Sales DESC;
```

Here's the breakdown of the result

![Location with the highest sales](Assets\Regionalsalesrevenue.png)

***Map plot showing the 11 regions with the highest revenue***

***Insight***

**Highest Sales**: Montana leads with $5,784 in total sales.

**Consistent Performers**: Illinois, California, and Idaho follow closely indicating consistent sales performance.

**Variation**: There’s a range of sales figures across different states.

NB: From the query you can get the sales revenue of all the regions and compare the variation or any consistency.

***b. Regional preferences***

Based on the above results of the location with the higher sales revenue we also conducted further analysis about customer behaviour pattern by investigating whether certain regions exhibit preferences for specific products. For instance, do customers in **Montana** tend to buy different items compared to those in **Illinois** or **California**?

Here's the query

```sql
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
```

Here's the results breakdown.

Generally, clothing category is the most purchased item in every region.

👀Check out the result, clothing bars have largest width compared to other Accessories, Footwear, and Outwear.

![Regional Category Preference](Assets\RegPreference.png)
*Power BI generated bar chart showing the regional product preference*

Let's take a look at these three regions, **Montana**, **Illinois**, and **California**, and compare.

![Regional Preference Comparison](Assets\RegionalPreferenceComparison.png)

Clothing is the highest selling category across all three states, but there are slight variations in the number of products sold within this category.

California: 47 products sold.

Illinois: 46 products sold.

Montana: 45 products sold.

Accessories follow as the second most popular category, but there are more pronounced differences between locations. Illinois has the lowest sales in this category.

California: 31 products sold.

Illinois: 27 products sold.

Montana: 28 products sold.

Footwear sales are consistent between California and Illinois, but slightly higher in Montana.

California: 11 products sold.

Illinois: 11 products sold

 Montana: 12 products sold.

Outerwear sees an increasing trend from west to east, with sales numbers rising from California to Montana.

California: 6 products sold.

Illinois: 8 products sold.

Montana: 11 products sold.

***c. Cross selling***

How can we encourage our customers to explore other categories and recommend related products based on purchases

Let's check different products in each category

```sql

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
```

Here's the results

| category    | item_purchased | purchase_count |
| ----------- | -------------- | -------------- |
| Accessories | Jewelry        | 171            |
| Accessories | Sunglasses     | 161            |
| Accessories | Belt           | 161            |
| Accessories | Scarf          | 157            |
| Accessories | Hat            | 154            |
| Accessories | Handbag        | 153            |
| Accessories | Backpack       | 143            |
| Accessories | Gloves         | 140            |
| Clothing    | Blouse         | 171            |
| Clothing    | Pants          | 171            |
| Clothing    | Shirt          | 169            |
| Clothing    | Dress          | 166            |
| Clothing    | Sweater        | 164            |
| Clothing    | Socks          | 159            |
| Clothing    | Skirt          | 158            |
| Clothing    | Shorts         | 157            |
| Clothing    | Hoodie         | 151            |
| Clothing    | T-shirt        | 147            |
| Clothing    | Jeans          | 124            |
| Footwear    | Sandals        | 160            |
| Footwear    | Shoes          | 150            |
| Footwear    | Sneakers       | 145            |
| Footwear    | Boots          | 144            |
| Outerwear   | Jacket         | 163            |
| Outerwear   | Coat           | 161            |

## 7. Customer loyalty

This section investigate the average purchase amount and average review rating for both New customers and existing loyal customers to provide business insight for our operation.

Here's the query

```sql
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
```

Breakdown of the results

| customer_segment | average_purchased_amount | average_review_rating |
| ---------------- | ------------------------ | --------------------- |
| New customer     | 58.46987952              | 3.843373494           |
| Loyal customers  | 59.7925072               | 3.747917212           |

1. **New Customers**:

**Average Purchased Amount**: Approximately **$58.47**.

**Average Review Rating**: Around **3.84** out of 5.

**Insight**:

 **New customers** tend to spend moderately, which is a positive sign.
 Their review ratings are relatively high, indicating initial satisfaction.
 To retain these customers, consider personalized onboarding experiences and targeted promotions

2 . **Loyal Customers**:

**Average Purchased Amount**: Approximately **$59.79**.

**Average Review Rating**: About **3.75** out of 5.

**Insight**:

 Loyal customers spend slightly more than new ones, which is encouraging. However, their review ratings are slightly lower. To enhance loyalty, focus on maintaining consistent service quality and rewarding their loyalty.

## 8. Frequency of purchase and Payment method

Being the last step of the analysi, the project investigated how often customers purchase product. Is it weekly, quarterly, Bi-weekly, monthly or annually. The method of payment was also essential in our analysis so to determine which area to adjust when it comes to payment.

Here's the query

***a. Frequency of purchases***

```sql
SELECT
    frequency_of_purchases,
    COUNT(*)as Frequency_of_purchase_count
FROM customer_details
GROUP BY
    frequency_of_purchases
ORDER BY
    Frequency_of_purchase_count DESC;
```

Here's the result breakdown

![Frequency of purchases](Assets\FreqPurchases.png)

**Every 3 Months**:
There are 584 instances where customers make purchases approximately every 3 months.
These customers exhibit a moderate frequency of buying.

**Annually**:
There are 572 instances where customers make purchases once a year.
These customers are likely to be infrequent buyers, possibly making annual or seasonal purchases.

**Quarterly**:
There are 563 instances where customers make purchases every quarter (approximately every 3 months).
Similar to the “Every 3 Months” group, these customers maintain a consistent buying pattern.

**Monthly**:
There are 553 instances where customers make purchases every month.
Monthly buyers are more frequent and engaged with the brand.

**Bi-Weekly**:
There are 547 instances where customers make purchases every two weeks (bi-weekly).
These customers are regular buyers, often making purchases twice a month.

**Fortnightly**:
There are 542 instances where customers make purchases every two weeks (fortnightly).
Similar to the “Bi-Weekly” group, these customers have a consistent buying rhythm.

**Weekly**:
There are 539 instances where customers make purchases every week.
Weekly buyers are highly engaged and likely to be loyal customers.

***b. Payment methods***

Here's the query

```sql
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
```

Results breakdown

| payment_method | payment_method_count |
| -------------- | -------------------- |
| PayPal         | 677                  |
| Credit Card    | 671                  |
| Cash           | 670                  |
| Debit Card     | 636                  |
| Venmo          | 634                  |
| Bank Transfer  | 612                  |

**PayPal** is the most frequently used payment method, with **677** instances.
Customers who prefer PayPal may appreciate its convenience, security, and widespread acceptance.

**Credit cards** are also popular, with **671** instances. Credit cards offer flexibility, rewards, and deferred payments. Customers value these benefits.

**Cash** payments occur 670 times. Some customers prefer cash for in-person transactions or privacy reasons.

**Debit cards** are used 636 times. Debit cards provide convenience and direct access to funds. Customers appreciate real-time transactions.

**Venmo**, a digital wallet, appears 634 times. Younger, tech-savvy customers often use Venmo for peer-to-peer payments and social interactions.

**Bank transfers** are chosen 612 times. Some customers prefer direct bank transfers for large transactions or recurring payments.

## Summary

The age group with large number of customers is 25-34 with Montana leading the region with largest number of customers and also revenue generation. Green color is the most prefered color and clothing category is the most purchased among all categories.
Discounts and promo code promotes purchases, and new coustomers has a high satisfaction for our product though there is still adjustments that need to be made.

## Conclusion

This project delves into answering most of operation questions that are so essential for marketing strategies and future business trajectories. Therefore, it would be very important to analyze both details provided in this project and make the best decision for the business.
