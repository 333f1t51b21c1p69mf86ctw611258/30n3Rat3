/* Formatted on 2/12/2015 3:01:06 PM (QP5 v5.269.14213.34746) */

SELECT instance, status , COUNT (1)
FROM cdr_log_process
	--   WHERE status > 3
GROUP BY instance, status
ORDER BY instance, status;

--

SELECT status, SUM (total_cdr_processed) FROM cdr_log_process GROUP BY status;

--

SELECT COUNT (1) FROM hot_rated_cdr;
--
analyze TABLE hot_rated_cdr_1 compute statistics;

SELECT COUNT (1) FROM vnp_data.hot_rated_cdr_1;
--truncate table vnp_data.hot_rated_cdr_1;

--
analyze TABLE hot_rated_cdr_2 compute statistics;

SELECT COUNT (1) FROM vnp_data.hot_rated_cdr_2;

--truncate table vnp_data.hot_rated_cdr_2;
------

SELECT *
FROM vnp_data.action_log
WHERE log_action LIKE '%MOVE_HRC_12_TO_HRC%'
ORDER BY log_time DESC;

SELECT * FROM vnp_data.action_log WHERE log_action LIKE '%AGGREGATE_HRC%' ORDER BY log_time DESC;

SELECT *
FROM vnp_data.action_log
WHERE log_action LIKE '%ADD_PART_BY_DAY%'
ORDER BY log_time DESC;
