-- Top 3 customers by revenue

SELECT 
    customer_id,
    SUM(amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(amount) DESC) AS revenue_rank
FROM orders
GROUP BY customer_id
ORDER BY total_revenue DESC
LIMIT 3;