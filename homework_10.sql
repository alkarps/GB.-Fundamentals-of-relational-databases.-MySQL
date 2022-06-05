/* Задача 1
Прислать предварительную версию DDL-команд курсового проекта "управление финансами"
*/
create database if not exists finance;
use finance;

drop table if exists users;
create table users
(
    id           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    login        varchar(50)     not null unique,
    has_password BINARY(20)      not null comment 'SHA-1 пароля',
    create_date  datetime        not null default now(),
    update_date  datetime on update now()
) comment 'Пользователи';

drop table if exists profiles;
create table profiles
(
    id      BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED not null,
    fio     varchar(255),
    foreign key (user_id) references users (id)
) comment 'Профили пользователей';

drop table if exists unions;
create table unions
(
    id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name`      varchar(255)    not null,
    `website`   varchar(255)             default null,
    create_date datetime        not null default now(),
    update_date datetime on update now()
) comment 'Объединение пользователей: компания, группа друзей, семья';

drop table if exists union_participants;
create table union_participants
(
    union_id BIGINT UNSIGNED NOT NULL,
    user_id  BIGINT UNSIGNED NOT NULL,
    primary key (union_id, user_id)
) comment 'Участники объединения';

drop table if exists account_types;
create table account_types
(
    id     BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(255)    not null
) comment 'Типы аккаунтов';

drop table if exists account_statuses;
create table account_statuses
(
    id     BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(255)    not null
) comment 'Статусы аккаунтов';

drop table if exists currency;
create table currency
(
    id     BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(255)    not null
) comment 'Валюта';

drop table if exists accounts;
create table accounts
(
    id                BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name`            varchar(255)    not null,
    account_type_id   BIGINT UNSIGNED NOT NULL,
    account_status_id BIGINT UNSIGNED NOT NULL,
    currency_id       BIGINT UNSIGNED NOT NULL,
    create_date       datetime        not null default now(),
    update_date       datetime on update now(),
    foreign key (account_type_id) references account_types (id),
    foreign key (account_status_id) references account_statuses (id),
    foreign key (currency_id) references currency (id)
) comment 'Аккаунты: счета, кредиты и прочее';

drop table if exists transaction_types;
create table transaction_types
(
    id     BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(255)    not null
) comment 'Тип транзакции';

drop table if exists transactions;
create table transactions
(
    id                           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    transaction_type_id          BIGINT UNSIGNED not null,
    linked_transaction_id        BIGINT UNSIGNED          default null comment 'Ссылка на оригинальную транзакция для которой проводится корректировка или возврата',
    from_account_id              BIGINT UNSIGNED          default null comment 'При поступлении извне используется значение null.',
    to_account_id                BIGINT UNSIGNED          default null comment 'При переводе из системы внешним аккаунтам используется значение null.',
    from_account_currency_id     BIGINT UNSIGNED NOT NULL comment 'Валюта аккаунта с которого поступает средства.',
    amount_from_account_currency decimal(24, 2)  not null,
    to_account_currency_id       BIGINT UNSIGNED NOT NULL comment 'Валюта аккаунта на который поступают средства.',
    amount_to_account_currency   decimal(24, 2)  not null,
    `description`                varchar(255)    not null,
    create_date                  datetime        not null default now(),
    update_date                  datetime on update now(),
    foreign key (transaction_type_id) references transaction_types (id),
    foreign key (linked_transaction_id) references transactions (id),
    foreign key (from_account_id) references accounts (id),
    foreign key (to_account_id) references accounts (id),
    foreign key (from_account_currency_id) references currency (id),
    foreign key (to_account_currency_id) references currency (id),
    check ( from_account_id <> to_account_id )
) comment 'Транзакции';

drop table if exists wallets;
create table wallets
(
    id         BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    account_id BIGINT UNSIGNED not null,
    user_id    BIGINT UNSIGNED,
    union_id   BIGINT UNSIGNED,
    foreign key (account_id) references accounts (id),
    foreign key (user_id) references users (id),
    foreign key (union_id) references unions (id),
    check ( user_id is not null and union_id is null or user_id is null and union_id is not null )
) comment 'Кошелек пользователя или компании';

/* Задача 2
Дамп БД (наполнение таблиц данными), не больше 10 строк в каждой таблице, для курсового проекта "управление финансами"
*/
insert into users(id, login, has_password, update_date)
values (1, 'test_user', SHA1('12345678'), null),
       (2, 'tetragon', SHA1('12345678'), null),
       (3, 'biden', SHA1('12345678'), null),
       (4, 'turok', SHA1('12345678'), null),
       (5, 'popka', SHA1('12345678'), null),
       (6, 'louigan', SHA1('12345678'), null),
       (7, 'potatus', SHA1('12345678'), null),
       (8, 'god_runner', SHA1('12345678'), null),
       (9, 'killyq', SHA1('12345678'), null),
       (10, 'pokiton', SHA1('12345678'), null);
insert into profiles(user_id, fio)
VALUES (1, 'Федя Пупкин'),
       (2, 'Федя Пупкин'),
       (3, 'Федя Пупкин'),
       (4, 'Федя Пупкин'),
       (5, 'Федя Пупкин'),
       (6, 'Федя Пупкин'),
       (7, 'Федя Пупкин'),
       (8, 'Федя Пупкин'),
       (9, 'Федя Пупкин'),
       (10, 'Федя Пупкин');
insert into unions(id, `name`, update_date)
values (1, 'Пупкины', null),
       (2, 'Пятерочка', null),
       (3, 'Грустный семыч', null),
       (4, 'Веселый семыч', null),
       (5, 'Пьяный семыч', null),
       (6, 'Пьянка 26.09', null),
       (7, 'Новый год у семыча', null),
       (8, 'ООО Рога и копыта', null),
       (9, 'Аренда квартиры', null),
       (10, 'Скидываемся на ДР', null);
insert into union_participants(union_id, user_id)
values (1, 1),
       (1, 2),
       (2, 3),
       (2, 1),
       (3, 4),
       (4, 5),
       (5, 6),
       (6, 7),
       (7, 8),
       (8, 9);
insert into account_types(id, `name`)
values (1, 'Кредит'),
       (2, 'Дебит');
insert into account_statuses(id, `name`)
values (1, 'Открыт'),
       (2, 'Закрыт');
insert into currency(id, `name`)
values (1, 'Рубль'),
       (2, 'Юань');
insert into accounts(id, `name`, account_type_id, account_status_id, currency_id, update_date)
values (1, 'Мелочь', 1, 1, 1, null),
       (2, 'Мелочь', 1, 1, 1, null),
       (3, 'Мелочь', 1, 1, 1, null),
       (4, 'Мелочь', 1, 1, 1, null),
       (5, 'Мелочь', 1, 1, 1, null),
       (6, 'Мелочь', 1, 1, 1, null),
       (7, 'Мелочь', 1, 1, 1, null),
       (8, 'Мелочь', 1, 1, 1, null),
       (9, 'Мелочь', 1, 1, 1, null),
       (10, 'Мелочь', 1, 1, 1, null);
insert into transaction_types(id, `name`)
values (1, 'Транзакция'),
       (2, 'Корректировка'),
       (3, 'Возврат');
insert into transactions (transaction_type_id, from_account_id, to_account_id,
                          from_account_currency_id, amount_from_account_currency, to_account_currency_id,
                          amount_to_account_currency, `description`, update_date)
values (1, 1, 2, 1, 1.0, 1, 1.0, 'test', null),
       (1, null, 4, 1, 1.0, 1, 1.0, 'test', null),
       (1, 3, null, 1, 1.0, 1, 1.0, 'test', null),
       (1, 5, 4, 1, 1.0, 1, 1.0, 'test', null),
       (1, 7, 9, 1, 1.0, 1, 1.0, 'test', null),
       (1, 6, 10, 1, 1.0, 1, 1.0, 'test', null),
       (1, 10, 3, 1, 1.0, 1, 1.0, 'test', null),
       (1, null, 2, 1, 1.0, 1, 1.0, 'test', null),
       (1, 1, null, 1, 1.0, 1, 1.0, 'test', null),
       (1, 3, 8, 1, 1.0, 1, 1.0, 'test', null);
insert into wallets(account_id, user_id, union_id)
VALUES (1, 1, null),
       (2, 2, null),
       (3, null, 1),
       (1, null, 2),
       (1, 4, null),
       (1, 10, null),
       (1, 6, null),
       (1, null, 3),
       (1, null, 8),
       (1, null, 10);
