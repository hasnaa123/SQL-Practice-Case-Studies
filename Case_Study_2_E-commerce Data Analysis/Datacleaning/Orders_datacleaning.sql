select * from orders ;
describe orders;
/*Handling Missing Data */
select * from orders where order_date = "" or order_date is null;
select * from orders where customer_id = "" or customer_id is null;
select * from orders where total_amount is null;

/* Fixing Structural Issues */
describe orders;
alter table orders modify order_date date;

/* Standardizing Data */
/* check negative or zero */
SELECT *
FROM orders
WHERE total_amount <= 0;

/* Remove duplicates */
With orders_rank as(select * , row_number() over(partition by order_date , customer_id
 , total_amount) as rk from orders)
SELECT customer_id
  FROM orders_rank
  WHERE rk > 1;
  
