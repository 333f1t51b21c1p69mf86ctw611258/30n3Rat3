/* Formatted on 3/16/2014 10:55:50 PM (QP5 v5.215.12089.38647) */
SELECT t1.GLOBAL_LOCATION_ID AS zone_id,
       t1.LOCATION AS zone,
       --       t1.SERVICE_VERSION_ID AS serviceVersionId,
       --       t1.LI AS li,
       t1.PART_OF AS part_of,
       t4.DISPLAY_VALUE AS time_zone_Key,
       t1.TIMEZONE AS time_zone,
       --       t1.SORT_BY AS sortBy,
       --       t1.GLL_LEVEL AS gllLevel,
       --       t1.IS_FA_ELIGIBLE AS isFaEligible,
       --       t7.DISPLAY_VALUE AS locationHierarchyKey,
       t1.HIERARCHY_LEVEL_ID AS hierarchy_Level_Id
  FROM GLOBAL_LOCATION t1
       LEFT OUTER JOIN TIMEZONE_KEY t2
          ON t1.TIMEZONE = t2.TIMEZONE
       LEFT OUTER JOIN TIMEZONE_REF t3
          ON     t2.TIMEZONE = t3.TIMEZONE
             AND t3.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
       LEFT OUTER JOIN TIMEZONE_VALUES t4
          ON     t2.TIMEZONE = t4.TIMEZONE
             AND t4.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
             AND t4.LANGUAGE_CODE = 1
       LEFT OUTER JOIN LOCATION_HIERARCHY_KEY t5
          ON t1.HIERARCHY_LEVEL_ID = t5.HIERARCHY_LEVEL_ID
       LEFT OUTER JOIN LOCATION_HIERARCHY_REF t6
          ON     t5.HIERARCHY_LEVEL_ID = t6.HIERARCHY_LEVEL_ID
             AND t6.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
       LEFT OUTER JOIN LOCATION_HIERARCHY_VALUES t7
          ON     t5.HIERARCHY_LEVEL_ID = t7.HIERARCHY_LEVEL_ID
             AND t7.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
             AND t7.LANGUAGE_CODE = 1
 WHERE t1.SERVICE_VERSION_ID = 1;