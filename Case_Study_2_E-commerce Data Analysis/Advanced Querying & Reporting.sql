/*
•	Pivoting Data: 
o	Use CASE or PIVOT to show a report where each column represents a different month and the value in each cell is the total sales for that month.
*/

SELECT
  YEAR(order_date) AS sales_year,
  SUM(CASE WHEN MONTH(order_date) = 1 THEN total_amount ELSE 0 END) AS Jan,
  SUM(CASE WHEN MONTH(order_date) = 2 THEN total_amount ELSE 0 END) AS Feb,
  SUM(CASE WHEN MONTH(order_date) = 3 THEN total_amount ELSE 0 END) AS Mar,
  SUM(CASE WHEN MONTH(order_date) = 4 THEN total_amount ELSE 0 END) AS Apr,
  SUM(CASE WHEN MONTH(order_date) = 5 THEN total_amount ELSE 0 END) AS May,
  SUM(CASE WHEN MONTH(order_date) = 6 THEN total_amount ELSE 0 END) AS Jun,
  SUM(CASE WHEN MONTH(order_date) = 7 THEN total_amount ELSE 0 END) AS Jul,
  SUM(CASE WHEN MONTH(order_date) = 8 THEN total_amount ELSE 0 END) AS Aug,
  SUM(CASE WHEN MONTH(order_date) = 9 THEN total_amount ELSE 0 END) AS Sep,
  SUM(CASE WHEN MONTH(order_date) = 10 THEN total_amount ELSE 0 END) AS Oct,
  SUM(CASE WHEN MONTH(order_date) = 11 THEN total_amount ELSE 0 END) AS Nov,
  SUM(CASE WHEN MONTH(order_date) = 12 THEN total_amount ELSE 0 END) AS `Dec` FROM orders
GROUP BY YEAR(order_date)
ORDER BY sales_year;
