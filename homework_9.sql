# Практическое задание по теме “Транзакции, переменные, представления”

/* Задача 1
В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
   Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
*/
START TRANSACTION;
insert into sample.users(id, name, birthday_at, created_at, updated_at)
SELECT id, name, birthday_at, created_at, updated_at
from shop.users
where id = 1;
COMMIT;
/* Задача 2
Создайте представление, которое выводит название name товарной позиции из таблицы
   products и соответствующее название каталога name из таблицы catalogs.
*/
CREATE VIEW product_and_catalog_name AS
SELECT p.name, c.name
FROM products p
         join catalogs c on c.id = p.catalog_id;
/* Задача 3
(по желанию) Пусть имеется таблица с календарным полем created_at.
   В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04',
   '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август,
   выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
*/
create table example.temp
(
    created_at date primary key
);
insert into example.temp(created_at)
values ('2018-08-01'),
       ('2016-08-04'),
       ('2018-08-16'),
       ('2018-08-17');
WITH recursive Date_Ranges AS (select '2018-08-01' as Date
                               union all
                               select Date + interval 1 day
                               from Date_Ranges
                               where Date < '2018-08-31')
select d.Date, if(isnull(t.created_at), 0, 1)
from example.temp t
         right outer join Date_Ranges d on t.created_at = d.Date
order by d.Date;
/* Задача 4
(по желанию) Пусть имеется любая таблица с календарным полем created_at.
   Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
*/
create table example.another_temp
(
    created_at date primary key
);
insert into example.another_temp(created_at)
values ('2018-08-01'),
       ('2016-08-04'),
       ('2018-08-16'),
       ('2018-08-17'),
       ('2018-01-17'),
       ('2019-08-17'),
       ('2018-08-27'),
       ('2020-08-17'),
       ('2018-10-17'),
       ('2118-08-17');
DELETE
FROM example.another_temp
WHERE created_at NOT IN (SELECT created_at
                         FROM (SELECT created_at
                               FROM example.another_temp
                               ORDER BY created_at DESC
                               LIMIT 5) foo);

#Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)

/* Задача 1
Создайте двух пользователей которые имеют доступ к базе данных shop.
   Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
   второму пользователю shop — любые операции в пределах базы данных shop.
*/
CREATE USER 'shop_read'@'localhost' IDENTIFIED BY 'shop_read_password';
GRANT SELECT, SHOW VIEW ON shop.* TO 'shop_read'@'localhost' IDENTIFIED BY 'shop_read_password';
FLUSH PRIVILEGES;
CREATE USER 'shop'@'localhost' IDENTIFIED BY 'shop_password';
GRANT ALL PRIVILEGES ON shop.* TO 'shop'@'localhost';
FLUSH PRIVILEGES;
/* Задача 2
(по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ,
   имя пользователя и его пароль. Создайте представление username таблицы accounts,
   предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы не
   имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.
*/
#Пусть таблица accounts живет в БД shop
CREATE VIEW users_view AS
SELECT a.id, a.name
FROM accounts a;
CREATE USER 'user_read'@'localhost' IDENTIFIED BY 'shop_read_password';
REVOKE ALL PRIVILEGES ON shop.* FROM 'username'@'localhost';
GRANT SHOW VIEW ON shop.* TO 'user_read'@'localhost' IDENTIFIED BY 'shop_read_password';
FLUSH PRIVILEGES;

#Практическое задание по теме “Хранимые процедуры и функции, триггеры"

/* Задача 1
Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
   С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
   с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
   с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/
DROP FUNCTION IF EXISTS hello;
DELIMITER $
CREATE FUNCTION hello() RETURNS VARCHAR(12)
BEGIN
    DECLARE result VARCHAR(12) DEFAULT 'Доброй ночи';
    SELECT case
               when current_time between '00:00:00' and '06:00:00' then 'Доброй ночи'
               when current_time between '06:00:01' and '12:00:00' then 'Доброе утро'
               when current_time between '12:00:01' and '18:00:00' then 'Добрый день'
               else 'Добрый вечер'
               end
    INTO result;
    RETURN result;
END $
DELIMITER ;
/* Задача 2
В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
   Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное
   значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
   При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/
DELIMITER //
CREATE TRIGGER product_insert
    BEFORE INSERT
    ON products
    FOR EACH ROW
    IF NEW.name is null and NEW.description is null THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Name or description can\'t be null.';
    END IF//
DELIMITER ;
DELIMITER //
CREATE TRIGGER product_update
    BEFORE UPDATE
    ON products
    FOR EACH ROW
    IF NEW.name is null and NEW.description is null THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Name or description can\'t be null.';
    END IF//
DELIMITER ;
/* Задача 3
(по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
   Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел.
   Вызов функции FIBONACCI(10) должен возвращать число 55.
*/
DELIMITER $$
CREATE FUNCTION FIBONACCI(n INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE f_0 INT default 0;
    DECLARE f_1 INT DEFAULT 1;
    DECLARE out_fib INT;
    DECLARE i INT;
    DECLARE f_2 INT;

    SET f_0 = 0;
    SET f_1 = 1;
    SET i = 1;

    WHILE (i<=n) DO
        SET f_2 = f_0 + f_1;
        SET f_0 = f_1;
        SET f_1 = f_2;
        SET i = i + 1;
    END WHILE;
    SET out_fib = f_0;
RETURN out_fib;
END $$
DELIMITER ;
select FIBONACCI(10);
