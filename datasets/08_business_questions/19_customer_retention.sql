-- Customer Retention Analysis

SELECT 
    cliente_id,
    COUNT(id) AS total_compras,

    CASE
        WHEN COUNT(id) >= 5 THEN 'Frequent'
        WHEN COUNT(id) >= 2 THEN 'Returning'
        ELSE 'One-time'
    END AS tipo_cliente

FROM ventas

GROUP BY cliente_id
ORDER BY total_compras DESC;