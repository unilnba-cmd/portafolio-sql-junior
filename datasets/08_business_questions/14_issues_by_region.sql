-- Top issue per region (advanced)

SELECT *
FROM (
    SELECT 
        region,
        primary_concern,
        COUNT(*) AS total_cases,
        RANK() OVER (PARTITION BY region ORDER BY COUNT(*) DESC) AS rank
    FROM ventas
    GROUP BY region, primary_concern
) t
WHERE rank = 1;