-- Cases by region and interaction channel

SELECT 
    region,
    canal,
    COUNT(*) AS total_cases
FROM ventas
GROUP BY region, canal
ORDER BY total_cases DESC;