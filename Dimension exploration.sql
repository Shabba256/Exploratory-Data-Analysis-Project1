-- Explore major dimensions in tables
SELECT DISTINCT country
FROM `gold.dim_customers`
;

SELECT gender, COUNT(customer_key) AS customers
FROM `gold.dim_customers`
GROUP BY gender
;

SELECT marital_status, COUNT(customer_key) AS customers
FROM `gold.dim_customers`
GROUP BY marital_status
;

SELECT DISTINCT category
FROM `gold.dim_products`;

SELECT category, subcategory, product_name
FROM `gold.dim_products`
ORDER BY 1,2
;





SELECT *
FROM `gold.dim_customers`;

SELECT *
FROM `gold.dim_products`;

SELECT *
FROM `gold.fact_sales`;