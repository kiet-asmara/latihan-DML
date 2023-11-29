-- 1. Bulk Data Insertion
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT
);

INSERT INTO products(product_id, product_name, quantity)
VALUES
    (1, 'Product A', 100),
    (2, 'Product B', 150),
    (3, 'Product C', 200),
    (4, 'Product D', 50),
    (5, 'Product E', 300),
    (6, 'Product Z', 0);

-- 2. Data Update with SubQuery
UPDATE employees
SET salary = salary * 1.10
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE name = "Finance"
);

-- 3. Deleting Records with a Condition from Another Table
DELETE FROM products
WHERE quantity = 0;

-- 4. Conditional Insertion
INSERT INTO students(student_id, student_name, marks)
SELECT 102, 'Jane Doe', 85
WHERE NOT EXISTS (
    SELECT 1
    FROM students
    WHERE student_name = 'Jane Doe'
);

-- 5. Data Update with Join and Aggregation
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    total_price int
);

CREATE TABLE items (
    item_id INT PRIMARY KEY,
    item_price int
);
CREATE TABLE order_items (
    order_id INT,
    item_id INT,
    total_price INT,
	FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);
INSERT INTO items(item_id, item_price)
VALUES
	(1, 200),
    (2, 300),
    (3, 400),
    (4, 500),
    (5, 600);

INSERT INTO orders(order_id)
VALUES
    (1), (2),(3), (4);

INSERT INTO order_items(order_id, item_id, total_price)
VALUES
    (1,1, 200),
    (1,3, 400),
    (1,5, 600),
    (2,1, 200),
    (2,2, 300),
    (2,4, 500),
    (3,2, 300),
    (3,3, 400),
    (4,1, 200),
    (4,5, 600);


UPDATE orders
SET total_price = (
    SELECT SUM(total_price)
    FROM order_items
    WHERE order_items.order_id = orders.order_id
)

-- 6. Soft Delete
ALTER TABLE employees
ADD left_company BOOLEAN DEFAULT false;

ALTER TABLE employees
ADD is_deleted BOOLEAN DEFAULT false;

UPDATE employees
SET is_deleted = true
WHERE left_company = true;

-- 7.  Bulk Update with CASE Statement
ALTER TABLE products
ADD unit_price int DEFAULT 1000;

UPDATE products
SET unit_price = CASE
    WHEN quantity > 100 THEN unit_price * 1.05
    ELSE unit_price * 1.10
END;

-- 8. Data De-duplication
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    email VARCHAR(100)
);

INSERT INTO customers(customer_id, email)
VALUES
	(1, "example@gmail.com"),
    (2, "example@gmail.com"),
    (3, "example2@gmail.com"),
    (4, "example2@gmail.com"),
    (5, "example3@gmail.com"),
    (6, "example3@gmail.com");

DELETE c1
FROM customers c1
JOIN customers c2
ON c1.email = c2.email AND c1.customer_id > c2.customer_id;