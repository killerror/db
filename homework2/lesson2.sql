/*
1. Используя операторы языка SQL, 
создайте таблицу “sales”. Заполните ее данными
*/
USE myfirstdb;

CREATE TABLE IF NOT EXISTS sales
(
id INT PRIMARY KEY AUTO_INCREMENT,
order_date DATE NOT NULL,
count_product INT NOT NULL);

INSERT INTO sales (order_date,count_product)
VALUES 
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);

SELECT * FROM sales;

/*
2.  Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва : 
меньше 100  -    Маленький заказ
от 100 до 300 - Средний заказ
больше 300  -     Большой заказ
*/
SELECT
id "id заказа",
IF(count_product < 100, "Маленький заказ",
	IF(count_product >= 100 AND count_product < 300, "Средний заказ",
		IF(count_product >= 300, "Большой заказ", "Неопределенно"))) AS "Тип заказа"
FROM sales;

/*
3. Создайте таблицу “orders”, заполните ее значениями
*/
CREATE TABLE IF NOT EXISTS orders
(
id INT PRIMARY KEY AUTO_INCREMENT,
employee_id VARCHAR(6) NOT NULL,
amount DOUBLE NOT NULL,
order_status VARCHAR(10) NOT NULL);

INSERT INTO orders (employee_id, amount, order_status)
VALUES 
('e03', 15.00, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED');

SELECT id, employee_id, amount,
	CASE 
		WHEN order_status = 'OPEN' THEN "Order is in open state"
        WHEN order_status = 'CLOSED' THEN "Order is closed"
        WHEN order_status = 'CANCELLED' THEN "Order is cancelled"
        ELSE "Ошибка. Статус не ясен."
	END full_order_status
FROM orders;
