DROP VIEW BALANCE_VIEW;

/* Formatted on 28/12/2014 17:17:16 (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW BALANCE_VIEW
(
   BALANCE_ID,
   RESELLER_VERSION_ID,
   SERVICE_VERSION_ID,
   UNIT_TYPE_NAME,
   UNIT_TYPE_ID,
   BALANCE_NAME,
   DESCRIPTION
)
AS
   SELECT t1.BALANCE_ID AS balance_id,                           -- balanceId,
          t2.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
          t5.SERVICE_VERSION_ID,                       -- AS serviceVersionId,
          t6.DISPLAY_VALUE AS unit_type_name,                 -- unitsTypeKey,
          t2.UNIT_TYPE AS unit_type_id,                           -- unitType,
          --       t8.DISPLAY_VALUE AS anncTypePromptRef,
          --       t2.ANNC_TYPE_ID AS anncTypeId,
          --       t2.IS_EXT_EXPOSABLE AS isExtExposable,
          --       t2.IS_INTERNAL AS isInternal,
          --       t2.IS_DEFAULT AS isDefault,
          --       t3.LANGUAGE_CODE AS languageCode,
          t3.DISPLAY_VALUE AS balance_name,                   -- displayValue,
          t3.DESCRIPTION AS description
     FROM cbs_owner.BALANCE_KEY t1
          INNER JOIN cbs_owner.BALANCE_REF t2
             ON t1.BALANCE_ID = t2.BALANCE_ID
          INNER JOIN cbs_owner.BALANCE_VALUES t3
             ON     t2.BALANCE_ID = t3.BALANCE_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.RESELLER_VERSION T100
             ON t100.RESELLER_VERSION_ID = T3.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
             ON t2.UNIT_TYPE = t4.UNIT_TYPE
          INNER JOIN cbs_owner.UNITS_TYPE_REF t5
             ON     t4.UNIT_TYPE = t5.UNIT_TYPE
                AND t5.SERVICE_VERSION_ID = t100.SERVICE_VERSION_ID
          INNER JOIN cbs_owner.UNITS_TYPE_VALUES t6
             ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.ANNC_TYPE_PROMPT_REF t7
             ON t2.ANNC_TYPE_ID = t7.ANNC_TYPE_ID
          LEFT OUTER JOIN cbs_owner.ANNC_TYPE_PROMPT_VALUES t8
             ON     t7.ANNC_TYPE_ID = t8.ANNC_TYPE_ID
                AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t3.LANGUAGE_CODE = 1;


GRANT SELECT ON BALANCE_VIEW TO VNP_COMMON;
