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
);