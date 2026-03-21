-- Top Selling Products Analysis
-- Identifies best-performing products based on revenue and quantity sold

SELECT 
    p.nombre AS producto,

    SUM(v.cantidad) AS