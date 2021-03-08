/*т.к. другие задания выполнил в прошлом уроке не стал добавлять сюда*/

select * from profile;
SELECT SUBSTRING(birthday, 1, 3) AS decade FROM profile GROUP BY decade;
SELECT count(*) as count, SUBSTRING(birthday, 1, 3) AS decade FROM profile GROUP BY decade;

/*Операторы , фильтрация, сортировка task 4*/
SELECT firstname, DATE_FORMAT(birthday, '%M') as mounthBirthday from  profile ;
SELECT firstname,
IF (DATE_FORMAT(birthday, '%M') = 'August', 'August', null) as August,
IF (DATE_FORMAT(birthday, '%M') = 'May', 'May', null)  as May
from  profile order by isnull(August) and isnull(May) ;

 /*Операторы , фильтрация, сортировка  task5*/
 SELECT * FROM profile WHERE user_id IN (5, 1, 2);
 SELECT * FROM profile order by user_id != 5 and  user_id != 1;

/*Агрегация данных task1*/
Select AVG(TIMESTAMPDIFF(YEAR, birthday, NOW())) AS ageUser from profile;

/*Агрегация данных task2*/
Select DATE_FORMAT(birthday, '%M') as mounth ,
 DAYOFWEEK(birthday) as dayofweek ,
 count(DAYOFWEEK(birthday)) as countBirthday
 from profile group by dayofweek, mounth; 