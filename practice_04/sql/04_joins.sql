SET TIME ZONE 'UTC';

-- Завдання 4.1
SELECT
c.name AS country,
b.name AS brand,
COUNT(DISTINCT oi.order_id) AS orders_cnt,
SUM(oi.quantity) AS units_sold,
SUM(oi.quantity * oi.unit_price) AS revenue
FROM shop.order_items AS oi

INNER JOIN shop.orders AS o ON o.order_id = oi.order_id
INNER JOIN shop.countries AS c ON c.country_code = o.country_code
INNER JOIN shop.products AS p ON p.product_id = oi.product_id
INNER JOIN shop.brands AS b ON b.brand_id = p.brand_id

WHERE o.status = 'received'
AND o.created_at >= '2025-10-01'
AND o.created_at < '2026-01-01'

GROUP BY c.name, b.name
ORDER BY country, revenue DESC, brand;

-- Завдання 4.2
SELECT
    p.product_id,
    p.sku,
    p.name,
    b.name AS brand,
    c.name AS category
FROM shop.products AS p
LEFT JOIN shop.brands AS b ON b.brand_id = p.brand_id
LEFT JOIN shop.categories AS c ON c.category_id = p.category_id
LEFT JOIN shop.order_items AS oi ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL
ORDER BY p.product_id;

-- Завдання 4.3
SELECT
     c.category_id,
     c.name AS category,
     cp.name AS parent,
     COUNT(p.product_id) AS products_cnt
FROM shop.categories AS c
LEFT JOIN shop.categories AS cp ON cp.category_id = c.parent_id
LEFT JOIN shop.products AS p ON p.category_id = c.category_id
GROUP BY c.category_id, c.name, cp.name
ORDER BY c.category_id;

-- Завдання 4.4
SELECT
cn.name AS country,
cr.name AS carrier,
COUNT(o.order_id) AS orders_cnt
FROM shop.countries AS cn
CROSS JOIN shop.carriers AS cr
LEFT JOIN shop.orders AS o ON o.country_code = cn.country_code
AND o.carrier_id = cr.carrier_id
AND (o.created_at >= '2025-12-01' AND o.created_at < '2026-01-01')
GROUP BY cn.name, cr.name
ORDER BY country, carrier;
