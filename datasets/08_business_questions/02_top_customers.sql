-- Top customers by total revenue

SELECT
    c.id_cliente,
    c.nombre,
    SUM(v.cantidad * v.precio) AS total_revenue
FROM ventas v
JOIN clientes c
ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre
ORDER BY total_revenue DESC;