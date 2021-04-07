SELECT * FROM crm.chat;
-- сортировка по дате создания к другим таблицам тоже подойдет
SELECT * FROM crm.chat  where date(at_create) = date(now());
--  вывод чата, текст, дата, имени и фото
SELECT 
    c.id AS id,
    c.`text`,
    c.to_user_id AS 'to_user',
    CONCAT_WS(' ', p.first_name, p.last_name) AS name_to,
    (SELECT 
            CONCAT_WS('.', name, id_type)
        FROM
            files
        WHERE
            id = p.avatar_id) AS avatar_user_name_1,
    c.from_user_id AS 'from_user',
    CONCAT_WS(' ', p2.first_name, p2.last_name) AS name_from,
    (SELECT 
            CONCAT_WS('.', name, id_type)
        FROM
            files
        WHERE
            id = p2.avatar_id) AS avatar_user_name_2
FROM
    crm.chat AS c
        LEFT JOIN
    crm.profile AS p ON c.to_user_id = p.id
        LEFT JOIN
    crm.profile AS p2 ON c.from_user_id = p.id
ORDER BY id DESC;