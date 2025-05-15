
-- 1. Top 5 best-selling products by total quantity sold
SELECT 
    p.product_name,
    SUM(o.quantity) AS total_sold
FROM sql_orders o
JOIN sql_products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5;

-- 2. Total revenue per month
SELECT 
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(quantity * price) AS total_revenue
FROM sql_orders
GROUP BY month
ORDER BY month;

-- 3. Active customers per month
SELECT 
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT client_id) AS active_customers
FROM sql_orders
GROUP BY month
ORDER BY month;

-- 4. Sales by country
SELECT 
    c.country,
    SUM(o.quantity * o.price) AS country_sales
FROM sql_orders o
JOIN sql_customers c ON o.client_id = c.client_id
GROUP BY c.country
ORDER BY country_sales DESC;

-- 5. Average number of orders per customer
SELECT 
    AVG(order_count) AS avg_orders_per_customer
FROM (
    SELECT client_id, COUNT(*) AS order_count
    FROM sql_orders
    GROUP BY client_id
) sub;

-- 6. Most ordered products in 'Accessories' category
SELECT 
    p.product_name,
    SUM(o.quantity) AS total_quantity
FROM sql_orders o
JOIN sql_products p ON o.product_id = p.product_id
WHERE p.category = 'Accessories'
GROUP BY p.product_name
ORDER BY total_quantity DESC;
