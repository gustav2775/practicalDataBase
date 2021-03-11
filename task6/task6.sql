-- Урок 6 Задание 1
/* Выучил функции рассматриваемые на уроке,но пока знаний не хватает, чтобы как то улучшить команды.  */

-- Урок 6 Задание 2
SELECT 
    to_user_id, COUNT(id) AS countz
FROM
    message
WHERE
    from_user_id = 79
        AND to_user_id IN 
        (SELECT 
            IF(to_user_id = 79,
                    from_user_id,
                    to_user_id) AS user_friend
        FROM
            friend_request
        WHERE
            to_user_id = 79 OR from_user_id = 79)
GROUP BY to_user_id
ORDER BY countz DESC;

-- Урок 6 задание 3
SELECT 
    to_user_id, COUNT(from_user_id) AS likes
FROM
    like_user
WHERE
    to_user_id IN (SELECT 
            *
        FROM
            (SELECT 
                user_id
            FROM
                profile
            WHERE
                TIMESTAMPDIFF(YEAR, birthday, NOW()) < 18
            LIMIT 10) profile)
GROUP BY to_user_id;

-- урок 6 задание 4 не придумал решение

SELECT gender,count(counts) FROM (SELECT * FROM (
(SELECT  gender, count(user_id) as counts FROM profile where gender in ('m','f') AND user_id in (SELECT 
    user_id
FROM
    like_media ) group by gender) table1
union
(SELECT  gender, count(user_id) as counts from profile where gender in ('m','f')  AND user_id in ( SELECT 
    user_id
FROM
    like_post
)group by gender) table2
union
(SELECT  gender, count(user_id) as counts from profile where gender in ('m','f') AND user_id in (SELECT 
   from_user_id
FROM
    like_user 
) group by gender) table3
) table4 )
group by gender;

-- урок 6 задание 5
SELECT user_id,
(SELECT 
    count(*)
FROM
    like_media where user_id = profile.user_id)  +
(SELECT 
    count(post_id)
FROM
    like_post where user_id = profile.user_id)+
(SELECT 
	COUNT(to_user_id)
FROM
    like_user  where from_user_id = profile.user_id) +
(SELECT 
	 COUNT(id)
FROM
    post  where user_id = profile.user_id) as activ
FROM profile
order by activ 