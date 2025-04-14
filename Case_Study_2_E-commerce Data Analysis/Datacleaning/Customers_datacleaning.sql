/* Data Cleanning */
 
 /* DELETE DUPLICATES */
SELECT * FROM customers;
select*, ROW_NUMBER() over 
(partition by first_name, last_name,email, phone , date_of_birth,registration_date,country) 
as rk from customers;

WITH ranked_customers AS (
  SELECT 
    *,
    ROW_NUMBER() OVER (
      PARTITION BY first_name, last_name, email, phone, date_of_birth, registration_date, country
      ORDER BY customer_id
    ) AS rk
  FROM customers
)
DELETE FROM customers
WHERE customer_id IN (
  SELECT customer_id
  FROM ranked_customers
  WHERE rk > 1
);
/* check and fix data types : customers table */
describe customers;
/* result :
customer_id	int			
first_name	text			
last_name	text			
email	text	
phone	text	
date_of_birth	text
registration_date	text	
country	text
We need to fix the date_of_birth , registration_date datatype */

alter table customers modify date_of_birth DATE;
alter table customers modify registration_date DATE;

 
