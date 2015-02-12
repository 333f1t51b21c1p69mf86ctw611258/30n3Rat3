/* Formatted on 2/10/2015 10:43:44 AM (QP5 v5.269.14213.34746) */
SELECT * FROM CBS_OWNER.SYNC_FLAG;

INSERT INTO cbs_owner.sync_flag
   SELECT *
     FROM cbs_owner.sync_flag
    WHERE reseller_version_id = 16 AND note LIKE '% successfully%';

INSERT INTO cbs_owner.sync_flag
   SELECT *
     FROM cbs_owner.sync_flag
    WHERE reseller_version_id = 17 AND note LIKE '% successfully%';

  SELECT reseller_version_id
    FROM usage_plan
GROUP BY reseller_version_id
ORDER BY reseller_version_id DESC;

  SELECT reseller_version_id
    FROM product_offer
GROUP BY reseller_version_id
ORDER BY reseller_version_id DESC;


  SELECT reseller_version_id
    FROM tariff_plan
GROUP BY reseller_version_id
ORDER BY reseller_version_id DESC;



-- Check PCAT

  SELECT *
    FROM vnp_common.action_log
   WHERE log_title LIKE '%LETS_GO%'
ORDER BY created_time DESC;


SELECT COUNT (*) FROM vnp_data.hot_rated_cdr_1;

SELECT COUNT (*) FROM vnp_data.hot_rated_cdr_2;

SELECT COUNT (*) FROM vnp_data.hot_rated_cdr_temp1;

SELECT COUNT (*) FROM vnp_data.hot_rated_cdr_temp2;

SELECT *
  FROM USER_SEGMENTS
 WHERE SEGMENT_NAME = 'HOT_RATED_CDR_1';

SELECT *
  FROM USER_SEGMENTS
 WHERE SEGMENT_NAME = 'HOT_RATED_CDR_2';

SELECT * FROM VNP_DATA.HOT_RATED_CDR_TEMP1;

SELECT *
  FROM USER_SEGMENTS
 WHERE SEGMENT_NAME = 'HOT_RATED_CDR_2';