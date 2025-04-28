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
