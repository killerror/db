DROP DATABASE IF EXISTS lesson3;
CREATE DATABASE IF NOT EXISTS `lesson3`;
USE `lesson3`;

DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`firstname` VARCHAR(45),
`lastname` VARCHAR(45),
`post` VARCHAR(45),
`seniority` INT,
`salary` INT,
`age` INT);

INSERT INTO `staff` (`firstname`, `lastname`, `post`,`seniority`,`salary`, `age`)
VALUES
('����', '�������', '���������', 40, 100000, 60), 
('����', '������', '���������', 8, 70000, 30),
('����', '������', '�������', 2, 70000, 25),
('����', '�����', '�������', 12, 50000, 35),
('����', '������', '�������', 40, 30000, 59),
('����', '������', '�������', 20, 55000, 60),
('����', '�������', '�������', 10, 20000, 35),
('�����', '�������', '�������', 8, 19000, 28),
('����', '�����', '�������', 5, 15000, 25),
('������', '������', '�������', 2, 11000, 19),
('����', '������', '�������', 3, 12000, 24),
('�������', '�������', '�������', 10, 10000, 49);

SELECT * FROM staff;

DROP TABLE IF EXISTS `activity_staff`;
CREATE TABLE IF NOT EXISTS `activity_staff`
(`id` INT PRIMARY KEY AUTO_INCREMENT,
`staff_id` INT,
FOREIGN KEY (staff_id) REFERENCES staff(id),
`date_activity` DATE,
`count_pages` INT
);


INSERT activity_staff (`staff_id`, `date_activity`, `count_pages`)
VALUES
(1,'2022-01-01',250),
(2,'2022-01-01',220),
(3,'2022-01-01',170),
(1,'2022-01-02',100),
(2,'2022-01-01',220),
(3,'2022-01-01',300),
(7,'2022-01-01',350),
(1,'2022-01-03',168),
(2,'2022-01-03',62),
(3,'2022-01-03',84);

/*
1. ������������ ������ �� ���� ���������� ����� (salary) � �������: ��������; ����������� 
*/
SELECT * FROM staff ORDER BY salary DESC;
SELECT * FROM staff ORDER BY salary;

/*
2. �������� 5 ������������ ���������� ���� (salary)
*/
SELECT DISTINCT salary FROM staff ORDER BY salary DESC LIMIT 5;

/*
3. ���������� ��������� �������� (salary) �� ������ ������������� (��st)
*/
SELECT post, SUM(salary) '��������� �.�.' FROM staff GROUP BY post;

/*
4. ������� ���-�� ����������� � �������������� (post) �������� � �������� �� 24 �� 49 ��� ������������.
*/
SELECT COUNT(id) "���-��" FROM staff WHERE post='�������' AND age BETWEEN 24 AND 49;

/*
5. ������� ���������� ��������������
*/
SELECT DISTINCT post FROM staff;

/*
6. �������� �������������, � ������� ������� ������� ����������� ������ 30 ��� ������������
*/
SELECT post FROM (SELECT post, AVG(age) AS 'avgAge' FROM staff GROUP BY post) AS list WHERE avgAge<=30;

/*
7. �������� id �����������, ������� ���������� ����� 500 ������� �� ���� ���
*/
SELECT staff_id, SUM(count_pages) '����� ���-�� ���.' FROM activity_staff GROUP BY staff_id HAVING SUM(count_pages) > 500;

/*
8. �������� ���, ����� �������� ����� 3 ����������� ����� ������� ���-�� �����������, ������� �������� � ��������� ���.
*/
SELECT date_activity '����', COUNT(staff_id) '���-�� ����.' FROM activity_staff GROUP BY date_activity HAVING COUNT(staff_id) > 3;

/*
9. �������� ������� ���������� ����� �� ����������, ������� ���������� ����� 30000
*/
SELECT post, AVG(salary) FROM staff GROUP BY post HAVING AVG(salary) > 30000;