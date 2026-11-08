--customers_email_key
INSERT INTO customers (email, full_name, phone, country, city) 
VALUES ('olena.koval@example.com', 'Ольга Коваль', '+380681234337', 'UA', 'Львів');

--products_price_check
INSERT INTO products (sku, name, brand, category, price, stock, attributes)
VALUES ('APL-IPA11-G3', 'iPad Air 11 G3 128GB', 'Apple', 'Планшети', 0.00, 1, '{"storage_gb": "128"}');

-- order_items_product_id_fkey
INSERT INTO order_items (order_id, product_id, quantity, unit_price) 
VALUES (1, 999, 2, 1566.00);

--order_items_pkey
INSERT INTO order_items (order_id, product_id, quantity, unit_price) 
VALUES (1, 18, 2, 13999.00);

--orders_status_check
UPDATE orders
SET status = 'returned'
WHERE order_id = 1;

--orders_customer_id_fkey
DELETE FROM customers 
WHERE customer_id = 1;
