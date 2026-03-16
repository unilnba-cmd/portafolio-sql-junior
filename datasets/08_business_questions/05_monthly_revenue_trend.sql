-- Monthly revenue trend

SELECT
    DATE_FORMAT(fecha, '%Y-%m') AS month,
    SUM(cantidad * precio) AS total_revenue

FROM ventas

GROUP BY
    DATE_FORMAT(fecha, '%Y-%m')

ORDER BY
    month;