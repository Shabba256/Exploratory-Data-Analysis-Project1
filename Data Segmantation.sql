/*
- Group data based on a specific range
-Helps understand the correlation between two measures
*/


WITH prod_segment AS (
	SELECT 
	product_key,
	product_name,
	cost,
	CASE WHEN cost < 100 THEN 'Below 100'
		 WHEN cost BETWEEN 100 AND 500 THEN '100 - 500'
		 WHEN cost BETWEEN 500 AND 1000 THEN '500 - 1000'
		 ELSE 'Above 1000'
	END AS cost_range
	FROM `gold.dim_products`
)
SELECT 
cost_range,
COUNT(product_key) AS total_product
FROM prod_segment
GROUP BY cost_range
ORDER BY total_product DESC
;




-- Example 2



WITH cust_spending AS (
	SELECT 
	gcust.customer_key,
	SUM(sales_amount) AS total_spending,
	MIN(order_date) AS first_date,
	MAX(order_date) AS last_date,
	TIMESTAMPDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan 
	FROM `gold.fact_sales` AS gsal
	LEFT JOIN `gold.dim_customers` AS gcust
		ON gsal.customer_key = gcust.customer_key
	GROUP BY gcust.customer_key
)

SELECT 
cust_segment,
COUNT(customer_key) AS total_customers
FROM (
	SELECT 
	customer_key,
	total_spending,
	lifespan,
	CASE WHEN lifespan > 12 AND total_spending > 5000 THEN 'VIP'
		 WHEN lifespan > 12 AND total_spending < 5000 THEN 'Regular'
		 ELSE 'NEW'
	END AS cust_segment
	FROM cust_spending) t
GROUP BY cust_segment
ORDER BY total_customers DESC
;






















































































