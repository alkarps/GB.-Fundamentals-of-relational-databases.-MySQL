/* Задача 1
Прислать предварительную версию DDL-команд курсового проекта "управление финансами"
*/
drop database if exists finance;
create database if not exists finance;
use finance;

drop table if exists users;
create table users
(
    id            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    login         varchar(50)     not null unique,
    hash_password BINARY(20)      not null comment 'SHA-1 пароля',
    create_date   datetime        not null default now(),
    update_date   datetime on update now()
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
insert into users(id, login, hash_password, update_date)
values (1, 'test_user', UNHEX(SHA1('12345678')), null),
       (2, 'tetragon', UNHEX(SHA1('12345678')), null),
       (3, 'biden', UNHEX(SHA1('12345678')), null),
       (4, 'turok', UNHEX(SHA1('12345678')), null),
       (5, 'popka', UNHEX(SHA1('12345678')), null),
       (6, 'louigan', UNHEX(SHA1('12345678')), null),
       (7, 'potatus', UNHEX(SHA1('12345678')), null),
       (8, 'god_runner', UNHEX(SHA1('12345678')), null),
       (9, 'killyq', UNHEX(SHA1('12345678')), null),
       (10, 'pokiton', UNHEX(SHA1('12345678')), null);
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

CREATE OR REPLACE VIEW user_accounts AS
select a.id                                            as account_id,
       a.name                                          as name,
       t.name                                          as type,
       `as`.name                                       as status,
       c.name                                          as currency,
       a.create_date,
       a.update_date,
       isnull(w.user_id)                               as is_union_account,
       if(ISNULL(w.user_id), u.name, 'Личный аккаунт') as description,
       u2.id                                           as union_user_id,
       u3.id                                           as user_id
from accounts a
         join account_statuses `as` on a.account_status_id = `as`.id
         join account_types t on a.account_type_id = t.id
         join currency c on a.currency_id = c.id
         join wallets w on a.id = w.account_id
         left join unions u on w.union_id = u.id
         left join union_participants up on u.id = up.union_id
         left join users u2 on up.user_id = u2.id
         left join users u3 on w.user_id = u3.id;

select ad.account_id,
       ad.name,
       ad.description,
       ad.is_union_account,
       ad.type,
       ad.status,
       ad.currency,
       ad.create_date,
       ad.update_date
from user_accounts ad
         join (select 2 as user_id) id on ad.user_id = id.user_id or ad.union_user_id = id.user_id;

CREATE OR REPLACE VIEW account_transaction AS
select t.id                                                          as transaction_id,
       tt.name                                                       as type,
       t.description,
       if(isnull(t.from_account_id), 'Внешний аккаунт', from_a.name) as soure,
       if(isnull(t.to_account_id), 'Внешний аккаунт', to_a.name)     as destination,
       from_c.name                                                   as source_currency,
       t.amount_from_account_currency                                as amount_in_source_currency,
       to_c.name                                                     as destination_currenry,
       t.amount_to_account_currency                                  as amount_in_destination_currency,
       from_a.id                                                     as source_id,
       to_a.id                                                       as destination_id
from transactions t
         join currency from_c on from_c.id = t.from_account_currency_id
         join currency to_c on to_c.id = t.to_account_currency_id
         join finance.transaction_types tt on tt.id = t.transaction_type_id
         left join finance.accounts from_a on from_a.id = t.from_account_id
         left join finance.accounts to_a on to_a.id = t.to_account_id;

select at.transaction_id,
       at.type,
       at.description,
       at.soure,
       at.destination,
       at.source_currency,
       at.amount_in_source_currency,
       at.destination_currenry,
       at.amount_in_destination_currency
from account_transaction at
         join (select 2 as accountId) id on at.source_id = id.accountId or at.destination_id = id.accountId;

DROP FUNCTION IF EXISTS cal_acc_balance;
DELIMITER $
CREATE FUNCTION cal_acc_balance(account_id BIGINT UNSIGNED) RETURNS decimal(24, 2)
BEGIN
    DECLARE result decimal(24, 2);
    select sum(if(t.to_account_id = id.accountId, t.amount_to_account_currency,
                  t.amount_from_account_currency)) as balance
    from transactions t
             join currency from_c on from_c.id = t.from_account_currency_id
             join currency to_c on to_c.id = t.to_account_currency_id
             join finance.transaction_types tt on tt.id = t.transaction_type_id
             left join finance.accounts from_a on from_a.id = t.from_account_id
             left join finance.accounts to_a on to_a.id = t.to_account_id
             join (select account_id as accountId) id on from_a.id = id.accountId or to_a.id = id.accountId
    INTO result;
    RETURN result;
END $
DELIMITER ;