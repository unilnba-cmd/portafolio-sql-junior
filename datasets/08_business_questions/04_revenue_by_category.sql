-- Revenue by product category

SELECT
    p.categoria,
    SUM(v.cantidad * v.precio) AS total_revenue

FROM ventas v

JOIN productos p
ON v.id_producto = p.id_producto

GROUP BY
    p.categoria

ORDER BY
    total_revenue DESC;