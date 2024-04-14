/*
Since I have already created a database for my project, I dive in directly to creating table for my data.
Just a brief details about my data. It's a e-commerce dataset with customer details. It has 18 columns with 
3900 rows describing customer details. 
*/

CREATE TABLE public.customer_details
(
    Customer_ID INT PRIMARY KEY,
    Age INT,
    Gender VARCHAR(50),
    Item_Purchased TEXT,
    Category TEXT,
    Purchased_Amount NUMERIC,
    Location TEXT,
    Size VARCHAR(50),
    Color VARCHAR(50),
    Season VARCHAR(50),
    Review_Rating DECIMAL(3, 2),
    Subscription_Status BOOLEAN,
    Shipping_Type TEXT,
    Discount_Applied BOOLEAN,
    Promo_code_used BOOLEAN,
    Previous_Purchases NUMERIC,
    Payment_Method TEXT,
    Frequency_of_Purchases TEXT
);



---Set ownership of the table to the postgres user
ALTER TABLE public.customer_details OWNER to postgres;


/* I encountered error when inserting values to my created table due to a missing extra column from my table that is presence 
in the csv file: column name Gender. Therefor I have to adjust the table
*/

ALTER TABLE customer_details
ADD Gender VARCHAR(50);

/*unfortunately I still had errors when inserting values because the column numbers were 
not the same. So i had to drop the table from my database and create a new one with correct 
column number and names.
*/

DROP TABLE customer_details;