DROP VIEW USAGE_ACTIVITY_VIEW;

/* Formatted on 28/12/2014 17:17:29 (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW USAGE_ACTIVITY_VIEW
(
   UA_ID,
   UA_NAME,
   RESELLER_VERSION_ID,
   SERVICE_VERSION_ID,
   UNIT_TYPE_NAME,
   UNIT_TYPE_ID,
   SUB_TYPE_NAME,
   SUB_TYPE_ID,
   APP_NAME,
   APP_ID,
   UA_INITIAL_NAME,
   UA_INITIAL_ID,
   TAX_CLASS_NAME,
   TAX_CLASS_ID,
   DESCRIPTION
)
AS
   SELECT t1.AUT_ID AS ua_id,                                        -- autId,
          t3.DISPLAY_VALUE AS ua_name,                        -- displayValue,
          t2.RESELLER_VERSION_ID,                     -- AS resellerVersionId,
          --       t2.IS_PRERATED AS isPrerated,
          --       t2.OPEN_ITEM_ID AS openItemId,
          --       t2.IS_LATE_FEE_EXEMPT AS isLateFeeExempt,
          t27.SERVICE_VERSION_ID,                      -- AS serviceVersionId,
          t28.DISPLAY_VALUE AS unit_type_name,                -- unitsTypeKey,
          t2.UNIT_TYPE AS unit_type_id,                           -- unitType,
          t13.DISPLAY_VALUE AS sub_type_name,                 -- subTypeIdKey,
          t2.SUB_TYPE_ID AS sub_type_id,                         -- subTypeId,
          t16.DISPLAY_VALUE AS app_name,                  -- applicationIdKey,
          t2.APPLICATION_ID AS app_id,                       -- applicationId,
          t19.DISPLAY_VALUE AS ua_initial_name,              -- autInitialKey,
          T19.INITIAL_AUT_ID AS ua_initial_id,
          --       t2.GENERATED_FROM AS generatedFrom,
          --       t2.ACTIVITY_CHAR_IDS AS activityCharIds,
          t22.DISPLAY_VALUE AS tax_class_name,                 -- taxClassKey,
          t2.TAX_CLASS AS tax_class_id,                           -- taxClass,
          --       t33.DISPLAY_VALUE AS productLineKey,
          --       t2.PRODUCT_LINE_ID AS productLineId,
          --       t36.DISPLAY_VALUE AS ratableUnitClassKey,
          --       t2.RATABLE_UNIT_CLASS AS ratableUnitClass,
          --       t3.LANGUAGE_CODE AS languageCode,
          t3.DESCRIPTION AS description
     FROM cbs_owner.AUT_FINAL_KEY t1
          INNER JOIN cbs_owner.AUT_FINAL_REF t2
             ON t1.AUT_ID = t2.AUT_ID
          INNER JOIN cbs_owner.AUT_FINAL_VALUES t3
             ON     t2.AUT_ID = t3.AUT_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.RESELLER_VERSION T100
             ON t100.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.UNITS_TYPE_KEY t26
             ON t2.UNIT_TYPE = t26.UNIT_TYPE
          INNER JOIN cbs_owner.UNITS_TYPE_REF t27
             ON     t26.UNIT_TYPE = t27.UNIT_TYPE
                AND t27.SERVICE_VERSION_ID = t100.SERVICE_VERSION_ID
          INNER JOIN cbs_owner.UNITS_TYPE_VALUES t28
             ON     t26.UNIT_TYPE = t28.UNIT_TYPE
                AND t28.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                AND t28.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.SUB_TYPE_ID_KEY t11
             ON t2.SUB_TYPE_ID = t11.SUB_TYPE_ID
          LEFT OUTER JOIN cbs_owner.SUB_TYPE_ID_REF t12
             ON     t11.SUB_TYPE_ID = t12.SUB_TYPE_ID
                AND t12.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
          LEFT OUTER JOIN cbs_owner.SUB_TYPE_ID_VALUES t13
             ON     t11.SUB_TYPE_ID = t13.SUB_TYPE_ID
                AND t13.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                AND t13.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.APPLICATION_ID_KEY t14
             ON t2.APPLICATION_ID = t14.APPLICATION_ID
          LEFT OUTER JOIN cbs_owner.APPLICATION_ID_REF t15
             ON     t14.APPLICATION_ID = t15.APPLICATION_ID
                AND t15.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
          LEFT OUTER JOIN cbs_owner.APPLICATION_ID_VALUES t16
             ON     t14.APPLICATION_ID = t16.APPLICATION_ID
                AND t16.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                AND t16.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.AUT_INITIAL_KEY t17
             ON t2.GENERATED_FROM = t17.INITIAL_AUT_ID
          LEFT OUTER JOIN cbs_owner.AUT_INITIAL_REF t18
             ON     t17.INITIAL_AUT_ID = t18.INITIAL_AUT_ID
                AND t18.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
          LEFT OUTER JOIN cbs_owner.AUT_INITIAL_VALUES t19
             ON     t17.INITIAL_AUT_ID = t19.INITIAL_AUT_ID
                AND t19.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                AND t19.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.TAX_CLASS_KEY t20
             ON t2.TAX_CLASS = t20.TAX_CLASS
          LEFT OUTER JOIN cbs_owner.TAX_CLASS_REF t21
             ON     t20.TAX_CLASS = t21.TAX_CLASS
                AND t21.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.TAX_CLASS_VALUES t22
             ON     t20.TAX_CLASS = t22.TAX_CLASS
                AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t22.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.PRODUCT_LINE_KEY t31
             ON t2.PRODUCT_LINE_ID = t31.PRODUCT_LINE_ID
          LEFT OUTER JOIN cbs_owner.PRODUCT_LINE_REF t32
             ON     t31.PRODUCT_LINE_ID = t32.PRODUCT_LINE_ID
                AND t32.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.PRODUCT_LINE_VALUES t33
             ON     t31.PRODUCT_LINE_ID = t33.PRODUCT_LINE_ID
                AND t33.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t33.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.RATABLE_UNIT_CLASS_KEY t34
             ON t2.RATABLE_UNIT_CLASS = t34.RATABLE_UNIT_CLASS
          LEFT OUTER JOIN cbs_owner.RATABLE_UNIT_CLASS_REF t35
             ON     t34.RATABLE_UNIT_CLASS = t35.RATABLE_UNIT_CLASS
                AND t35.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
          LEFT OUTER JOIN cbs_owner.RATABLE_UNIT_CLASS_VALUES t36
             ON     t34.RATABLE_UNIT_CLASS = t36.RATABLE_UNIT_CLASS
                AND t36.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                AND t36.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t3.LANGUAGE_CODE = 1;


GRANT SELECT ON USAGE_ACTIVITY_VIEW TO VNP_COMMON;
