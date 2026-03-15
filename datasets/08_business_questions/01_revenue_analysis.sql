SELECT 
    p.nombre AS producto,
    SUM(v.cantidad * v.precio) AS revenue_total
FROM datasets.ventas v
JOIN datasets.productos p
ON v.id_producto = p.id_producto
GROUP BY p.nombre
ORDER BY revenue_total DESC;