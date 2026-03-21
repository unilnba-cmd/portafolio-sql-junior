-- Revenue Analysis by Date
-- Calculates daily revenue metrics including total sales, average ticket, and extremes

SELECT 
    DATE(v.fecha) AS fecha,

    COUNT(v.id) AS total_transacciones,

    SUM(v.cantidad * v.precio) AS ingresos_totales,

    AVG(v.cantidad * v.precio) AS ticket_promedio,

    MAX(v.cantidad * v.precio) AS venta_maxima,

    MIN(v.cantidad * v.precio) AS venta_minima

FROM ventas v

GROUP BY DATE(v.fecha)

ORDER BY fecha;