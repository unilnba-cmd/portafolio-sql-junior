-- Customer retention analysis

SELECT 
    id_cliente,
    COUNT(DISTINCT DATE_FORMAT(fecha, '%Y-%m')) AS active_months
FROM ventas
GROUP BY id_cliente
HAVING COUNT(DISTINCT DATE_FORMAT(fecha, '%Y-%m')) > 1
ORDER BY active_months DESC;