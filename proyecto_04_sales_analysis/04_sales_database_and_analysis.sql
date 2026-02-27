-- ============================================
-- Project 04: Sales Database & Revenue Analysis
-- Author: Nelson Antonio Blandón
-- Description: Simulate a small business sales database
-- ============================================

CREATE DATABASE IF NOT EXISTS sales_db;
USE sales_db;

-- Customers table
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    country VARCHAR(50)
);

-- Products table
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Orders table
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT NOT NULL,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert sample customers
INSERT INTO customers VALUES
(1, 'John Smith', 'john@email.com', 'USA'),
(2, 'Maria Lopez', 'maria@email.com', 'Spain'),
(3, 'Carlos Perez', 'carlos@email.com', 'Mexico');

-- Insert sample products
INSERT INTO products VALUES
(1, 'Laptop', 1200.00),
(2, 'Phone', 800.00),
(3, 'Headphones', 150.00);

-- Insert sample orders
INSERT INTO orders VALUES
(1, 1, 1, 1, '2026-02-01'),
(2, 2, 2, 2, '2026-02-05'),
(3, 3, 3, 3, '2026-02-10'),
(4, 1, 2, 1, '2026-02-15');

-- Revenue per order
SELECT 
    o.id AS order_id,
    c.name AS customer,
    p.product_name,
    o.quantity,
    (p.price * o.quantity) AS total_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN products p ON o.product_id = p.id;

-- Total revenue
SELECT SUM(p.price * o.quantity) AS total_company_revenue
FROM orders o
JOIN products p ON o.product_id = p.id;

-- Revenue by customer
SELECT 
    c.name,
    SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN products p ON o.product_id = p.id
GROUP BY c.name
ORDER BY total_spent DESC;