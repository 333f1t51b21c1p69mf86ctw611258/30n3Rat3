/* Formatted on 30/05/2014 18:44:51 (QP5 v5.227.12220.39754) */
TRUNCATE TABLE rated_cdr;
TRUNCATE TABLE balance_counter;

--TRUNCATE TABLE rated_cdr;
--TRUNCATE TABLE balance_counter;

--TRUNCATE TABLE discount_counter;

--UPDATE hot_rated_cdr_86
--   SET rerate_flag = 0
-- WHERE cdr_type = 1;

--UPDATE HOT_RATED_CDR_86
--   SET RERATE_FLAG = 0
-- WHERE CDR_TYPE = 1 AND AUT_FINAL_ID = 30411;

--
--UPDATE hot_rated_cdr_86
--   SET rerate_flag = 0
-- WHERE cdr_type = 4;

--UPDATE hot_rated_cdr_86
--   SET rerate_flag = 0
-- WHERE cdr_type = 7;

--UPDATE hot_rated_cdr_dev
--   SET rerate_flag = 0
-- WHERE cdr_type = 4 AND a_number = '84914632111';


--UPDATE hot_rated_cdr_dev
--   SET rerate_flag = 0
-- WHERE a_number = '84935379525' AND cdr_type = 4;


UPDATE hot_rated_cdr
   SET rerate_flag = 0;

COMMIT;