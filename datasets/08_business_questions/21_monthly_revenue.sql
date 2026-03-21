-- Monthly Revenue Analysis

SELECT 
    strftime('%Y-%m', v.fecha) AS mes,

    COUNT(v.id) AS total_transacciones,

    SUM(v.cantidad * v.precio) AS ingresos_totales

FROM ventas v

GROUP BY mes
ORDER BY mes;