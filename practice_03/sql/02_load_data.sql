COPY customers (customer_id, email, full_name, phone, country, city, registered_at)
FROM '/data/customers.csv' WITH (FORMAT csv, HEADER true);

COPY products (product_id, sku, name, brand, category, price, stock, is_active, attributes)
FROM '/data/products.csv' WITH (FORMAT csv, HEADER true);

COPY orders (order_id, customer_id, status, created_at)
FROM '/data/orders.csv' WITH (FORMAT csv, HEADER true);

COPY order_items (order_id, product_id, quantity, unit_price)
FROM '/data/order_items.csv' WITH (FORMAT csv, HEADER true);


ALTER TABLE customers ALTER COLUMN customer_id RESTART WITH 41;
ALTER TABLE products  ALTER COLUMN product_id  RESTART WITH 25; 
ALTER TABLE orders    ALTER COLUMN order_id    RESTART WITH 73;  

INSERT INTO customers (email, full_name, phone, country, city) 
VALUES ('nazar.kravets@example.com', 'Назар Кравець', '+380671234567', 'UA', 'Тернопіль')
RETURNING customer_id, registered_at;