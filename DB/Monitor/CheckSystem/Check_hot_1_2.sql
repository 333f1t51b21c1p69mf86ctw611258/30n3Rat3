/* Formatted on 2/12/2015 3:01:06 PM (QP5 v5.269.14213.34746) */
  SELECT instance, status, COUNT (1)
    FROM cdr_log_process
--   WHERE status > 3
GROUP BY instance, status
ORDER BY instance, status;

select * from hot_aggregated_cdr;

  SELECT status, SUM (total_cdr_processed)
    FROM cdr_log_process
GROUP BY status;

SELECT COUNT (1) FROM hot_rated_cdr;

SELECT *
  FROM cdr_log_process
 WHERE status = 5;

  SELECT *
    FROM cdr_log_process
   WHERE TRUNC (start_time) = TRUNC (SYSDATE) AND status = -7
ORDER BY start_time DESC;

UPDATE cdr_log_process
   SET status = 3
 WHERE status = 5;

SELECT *
  FROM cdr_log_process
 WHERE cdr_log_process_id = 485693;

SELECT COUNT (1) FROM cdr_log_process;

SELECT *
  FROM hot_rated_cdr PARTITION (P150127)
 WHERE cdr_record_header_id = 397441;

SELECT COUNT (1) FROM vnp_data.hot_rated_cdr_1;

--truncate table vnp_data.hot_rated_cdr_1;

SELECT COUNT (1) FROM vnp_data.hot_rated_cdr_2;

--truncate table vnp_data.hot_rated_cdr_2;

  SELECT cdr_record_header_id
    FROM vnp_data.hot_rated_cdr_1
GROUP BY cdr_record_header_id;

  SELECT cdr_record_header_id
    FROM vnp_data.hot_rated_cdr_2
GROUP BY cdr_record_header_id;

--33551336

SELECT COUNT (*) * 100
  FROM vnp_data.hot_rated_cdr_1 SAMPLE BLOCK (1);

--33711500

--truncate table vnp_data.hot_rated_cdr_1;
--25700623

SELECT COUNT (*)
  FROM hot_rated_cdr_1
 WHERE rerate_flag = 0;

 --33551336

SELECT COUNT (1)
  FROM hot_rated_cdr_1 PARTITION (p8);

SELECT COUNT (1)
  FROM hot_rated_cdr_temp1 PARTITION (p9);

SELECT COUNT (*)
  FROM hot_rated_cdr_1
 WHERE rerate_flag = 10;

--23870256

SELECT COUNT (*) FROM hot_rated_cdr_temp1;

--54515097

SELECT COUNT (*)
  FROM hot_rated_cdr_temp1
 WHERE rerate_flag = 10;

--25700623

SELECT COUNT (*)
  FROM hot_rated_cdr_1
 WHERE rerate_flag = 13;

SELECT *
  FROM hot_rated_cdr_1
 WHERE rerate_flag = 13;

SELECT COUNT (*)
  FROM hot_rated_cdr_1
 WHERE rerate_flag = 14;

--------------------------------------------------------------------------------

SELECT COUNT (1) FROM vnp_data.hot_rated_cdr_2;

--30440869

SELECT COUNT (1)
  FROM hot_rated_cdr_2 PARTITION (p9);

SELECT COUNT (1)
  FROM hot_rated_cdr_temp2 PARTITION (p9);

SELECT COUNT (*) * 100
  FROM vnp_data.hot_rated_cdr_2 SAMPLE BLOCK (1);

--truncate table vnp_data.hot_rated_cdr_2;

SELECT COUNT (*) FROM hot_rated_cdr_temp2;

--45066490

SELECT COUNT (*)
  FROM hot_rated_cdr_2
 WHERE rerate_flag = 0;

SELECT COUNT (*)
  FROM hot_rated_cdr_2
 WHERE rerate_flag = 13;

--30440869

SELECT COUNT (*)
  FROM hot_rated_cdr_temp2
 WHERE rerate_flag = 10;

--35410527



------

  SELECT cdr_record_header_id, COUNT (1)
    FROM vnp_data.hot_rated_cdr_1
GROUP BY cdr_record_header_id;

  SELECT cdr_record_header_id, COUNT (1)
    FROM vnp_data.hot_rated_cdr_2
GROUP BY cdr_record_header_id;

  SELECT *
    FROM vnp_data.action_log
   WHERE log_action LIKE '%MOVE_HRC_12_TO_HRC%'
ORDER BY log_time DESC;

  SELECT *
    FROM vnp_data.action_log
   WHERE log_action LIKE '%MOVE_HRC_34_TO_HRC%'
ORDER BY log_time DESC;

  SELECT *
    FROM vnp_data.action_log
   WHERE log_action LIKE '%AGGREGATE_HRC%'
ORDER BY log_time DESC;

  SELECT *
    FROM vnp_data.action_log
   WHERE log_action LIKE '%ADD_PART_BY_DAY%'
ORDER BY log_time DESC;

  SELECT *
    FROM vnp_data.action_log
   WHERE log_action LIKE '%AGGR_MOVE_TO_HOT%'
ORDER BY log_time DESC;

SELECT * FROM CBS_OWNER.GPRS_TRANSLATION;

INSERT INTO hot_rated_cdr_temp1
   SELECT * FROM hot_rated_cdr_1;

COMMIT;

INSERT INTO hot_rated_cdr_temp2
   SELECT * FROM hot_rated_cdr_2;

COMMIT;