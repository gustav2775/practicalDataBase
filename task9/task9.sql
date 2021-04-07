--Транзакции, переменные, представления

--Задание 1

begin;
insert vk.like_post value ( 1, (select media_id from vk.like_media where user_id = 1) );
delete from vk.like_media where user_id = 1 ;
commit;

--Задание 2

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `new_view` AS
    SELECT 
        `p`.`id` AS `post`,
        `m`.`id` AS `media_id`,
        `mt`.`name` AS `type`
    FROM
        ((`post` `p`
        LEFT JOIN `media` `m` ON ((`p`.`media_id` = `m`.`id`)))
        JOIN `media_type` `mt` ON ((`mt`.`id` = `m`.`media_type_id`)))
    ORDER BY `p`.`id`

-- Хранимые процедуры и функции, триггеры

-- Задание 1

CREATE DEFINER=`root`@`localhost` FUNCTION `hello`() RETURNS char(225) CHARSET utf8mb4
    NO SQL
BEGIN
    DECLARE massege TEXT(225);
SET massege = CASE    
    WHEN HOUR(NOW()) BETWEEN 6 AND 12 THEN  'Доброе утро'
    WHEN HOUR(NOW()) BETWEEN 13 AND 18 THEN  'Добрый день'
    WHEN HOUR(NOW()) BETWEEN 19 AND 00 THEN  'Добрый вечер'
    WHEN HOUR(NOW()) BETWEEN 00 AND 5 THEN'Доброй ночи'
END;
RETURN massege;
END

--Задание 2
ALTER TABLE `vk`.`media` 
ADD COLUMN `name1` VARCHAR(45) NULL DEFAULT 'new name' AFTER `created_at`,
ADD COLUMN `description1` VARCHAR(256) NULL DEFAULT NULL AFTER `name1`;

--При создание строки обе колонки не должны быть равны NULL
DROP TRIGGER IF EXISTS `vk`.`media_BEFORE_INSERT`;
DELIMITER $$
USE `vk`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vk`.`media_BEFORE_INSERT`
BEFORE INSERT ON `media` FOR EACH ROW
BEGIN
	IF isnull(new.name) AND isnull(new.description) THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT  = 'name and description is not NULL';
    END IF;
END$$
DELIMITER ;

--Запрет на присваевание полям NULL или пустого поля
DROP TRIGGER IF EXISTS `vk`.`media_BEFORE_UPDATE`;

DELIMITER $$
USE `vk`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `media_BEFORE_UPDATE` BEFORE UPDATE ON `media` FOR EACH ROW BEGIN
IF isnull(new.name) OR IsEmpty(new.name) OR IsEmpty(new.description) OR isNull(new.description) THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT  = 'Is not NULL';
    END IF;
END$$
DELIMITER ;

