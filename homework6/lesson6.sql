CREATE DATABASE hw6;
USE hw6;
/*
1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/ 
DROP FUNCTION find_time;
DELIMITER $$
CREATE FUNCTION find_time(n INT) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(50) DEFAULT '';
    DECLARE days INT DEFAULT 0;
    DECLARE hours INT DEFAULT 0;
    DECLARE minutes INT DEFAULT 0;
    
    SET days = n DIV 86400;
    IF days > 0 THEN
    SET result=CONCAT(result,days,' ','days');
    SET n=n % 86400;
    END IF;
    
	SET hours = n DIV 3600;
    IF hours > 0 THEN
    SET result=CONCAT(result,' ',hours,' ','hours');
    SET n=n % 3600;
    END IF;
    
    SET minutes = n DIV 60;
    IF minutes > 0 THEN
    SET result=CONCAT(result,' ',minutes,' ','minutes');
    SET n=n % 60;
    END IF;
    
	IF n > 0 THEN
    SET result=CONCAT(result,' ',n,' ','seconds');
    END IF;
    RETURN result;
END $$
DELIMITER ;
    
SELECT find_time(123456);

/*
Создайте процедуру, которая выводит только четные числа от 1 до 10. Пример: 2,4,6,8,10
*/
DROP PROCEDURE even;
DELIMITER //
CREATE PROCEDURE even()
BEGIN

DECLARE result VARCHAR(50) DEFAULT '';
DECLARE n INT DEFAULT 1;
WHILE n <= 10 DO
	IF n%2=0 THEN
    SET result = CONCAT(result,' ', n);
    END IF;
    SET n=n+1;
END WHILE;
SELECT result AS 'even numbers';
END //
DELIMITER ;

CALL even; 