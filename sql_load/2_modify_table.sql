/*
There are two steps you can follow when inseting values into our tables from CSV file.
1. The first step is runing direct path of data using the following query
*/

Copy customer_details
FROM 'C:\Users\Gerald\OneDrive\Desktop\E-commerce_sales_project_sql\CSV_file\customer_details.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

/* 
Encountering error, could not open file "C:\Users\Gerald\OneDrive\Desktop\E-commerce_sales_project_sql\CSV_file\customer_details.csv" for reading: Permission denied 
takes us to the second step which is using the PgAdmin. These are steps to follow:
1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `sql_course` database
3. Right-click `sql_course` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
    1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy customer_details FROM 'C:\Users\Gerald\OneDrive\Desktop\E-commerce_sales_project_sql\CSV_file\customer_details.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
*/

---NOTE: ensure you copy the correct path




SELECT*
FROM customer_details;