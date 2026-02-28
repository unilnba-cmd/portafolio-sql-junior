-- ============================================
-- Project 06: Advanced SQL – Subqueries, CTEs & Window Functions
-- Author: Nelson Antonio Blandón
-- ============================================

USE sales_db;

-- 1️⃣ Customers who spent above average
SELECT name, total_spent
FROM (
    SELECT 
        c.name,
        SUM(p.price * o.quantity) AS total_spent
    FROM orders o
    JOIN customers c ON o.customer_id = c.id
    JOIN products p ON o.product_id = p.id
    GROUP BY c.name
) AS customer_totals
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(p.price * o.quantity) AS total_spent
        FROM orders o
        JOIN products p ON o.product_id = p.id
        GROUP BY o.customer_id
    ) AS avg_table
);

-- 2️⃣ CTE – Revenue by customer
WITH revenue_cte AS (
    SELECT 
        c.name,
        SUM(p.price * o.quantity) AS total_spent
    FROM orders o
    JOIN customers c ON o.customer_id = c.id
    JOIN products p ON o.product_id = p.id
    GROUP BY c.name
)
SELECT *
FROM revenue_cte
ORDER BY total_spent DESC;

-- 3️⃣ Ranking customers (Window Function)
SELECT 
    c.name,
    SUM(p.price * o.quantity) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.price * o.quantity) DESC) AS spending_rank
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN products p ON o.product_id = p.id
GROUP BY c.name;

-- 4️⃣ Running total revenue
SELECT 
    o.order_date,
    SUM(p.price * o.quantity) AS daily_revenue,
    SUM(SUM(p.price * o.quantity)) 
        OVER (ORDER BY o.order_date) AS running_total
FROM orders o
JOIN products p ON o.product_id = p.id
GROUP BY o.order_date
ORDER BY o.order_date;