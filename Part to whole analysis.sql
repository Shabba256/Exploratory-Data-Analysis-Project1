/*
- Analyze how an individual part is performing compared to the overall
-allowing us to understand which category has the greatest impact on business
*/


WITH cate_table AS(
	SELECT 
	category,
	SUM(sales_amount) AS total_sales
	FROM `gold.fact_sales` AS gsal
	LEFT JOIN `gold.dim_products` AS gprod
		ON gsal.product_key = gprod.product_key
	GROUP BY category
)

SELECT 
category,
total_sales,
SUM(total_sales) OVER () AS overall_sales, 
CONCAT(ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2), '%') AS percentage_sales
FROM cate_table
ORDER BY total_sales DESC
;

# Bikes generate the most sales with a percentage of 96.46%


-- Example 2  More analysis based on the results from Example 1


WITH bike_table AS (
	SELECT 
	product_name,
	SUM(sales_amount) AS total_bike_sales 
	FROM `gold.fact_sales` AS gsal
	LEFT JOIN `gold.dim_products` AS gprod
		ON gsal.product_key = gprod.product_key
	WHERE category = 'Bikes'
	GROUP BY product_name
)

SELECT 
product_name,
total_bike_sales,
SUM(total_bike_sales) OVER () AS overall_bike_sales,
CONCAT(ROUND((total_bike_sales / SUM(total_bike_sales) OVER ()) * 100, 2), ' %') AS percentage_bike_sales
FROM bike_table
ORDER BY total_bike_sales DESC
;

# The least sold bikes are; Mountain-500 Silver-44 and Mountain-500 Black - 52 both at 0.08 %
# The most sold bike is a Mountain-200 Black-46 at 4.85 %


# Example 3


WITH cate_table2 AS (
	SELECT 
	category,
	SUM(quantity) AS total_quantity
	FROM `gold.fact_sales` AS gsal
	LEFT JOIN `gold.dim_products` AS gprod
		ON gsal.product_key = gprod.product_key
	GROUP BY category
)
SELECT 
category,
total_quantity,
SUM(total_quantity) OVER() AS overall_quantity,
CONCAT(ROUND((total_quantity / SUM(total_quantity) OVER()) * 100, 2), ' %') AS percentage_qty
FROM cate_table2
ORDER BY total_quantity DESC
;

#The companys' biggest stock is accessories which comprises 59.77 % of the entire stock







SELECT *
FROM `gold.dim_customers`;

SELECT *
FROM `gold.dim_products`;

SELECT *
FROM `gold.fact_sales`;