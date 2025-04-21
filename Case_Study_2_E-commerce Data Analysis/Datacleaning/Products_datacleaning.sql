/* Remove duplicates*/
With products_duplicate as(
select * , row_number() over(partition by product_name, 
category, brand,price,stock_quantity, rating , 
release_year) as rk from products
)
delete from products where product_id in 
(select product_id from products_duplicate where rk > 1)
;

/* Standrize data */
select distinct category from products order by category ASC;
update Products set category="Speaker" where category like "%speeker%";
update Products set category="Headphones" where category like "%head phones%";
update Products set category="Laptop" where category like "%lap top%";
update Products set category="Smartphone" where category like "%smart phone%";
update Products set category="Tablet" where category like "%Tablets%";

select  distinct brand from products order by brand asc;
update Products set brand ="Razer" where brand like "%R@zer%";
update Products set brand ="Sony" where brand like "%sony.%";
update Products set brand ="Asus" where brand like "%Asu$%";
update Products set brand ="Google" where brand like "%googl%";
update Products set brand ="Logitech" where brand like "%logi tech%";
update Products set brand ="Microsoft" where brand like "%MICRO soft%";
update Products set brand ="Lenovo" where brand like "%len0vo%";
update Products set brand ="HP" where brand like "%hp%";

/* Fixing Structural Issues*/
  describe products;
  alter table products modify release_year year;


/*Handling Missing Data */
select * from products where category is null OR category ="";
UPDATE Products 
SET category = 
  CASE 
    WHEN product_name LIKE "%Tablet%" THEN "Tablet"
    WHEN product_name LIKE "%Accessory%" THEN "Accessory"
    WHEN product_name LIKE "%Headphones%" THEN "Headphones"
    WHEN product_name LIKE "%Smartphone%" THEN "Smartphone"
    WHEN product_name LIKE "%Wearable%" THEN "Wearable"
    WHEN product_name LIKE "%Laptop%" THEN "Laptop"
    WHEN product_name LIKE "%Speaker%" THEN "Speaker"
  END
WHERE TRIM(COALESCE(category, '')) = '';
  
select * from products where TRIM(COALESCE(brand, '')) = '';
  
select distinct brand from products;
UPDATE Products 
SET Brand = 
  CASE 
    WHEN product_name LIKE "%Microsoft%" THEN "Microsoft"
    WHEN product_name LIKE "%JBL%" THEN "JBL"
    WHEN product_name LIKE "%Lenovo%" THEN "Lenovo"
    WHEN product_name LIKE "%Sony%" THEN "Sony"
    WHEN product_name LIKE "%Asus%" THEN "Asus"
    WHEN product_name LIKE "%Dell%" THEN "Dell"
    WHEN product_name LIKE "%Logitech%" THEN "Logitech"
    WHEN product_name LIKE "%HP%" THEN "HP"
    WHEN product_name LIKE "%Google%" THEN "Google"
    WHEN product_name LIKE "%Razer%" THEN "Razer"
    WHEN product_name LIKE "%Samsung%" THEN "Samsung"
    WHEN product_name LIKE "%apple%" THEN "apple"
  END
WHERE TRIM(COALESCE(brand, '')) = '';

/* stock_quantity and release_year won’t contribute meaningfully in current 
analysis (e.g., product trends, sales insights, etc.),
 i'll drop them and keep the dataset clean*/
 
ALTER TABLE Products 
DROP COLUMN stock_quantity,
DROP COLUMN release_year;
delete from products where TRIM(COALESCE(product_name, '')) = '';