/* Задача 1
Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products
   в таблицу logs помещается время и дата создания записи, название таблицы,
   идентификатор первичного ключа и содержимое поля name.
*/
create table logs
(
    id          serial primary key,
    `table_name`  enum ('users', 'catalogs', 'products'),
    external_id bigint unsigned,
    `name`      varchar(255),
    log_date    datetime default now()
);
DELIMITER //
create trigger users_log AFTER insert ON users FOR EACH ROW
    insert into logs(`table_name`, external_id, `name`) value ('users', NEW.id, NEW.name);
DELIMITER ;
DELIMITER //
create trigger catalogs_log AFTER insert ON catalogs FOR EACH ROW
    insert into logs(`table_name`, external_id, `name`) value ('catalogs', NEW.id, NEW.name);
DELIMITER ;
DELIMITER //
create trigger products_log AFTER insert ON products FOR EACH ROW
    insert into logs(`table_name`, external_id, `name`) value ('products', NEW.id, NEW.name);
DELIMITER ;
/* Задача 2
(по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
*/
INSERT INTO users (id, name, birthday_at)
SELECT n, CONCAT('Customer', n), now()
  FROM
(
select a.N + b.N * 10 + c.N * 100 + d.N * 1000 + e.N * 10000 + f.N * 100000 + 1 N
from (select 0 as N union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) a
      , (select 0 as N union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) b
      , (select 0 as N union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) c
      , (select 0 as N union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) d
      , (select 0 as N union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) e
      , (select 0 as N union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) f
) t