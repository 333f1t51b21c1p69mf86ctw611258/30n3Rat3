/* Formatted on 3/25/2014 10:10:41 AM (QP5 v5.215.12089.38647) */
SELECT t1.GLOBAL_LOCATION_ID AS globalLocationId,
       t1.LOCATION AS location,
       t1.SERVICE_VERSION_ID AS serviceVersionId,
       t1.LI AS li,
       t1.PART_OF AS partOf,
       t4.DISPLAY_VALUE AS timezoneKey,
       t1.TIMEZONE AS timezone,
       t1.SORT_BY AS sortBy,
       t1.GLL_LEVEL AS gllLevel,
       t1.IS_FA_ELIGIBLE AS isFaEligible,
       t7.DISPLAY_VALUE AS locationHierarchyKey,
       t1.HIERARCHY_LEVEL_ID AS hierarchyLevelId
  FROM cbs_owner.GLOBAL_LOCATION t1
       LEFT OUTER JOIN cbs_owner.TIMEZONE_KEY t2
          ON t1.TIMEZONE = t2.TIMEZONE
       LEFT OUTER JOIN cbs_owner.TIMEZONE_REF t3
          ON     t2.TIMEZONE = t3.TIMEZONE
             AND t3.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
       LEFT OUTER JOIN cbs_owner.TIMEZONE_VALUES t4
          ON     t2.TIMEZONE = t4.TIMEZONE
             AND t4.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
             AND t4.LANGUAGE_CODE = 1
       LEFT OUTER JOIN cbs_owner.LOCATION_HIERARCHY_KEY t5
          ON t1.HIERARCHY_LEVEL_ID = t5.HIERARCHY_LEVEL_ID
       LEFT OUTER JOIN cbs_owner.LOCATION_HIERARCHY_REF t6
          ON     t5.HIERARCHY_LEVEL_ID = t6.HIERARCHY_LEVEL_ID
             AND t6.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
       LEFT OUTER JOIN cbs_owner.LOCATION_HIERARCHY_VALUES t7
          ON     t5.HIERARCHY_LEVEL_ID = t7.HIERARCHY_LEVEL_ID
             AND t7.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
             AND t7.LANGUAGE_CODE = 1
 WHERE t1.SERVICE_VERSION_ID = 1;