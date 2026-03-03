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

 -- =========================================
-- Customer Segmentation by Revenue Tier
-- =========================================

WITH customer_totals AS (
    SELECT 
        c.customer_name,
        SUM(f.total_amount) AS total_revenue
    FROM fact_sales f
    JOIN dim_customers c ON f.customer_key = c.customer_key
    GROUP BY c.customer_name
)

SELECT 
    customer_name,
    total_revenue,
    CASE 
        WHEN total_revenue >= 3000 THEN 'High Value'
        WHEN total_revenue >= 1500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_totals
ORDER BY total_revenue DESC;

-- ============================================
-- CUSTOMER RETENTION ANALYSIS
-- ============================================

SELECT
    DATE_FORMAT(sale_date, '%Y-%m') AS month,
    COUNT(DISTINCT customer_id) AS active_customers
FROM fact_sales
GROUP BY month
ORDER BY month;

WITH customer_months AS (
    SELECT
        customer_id,
        DATE_FORMAT(sale_date, '%Y-%m') AS month
    FROM fact_sales
    GROUP BY customer_id, month
)

SELECT *
FROM customer_months;

-- ============================================
-- CUSTOMER CHURN ANALYSIS (90-Day Rule)
-- ============================================

WITH last_purchase AS (
    SELECT
        customer_id,
        MAX(sale_date) AS last_purchase_date
    FROM fact_sales
    GROUP BY customer_id
)

SELECT
    customer_id,
    last_purchase_date,
    DATEDIFF(CURDATE(), last_purchase_date) AS days_inactive,
    CASE
        WHEN DATEDIFF(CURDATE(), last_purchase_date) >= 90 THEN 'CHURNED'
        ELSE 'ACTIVE'
    END AS customer_status
FROM last_purchase;

-- ============================================
-- CUSTOMER STATUS KPI DISTRIBUTION
-- ============================================

WITH last_purchase AS (
    SELECT
        customer_id,
        MAX(sale_date) AS last_purchase_date
    FROM fact_sales
    GROUP BY customer_id
),

customer_status AS (
    SELECT
        customer_id,
        CASE
            WHEN DATEDIFF(CURDATE(), last_purchase_date) >= 90 THEN 'CHURNED'
            WHEN DATEDIFF(CURDATE(), last_purchase_date) >= 45 THEN 'AT RISK'
            ELSE 'ACTIVE'
        END AS status
    FROM last_purchase
)

SELECT
    status,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_status), 2) AS percentage
FROM customer_status
GROUP BY status;
);