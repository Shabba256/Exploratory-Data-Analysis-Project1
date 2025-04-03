-- Which 5 products generate the highest revenue

SELECT
product_name, 
SUM(sales_amount) total_revenue
FROM  `gold.fact_sales` f
LEFT JOIN `gold.dim_products` p
	ON f.product_key = p.product_key
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 5
;

#Using window functions

SELECT *
FROM (
	SELECT
	product_name, 
	SUM(sales_amount) total_revenue,
	ROW_NUMBER() OVER( ORDER BY SUM(sales_amount) DESC) row_num
	FROM  `gold.fact_sales` f
	LEFT JOIN `gold.dim_products` p
		ON f.product_key = p.product_key
	GROUP BY product_name
) t
WHERE row_num <= 5
;


-- What are the 5 worst-performing products in terms of sale

SELECT 
product_name,
SUM(sales_amount) total_sales
FROM `gold.fact_sales` f 
LEFT JOIN `gold.dim_products` p 
	ON f.product_key = p.product_key
GROUP BY product_name
ORDER BY total_sales
LIMIT 5
;

#Using window functions

SELECT *
FROM(
	SELECT 
	product_name,
	SUM(sales_amount) total_sales,
	RANK() OVER( ORDER BY SUM(sales_amount)) rank_num
	FROM `gold.fact_sales` f 
	LEFT JOIN `gold.dim_products` p 
		ON f.product_key = p.product_key
	GROUP BY product_name
) t
WHERE rank_num <= 5
;

-- Find the top 10 customers who have generated the highest revenue

SELECT 
c.customer_key,
first_name,
last_name,
SUM(sales_amount) total_revenue
FROM `gold.fact_sales` f
LEFT JOIN `gold.dim_customers` c
	ON f.customer_key = c.customer_key
GROUP BY 
c.customer_key,
first_name,
last_name
ORDER BY total_revenue DESC
LIMIT 10
;

#Using window functions

SELECT *
FROM (
	SELECT 
	c.customer_key,
	first_name,
	last_name,
	SUM(sales_amount) total_revenue,
	DENSE_RANK() OVER( ORDER BY SUM(sales_amount) DESC) dense_rank_num
	FROM `gold.fact_sales` f
	LEFT JOIN `gold.dim_customers` c
		ON f.customer_key = c.customer_key
	GROUP BY 
	c.customer_key,
	first_name,
	last_name
) t
WHERE dense_rank_num <= 10
;

-- Find the 3 customers with the fewest orders placed

SELECT 
c.customer_key,
first_name,
last_name,
COUNT(DISTINCT order_number) total_orders
FROM `gold.fact_sales` f   
LEFT JOIN `gold.dim_customers` c 
	ON f.customer_key = c.customer_key
GROUP BY
c.customer_key,
first_name,
last_name
ORDER BY total_orders 
LIMIT 3
;

#Using window functions

SELECT *
FROM (
	SELECT 
	c.customer_key,
	first_name,
	last_name,
	COUNT(DISTINCT order_number) total_orders,
	ROW_NUMBER() OVER( ORDER BY COUNT(DISTINCT order_number)) row_num
	FROM `gold.fact_sales` f   
	LEFT JOIN `gold.dim_customers` c 
		ON f.customer_key = c.customer_key
	GROUP BY
	c.customer_key,
	first_name,
	last_name
) t
WHERE row_num <= 3
;













































































