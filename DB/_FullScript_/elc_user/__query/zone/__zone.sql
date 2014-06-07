/* Formatted on 10/4/2014 10:21:18 (QP5 v5.227.12220.39754) */
DROP TABLE zone;

SELECT * FROM zone;

CREATE TABLE zone
AS
   SELECT t1.GLOBAL_LOCATION_ID AS zone_id,               -- globalLocationId,
          T1.LI,
          t1.LOCATION AS zone_name,                               -- location,
          --       t1.SERVICE_VERSION_ID AS serviceVersionId,
          --       t1.LI AS li,
          t1.PART_OF AS part_of,                                    -- partOf,
          t4.DISPLAY_VALUE AS time_zone_name,                  -- timezoneKey,
          t1.TIMEZONE AS time_zone_id,                            -- timezone,
          --       t1.SORT_BY AS sortBy,
          --       t1.GLL_LEVEL AS gllLevel,
          --       t1.IS_FA_ELIGIBLE AS isFaEligible,
          t7.DISPLAY_VALUE AS hierarchy_name,         -- locationHierarchyKey,
          t1.HIERARCHY_LEVEL_ID AS hierarchy_id,          -- hierarchyLevelId,
          -- add translation
          t21.GLOBAL_TRANSLATION_ID AS translation_id, -- globalTranslationId,
          t21.GLT_NUMBER AS glt_number                      -- , -- gltNumber,
     --       t23.DISPLAY_VALUE AS TYPE,
     --       t21.SERVICE_VERSION_ID AS serviceVersionId,
     --       t21.LOCATION AS location,
     --       t25.DISPLAY_VALUE AS oppsQueryType,
     --       t27.DISPLAY_VALUE AS tppsQueryType
     FROM cbs_owner.GLOBAL_LOCATION t1
          LEFT OUTER JOIN cbs_owner.TIMEZONE_KEY t2
             ON t1.TIMEZONE = t2.TIMEZONE
          LEFT OUTER JOIN
          cbs_owner.TIMEZONE_REF t3
             ON     t2.TIMEZONE = t3.TIMEZONE
                AND t3.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.TIMEZONE_VALUES t4
             ON     t2.TIMEZONE = t4.TIMEZONE
                AND t4.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
                AND t4.LANGUAGE_CODE = 1
          LEFT OUTER JOIN cbs_owner.LOCATION_HIERARCHY_KEY t5
             ON t1.HIERARCHY_LEVEL_ID = t5.HIERARCHY_LEVEL_ID
          LEFT OUTER JOIN
          cbs_owner.LOCATION_HIERARCHY_REF t6
             ON     t5.HIERARCHY_LEVEL_ID = t6.HIERARCHY_LEVEL_ID
                AND t6.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.LOCATION_HIERARCHY_VALUES t7
             ON     t5.HIERARCHY_LEVEL_ID = t7.HIERARCHY_LEVEL_ID
                AND t7.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
                AND t7.LANGUAGE_CODE = 1
          -- add translation
          INNER JOIN
          cbs_owner.GLOBAL_TRANSLATION t21
             ON     T21.LOCATION = T1.LOCATION
                AND T21.SERVICE_VERSION_ID = T1.SERVICE_VERSION_ID
          LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_REF t22
             ON t22.enumeration_key = LOWER ('TYPE') AND t22.VALUE = t21.TYPE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t23
             ON     t23.enumeration_key = t22.enumeration_key
                AND t23.VALUE = t22.VALUE
                AND t23.LANGUAGE_CODE = 1
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t24
             ON     t24.enumeration_key = LOWER ('OPPS_QUERY_TYPE')
                AND t24.VALUE = t21.OPPS_QUERY_TYPE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t25
             ON     t25.enumeration_key = t24.enumeration_key
                AND t25.VALUE = t24.VALUE
                AND t25.LANGUAGE_CODE = 1
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t26
             ON     t26.enumeration_key = LOWER ('TPPS_QUERY_TYPE')
                AND t26.VALUE = t21.TPPS_QUERY_TYPE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t27
             ON     t27.enumeration_key = t26.enumeration_key
                AND t27.VALUE = t26.VALUE
                AND t27.LANGUAGE_CODE = 1
    WHERE t1.SERVICE_VERSION_ID = 1;