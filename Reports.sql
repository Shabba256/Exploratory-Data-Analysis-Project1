#Here  I will create reports and views


CREATE VIEW `gold.report_customers` AS
WITH base_query AS (
	SELECT 
	f.order_number,
	f.product_key,
	f.order_date,
	f.sales_amount,
	f.quantity,
	c.customer_key,
	c.customer_number,
	CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
	TIMESTAMPDIFF(YEAR, c.birthdate, CURDATE()) AS age
	FROM `gold.fact_sales` f
	LEFT JOIN `gold.dim_customers` c
		ON f.customer_key = c.customer_key
	WHERE birthdate != '' AND birthdate IS NOT NULL AND order_date != '' AND order_date IS NOT NULL
),
customer_aggregation AS (
SELECT 
customer_key,
customer_number,
customer_name,
age,
COUNT(DISTINCT order_number) AS total_orders,
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_quantity,
COUNT(DISTINCT product_key) AS total_products,
MAX(order_date) AS last_order_date,
TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan 
FROM base_query
GROUP BY customer_key,
		 customer_number,
		 customer_name,
		 age
)
SELECT
customer_key,
customer_number,
customer_name,
age,
CASE 
	 WHEN age < 20 THEN 'Under 20'
     WHEN age BETWEEN 20 AND 29 THEN '20-29'
     WHEN age BETWEEN 30 AND 39 THEN '30-39'
     WHEN age BETWEEN 40 AND 49 THEN '40-49'
     ELSE '50 and Above'
END AS age_group,
CASE 
	 WHEN lifespan > 12 AND total_sales > 5000 THEN 'VIP'
	 WHEN lifespan > 12 AND total_sales < 5000 THEN 'Regular'
	 ELSE 'NEW'
END AS cust_segment,
last_order_date,
TIMESTAMPDIFF(MONTH, last_order_date, CURDATE()) AS recency,
total_orders,
total_sales,
total_quantity,
total_products,
lifespan,
ROUND(CASE 
	 WHEN total_orders = 0  THEN 0
     ELSE total_sales / total_orders
END, 2)  AS avg_order_value,
ROUND(CASE
	 WHEN lifespan = 0 THEN total_sales
     ELSE total_sales / lifespan
END, 2) AS avg_monthly_spending
FROM customer_aggregation
;