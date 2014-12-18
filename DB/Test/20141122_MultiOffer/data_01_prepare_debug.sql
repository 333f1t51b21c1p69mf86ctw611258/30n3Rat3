/* Formatted on 17/12/2014 5:12:20 PM (QP5 v5.215.12089.38647) */
TRUNCATE TABLE vnp_data.rated_cdr_dev;

SELECT * FROM vnp_data.hot_rated_cdr;

SELECT COUNT (1)
  FROM vnp_data.hot_rated_cdr
 WHERE rerate_flag = 0;

-- 4779784

UPDATE vnp_data.hot_rated_cdr
   SET rerate_flag = 0
 WHERE a_number = '841247494428';


------------- VOICE

  SELECT *
    FROM vnp_data.hot_rated_cdr_dev
   WHERE cdr_type = 1 AND a_number = '841247494428'
ORDER BY cdr_start_time;

UPDATE vnp_data.hot_rated_cdr_dev
   SET rerate_flag = 0
 WHERE cdr_type = 1 AND a_number = '841247494428';

UPDATE vnp_data.hot_rated_cdr_dev
   SET rerate_flag = 0
 WHERE cdr_type = 1 AND a_number = '84914251186' AND map_id = 1768;

------------- SMS

  SELECT *
    FROM vnp_data.hot_rated_cdr_dev
   WHERE cdr_type = 4 AND a_number = '841247494428'       -- and map_id = 1653
ORDER BY cdr_start_time;

UPDATE vnp_data.hot_rated_cdr_dev
   SET rerate_flag = 0
 WHERE cdr_type = 4 AND a_number = '841247494428';

-- SMS Onnet

UPDATE vnp_data.hot_rated_cdr_dev
   SET rerate_flag = 0
 WHERE cdr_type = 4 AND a_number = '84914251186' AND map_id = 1488;

-- SMS Mobifone

UPDATE vnp_data.hot_rated_cdr_dev
   SET rerate_flag = 0
 WHERE cdr_type = 4 AND a_number = '84914251186' AND map_id = 1489;

DELETE FROM vnp_data.rated_cdr
      WHERE 1 = 1;

COMMIT;

SELECT * FROM vnp_data.rated_cdr_dev;

SELECT COUNT (1)
  FROM vnp_data.hot_rated_cdr
 WHERE a_number = '841247494428';

SELECT * FROM vnp_data.hot_rated_cdr;

SELECT *
  FROM vnp_data.rated_cdr
 WHERE a_number = '841247494428';

SELECT COUNT (1) FROM vnp_data.hot_rated_cdr;

SELECT COUNT (1) FROM vnp_data.rated_cdr;