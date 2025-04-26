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
  WITH SalesCTE AS (
  SELECT 
    P.category,
    ROUND(SUM(CASE WHEN YEAR(O.order_date) = YEAR(CURDATE()) - 1 THEN OI.price ELSE 0 END), 2) AS old_sales,
    ROUND(SUM(CASE WHEN YEAR(O.order_date) = YEAR(CURDATE()) THEN OI.price ELSE 0 END), 2) AS new_sales
  FROM order_items OI
  INNER JOIN products P ON OI.product_id = P.product_id
  INNER JOIN orders O ON O.order_id = OI.order_id
  WHERE YEAR(O.order_date) IN (YEAR(CURDATE()), YEAR(CURDATE()) - 1)
  GROUP BY P.category
)
SELECT 
  category,
  ROUND(((new_sales - old_sales) / old_sales) * 100, 2) AS percentage_growth,
  CASE 
    WHEN old_sales = 0 THEN 'No sales last year'
    WHEN ((new_sales - old_sales) / old_sales) * 100 > 0 THEN 'Growth'
    WHEN ((new_sales - old_sales) / old_sales) * 100 < 0 THEN 'Decline'
    ELSE 'No Change'
  END AS comment
FROM SalesCTE;