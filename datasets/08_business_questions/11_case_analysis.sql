-- Case analysis by primary concern

SELECT 
    primary_concern,
    COUNT(*) AS total_cases
FROM ventas  -- simula tu CRM
GROUP BY primary_concern
ORDER BY total_cases DESC;