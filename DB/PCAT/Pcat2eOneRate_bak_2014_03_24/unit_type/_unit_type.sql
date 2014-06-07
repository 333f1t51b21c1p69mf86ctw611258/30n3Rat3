/* Formatted on 3/19/2014 9:59:17 PM (QP5 v5.227.12220.39754) */
SELECT t1.UNIT_TYPE AS type_id,                                   -- unitType,
       --       t2.SERVICE_VERSION_ID AS serviceVersionId,
       --       t2.IS_USAGE AS isUsage,
       --       t2.IS_RC AS isRc,
       --       t2.IS_DEFAULT AS isDefault,
       --       t2.IS_INTERNAL AS isInternal,
       --       t2.UNIT_CODE AS unitCode,
       --       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS type_name,                         -- displayValue,
       t3.DESCRIPTION AS description
  FROM UNITS_TYPE_KEY t1
       INNER JOIN UNITS_TYPE_REF t2 ON t1.UNIT_TYPE = t2.UNIT_TYPE
       INNER JOIN
       UNITS_TYPE_VALUES t3
          ON     t2.UNIT_TYPE = t3.UNIT_TYPE
             AND t2.SERVICE_VERSION_ID = t3.SERVICE_VERSION_ID
 WHERE t2.SERVICE_VERSION_ID = 1 AND t3.LANGUAGE_CODE = 1;