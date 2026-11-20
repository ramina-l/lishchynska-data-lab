SET TIME ZONE 'UTC';

-- Завдання 3.1
SELECT 
country_code,
COUNT(*) AS orders_cnt,
COUNT(DISTINCT customer_id) AS customers_cnt,
SUM(total_amount) AS total_sum,
ROUND(AVG(total_amount),2) AS avg_check,
MIN(total_amount) AS min_check,
MAX(total_amount) AS max_check
FROM shop.orders
WHERE status = 'received'
AND (created_at >= '2025-01-01'  AND  created_at < '2026-01-01')

GROUP BY country_code
ORDER BY country_code;

-- Завдання 3.2
SELECT  
DATE(date_trunc('month',created_at)) AS order_month,
COUNT(*) AS orders_cnt,
COUNT(DISTINCT customer_id) AS customers_cnt,
SUM(total_amount) AS total_sum,
ROUND(AVG(total_amount),2) AS avg_check

FROM shop.orders
WHERE country_code = 'UA'
AND status = 'received'

GROUP BY DATE(date_trunc('month',created_at)) 
ORDER BY order_month;


-- Завдання 3.3
SELECT  country_code,
date_part('hour', created_at)::int AS order_hour,
COUNT(*) AS orders_cnt,
ROUND(AVG(total_amount),2) AS avg_check
FROM shop.orders
WHERE status <>'cancelled'
AND (created_at >= '2025-01-01'  AND  created_at < '2026-01-01')

GROUP BY country_code, order_hour
ORDER BY country_code, order_hour;

-- Завдання 3.4
SELECT  
customer_id,
COUNT(*) AS orders_cnt,
SUM(total_amount) AS total_sum,

DATE(MIN(created_at)) AS first_order_date,
DATE(MAX(created_at)) AS last_order_date
FROM shop.orders
WHERE country_code = 'UA'
AND status = 'received'
GROUP BY customer_id
HAVING COUNT(*) >= 15 AND SUM(total_amount) >= 500000
ORDER BY total_sum DESC, customer_id
LIMIT 20;