# 1.	�������� ������� � ���������� ����������. ��������� �� �������. 
CREATE DATABASE mobilePhone;
USE mobilePhone;

CREATE TABLE phones
(Id INT PRIMARY KEY NOT NULL,
ProductName VARCHAR(30) NOT NULL,
Manufacturer VARCHAR(30) NOT NULL,
ProductCount INT,
Price INT); 

INSERT INTO phones(Id, ProductName, Manufacturer, ProductCount, Price)
VALUES
(1, "iPhone X", "Apple", 3, 76000),
(2, "iPhone 8", "Apple", 2, 51000),
(3, "Galaxy S9", "Samsung", 2, 56000),
(4, "Galaxy S8", "Samsung", 1, 41000),
(5, "P20 Pro", "Huawei", 5, 36000);

# 2. 	�������� ��������, ������������� � ���� ��� �������, ���������� ������� ��������� 2 
SELECT ProductName, Manufacturer, Price 
FROM phones
WHERE ProductCount > 2;

# 3.  	�������� ���� ����������� ������� ����� �Samsung�
SELECT ProductName, ProductCount, Price 
FROM phones
WHERE Manufacturer = "Samsung";

# 4.*** � ������� ���������� ��������� �����:
# 4.1. ������, � ������� ���� ���������� "Iphone"
SELECT ProductName, Manufacturer, ProductCount, Price 
FROM phones
WHERE ProductName LIKE "%Iphone%";

# 4.2. "Samsung"
SELECT ProductName, Manufacturer, ProductCount, Price 
FROM phones
WHERE  Manufacturer LIKE "%Samsung%";

# 4.3.  ������, � ������� ���� ����� "8"  
SELECT ProductName, Manufacturer, ProductCount, Price 
FROM phones
WHERE ProductName LIKE "%8%";