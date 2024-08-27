-- Create a database to store the sales data
CREATE DATABASE "Sales Data "
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
-- Create a table named "sales_sample"
CREATE TABLE Sales_sample (Product_Id INT, 
Region VARCHAR(50), On_date DATE, Sales_Amount NUMERIC);

-- Insert 10 sample records into the "sales_sample"
INSERT INTO Sales_sample (Product_Id, Region, On_date, Sales_Amount) VALUES 
('1', 'East', '2023-10-10', '45000'),
('2', 'West', '2023-09-19', '75000'),
('2', 'East', '2023-10-21', '65000'),
('3', 'North', '2023-09-20', '40000'),
('4', 'North', '2023-08-06', '70000'),
('2', 'South', '2023-08-25', '76000'),
('5', 'North', '2023-11-23', '48000'),
('5', 'West', '2023-11-11', '58000'),
('3', 'East', '2023-09-19', '72000'),
('1', 'West', '2023-09-29', '63000');

Select Select * from Sales_Sample;

-- Drill down - query to perform drill down from region to product level to understand sales performance
SELECT Region, Product_Id, Sum(Sales_Amount) AS Sales_Amount
FROM Sales_Sample
GROUP BY 1,2
ORDER BY Region, Product_Id, Sales_Amount;

-- Rollup -  query to perform roll up from product to region level to view total sales by region
SELECT Region, Product_Id, Sum(Sales_Amount) AS Sales_Amount
FROM Sales_Sample
GROUP BY ROLLUP (1,2)
ORDER BY Region;

-- Cube - query to explore sales data from different perspectives, such as product, region, and date
SELECT Region, Product_Id, On_Date, SUM(Sales_Amount) AS Sales_Amount
FROM Sales_Sample
GROUP BY Cube (1,2,3)
ORDER BY Region, Product_Id, On_Date, Sales_Amount;

-- Slice -  query to slice the data to view sales for a particular region or date range
SELECT Region, Product_Id, On_Date, SUM(Sales_Amount) AS Sales_Amount
FROM Sales_Sample
WHERE Region in('North', 'South') OR On_Date BETWEEN To_date('2023-08-20','YYYY-MM-DD') AND To_Date('2023-10-20','YYYY-MM-DD') 
GROUP BY 1,2,3
ORDER BY Region, Product_Id, On_Date, Sales_Amount;

-- Dice - query to view sales for specific combinations of product, region, and date
SELECT Region, Product_Id, On_Date, SUM(Sales_Amount) AS Sales_Amount
FROM Sales_Sample
WHERE Region in ('North', 'South') AND Product_Id IN (1,2) AND On_Date 
BETWEEN To_date('2023-08-20','YYYY-MM-DD') And To_Date('2023-10-20','YYYY-MM-DD') 
GROUP BY 1,2,3
ORDER BY Region, Product_Id, On_Date, Sales_Amount;