-- Lets find the latest and first order date
-- Lets also find the years, months and days between them


SELECT 
MIN(order_date) AS first_order_date,
MAX(order_date) AS latest_order_date,
TIMESTAMPDIFF(YEAR, MIN(order_date), MAX(order_date)) Years_between,
TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) Months_between,
TIMESTAMPDIFF(DAY, MIN(order_date), MAX(order_date)) Days_between
FROM `gold.fact_sales`
WHERE order_date IS NOT NULL AND order_date != '';


-- Lets also explore the birth dates

SELECT 
MIN(birthdate) Oldest,
MAX(birthdate) Youngest,
TIMESTAMPDIFF(YEAR, MIN(birthdate), CURDATE()) Age_Oldest,
TIMESTAMPDIFF(YEAR, MAX(birthdate), CURDATE()) Age_Youngest,
TIMESTAMPDIFF(YEAR, MIN(birthdate), MAX(birthdate)) Years_between   /* difference between the birthdates*/
FROM `gold.dim_customers`
WHERE birthdate != ''
;











