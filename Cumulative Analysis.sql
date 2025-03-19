# In this project, we look at the following;
-- calculate the total sales per month
-- and the running total of sales over time


SELECT 
order_year,
order_month,
total_sales,
avg_price,
SUM(total_sales) OVER (PARTITION BY order_year ORDER BY order_year, order_month) AS cumulative_sales,
AVG(avg_price) OVER (PARTITION BY order_year ORDER BY order_year, order_month) AS moving_avg_price
FROM 
(
	SELECT 
	YEAR(order_date) AS order_year,
	MONTH(order_date) AS order_month,
	SUM(sales_amount) AS total_sales,
    AVG(price) AS avg_price
	FROM `gold.fact_sales`
	WHERE order_date IS NOT NULL AND order_date != ''
	GROUP BY YEAR(order_date), MONTH(order_date)
) AS sales_data;



#Lets use the shipping date


SELECT
shipping_year,
shipping_month,
total_sales,
total_quantity,
avg_price,
SUM(total_sales) OVER (PARTITION BY shipping_year  ORDER BY shipping_year, shipping_month) AS cumulative_sales,
SUM(total_quantity) OVER (PARTITION BY shipping_year ORDER BY shipping_year, shipping_month) AS cumulative_quantity,
AVG(avg_price) OVER (PARTITION BY shipping_year ORDER BY shipping_year, shipping_month) AS moving_avg_price
FROM
(
	SELECT
	YEAR(shipping_date) AS shipping_year,
	MONTH(shipping_date) AS shipping_month,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	AVG(price) AS avg_price
	FROM `gold.fact_sales`
	GROUP BY shipping_year, shipping_month
) AS sales_data2;



#last example of cumulative analysis over time using  due date


SELECT
due_year,
due_month,
total_customer,
total_sales,
total_quantity,
SUM(total_customer) OVER (PARTITION BY due_year  ORDER BY due_year, due_month) AS cumulative_total_customers,
SUM(total_sales) OVER (PARTITION BY due_year ORDER BY due_year, due_month) AS cumulative_sales,
SUM(total_quantity) OVER (PARTITION BY due_year ORDER BY due_year, due_month) AS cumulative_quantity
FROM
(
	SELECT
	YEAR(due_date) AS due_year,
	MONTH(due_date) AS due_month,
	COUNT(DISTINCT customer_key) AS total_customer,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity
	FROM `gold.fact_sales`
	GROUP BY due_year, due_month
) AS sales_data3;


SELECT *
FROM `gold.fact_sales`; 