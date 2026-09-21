SELECT 
YEAR(order_date) as order_year, 
MONTH(order_date) as order_month, 
SUM(sales_amount) as total_Sales,
COUNT(DISTINCT customer_key) as total_customer,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date)


SELECT
order_date,
total_sales,
SUM(total_sales) OVER (PARTITION BY YEAR(order_date) ORDER BY order_date) as running_total_sales
--window function
FROM
(
SELECT
DATETRUNC(month, order_date) as order_date,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
) t



WITH yearly_product_sales AS (
SELECT
YEAR(f.order_date) AS order_year,
p.product_name,
SUM(f.sales_amount) AS current_sales    
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE order_date IS NOT NULL
GROUP BY
YEAR(f.order_date),
p.product_name 
)
SELECT
order_year,
product_name,
current_sales,
AVG(current_sales) OVER (PARTITION BY product_name) avg_sales,
current_sales - AVG(current_sales) OVER (PARTITION BY product_name) as diff_sales,
CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'ABOVE AVERAGE'
     WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'BELOW AVERAGE'
     ELSE 'AVG'
END avg_change,
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) py_sales, 
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py
FROM yearly_product_sales
ORDER BY product_name, order_year

--Which categories contribute the most overall sales?
WITH category_sales AS (
SELECT
category,
SUM(sales_amount) total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key  = f.product_key
GROUP BY category
)
SELECT
category,
total_sales, 
SUM(total_sales) OVER () overall_sales,
(CAST(total_sales AS FLOAT)/SUM(total_sales) OVER ())*100 AS percentage_of_total
FROM category_sales    