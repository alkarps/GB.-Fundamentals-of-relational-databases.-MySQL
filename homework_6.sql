/* Задача 1
Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека,
который больше всех общался с выбранным пользователем (написал ему сообщений).
*/
-- Если нужно получить id пользователя и количество сообщений:
select if(m.from_user_id<>u.id, m.from_user_id, m.to_user_id) as friend_id, count(*) as messages_count
from users u
    join messages m on u.id = m.from_user_id or u.id = m.to_user_id
where u.id = 1
group by friend_id
order by messages_count desc
limit 1;
-- Если нужно получить только id пользователя:
select friend_id from
(select if(m.from_user_id<>u.id, m.from_user_id, m.to_user_id) as friend_id, count(*) as messages_count
from users u
    join messages m on u.id = m.from_user_id or u.id = m.to_user_id
where u.id = 1
group by friend_id
order by messages_count desc) as most_communication_friend
limit 1;
/* Задача 2
Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
*/
select count(*) as count_likes from profiles p
    join likes l on p.user_id = l.user_id
where YEAR(NOW())-YEAR(p.birthday)<10;
/* Задача 3
Определить кто больше поставил лайков (всего): мужчины или женщины.
*/
select gender from (select if(p.gender='f','Женщины','Мужчины') as gender, count(*) as count_likes from profiles p
    join likes l on p.user_id = l.user_id
group by gender
order by count_likes desc) as gender_likes_stat
limit 1;