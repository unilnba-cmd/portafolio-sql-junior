-- ============================================
-- Project 05: KPI & Executive Insights Report
-- Author: Nelson Antonio Blandón
-- Description: Business KPI analysis using sales_db
-- ============================================

USE sales_db;

-- 1️⃣ Total Company Revenue
SELECT 
    SUM(p.price * o.quantity) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.id;


-- 2️⃣ Monthly Revenue
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(p.price * o.quantity) AS monthly_revenue
FROM orders o
JOIN products p ON o.product_id = p.id
GROUP BY month
ORDER BY month;


-- 3️⃣ Revenue by Country
SELECT 
    c.country,
    SUM(p.price * o.quantity) AS revenue_by_country
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN products p ON o.product_id = p.id
GROUP BY c.country
ORDER BY revenue_by_country DESC;


-- 4️⃣ Top 3 Customers by Spending
SELECT 
    c.name,
    SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN products p ON o.product_id = p.id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 3;


-- 5️⃣ Best-Selling Product
SELECT 
    p.product_name,
    SUM(o.quantity) AS total_units_sold
FROM orders o
JOIN products p ON o.product_id = p.id
GROUP BY p.product_name
ORDER BY total_units_sold DESC
LIMIT 1;


-- 6️⃣ Customer Segmentation (CASE WHEN)
SELECT 
    c.name,
    SUM(p.price * o.quantity) AS total_spent,
    CASE
        WHEN SUM(p.price * o.quantity) >= 2000 THEN 'High Value'
        WHEN SUM(p.price * o.quantity) >= 1000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN products p ON o.product_id = p.id
GROUP BY c.name
ORDER BY total_spent DESC;