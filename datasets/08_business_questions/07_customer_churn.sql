-- Customer churn analysis (single purchase customers)

SELECT 
    id_cliente,
    COUNT(*) AS total_orders
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) = 1
ORDER BY total_orders;