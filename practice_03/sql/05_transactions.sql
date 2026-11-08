BEGIN;

SELECT product_id, sku, stock, price
FROM products
WHERE sku IN ('APL-IPD11-A16', 'SNY-XM5')
ORDER BY product_id
FOR UPDATE;

INSERT INTO orders (customer_id)
VALUES (41)
RETURNING order_id;

INSERT INTO order_items (order_id, product_id, quantity, unit_price) 
VALUES	(73, 13, 2, 17999.00),
		(73, 18, 1, 13999.00);

UPDATE products
SET stock = stock - 2
WHERE product_id = 13;  

UPDATE products
SET stock = stock - 1
WHERE product_id = 18;   

COMMIT;



BEGIN;

INSERT INTO orders (customer_id)
VALUES (1)
RETURNING order_id;

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (74, 7, 3, 49999.00);

UPDATE products
SET stock = stock - 3
WHERE product_id = 7;
-- ERROR: new row for relation "products" violates check constraint "products_stock_check"
ROLLBACK;

BEGIN;

INSERT INTO products (sku, name, brand, category_id, price, stock)
VALUES
    ('APL-APP3',     'AirPods Pro 3',    'Apple',   2, 11999.00, 42),
    ('SMS-S25-256',  'Galaxy S25 256GB', 'Samsung', 1, 35999.00, 20),
    ('GGL-PX10-128', 'Pixel 10 128GB',   'Google',  1, 34999.00, 15),
    ('LNV-TABP12',   'Tab P12',          'Lenovo',  5, 15499.50, 10)
ON CONFLICT (sku) DO UPDATE
SET price = EXCLUDED.price,
    stock = EXCLUDED.stock
RETURNING sku, old.price AS old_price, new.price AS new_price;

SAVEPOINT before_discontinue;

DELETE FROM products WHERE sku = 'JBL-T520BT';
-- ERROR: update or delete on table "products" violates RESTRICT setting of foreign key constraint "order_items_product_id_fkey" on table "order_items"

ROLLBACK TO SAVEPOINT before_discontinue;

UPDATE products SET is_active = false WHERE sku = 'JBL-T520BT';

COMMIT;
