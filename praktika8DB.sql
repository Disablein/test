-- Удаляем таблицы, если они существуют, чтобы избежать ошибок при повторном выполнении
DROP TABLE IF EXISTS Order_Items;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- Создание таблицы Покупателей
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    recommended_by INT,
    FOREIGN KEY (recommended_by) REFERENCES Customers(customer_id)
);

-- Создание таблицы Товаров
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Создание таблицы Заказов
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Создание таблицы Состава Заказа
CREATE TABLE Order_Items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Задание 1
SELECT Customers.full_name, Orders.order_date
FROM Orders
INNER JOIN Customers ON Orders.customer_id = Customers.customer_id;


-- Задание 2
SELECT Customers.full_name
FROM Customers
LEFT JOIN Orders ON Customers.customer_id = Orders.customer_id
WHERE Orders.order_id IS NULL;


-- Задание 3
SELECT Products.product_name, Order_Items.quantity, Order_Items.price_per_unit
FROM Order_Items
JOIN Products ON Order_Items.product_id = Products.product_id
WHERE Order_Items.order_id = 1;


-- Задание 4
SELECT Customers.full_name
FROM Customers
WHERE Customers.customer_id IN (
    SELECT Orders.customer_id
    FROM Orders
    JOIN Order_Items ON Orders.order_id = Order_Items.order_id
    JOIN Products ON Order_Items.product_id = Products.product_id
    WHERE Products.product_name = 'Смартфон'
);


-- Задание 5
SELECT Products.product_name, Products.price
FROM Products
WHERE Products.price > (SELECT AVG(Products.price) FROM Products);


-- Задание 6
SELECT Orders.order_id, Orders.order_date
FROM Orders
WHERE EXISTS (
    SELECT 1
    FROM Order_Items
    JOIN Products ON Order_Items.product_id = Products.product_id
    WHERE Order_Items.order_id = Orders.order_id AND Products.price > 100000
);


-- Задание 7
--LEFT JOIN
SELECT Customers.full_name
FROM Customers
LEFT JOIN Orders ON Customers.customer_id = Orders.customer_id
LEFT JOIN Order_Items ON Orders.order_id = Order_Items.order_id
LEFT JOIN Products ON Order_Items.product_id = Products.product_id 
                  AND Products.product_name = 'Ноутбук'
WHERE Products.product_id IS NULL;

--NOT IN
SELECT Customers.full_name
FROM Customers
WHERE Customers.customer_id NOT IN (
    SELECT Orders.customer_id
    FROM Orders
    JOIN Order_Items ON Orders.order_id = Order_Items.order_id
    JOIN Products ON Order_Items.product_id = Products.product_id
    WHERE Products.product_name = 'Ноутбук'
);


-- Задание 8
SELECT Products.product_name
FROM Order_Items
RIGHT JOIN Products ON Order_Items.product_id = Products.product_id
WHERE Order_Items.order_item_id IS NULL;


-- Задание 9
SELECT Customers.full_name, Products.product_name, Order_Items.quantity
FROM Customers
FULL OUTER JOIN Orders ON Customers.customer_id = Orders.customer_id
FULL OUTER JOIN Order_Items ON Orders.order_id = Order_Items.order_id
FULL OUTER JOIN Products ON Order_Items.product_id = Products.product_id;


-- Задание 10
--JOIN с подзапросом
SELECT DISTINCT Customers.full_name
FROM Customers
JOIN Orders ON Customers.customer_id = Orders.customer_id
JOIN Order_Items ON Orders.order_id = Order_Items.order_id
JOIN Products ON Order_Items.product_id = Products.product_id
WHERE Products.price = (SELECT MAX(Products.price) FROM Products);

--Только подзапросы
SELECT Customers.full_name
FROM Customers
WHERE Customers.customer_id IN (
    SELECT Orders.customer_id 
    FROM Orders 
    WHERE Orders.order_id IN (
        SELECT Order_Items.order_id 
        FROM Order_Items 
        WHERE Order_Items.product_id IN (
            SELECT Products.product_id 
            FROM Products 
            WHERE Products.price = (SELECT MAX(Products.price) FROM Products)
        )
    )
);


-- Задание 11
SELECT Customers.full_name, Unique_Categories.category
FROM Customers
CROSS JOIN (SELECT DISTINCT Products.category FROM Products) AS Unique_Categories;


-- Задание 12
SELECT New_Customer.full_name AS new_customer, 
       Recommender.full_name AS recommended_by
FROM Customers AS New_Customer
JOIN Customers AS Recommender ON New_Customer.recommended_by = Recommender.customer_id;
