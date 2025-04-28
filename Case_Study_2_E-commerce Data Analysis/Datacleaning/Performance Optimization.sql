/*
Indexing: 
Identify which queries in your analysis are taking the longest and create 
indexes to optimize them (e.g., on order_date, product_id).

*/
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_orders_customer_id ON orders(customer_id);

CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

CREATE INDEX idx_products_product_id ON products(product_id);

CREATE INDEX idx_customers_customer_id ON customers(customer_id);



