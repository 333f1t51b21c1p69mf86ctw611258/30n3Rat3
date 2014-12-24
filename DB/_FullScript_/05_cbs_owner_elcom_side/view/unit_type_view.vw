DROP VIEW CBS_OWNER.UNIT_TYPE_VIEW;

/* Formatted on 10/12/2014 9:03:06 AM (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW CBS_OWNER.UNIT_TYPE_VIEW
(
   TYPE_ID,
   SERVICE_VERSION_ID,
   TYPE_NAME,
   DESCRIPTION
)
AS
   SELECT t1.UNIT_TYPE AS type_id,                                -- unitType,
          t2.SERVICE_VERSION_ID,                       -- AS serviceVersionId,
          --       t2.IS_USAGE AS isUsage,
          --       t2.IS_RC AS isRc,
          --       t2.IS_DEFAULT AS isDefault,
          --       t2.IS_INTERNAL AS isInternal,
          --       t2.UNIT_CODE AS unitCode,
          --       t3.LANGUAGE_CODE AS languageCode,
          t3.DISPLAY_VALUE AS type_name,                      -- displayValue,
          t3.DESCRIPTION AS description
     FROM cbs_owner.UNITS_TYPE_KEY t1
          INNER JOIN cbs_owner.UNITS_TYPE_REF t2
             ON t1.UNIT_TYPE = t2.UNIT_TYPE
          INNER JOIN cbs_owner.UNITS_TYPE_VALUES t3
             ON     t2.UNIT_TYPE = t3.UNIT_TYPE
                AND t2.SERVICE_VERSION_ID = t3.SERVICE_VERSION_ID
    WHERE t3.LANGUAGE_CODE = 1;


GRANT SELECT ON CBS_OWNER.UNIT_TYPE_VIEW TO VNP_COMMON;
