/*
•	Product Stock Forecasting: 
o	Calculate which products are in danger of running out of stock 
based on sales trends (e.g., using SUM() to check the average sales per day and then 
predicting how long the current stock will last).
*/
SELECT 
  P.product_id,
  P.product_name,
  P.stock_quantity,
  ROUND(SUM(OI.quantity) / 30, 2) AS avg_daily_sales,
  ROUND(P.stock_quantity / (SUM(OI.quantity) / 30), 2) AS estimated_days_left
FROM products P
JOIN order_items OI ON P.product_id = OI.product_id
JOIN orders O ON OI.order_id = O.order_id
WHERE O.order_date >= CURDATE() - INTERVAL 30 DAY
GROUP BY P.product_id, P.product_name, P.stock_quantity
HAVING estimated_days_left < 10
ORDER BY estimated_days_left ASC;

/* 
Year-over-Year Growth: 
	Calculate the percentage growth in sales from 
    the previous year to the current year for each product category.
    Percentage Growth=( (New Sales−Old Sales)/Old sales )×100

 */
 WITH salesCTE as (
 select P.category,Round(Sum(OI.price),2) as total_sales,YEAR(O.order_date) as sales_year from 
 order_items OI inner join products P ON OI.product_id = P.product_id
 inner join orders O on O.order_id = OI.order_id
 where (YEAR(O.order_date) = (YEAR(CURDATE()) - 1) or YEAR(O.order_date) = YEAR(CURDATE())) group by P.category,sales_year)
 select total_sales as new_sales from salesCTE where sales_year = YEAR(CURDATE())
 ;
 
  WITH salesCTE as (
 select P.category,Round(Sum(OI.price),2) as total_sales,YEAR(O.order_date) as sales_year from 
 order_items OI inner join products P ON OI.product_id = P.product_id
 inner join orders O on O.order_id = OI.order_id
 where (YEAR(O.order_date) = (YEAR(CURDATE()) - 1) or YEAR(O.order_date) = YEAR(CURDATE())) group by P.category,sales_year)
 select total_sales as old_sales from salesCTE where sales_year = YEAR(CURDATE())-1,
 select total_sales as new_sales from salesCTE where sales_year = YEAR(CURDATE());
 
 WITH salesCTE AS (
  SELECT 
    P.category,
    ROUND(SUM(OI.price), 2) AS total_sales,
    YEAR(O.order_date) AS sales_year
  FROM order_items OI
  INNER JOIN products P ON OI.product_id = P.product_id
  INNER JOIN orders O ON O.order_id = OI.order_id
  WHERE YEAR(O.order_date) IN (YEAR(CURDATE()), YEAR(CURDATE()) - 1)
  GROUP BY P.category, sales_year
)

SELECT 
  category,
  ROUND(SUM(CASE WHEN sales_year = YEAR(CURDATE()) - 1 THEN total_sales ELSE 0 END),2) AS old_sales,
  ROUND(SUM(CASE WHEN sales_year = YEAR(CURDATE()) THEN total_sales ELSE 0 END),2) AS new_sales,
FROM salesCTE
GROUP BY category;

  SELECT 
    P.category,
    ROUND(SUM(OI.price), 2) AS total_sales,
    YEAR(O.order_date) AS sales_year
  FROM order_items OI
  INNER JOIN products P ON OI.product_id = P.product_id
  INNER JOIN orders O ON O.order_id = OI.order_id
  WHERE YEAR(O.order_date) IN (YEAR(CURDATE()), YEAR(CURDATE()) - 1)
  GROUP BY P.category, sales_year;

