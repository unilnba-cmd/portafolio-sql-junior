-- Customer segmentation by revenue

SELECT 
    id_cliente,
    SUM(cantidad * precio) AS total_revenue,

    CASE
        WHEN SUM(cantidad * precio) >= 2000 THEN 'High Value'
        WHEN SUM(cantidad * precio) >= 1000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS segment

FROM ventas
GROUP BY id_cliente
ORDER BY total_revenue DESC;