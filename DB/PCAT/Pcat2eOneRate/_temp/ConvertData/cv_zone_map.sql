/* Formatted on 04/03/2014 16:45:48 (QP5 v5.215.12089.38647) */
create table zone_map_1
as
select * from zone_map where 1 = 2;

desc zone_map_1;

INSERT INTO ZONE_MAP (SERVICE_ID,
                      SERVICE_NAME,
                      CODE,
                      NW_GROUP,
                      ZONE,
                      TIMEZONE,
                      Hierarchy_level)
   SELECT 2,
          'Voice',
          t8.GLT_NUMBER AS gltNumber,
          t1.PART_OF AS partOf,
          t1.LOCATION AS location,
          t1.TIMEZONE AS timezone,
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
          LEFT OUTER JOIN cbs_owner.GLOBAL_TRANSLATION t8
             ON (t1.LOCATION = t8.LOCATION)
    WHERE t1.SERVICE_VERSION_ID = 1;