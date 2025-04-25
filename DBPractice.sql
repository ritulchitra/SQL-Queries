CREATE DATABASE IF NOT EXISTS db;
USE db;


CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    city VARCHAR(50),
    country VARCHAR(50)
);


CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);


CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO customers (first_name, last_name, email, phone_number, city, country)
VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', 'New York', 'USA'),
('Jane', 'Smith', 'jane.smith@example.com', '9876543210', 'Los Angeles', 'USA'),
('Ajay','Kumar','ajay@gmail.com','8987867656','Mumbai','India'),
('Rahul','Gaur','rahul@gmail.com','78678898765','Mumbai','India'),
('Janny', 'Smith', 'janny.smith@example.com', '9876543786', 'Los Angeles', 'USA');


INSERT INTO products (product_name, category, price, stock_quantity)
VALUES
('Laptop', 'Electronics', 799.99, 50),
('Smartphone', 'Electronics', 499.99, 100),
('TV','Electronics',399.93,45);


INSERT INTO orders (customer_id, order_date, total_amount)
VALUES
(1, '2025-04-01', 799.99),
(2, '2025-04-02', 499.99),
(3,'2025-04-09',499.99);


INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 799.99),
(2, 2, 1, 499.99),
(3,2,3,499.99);

select * from customers;

SELECT customer_id, first_name, last_name, email, city
FROM customers
WHERE country = 'USA'
ORDER BY last_name;


SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;



SELECT o.order_id, c.first_name, c.last_name, o.order_date, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;




SELECT c.first_name, c.last_name, o.order_id, o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;


SELECT o.order_id, o.order_date, c.first_name, c.last_name
FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.customer_id;



SELECT first_name, last_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
);



SELECT product_name, price
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);


SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;


SELECT category, AVG(price) AS average_price
FROM products
GROUP BY category;


CREATE VIEW customer_orders_view AS
SELECT c.first_name, c.last_name, o.order_id, o.order_date, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;


SELECT * FROM customer_orders_view;


CREATE VIEW product_sales_view AS
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name;


SELECT * FROM product_sales_view;



CREATE INDEX idx_email ON customers(email);


CREATE INDEX idx_order_date ON orders(order_date);


select * from customers	;

SELECT customer_id, email FROM customers WHERE email = 'john.doe@example.com';


