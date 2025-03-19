#Changes overtime based on order date
SELECT 
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM `gold.fact_sales` AS gsal
WHERE order_date IS NOT NULL AND order_date != ''
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

#Change over time based on due_date
SELECT 
YEAR(due_date) AS due_year,
MONTH(due_date) AS due_month,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quatinty
FROM `gold.fact_sales`
GROUP BY YEAR(due_date), MONTH(due_date) 
ORDER BY YEAR(due_date), MONTH(due_date);

#Change over time based on shipping date
SELECT
YEAR(shipping_date) AS shipping_year,
MONTH(shipping_date) AS shipping_month,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM `gold.fact_sales`
GROUP BY YEAR(shipping_date), MONTH(shipping_date)
ORDER BY YEAR(shipping_date), MONTH(shipping_date)
;








SELECT *
FROM `gold.fact_sales` AS gsal;