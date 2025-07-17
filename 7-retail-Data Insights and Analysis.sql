-- Data Insights and Analysis
-- Practical business questions answered with SQL

-- 1. Which day of the week has the highest sales?
-- Day-of-week analysis
SELECT 
    DAYNAME(sale_date) as day_of_week,
    DAYOFWEEK(sale_date) as day_number,
    COUNT(*) as total_sales,
    SUM(total_amount) as total_revenue,
    AVG(total_amount) as avg_transaction_value
FROM sales 
GROUP BY DAYNAME(sale_date), DAYOFWEEK(sale_date)
ORDER BY total_revenue DESC;

-- 2. What's the average time between customer registration and first purchase?
-- Customer behavior analysis
SELECT 
    AVG(DATEDIFF(first_purchase_date, registration_date)) as avg_days_to_first_purchase,
    MIN(DATEDIFF(first_purchase_date, registration_date)) as min_days,
    MAX(DATEDIFF(first_purchase_date, registration_date)) as max_days
FROM (
    SELECT 
        c.customer_id,
        c.registration_date,
        MIN(s.sale_date) as first_purchase_date
    FROM customers c
    INNER JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.registration_date
) customer_first_purchase;

-- 3. Which products are frequently bought together?
-- Basic market basket analysis
SELECT 
    p1.product_name as product_1,
    p2.product_name as product_2,
    COUNT(*) as times_bought_together
FROM sales s1
INNER JOIN sales s2 ON s1.customer_id = s2.customer_id 
    AND s1.sale_date = s2.sale_date 
    AND s1.product_id < s2.product_id
INNER JOIN products p1 ON s1.product_id = p1.product_id
INNER JOIN products p2 ON s2.product_id = p2.product_id
GROUP BY p1.product_name, p2.product_name
HAVING COUNT(*) > 1
ORDER BY times_bought_together DESC;

-- 4. Customer loyalty analysis - repeat customers
-- Identify loyal customers
SELECT 
    c.first_name,
    c.last_name,
    c.registration_date,
    COUNT(s.sale_id) as total_purchases,
    SUM(s.total_amount) as total_spent,
    MIN(s.sale_date) as first_purchase,
    MAX(s.sale_date) as last_purchase,
    DATEDIFF(MAX(s.sale_date), MIN(s.sale_date)) as customer_lifespan_days
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.registration_date
HAVING COUNT(s.sale_id) > 1
ORDER BY total_purchases DESC, total_spent DESC;

-- 5. Seasonal trends - which months are best for sales?
-- Seasonal analysis
SELECT 
    MONTH(sale_date) as month_number,
    MONTHNAME(sale_date) as month_name,
    COUNT(*) as total_sales,
    SUM(total_amount) as total_revenue,
    AVG(total_amount) as avg_transaction_value
FROM sales 
GROUP BY MONTH(sale_date), MONTHNAME(sale_date)
ORDER BY total_revenue DESC;

-- 6. Price sensitivity analysis
-- How do different price ranges perform?
SELECT 
    CASE 
        WHEN p.price < 20 THEN 'Under $20'
        WHEN p.price < 50 THEN '$20 - $49'
        WHEN p.price < 100 THEN '$50 - $99'
        ELSE '$100+'
    END as price_range,
    COUNT(s.sale_id) as total_sales,
    SUM(s.total_amount) as total_revenue,
    AVG(s.total_amount) as avg_sale_amount,
    COUNT(DISTINCT s.customer_id) as unique_customers
FROM products p
INNER JOIN sales s ON p.product_id = s.product_id
GROUP BY price_range
ORDER BY total_revenue DESC;

-- 7. Customer geographic distribution and performance
-- Geographic insights
SELECT 
    c.state,
    COUNT(DISTINCT c.customer_id) as total_customers,
    COUNT(s.sale_id) as total_sales,
    SUM(s.total_amount) as total_revenue,
    AVG(s.total_amount) as avg_transaction_value,
    SUM(s.total_amount) / COUNT(DISTINCT c.customer_id) as revenue_per_customer
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.state
HAVING total_sales > 0
ORDER BY revenue_per_customer DESC;

-- 8. Product category preferences by customer demographics
-- Category analysis by state
SELECT 
    c.state,
    cat.category_name,
    COUNT(s.sale_id) as sales_count,
    SUM(s.total_amount) as category_revenue,
    ROUND(SUM(s.total_amount) / SUM(SUM(s.total_amount)) OVER (PARTITION BY c.state) * 100, 2) as percentage_of_state_revenue
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
INNER JOIN products p ON s.product_id = p.product_id
INNER JOIN categories cat ON p.category_id = cat.category_id
GROUP BY c.state, cat.category_name
ORDER BY c.state, category_revenue DESC;

-- 9. Customer purchase frequency analysis
-- How often do customers buy?
SELECT 
    purchase_frequency,
    COUNT(*) as customer_count,
    AVG(total_spent) as avg_total_spent
FROM (
    SELECT 
        c.customer_id,
        COUNT(s.sale_id) as purchase_frequency,
        SUM(s.total_amount) as total_spent
    FROM customers c
    LEFT JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id
) customer_frequency
GROUP BY purchase_frequency
ORDER BY purchase_frequency;

-- 10. Revenue growth analysis
-- Month-over-month growth
SELECT 
    year_month,
    monthly_revenue,
    LAG(monthly_revenue) OVER (ORDER BY year_month) as previous_month_revenue,
    monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY year_month) as revenue_change,
    CASE 
        WHEN LAG(monthly_revenue) OVER (ORDER BY year_month) > 0 THEN
            ROUND(((monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY year_month)) / 
                   LAG(monthly_revenue) OVER (ORDER BY year_month)) * 100, 2)
        ELSE NULL
    END as growth_percentage
FROM (
    SELECT 
        DATE_FORMAT(sale_date, '%Y-%m') as year_month,
        SUM(total_amount) as monthly_revenue
    FROM sales 
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
) monthly_data
ORDER BY year_month;