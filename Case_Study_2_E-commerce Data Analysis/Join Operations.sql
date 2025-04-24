/*
	Customer Order History:
	For a given customer, retrieve their total number of orders, total spent, and the list of products purchased.
*/
SELECT 
  C.customer_id, 
  C.first_name, 
  C.last_name, 
  COUNT(DISTINCT O.order_id) AS total_orders,
  ROUND(SUM(O.total_amount), 2) AS total_revenue,
  GROUP_CONCAT(DISTINCT P.product_name SEPARATOR ', ') AS products_purchased
FROM customers C
INNER JOIN orders O ON C.customer_id = O.customer_id
INNER JOIN order_items OI ON O.order_id = OI.order_id
INNER JOIN products P ON OI.product_id = P.product_id
GROUP BY C.customer_id, C.first_name, C.last_name;

/* 
•	Top-selling Products:
o	List the top 10 products by total quantity sold.
o	Use JOINs between Products and Order_Items and aggregate sales data.*/

select P.product_id , P.product_name,sum(O.quantity) as total_quantity_sale
from products P 
inner join order_items O ON P.product_id = O.product_id 
group by P.product_id, P.product_name
order by total_quantity_sale  DESC limit 10
 ;


