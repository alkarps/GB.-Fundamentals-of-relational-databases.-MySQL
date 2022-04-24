/** Задание 1
Установите СУБД MySQL.
Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.
**/
# Установите СУБД MySQL с помощью докер образа.
# docker volume create mysql-volume
# docker volume create mysql-config
# docker run --name=mk-mysql -p3306:3306 -v mysql-volume:/var/lib/mysql -v mysql-config:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=12345678 -d mysql
# Добавляем конфигурацию для подключения без ввода логина и пароля
# root@4529d8e204ab:/# cd /etc/mysql/conf.d/
# root@4529d8e204ab:/etc/mysql/conf.d# cat > client.cnf
# [client]
# user=root
# password="12345678"
#
# [mysql]
# user=root
# password="12345678"
#
# [mysqldump]
# user=root
# password="12345678"
#
# [mysqldiff]
# user=root
# password="12345678"
# Необходимо перезапустить докер
# docker restart mk-mysql
# Проверяем возможность подключения к mysql без логина и пароля
# root@4529d8e204ab:/# mysql
# Welcome to the MySQL monitor.  Commands end with ; or \g.
# Your MySQL connection id is 9
# Server version: 8.0.28 MySQL Community Server - GPL
#
# Copyright (c) 2000, 2022, Oracle and/or its affiliates.
#
# Oracle is a registered trademark of Oracle Corporation and/or its
# affiliates. Other names may be trademarks of their respective
# owners.
#
# Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
#
# mysql>
/** Задание 2
Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.
**/
# Подключаемся к докеру
# docker exec -it mk-mysql bash
# mysql -u root -p12345678
# Создание БД example
create database example;
# Создание таблицы users, состоящую из двух столбцов, числового id и строкового name
create table example.users
(
    id int auto_increment primary key,
    name nvarchar(100)
)
# exit;
/** Задание 3
Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.
**/
# mysqldump -u root -p12345678 --routines --triggers example > /tmp/example_dump.sql
# mysqladmin create sample -p12345678
# mysql -u root -p12345678 sample < /tmp/example_dump.sql
/** Задание 4
(по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
**/
# mysqldump -u root -p12345678 mysql help_keyword --where="1=1 LIMIT 100"> /tmp/help_keyword.dump