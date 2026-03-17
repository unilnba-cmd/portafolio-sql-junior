CASE 
    WHEN SUM(cantidad * precio) > 1000 THEN 'High Value'
    WHEN SUM(cantidad * precio) > 500 THEN 'Medium Value'
    ELSE 'Low Value'
END AS customer_segment