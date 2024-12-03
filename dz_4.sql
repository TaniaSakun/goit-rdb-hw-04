-- Task 1 Create a database for the book library
CREATE DATABASE LibraryManagement;
USE LibraryManagement;

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year YEAR NOT NULL,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Task 2 Fill the tables with simple, fictional test data.
INSERT INTO authors (author_name) VALUES 
('J.K. Rowling'),
('George R.R. Martin');
SELECT * FROM authors;

INSERT INTO genres (genre_name) VALUES 
('Fantasy'),
('Science Fiction');
SELECT * FROM genres;

INSERT INTO books (title, publication_year, author_id, genre_id) VALUES 
('Harry Potter and the Philosopher\'s Stone', 1997, 1, 1),
('A Game of Thrones', 1996, 2, 1);
SELECT * FROM books;

INSERT INTO users (username, email) VALUES 
('john_doe', 'john@example.com'),
('jane_smith', 'jane@example.com');
SELECT * FROM users;

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES 
(1, 1, '2024-11-01', '2024-11-10'), (2, 2, '2024-11-15', NULL);
SELECT * FROM borrowed_books;

-- Task 3: Combine All Tables Using FROM and INNER JOIN
USE dz_3_Sakun;

SELECT *
FROM order_details od
INNER JOIN orders o ON od.order_id = o.id
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers s ON o.shipper_id = s.id
INNER JOIN suppliers sup ON p.supplier_id = sup.id;

-- Task 4 Run the queries
SELECT COUNT(*) AS row_count
FROM order_details od
INNER JOIN orders o ON od.order_id = o.id
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers s ON o.shipper_id = s.id
INNER JOIN suppliers sup ON p.supplier_id = sup.id;

SELECT COUNT(*) 
FROM orders
INNER JOIN order_details on orders.id = order_details.order_id
LEFT JOIN products on order_details.product_id = products.id
RIGHT JOIN customers on orders.customer_id = customers.id
LEFT JOIN categories on products.category_id = categories.id
LEFT JOIN suppliers on products.supplier_id = suppliers.id
LEFT JOIN employees on orders.employee_id = employees.employee_id
LEFT JOIN shippers on orders.shipper_id = shippers.id;

-- When performing various LEFT/RIGHT JOIN combinations, the total number of rows returned was 535, 
-- which is more than the number of products in all orders (records from the order_details table). 
-- This is because the customers table contains customers who did not place orders. Using a RIGHT JOIN 
-- on the customers table resulted in all records from this table being included in the result set, even 
-- those that did not have a match in other tables.

SELECT *
FROM employees
WHERE employee_id > 3 AND employee_id <= 10;

SELECT 
    cat.name AS category_name,
    COUNT(*) AS row_count,
    AVG(od.quantity) AS avg_quantity
FROM order_details od
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
GROUP BY cat.name;

SELECT 
    cat.name AS category_name,
    COUNT(*) AS row_count,
    AVG(od.quantity) AS avg_quantity
FROM order_details od
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
GROUP BY cat.name
HAVING AVG(od.quantity) > 21;

SELECT 
    cat.name AS category_name,
    COUNT(*) AS row_count,
    AVG(od.quantity) AS avg_quantity
FROM order_details od
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
GROUP BY cat.name
HAVING AVG(od.quantity) > 21
ORDER BY row_count DESC;

SELECT 
    cat.name AS category_name,
    COUNT(*) AS row_count,
    AVG(od.quantity) AS avg_quantity
FROM order_details od
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
GROUP BY cat.name
HAVING AVG(od.quantity) > 21
ORDER BY row_count DESC
LIMIT 4 OFFSET 1;