-- Data for Retail Analysis Project

USE retail_analysis;

-- Insert categories
INSERT INTO categories (category_id, category_name, description) VALUES
(1, 'Electronics', 'Electronic devices and gadgets'),
(2, 'Clothing', 'Apparel and fashion items'),
(3, 'Books', 'Books and educational materials'),
(4, 'Home & Garden', 'Home improvement and garden items'),
(5, 'Sports', 'Sports and fitness equipment');

-- Insert customers
INSERT INTO customers (customer_id, first_name, last_name, email, city, state, registration_date) VALUES
(1, 'John', 'Smith', 'john.smith@email.com', 'New York', 'NY', '2023-01-15'),
(2, 'Sarah', 'Johnson', 'sarah.j@email.com', 'Los Angeles', 'CA', '2023-01-20'),
(3, 'Mike', 'Brown', 'mike.brown@email.com', 'Chicago', 'IL', '2023-02-01'),
(4, 'Emily', 'Davis', 'emily.davis@email.com', 'Houston', 'TX', '2023-02-10'),
(5, 'David', 'Wilson', 'david.w@email.com', 'Phoenix', 'AZ', '2023-02-15'),
(6, 'Lisa', 'Miller', 'lisa.miller@email.com', 'Philadelphia', 'PA', '2023-03-01'),
(7, 'James', 'Garcia', 'james.garcia@email.com', 'San Antonio', 'TX', '2023-03-05'),
(8, 'Maria', 'Rodriguez', 'maria.r@email.com', 'San Diego', 'CA', '2023-03-10'),
(9, 'Robert', 'Martinez', 'robert.m@email.com', 'Dallas', 'TX', '2023-03-15'),
(10, 'Jennifer', 'Anderson', 'jennifer.a@email.com', 'San Jose', 'CA', '2023-03-20');

-- Insert products
INSERT INTO products (product_id, product_name, category_id, price, cost) VALUES
(1, 'Wireless Headphones', 1, 99.99, 45.00),
(2, 'Smartphone Case', 1, 24.99, 8.00),
(3, 'T-Shirt', 2, 19.99, 7.00),
(4, 'Jeans', 2, 49.99, 20.00),
(5, 'Novel Book', 3, 14.99, 6.00),
(6, 'Cookbook', 3, 29.99, 12.00),
(7, 'Garden Tools', 4, 39.99, 18.00),
(8, 'Plant Pot', 4, 12.99, 5.00),
(9, 'Basketball', 5, 34.99, 15.00),
(10, 'Yoga Mat', 5, 24.99, 10.00),
(11, 'Laptop Stand', 1, 59.99, 25.00),
(12, 'Winter Jacket', 2, 89.99, 35.00),
(13, 'Study Guide', 3, 22.99, 9.00),
(14, 'LED Light', 4, 16.99, 7.00),
(15, 'Tennis Racket', 5, 79.99, 30.00);

-- Insert sales data
INSERT INTO sales (sale_id, customer_id, product_id, sale_date, quantity, total_amount) VALUES
(1, 1, 1, '2023-04-01', 1, 99.99),
(2, 1, 2, '2023-04-01', 2, 49.98),
(3, 2, 3, '2023-04-02', 3, 59.97),
(4, 3, 4, '2023-04-03', 1, 49.99),
(5, 4, 5, '2023-04-04', 2, 29.98),
(6, 5, 6, '2023-04-05', 1, 29.99),
(7, 6, 7, '2023-04-06', 1, 39.99),
(8, 7, 8, '2023-04-07', 3, 38.97),
(9, 8, 9, '2023-04-08', 1, 34.99),
(10, 9, 10, '2023-04-09', 2, 49.98),
(11, 10, 11, '2023-04-10', 1, 59.99),
(12, 1, 12, '2023-04-11', 1, 89.99),
(13, 2, 13, '2023-04-12', 1, 22.99),
(14, 3, 14, '2023-04-13', 2, 33.98),
(15, 4, 15, '2023-04-14', 1, 79.99),
(16, 5, 1, '2023-04-15', 1, 99.99),
(17, 6, 3, '2023-04-16', 2, 39.98),
(18, 7, 5, '2023-04-17', 1, 14.99),
(19, 8, 7, '2023-04-18', 1, 39.99),
(20, 9, 9, '2023-04-19', 1, 34.99),
(21, 10, 2, '2023-04-20', 3, 74.97),
(22, 1, 4, '2023-05-01', 1, 49.99),
(23, 2, 6, '2023-05-02', 1, 29.99),
(24, 3, 8, '2023-05-03', 2, 25.98),
(25, 4, 10, '2023-05-04', 1, 24.99),
(26, 5, 12, '2023-05-05', 1, 89.99),
(27, 6, 14, '2023-05-06', 1, 16.99),
(28, 7, 1, '2023-05-07', 1, 99.99),
(29, 8, 3, '2023-05-08', 1, 19.99),
(30, 9, 5, '2023-05-09', 2, 29.98);
