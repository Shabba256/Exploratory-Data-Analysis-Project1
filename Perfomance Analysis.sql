#In this project, We shall look at the following;
-- comparing the current value to a target value
-- Helps us measure success and compare performance
/* analyze the anual performance of products by comparing each products' sales 
to both it's average sales perfomance and the previous years' sales */


WITH anual_product_sales AS (
	SELECT 
	YEAR(order_date) AS order_year,
	gprod.product_name,
	SUM(sales_amount) AS current_sales
	FROM `gold.fact_sales` AS gsal
	LEFT JOIN `gold.dim_products` AS gprod
		ON gsal.product_key = gprod.product_key
	WHERE order_date IS NOT NULL AND order_date != ''
	GROUP BY order_year, gprod.product_name
)

SELECT 
order_year,
product_name,
current_sales,
AVG(current_sales) OVER (ORDER BY product_name, order_year) AS avg_sales,
current_sales - AVG(current_sales) OVER (ORDER BY product_name, order_year) AS diff_avg,
CASE WHEN current_sales - AVG(current_sales) OVER (ORDER BY product_name, order_year) < 0 THEN 'Below Average'
	 WHEN current_sales - AVG(current_sales) OVER (ORDER BY product_name, order_year) > 0 THEN 'Above Average'
     ELSE 'Average'
END avg_change,
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS prev_sales,
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_prev_sales,
CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
	 WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
     ELSE 'No Change'
END sales_change
FROM `anual_product_sales`
;



-- Another example of performance analysis using  shipping sate



WITH anual_sales AS (
	SELECT 
	YEAR(shipping_date) AS current_year,
	gprod.product_name,
	SUM(sales_amount) AS current_sales
	FROM `gold.fact_sales` AS gsal
	LEFT JOIN `gold.dim_products` AS gprod
		ON gsal.product_key = gprod.product_key
	GROUP BY YEAR(shipping_date), gprod.product_name
)

SELECT 
current_year,
product_name,
current_sales,
AVG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) AS avg_sales,
current_sales - AVG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) AS diff_avg,
CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) < 0 THEN 'Below Average'
	 WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) > 0 THEN 'Above Average'
     ELSE 'Average'
END AS avg_change,
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) AS prev_sales,
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) AS diff_sales,
CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) < 0 THEN 'Deacrease'
	 WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) > 0 THEN 'Increase'
     ELSE 'No Change'
END AS sales_change
FROM anual_sales
;


-- Another example using due date to master WITH as a CTE


WITH anual_sales AS (
	SELECT
	YEAR(due_date) AS current_year,
	gprod.product_name,
	SUM(sales_amount) AS current_sales
	FROM `gold.fact_sales` AS gsal
	LEFT JOIN `gold.dim_products` AS gprod
		ON gsal.product_key = gprod.product_key
	GROUP BY YEAR(due_date), gprod.product_name
)
SELECT 
current_year,
product_name,
current_sales,
AVG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) AS avg_sales,
current_sales - AVG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) AS diff_avg,
CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) < 0 THEN 'Below Average'
	 WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) > 0 THEN 'Above Average'
     ELSE 'Average'
END AS avg_change,
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) AS prev_sales,
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) AS diff_sales,
CASE WHEN  current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) < 0 THEN 'Decrease'
	 WHEN  current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY current_year) > 0 THEN 'Increase'
	 ELSE 'No Change'
END AS sales_change
FROM anual_sales
;


















































SELECT *
FROM `gold.fact_sales`;

SELECT *
FROM `gold.dim_products`;