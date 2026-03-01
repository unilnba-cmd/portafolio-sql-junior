-- ============================================
-- Project 07: Mini Data Warehouse
-- Author: Nelson Antonio Blandón
-- ============================================

CREATE DATABASE company_dw;
USE company_dw;

-- =============================
-- DIMENSION TABLES
-- =============================

-- Customers Dimension
CREATE TABLE dim_customers (
    customer_key INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);

-- Products Dimension
CREATE TABLE dim_products (
    product_key INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(100)
);

-- Date Dimension
CREATE TABLE dim_date (
    date_key DATE PRIMARY KEY,
    year INT,
    month INT,
    month_name VARCHAR(20)

    -- =============================
-- INSERT DATA INTO DIMENSIONS
-- =============================

-- Customers
INSERT INTO dim_customers (customer_id, customer_name, city) VALUES
(1, 'Carlos Lopez', 'Managua'),
(2, 'Maria Perez', 'Leon'),
(3, 'Juan Martinez', 'Granada');

-- Products
INSERT INTO dim_products (product_id, product_name, category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Phone', 'Electronics'),
(3, 'Desk Chair', 'Furniture');

-- Date Dimension
INSERT INTO dim_date (date_key, year, month, month_name) VALUES
('2026-01-01', 2026, 1, 'January'),
('2026-02-01', 2026, 2, 'February'),
('2026-03-01', 2026, 3, 'March');
);

-- =============================
-- FACT TABLE
-- =============================

CREATE TABLE fact_sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    date_key DATE,
    customer_key INT,
    product_key INT,
    quantity INT,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (customer_key) REFERENCES dim_customers(customer_key),
    FOREIGN KEY (product_key) REFERENCES dim_products(product_key)

    -- =============================
-- INSERT DATA INTO FACT TABLE
-- =============================

INSERT INTO fact_sales (date_key, customer_key, product_key, quantity, total_amount) VALUES
('2026-01-01', 1, 1, 2, 2000.00),
('2026-01-01', 2, 2, 1, 800.00),
('2026-02-01', 1, 2, 3, 2400.00),
('2026-02-01', 3, 3, 2, 600.00),
('2026-03-01', 2, 1, 1, 1000.00);

-- =============================
-- Monthly Revenue Analysis
-- =============================

SELECT 
    d.year,
    d.month_name,
    SUM(f.total_amount) AS monthly_revenue
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;

-- =========================================
-- Running Total Revenue
-- =========================================

SELECT 
    d.year,
    d.month,
    d.month_name,
    SUM(f.total_amount) AS monthly_revenue,
    SUM(SUM(f.total_amount)) OVER (
        ORDER BY d.year, d.month
    ) AS running_total_revenue
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;

-- =========================================
-- Month-over-Month Growth
-- =========================================

WITH monthly_revenue AS (
    SELECT 
        d.year,
        d.month,
        d.month_name,
        SUM(f.total_amount) AS revenue
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY d.year, d.month, d.month_name
)

SELECT 
    year,
    month,
    month_name,
    revenue,
    LAG(revenue) OVER (ORDER BY year, month) AS previous_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY year, month)) 
        / LAG(revenue) OVER (ORDER BY year, month) * 100, 
        2
    ) AS growth_percentage
FROM monthly_revenue;

-- =========================================
-- Customer Revenue Ranking
-- =========================================

SELECT 
    c.customer_name,
    SUM(f.total_amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(f.total_amount) DESC) AS revenue_rank
FROM fact_sales f
JOIN dim_customers c ON f.customer_key = c.customer_key
GROUP BY c.customer_name;

-- =========================================
-- Executive Summary - Q1 2026
-- =========================================

WITH monthly_revenue AS (
    SELECT 
        d.year,
        d.month,
        d.month_name,
        SUM(f.total_amount) AS revenue
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY d.year, d.month, d.month_name
)
SELECT 
    SUM(revenue) AS total_q1_revenue,
    ROUND(AVG(revenue), 2) AS average_monthly_revenue,
    MAX(revenue) AS best_month_revenue,
    MIN(revenue) AS worst_month_revenue
FROM monthly_revenue;

-- =========================================
-- Top Product Q1
-- =========================================

SELECT 
    p.product_name,
    SUM(f.total_amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(f.total_amount) DESC) AS revenue_rank
FROM fact_sales f
JOIN dim_products p ON f.product_key = p.product_key
GROUP BY p.product_name;

-- =========================================
-- Customer Revenue Change Month-over-Month
-- =========================================

WITH customer_monthly AS (
    SELECT 
        c.customer_name,
        d.year,
        d.month,
        SUM(f.total_amount) AS revenue
    FROM fact_sales f
    JOIN dim_customers c ON f.customer_key = c.customer_key
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY c.customer_name, d.year, d.month
)

SELECT 
    customer_name,
    year,
    month,
    revenue,
    LAG(revenue) OVER (
        PARTITION BY customer_name 
        ORDER BY year, month
    ) AS previous_revenue,
    revenue - LAG(revenue) OVER (
        PARTITION BY customer_name 
        ORDER BY year, month
    ) AS revenue_change
FROM customer_monthly
ORDER BY customer_name, year, month;
);