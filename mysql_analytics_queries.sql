-- ====================================================================
-- E-commerce Analytics & Conversion Analysis (MySQL)
-- Target Database Schema: E-commerce Marketing Analytics
-- ====================================================================

-- Query 1: Daily Conversion Rate & Funnel Performance
SELECT 
    event_date,
    COUNT(DISTINCT user_id) AS total_users,
    SUM(CASE WHEN event_name = 'view_item' THEN 1 ELSE 0 END) AS item_views,
    SUM(CASE WHEN event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS cart_adds,
    SUM(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS total_purchases,
    ROUND(SUM(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) / COUNT(DISTINCT user_id) * 100, 2) AS conversion_rate_pct
FROM 
    ecommerce_events
GROUP BY 
    event_date
ORDER BY 
    event_date DESC;

-- Query 2: Traffic Source & Medium Revenue Analysis
SELECT 
    source,
    medium,
    COUNT(DISTINCT user_id) AS total_users,
    SUM(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS purchases,
    ROUND(SUM(purchase_revenue), 2) AS total_revenue_usd
FROM 
    ecommerce_events
GROUP BY 
    source, medium
ORDER BY 
    total_revenue_usd DESC;
