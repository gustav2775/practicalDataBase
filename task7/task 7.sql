-- урок 7 задание 1. Вывожу всех пользователей которые хотя бы 1 раз написали сообщение

select id, from_user_id user, (from_user_id != 0 ) from message;
select id, from_user_id as user from message;

-- урок 7 задание 2. Вывожу список media  которым соответствует media_type

SELECT 
    media.id AS media_id,
    media_type.name AS `type`,
    media.user_id,
    CONCAT_WS('  ',
            `profile`.firstname,
            `profile`.lastname) AS name
FROM
    media_type
        JOIN
    media
        JOIN
    `profile` ON media.media_type_id = media_type.id
        AND media.user_id = `profile`.user_id
        order by `type`;
        
-- урок 7 задание 3
SELECT 
    id, `name` AS `from`, `to`
FROM
    flights
        JOIN
    cities ON flights.`from` = cities.label