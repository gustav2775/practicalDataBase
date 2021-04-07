CREATE DEFINER=`root`@`localhost` FUNCTION `time_call`(id_call int) RETURNS time
    NO SQL
BEGIN
declare time_call time;
	SET time_call = ( SELECT 
	SEC_TO_TIME((CAST(at_start_call AS TIME) - CAST(at_end_call AS TIME)))
   from `calls` 
   where id = id_call);
RETURN time_call;
END