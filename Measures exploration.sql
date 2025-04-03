#Here I cover all the key metrics for the business, individually and then generated a report in the last query

-- Find the Total Sales

SELECT SUM(sales_amount) Total_sales
FROM `gold.fact_sales`;

-- Find how many items were sold

SELECT SUM(quantity) Total_quantity
FROM `gold.fact_sales`
;

-- Find the total number of orders

SELECT COUNT(DISTINCT order_number) Total_orders
FROM `gold.fact_sales`
;

-- Find the total number of products
 
 SELECT COUNT( DISTINCT product_key) Total_products
 FROM `gold.dim_products`
 ;
 
-- Find the total number of customers

SELECT COUNT(DISTINCT customer_key) AS Total_customers
FROM `gold.dim_customers`
;

-- Find the total number of customers that has placed an order

SELECT COUNT(DISTINCT customer_key) Active_customers
FROM `gold.fact_sales`
;


-- Generate a report that shows all key metrics of the business

SELECT 'Total_sales' AS measure_name, SUM(sales_amount) AS measure_value
FROM `gold.fact_sales`
UNION ALL
SELECT 'Total_quantity' AS measure_name, SUM(quantity) AS measure_value 
FROM `gold.fact_sales`
UNION ALL
SELECT 'Total_orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value 
FROM `gold.fact_sales`
UNION ALL
SELECT 'Total_products' AS measure_name, COUNT( DISTINCT product_key) AS measure_value 
FROM `gold.dim_products`
UNION ALL 
SELECT 'Total_customers' AS measure_name, COUNT(DISTINCT customer_key) AS measure_value
FROM `gold.dim_customers`
UNION ALL
SELECT 'Active_customers' AS measure_name, COUNT(DISTINCT customer_key) AS measure_value 
FROM `gold.fact_sales`
;








































































