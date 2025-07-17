-- Aggregation and Grouping Queries
-- GROUP BY, COUNT, SUM, AVG functions

-- 1. Count customers by state
-- Basic GROUP BY with COUNT
SELECT state, COUNT(*) as customer_count 
FROM customers 
GROUP BY state 
ORDER BY customer_count DESC;

-- 2. Total sales by month
-- Date functions with GROUP BY
SELECT 
    YEAR(sale_date) as year,
    MONTH(sale_date) as month,
    COUNT(*) as number_of_sales,
    SUM(total_amount) as total_revenue
FROM sales 
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year, month;

-- 3. Average product price by category
-- JOIN with aggregation
SELECT 
    c.category_name,
    COUNT(p.product_id) as product_count,
    AVG(p.price) as average_price,
    MIN(p.price) as lowest_price,
    MAX(p.price) as highest_price
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY average_price DESC;

-- 4. Customer purchase summary
-- Multiple aggregations per customer
SELECT 
    c.first_name,
    c.last_name,
    COUNT(s.sale_id) as total_purchases,
    SUM(s.total_amount) as total_spent,
    AVG(s.total_amount) as average_order_value
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- 5. Product sales performance
-- Product-level aggregation
SELECT 
    p.product_name,
    COUNT(s.sale_id) as times_sold,
    SUM(s.quantity) as total_quantity_sold,
    SUM(s.total_amount) as total_revenue
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;

-- 6. Daily sales summary
-- Daily aggregation
SELECT 
    sale_date,
    COUNT(*) as number_of_sales,
    SUM(total_amount) as daily_revenue,
    AVG(total_amount) as average_sale_amount
FROM sales 
GROUP BY sale_date
ORDER BY sale_date;

-- 7. Category sales performance
-- Category-level analysis
SELECT 
    c.category_name,
    COUNT(s.sale_id) as total_sales,
    SUM(s.total_amount) as total_revenue,
    AVG(s.total_amount) as average_sale_amount
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN sales s ON p.product_id = s.product_id
GROUP BY c.category_id, c.category_name
ORDER BY total_revenue DESC;

-- 8. Find customers with more than 2 purchases
-- HAVING clause usage
SELECT 
    c.first_name,
    c.last_name,
    COUNT(s.sale_id) as purchase_count,
    SUM(s.total_amount) as total_spent
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(s.sale_id) > 2
ORDER BY purchase_count DESC;

-- 9. Monthly revenue growth
-- Period comparison
SELECT 
    YEAR(sale_date) as year,
    MONTH(sale_date) as month,
    SUM(total_amount) as monthly_revenue
FROM sales 
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year, month;

-- 10. Top spending customers
-- Customer ranking by spending
SELECT 
    c.first_name,
    c.last_name,
    c.city,
    c.state,
    SUM(s.total_amount) as total_spent
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city, c.state
ORDER BY total_spent DESC
LIMIT 5;