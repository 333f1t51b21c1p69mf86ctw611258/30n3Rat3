/* Formatted on 16/3/15 17:10:40 (QP5 v5.240.12305.39476) */
  SELECT instance, status, COUNT (1)
    FROM cdr_log_process
--   WHERE status > 3
GROUP BY instance, status
ORDER BY instance, status;

--

  SELECT status, SUM (total_cdr_processed)
    FROM cdr_log_process
GROUP BY status;

--

SELECT COUNT (1) FROM hot_rated_cdr;

--
ANALYZE TABLE hot_rated_cdr_1 COMPUTE STATISTICS;

SELECT COUNT (1) FROM vnp_data.hot_rated_cdr_1;

--truncate table vnp_data.hot_rated_cdr_1;

--
ANALYZE TABLE hot_rated_cdr_2 COMPUTE STATISTICS;


SELECT COUNT (1) FROM vnp_data.hot_rated_cdr_2;

--truncate table vnp_data.hot_rated_cdr_2;

------

  SELECT *
    FROM vnp_data.action_log
   WHERE log_action LIKE '%MOVE_HRC_12_TO_HRC%'
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
   WHERE log_action LIKE '%AGGREGATE_RATED_CDR%'
ORDER BY log_time DESC;