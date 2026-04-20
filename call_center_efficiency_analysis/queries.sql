-- KPI GENERAL

SELECT 
    COUNT(*) AS total_calls,

    SUM(CASE WHEN call_status = 'completed' THEN 1 ELSE 0 END) AS completed_calls,

    SUM(CASE WHEN call_status = 'missed' THEN 1 ELSE 0 END) AS missed_calls,

    ROUND(AVG(call_duration), 2) AS avg_call_duration,

    ROUND(AVG(wait_time), 2) AS avg_wait_time,

    SUM(sale_amount) AS total_revenue,

    ROUND(SUM(converted) * 1.0 / COUNT(*), 4) AS conversion_rate

FROM calls;