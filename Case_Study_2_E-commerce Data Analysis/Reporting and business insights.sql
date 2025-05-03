/*
Customer Segmentation:
Use the data to categorize customers into different 
segments based on their total purchase volume or frequency
 (e.g., high-value customers, repeat buyers, one-time buyers).
 
*/

With customerCTE as (select customer_id, count(customer_id) as frequence_buyers from orders group by customer_id)
 select customer_id,frequence_buyers,
 CASE 
 WHEN frequence_buyers = 1 THEN 'one_time_buyers'
 WHEN frequence_buyers > 1 AND frequence_buyers < 5 THEN 'repeat_buyers'
 WHEN frequence_buyers > 5 THEN 'high_value_customers'
 END as segmentation
  FROM customerCTE ;
  
  
/*
•	Churn Rate: Calculate the customer churn rate by identifying 
customers who made their last purchase more than 6 months ago 
and haven't returned since.
*/
WITH ChurnRateCTE AS (
  SELECT 
    customer_id,
    MAX(order_date) AS last_order_date
  FROM orders
  GROUP BY customer_id
)
SELECT 
  (COUNT(CASE WHEN last_order_date <= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH) THEN 1 END) / 
   COUNT(DISTINCT customer_id)) * 100 AS churn_rate
FROM ChurnRateCTE;

/*
Monthly Payment Trend with Success/Failure Breakdown 
*/
SELECT
  DATE_FORMAT(payment_date, '%Y-%m') AS month,
  COUNT(*) AS total_payments,
  SUM(CASE WHEN payment_status = 'completed' THEN 1 ELSE 0 END)          AS successful_payments,
  SUM(CASE WHEN payment_status <> 'completed' THEN 1 ELSE 0 END)          AS failed_payments,
  ROUND(
    100.0 * SUM(CASE WHEN payment_status = 'completed' THEN 1 ELSE 0 END) 
    / COUNT(*), 
    2
  ) AS success_rate_pct
FROM payments
GROUP BY month
ORDER BY month;



/*How much revenue is lost each month due to failed or declined payments,
 and which payment methods contribute most to this loss
*/

select  P.payment_method, DATE_FORMAT(payment_date, '%Y-%m') AS month,Round(sum(O.total_amount),2) as lost_revenue from Payments P inner join orders O 
ON P.order_id = O.order_id where P.payment_status = "Failed" group by P.payment_method, month order by month,lost_revenue desc;
