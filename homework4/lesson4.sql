DROP DATABASE IF EXISTS `hw4`;
CREATE DATABASE IF NOT EXISTS `hw4`;
USE `hw4`;

DROP TABLE IF EXISTS `shops`;
CREATE TABLE `shops` (
	`id` INT,
    `shopname` VARCHAR (100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `cats`;
CREATE TABLE `cats` (
	`name` VARCHAR (100),
    `id` INT,
    PRIMARY KEY (id),
    shops_id INT,
    CONSTRAINT fk_cats_shops_id FOREIGN KEY (shops_id)
        REFERENCES `shops` (id)
);

INSERT INTO `shops`
VALUES 
		(1, "������ ����"),
        (2, "������ ���"),
        (3, "��������"),
        (4, "����� � ������");

INSERT INTO `cats`
VALUES 
		("Murzik",1,1),
        ("Nemo",2,2),
        ("Vicont",3,1),
        ("Zuza",4,3);
        
SELECT * FROM cats;
/*��������� JOIN-�, ��������� ��������� ��������:
1.������� ���� ������� �� ��������� �� id (������� ���������� shops.id = cats.shops_id)
2.������� �������, � ������� ��������� ��� ������� (���������� ��������� 2 ���������)
3.������� ��������, � ������� �� ��������� ���� ������� � �Zuza�
*/
-- 1
SELECT s.shopname, c.name 
FROM shops s 
JOIN cats c
ON s.id = c.shops_id;

-- 2
SELECT s.shopname, c.name 
FROM shops s 
JOIN cats c
ON s.id = c.shops_id
WHERE c.name="Murzik";

SELECT s.shopname, slim_cats.name
FROM shops s 
JOIN (SELECT shops_id, name FROM cats
WHERE name="Murzik") AS slim_cats
ON s.id = slim_cats.shops_id;

SELECT s.shopname, c.name 
FROM shops s, cats c
WHERE s.id = c.shops_id AND c.name="Murzik";

SELECT *
FROM shops s 
WHERE EXISTS (SELECT * FROM cats c
WHERE s.id = c.shops_id AND c.name="Murzik");

-- 3
SELECT s.id, s.shopname, c.name 
FROM shops s 
JOIN cats c
ON s.id = c.shops_id
WHERE c.name NOT IN ("Murzik","Zuza");

-- ��������� �������, �������:

DROP TABLE IF EXISTS Analysis;

CREATE TABLE Analysis
(
	an_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	an_name varchar(50),
	an_cost INT,
	an_price INT,
	an_group INT
);

INSERT INTO analysis (an_name, an_cost, an_price, an_group)
VALUES 
	('����� ������ �����', 30, 50, 1),
	('�������� �����', 150, 210, 1),
	('������ ����� �� �������', 110, 130, 1),
	('����� ������ ����', 25, 40, 2),
	('����� ������ ����', 35, 50, 2),
	('����� ������ ����', 25, 40, 2),
	('���� �� COVID-19', 160, 210, 3);

DROP TABLE IF EXISTS GroupsAn;

CREATE TABLE GroupsAn
(
	gr_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	gr_name varchar(50),
	gr_temp FLOAT(5,1),
	FOREIGN KEY (gr_id) REFERENCES Analysis (an_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO groupsan (gr_name, gr_temp)
VALUES 
	('������� �����', -12.2),
	('����� �������', -20.0),
	('���-�����������', -20.5);

SELECT * FROM groupsan;

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders
(
	ord_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	ord_datetime DATETIME,	-- 'YYYY-MM-DD hh:mm:ss'
	ord_an INT,
	FOREIGN KEY (ord_an) REFERENCES Analysis (an_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Orders (ord_datetime, ord_an)
VALUES 
	('2020-02-04 07:15:25', 1),
	('2020-02-04 07:20:50', 2),
	('2020-02-04 07:30:04', 1),
	('2020-02-04 07:40:57', 1),
	('2020-02-05 07:05:14', 1),
	('2020-02-05 07:15:15', 3),
	('2020-02-05 07:30:49', 3),
	('2020-02-06 07:10:10', 2),
	('2020-02-06 07:20:38', 2),
	('2020-02-07 07:05:09', 1),
	('2020-02-07 07:10:54', 1),
	('2020-02-07 07:15:25', 1),
	('2020-02-08 07:05:44', 1),
	('2020-02-08 07:10:39', 2),
	('2020-02-08 07:20:36', 1),
	('2020-02-08 07:25:26', 3),
	('2020-02-09 07:05:06', 1),
	('2020-02-09 07:10:34', 1),
	('2020-02-09 07:20:19', 2),
	('2020-02-10 07:05:55', 3),
	('2020-02-10 07:15:08', 3),
	('2020-02-10 07:25:07', 1),
	('2020-02-11 07:05:33', 1),
	('2020-02-11 07:10:32', 2),
	('2020-02-11 07:20:17', 3),
	('2020-02-12 07:05:36', 1),
	('2020-02-12 07:10:54', 2),
	('2020-02-12 07:20:19', 3),
	('2020-02-12 07:35:38', 1);

SELECT * FROM orders;
/*
4.������� �������� � ���� ��� ���� ��������, ������� ����������� 5 ������� 2020 � ��� ��������� ������.
*/
SELECT * 
FROM analysis a
JOIN orders o
ON a.an_id = o.ord_an
-- WHERE substring(o.ord_datetime,1,10) >= "2020-02-05" AND  substring(o.ord_datetime,1,10)<"2020-02-05"+INTERVAL 1 WEEK
WHERE DATE(o.ord_datetime) BETWEEN "2020-02-05" AND "2020-02-05"+INTERVAL 1 WEEK
ORDER BY o.ord_datetime;