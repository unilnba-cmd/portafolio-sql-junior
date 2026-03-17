-- KPI summary for business

SELECT 
    COUNT(DISTINCT id_cliente) AS total_customers,
    COUNT(id_venta) AS total_orders,
    SUM(cantidad * precio) AS total_revenue
FROM ventas;