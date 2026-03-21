SELECT 
    cliente_id,
    SUM(cantidad * precio) AS total_gastado,

    CASE
        WHEN SUM(cantidad * precio) > 1000 THEN 'High Value'
        WHEN SUM(cantidad * precio) > 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment

FROM ventas
GROUP BY cliente_id
ORDER BY total_gastado DESC;