/*Handling Missing Data */
select * from payments;
SELECT 
  CONCAT(
    'SELECT * FROM ', 
    table_name, 
    ' WHERE ', 
    GROUP_CONCAT(CONCAT(column_name, ' IS NULL') SEPARATOR ' OR '), 
    ';'
  ) AS generated_query
FROM information_schema.columns
WHERE table_schema = 'learning'
  AND table_name = 'payments';
  
SELECT * FROM payments WHERE order_id IS NULL OR payment_date IS NULL OR payment_id IS NULL OR payment_method IS NULL OR payment_status IS NULL;

/* Fixing Structural Issues */
describe payments;
alter table payments modify payment_date DATE;

/* Standardizing Data */
select distinct payment_method from payments;
select distinct payment_status from payments;
/* before standrizing :
Pending
Failed
Completed
compeleted
pendding */
update payments set payment_status = "Completed" where payment_status like '%compeleted%';
update payments set payment_status = "Pending" where payment_status like '%pendding%';

/* After standrizing :
Pending
Failed
Completed */
