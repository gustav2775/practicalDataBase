use crm;
SELECT * FROM calls;
select date(now());
select count(*), date(at_start_call) as `dates` from crm.`calls` WHERE to_user_id = 1 Having `dates`= date(now());

select `crm`.`count_call_user` (51,'2021-04-04');
select `crm`.time_call(1);
SELECT SEC_TO_TIME((CAST(at_start_call AS TIME) - CAST(at_end_call AS TIME)))
   from `calls` 
   where id = 1