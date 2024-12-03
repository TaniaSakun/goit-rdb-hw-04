# goit-rdb-hw-04
The repository for the 4th GoItNeo Relational Databases homework

### 1. Create a database for the book library according to the structure below. Use DDL commands to create the necessary tables and their relationships.
**Database Structure**

a) Schema Name—"LibraryManagement”
```
CREATE DATABASE LibraryManagement;
USE LibraryManagement;
```

b) Table "authors":
author_id (INT, auto-incrementing PRIMARY KEY)
author_name (VARCHAR)
```
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);
```

c) Table "genres":
genre_id (INT, auto-incrementing PRIMARY KEY)
genre_name (VARCHAR)
```
CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);
```

d) Table "books":
book_id (INT, auto-incrementing PRIMARY KEY)
title (VARCHAR)
publication_year (YEAR)
author_id (INT, FOREIGN KEY relationship with "Authors")
genre_id (INT, FOREIGN KEY relationship with "Genres")
```
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year YEAR NOT NULL,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);
```

e) Table "users":
user_id (INT, auto-incrementing PRIMARY KEY)
username (VARCHAR)
email (VARCHAR)
```
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);
```

f) Table "borrowed_books":
borrow_id (INT, auto-incrementing PRIMARY KEY)
book_id (INT, FOREIGN KEY relationship from "Books")
user_id (INT, FOREIGN KEY relation to "Users")
borrow_date (DATE)
return_date (DATE)
```
CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```
<img width="664" alt="p1" src="https://github.com/user-attachments/assets/f44226fb-ba6b-4e26-b88f-48602d15b502">

### 2. Fill the tables with simple, fictional test data. One or two rows per table are enough.
```
INSERT INTO authors (author_name) VALUES 
('J.K. Rowling'),
('George R.R. Martin');
SELECT * FROM authors;
```
<img width="437" alt="p2_authors" src="https://github.com/user-attachments/assets/7ecf2665-1757-4fe4-baa7-46f8d8a18ae4">

```
INSERT INTO genres (genre_name) VALUES 
('Fantasy'),
('Science Fiction');
SELECT * FROM genres;
```
<img width="480" alt="p2_genres" src="https://github.com/user-attachments/assets/488d4d02-7717-493e-ae1d-25826ce0baea">

```
INSERT INTO books (title, publication_year, author_id, genre_id) VALUES 
('Harry Potter and the Philosopher\'s Stone', 1997, 1, 1),
('A Game of Thrones', 1996, 2, 1);
SELECT * FROM books;
```
<img width="679" alt="p2_books" src="https://github.com/user-attachments/assets/9cf68f16-a371-4b56-99b1-9d6b04ca1e33">

```
INSERT INTO users (username, email) VALUES 
('john_doe', 'john@example.com'),
('jane_smith', 'jane@example.com');
SELECT * FROM users;
```
<img width="572" alt="p2_users" src="https://github.com/user-attachments/assets/f359066e-a56e-4aa4-b6e1-ac0e75279545">

```
INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES 
(1, 1, '2024-11-01', '2024-11-10'), (2, 2, '2024-11-15', NULL);
SELECT * FROM borrowed_books;
```
<img width="583" alt="p2_borrowed_books" src="https://github.com/user-attachments/assets/25db6069-5b21-4ee1-a859-19a49dd1d61e">


Go to the database you worked with on the topic.
### 3. Write a query using the FROM and INNER JOIN operators that joins all the data tables we loaded from the files: order_details, orders, customers, products, categories, employees, shippers, and suppliers. To do this, you need to find common keys.
Check that the query is executed correctly.
```
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
```
<img width="1210" alt="p3" src="https://github.com/user-attachments/assets/cb478a93-c2ba-44b9-984b-06b931db9f31">

### 4. Run the queries listed below.

1. Determine how many rows you got (using the COUNT operator).
```
SELECT COUNT(*) AS row_count
FROM order_details od
INNER JOIN orders o ON od.order_id = o.id
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers s ON o.shipper_id = s.id
INNER JOIN suppliers sup ON p.supplier_id = sup.id;
```
<img width="462" alt="p4_1_count" src="https://github.com/user-attachments/assets/03da3644-bde8-4cf9-b580-feabe0c1bd07">


2. Change several INNER operators to LEFT or RIGHT. Determine what happens to the number of rows. Why? Write the answer in a text file.
```
SELECT COUNT(*) AS row_count
FROM order_details od
LEFT JOIN orders o ON od.order_id = o.id
LEFT JOIN customers c ON o.customer_id = c.id
LEFT JOIN products p ON od.product_id = p.id;
```
<img width="526" alt="p4_2_join_left_right" src="https://github.com/user-attachments/assets/e4623503-3869-4a1a-82c6-4f0472427774">

3. Select only those rows where employee_id > 3 and ≤ 10.
```
SELECT *
FROM employees
WHERE employee_id > 3 AND employee_id <= 10;
```
<img width="771" alt="p4_3_employee_id_3_10" src="https://github.com/user-attachments/assets/82f0b963-4147-4913-a0fa-e6a688b75bae">


4. Group by category name, count the number of rows in the group and determine the average quantity of the product (the amount of the product is in order_details.quantity)
```
SELECT 
    cat.name AS category_name,
    COUNT(*) AS row_count,
    AVG(od.quantity) AS avg_quantity
FROM order_details od
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
GROUP BY cat.name;
```
<img width="400" alt="p4_4_group_by_categories" src="https://github.com/user-attachments/assets/ca4ac40f-6d01-4ca3-a878-407964824209">

5. Filter out the rows where the average quantity of the product is greater than 21.
```
SELECT 
    cat.name AS category_name,
    COUNT(*) AS row_count,
    AVG(od.quantity) AS avg_quantity
FROM order_details od
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
GROUP BY cat.name
HAVING AVG(od.quantity) > 21;
```
<img width="414" alt="p4_5_avg_gt_21" src="https://github.com/user-attachments/assets/a369d1dd-74cb-41c5-b56a-0ca6e09b638b">

6. Sort the rows in descending order of the number of rows.
```
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
```
<img width="486" alt="p4_6_order" src="https://github.com/user-attachments/assets/1f30a2f2-5f1a-4b63-b3d1-c780e15d370a">

7. Display (select) four rows with the first row omitted.
```
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
```
<img width="416" alt="p4_7_limit_offset" src="https://github.com/user-attachments/assets/652d1d67-dd61-4987-88fc-279b142f3075">
