-- Fundamental SQL Queries
-- Basic SELECT statements, filtering, and sorting

-- 1. View all customers
-- Shows basic SELECT statement
SELECT * FROM customers;

-- 2. View specific columns
-- Demonstrates column selection
SELECT first_name, last_name, email FROM customers;

-- 3. Filter customers by state
-- Shows WHERE clause usage
SELECT first_name, last_name, city, state 
FROM customers 
WHERE state = 'CA';

-- 4. Sort customers by registration date
-- Demonstrates ORDER BY
SELECT first_name, last_name, registration_date 
FROM customers 
ORDER BY registration_date;

-- 5. Find products under $30
-- Shows numeric filtering
SELECT product_name, price 
FROM products 
WHERE price < 30.00
ORDER BY price;

-- 6. Search for products containing 'book'
-- Demonstrates LIKE operator
SELECT product_name, price 
FROM products 
WHERE product_name LIKE '%book%';

-- 7. Find customers registered in 2023
-- Shows date filtering
SELECT first_name, last_name, registration_date 
FROM customers 
WHERE registration_date >= '2023-01-01' 
  AND registration_date < '2024-01-01';

-- 8. Get top 5 most expensive products
-- Combines ORDER BY with LIMIT
SELECT product_name, price 
FROM products 
ORDER BY price DESC 
LIMIT 5;

-- 9. Find sales in April 2023
-- Date range filtering
SELECT sale_id, customer_id, product_id, sale_date, total_amount 
FROM sales 
WHERE sale_date >= '2023-04-01' 
  AND sale_date < '2023-05-01'
ORDER BY sale_date;

-- 10. Count total number of customers
-- Basic COUNT function
SELECT COUNT(*) as total_customers FROM customers;