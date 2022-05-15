/* Задача 1.1
Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
*/
# Не очень понятно что нужно сделать:
# подапдейтить поля или написать селект с возвращением текущей даты и времени в этих полях.
# Поэтому вот 2 варианта:
select COALESCE(created_at,current_timestamp()) as created_at, COALESCE(updated_at,current_timestamp()) as updated_at
from users;
update users set created_at = current_timestamp() where created_at is null;
update users set updated_at = current_timestamp() where updated_at is null;
/* Задача 1.2
Таблица users была неудачно спроектирована.
Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в
   формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
*/
ALTER TABLE users rename column created_at to created_at_old;
ALTER TABLE users rename column updated_at to updated_at_old;
ALTER TABLE users add column created_at datetime not null default current_timestamp();
ALTER TABLE users add column updated_at datetime not null default current_timestamp();
update users set created_at = CAST(created_at_old AS datetime),updated_at = CAST(updated_at_old AS datetime) WHERE 1;
ALTER TABLE users drop column created_at_old;
ALTER TABLE users drop column updated_at_old;
/* Задача 1.3
В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
   0, если товар закончился и выше нуля, если на складе имеются запасы.
   Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value.
   Однако, нулевые запасы должны выводиться в конце, после всех записей.
*/
SELECT * FROM storehouses_products ORDER BY value = 0, value;
/* Задача 1.4
(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
   Месяцы заданы в виде списка английских названий ('may', 'august')
*/
# Странное задание. Если предположить, что дата рождения хранится в отдельном поле,то решение простое:
SELECT * FROM users where LOWER(birth_month) in ('may', 'august');
# Если дата рождения хранится в виде строки вида %d %M %Y, то можно лайком (можно регуляркой, но лень составлять):
SELECT * FROM users where LOWER(birthdate) like '%may%' or LOWER(birthdate) like '%august%';
# Если дата рождения хранится в виде даты,то можно сконвертировать в строку:
SELECT * FROM users where LOWER(DATE_FORMAT(birthdate, '%M')) in ('may', 'august');
/* Задача 1.5
(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2);
   Отсортируйте записи в порядке, заданном в списке IN.
*/
SELECT * FROM catalogs order by id = 5, id;
/* Задача 2.1
Подсчитайте средний возраст пользователей в таблице users
*/
SELECT AVG(DATEDIFF(YEAR(NOW()), YEAR(birthdate))) as `Average` FROM users;
/* Задача 2.2
Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
   Следует учесть, что необходимы дни недели текущего года, а не года рождения.
*/
SELECT
DAYOFWEEK(DATE_FORMAT(DATE_ADD(birthdate, INTERVAL (YEAR(CURRENT_DATE()) - YEAR(birthdate)) YEAR), '%Y-%m-%d')) as day_of_week,
count(*) as count_birthday FROM users group by day_of_week;
/* Задача 2.3
(по желанию) Подсчитайте произведение чисел в столбце таблицы
*/
SELECT exp(SUM(log(value))) FROM temp;