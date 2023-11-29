CREATE DATABASE tasty_bites;

CREATE TABLE Employees (
	employee_id int PRIMARY KEY,
    first_name varchar(50),
    last_name varchar(50),
    position varchar(50)
);

CREATE TABLE MenuItems (
	item_id int PRIMARY KEY,
    name varchar(50),
    description TEXT,
    price decimal(10,2),
    category varchar(50)
);

CREATE TABLE Orders (
	order_id int PRIMARY KEY,
    table_number int,
    employee_id int,
    order_date DATE,
    status varchar(50),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE OrderItems (
	order_item_id int PRIMARY KEY,
    order_id int,
    item_id int,
    quantity int,
    subtotal decimal(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES menuitems(item_id)
);

CREATE TABLE Payments (
	payment_id int PRIMARY KEY,
    order_id int,
    payment_date DATE,
    payment_method varchar(50),
    total_amount decimal(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


INSERT INTO employees (employee_id, first_name, last_name, position)
VALUES (1, 'John', 'Doe', 'Waiter');

INSERT INTO MenuItems (item_id,name,description,price,category)
VALUES (1,'Steak','Grilled sirloin steak', 25.99, 'Main Course');

INSERT INTO Orders (order_id, table_number, employee_id, order_date, status)
VALUES (1, 5, 1, '2023-08-04', 'Pending');

INSERT INTO OrdersItems (order_item_id, order_id, item_id, quantity, subtotal)
VALUES (1, 1,1,2,51.98);

INSERT INTO Payments (payment_id, order_id, payment_date, payment_method,total_amount)
VALUES (1, 1, '2023-08-04', 'Credit Card', 51.98);