/* Formatted on 13/1/2015 18:20:16 (QP5 v5.215.12089.38647) */
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

  SELECT *
    FROM vnp_data.action_log
   WHERE log_action LIKE '%MOVE_TO_HOT_RATED%'
ORDER BY log_time DESC;

  SELECT *
    FROM vnp_common.action_log
   WHERE log_title LIKE '%LETS_GO%'
ORDER BY created_time DESC;

SELECT COUNT (*) FROM vnp_data.hot_rated_cdr_1;

SELECT COUNT (*) FROM vnp_data.hot_rated_cdr_2;