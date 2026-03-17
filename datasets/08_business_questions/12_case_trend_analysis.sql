-- Case trend analysis (monthly)

SELECT 
    DATE_FORMAT(fecha, '%Y-%m') AS month,
    COUNT(*) AS total_cases
FROM ventas
GROUP BY DATE_FORMAT(fecha, '%Y-%m')
ORDER BY month;