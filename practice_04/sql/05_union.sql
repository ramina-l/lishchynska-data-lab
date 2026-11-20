SET TIME ZONE 'UTC';

-- Завдання 5.1
SELECT
	created_at AS event_at,
	'замовлення створено' AS event,
	total_amount AS amount
FROM shop.orders
WHERE order_id = 271060

UNION ALL

SELECT
	created_at AS event_at,
	CASE 
		WHEN status = 'succeeded' THEN 'платіж успішний'
		WHEN status = 'failed' THEN 'платіж відхилено' END AS event,
	amount AS amount
FROM shop.payments
WHERE order_id = 271060
UNION ALL

SELECT
	shipped_at AS event_at,
	'відправлено' AS event,
	NULL AS amount
FROM shop.shipments
WHERE order_id = 271060
AND shipped_at IS NOT NULL

UNION ALL

SELECT
	received_at AS event_at,
	'отримано' AS event,
	NULL AS amount
FROM shop.shipments
WHERE order_id = 271060
AND received_at IS NOT NULL

ORDER BY event_at, event;

-- Завдання 5.2
SELECT
	country_code,
	'замовлення' AS metric,
	SUM(total_amount) AS amount
FROM shop.orders
WHERE (created_at >= '2025-12-01'  AND  created_at < '2026-01-01')
GROUP BY country_code

UNION ALL

SELECT 
	o.country_code,	
	'позиції' AS metric,
	SUM(oi.quantity * oi.unit_price) AS amount 
FROM shop.order_items oi
INNER JOIN shop.orders o ON o.order_id = oi.order_id
WHERE (o.created_at >= '2025-12-01'  AND  o.created_at < '2026-01-01')
GROUP BY o.country_code

UNION ALL

SELECT
	o.country_code,	
	'успішні платежі' AS metric,
	SUM(p.amount) AS amount
FROM shop.payments p
INNER JOIN shop.orders o ON o.order_id = p.order_id
WHERE p.payment_type ='payment' AND p.status ='succeeded'
AND (o.created_at >= '2025-12-01'  AND  o.created_at < '2026-01-01')
GROUP BY o.country_code

ORDER BY country_code, metric;