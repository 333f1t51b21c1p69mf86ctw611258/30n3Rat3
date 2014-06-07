/* Formatted on 05/03/2014 11:05:47 (QP5 v5.215.12089.38647) */
SELECT t1.UNIT_TYPE AS unitType,
       t2.SERVICE_VERSION_ID AS serviceVersionId,
       t2.IS_USAGE AS isUsage,
       t2.IS_RC AS isRc,
       t2.IS_DEFAULT AS isDefault,
       t2.IS_INTERNAL AS isInternal,
       t2.UNIT_CODE AS unitCode,
       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description
  FROM cbs_owner.UNITS_TYPE_KEY t1
       INNER JOIN cbs_owner.UNITS_TYPE_REF t2
          ON t1.UNIT_TYPE = t2.UNIT_TYPE
       INNER JOIN cbs_owner.UNITS_TYPE_VALUES t3
          ON     t2.UNIT_TYPE = t3.UNIT_TYPE
             AND t2.SERVICE_VERSION_ID = t3.SERVICE_VERSION_ID
 WHERE t2.SERVICE_VERSION_ID = 1 AND t3.LANGUAGE_CODE = 1;