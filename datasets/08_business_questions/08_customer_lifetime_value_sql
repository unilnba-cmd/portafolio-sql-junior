-- Customer lifetime value (LTV)

SELECT 
    id_cliente,
    SUM(cantidad * precio) AS total_revenue
FROM ventas
GROUP BY id_cliente
ORDER BY total_revenue DESC;