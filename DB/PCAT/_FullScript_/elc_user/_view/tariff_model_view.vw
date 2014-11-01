DROP VIEW ELC_USER.TARIFF_MODEL_VIEW;

/* Formatted on 22/05/2014 15:15:14 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW ELC_USER.TARIFF_MODEL_VIEW
(
   TARIFF_MODEL_ID,
   TARIFF_MODEL_NAME,
   RESELLER_VERSION_ID,
   STEP,
   TIER_FROM,
   TIER_TO,
   BEAT,
   FACTOR,
   CHARGE_BASE,
   DESCRIPTION
)
AS
   SELECT t1.TARIFF_ID AS tariff_model_id,                        -- tariffId,
          t3.DISPLAY_VALUE AS tariff_model_name,              -- displayValue,
          t2.RESELLER_VERSION_ID,                     -- AS resellerVersionId,
          --       t5.SERVICE_VERSION_ID AS serviceVersionId,
          --       t6.DISPLAY_VALUE AS unitsTypeKey,
          --       t2.UNIT_TYPE AS unitType,
          --       t8.ISO_CODE AS currencyIsoCode,
          --       t8.IMPLIED_DECIMAL AS currencyImpliedDecimal,
          --       t9.DISPLAY_VALUE AS rateCurrencyKey,
          --       t2.CURRENCY_CODE AS currencyCode,

          -- *** add and modify
          1 AS STEP,
          0 AS TIER_FROM,
          t2.FIRST_CON_AMOUNT AS TIER_TO,                   -- firstConAmount,
          t2.FIRST_CON_AMOUNT AS BEAT,                      -- firstConAmount,
          t2.FIRST_CON_CHARGE AS FACTOR,                    -- firstConCharge,
          t2.FIRST_CON_AMOUNT AS CHARGE_BASE,               -- firstConAmount,
          --       t2.ADD_CON_AMOUNT AS addConAmount,
          --       t2.ADD_CON_CHARGE AS addConCharge,
          -- ### add and modify


          --       t2.ALLOW_DISCOUNT AS allowDiscount,
          --       t2.IS_CHARGEBLE AS isChargeble,
          --       t2.CONVERSION_RQD AS conversionRqd,
          --       t11.DISPLAY_VALUE AS tariffCategory,
          --       t2.NON_MON_ALLOWED AS nonMonAllowed,
          --       t3.LANGUAGE_CODE AS languageCode,

          t3.DESCRIPTION AS description
     FROM cbs_owner.TARIFF_KEY t1
          INNER JOIN cbs_owner.TARIFF_REF t2 ON t1.TARIFF_ID = t2.TARIFF_ID
          INNER JOIN
          cbs_owner.TARIFF_VALUES t3
             ON     t2.TARIFF_ID = t3.TARIFF_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
             ON t2.UNIT_TYPE = t4.UNIT_TYPE
          INNER JOIN cbs_owner.UNITS_TYPE_REF t5
             ON t4.UNIT_TYPE = t5.UNIT_TYPE AND t5.SERVICE_VERSION_ID = 1
          INNER JOIN
          cbs_owner.UNITS_TYPE_VALUES t6
             ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.RATE_CURRENCY_KEY t7
             ON t2.CURRENCY_CODE = t7.CURRENCY_CODE
          INNER JOIN
          cbs_owner.RATE_CURRENCY_REF t8
             ON     t7.CURRENCY_CODE = t8.CURRENCY_CODE
                AND t8.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
          INNER JOIN
          cbs_owner.RATE_CURRENCY_VALUES t9
             ON     t7.CURRENCY_CODE = t9.CURRENCY_CODE
                AND t9.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t10
             ON     t10.enumeration_key = LOWER ('TARIFF_CATEGORY')
                AND t10.VALUE = t2.TARIFF_CATEGORY
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t11
             ON     t11.enumeration_key = t10.enumeration_key
                AND t11.VALUE = t10.VALUE
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t3.LANGUAGE_CODE = 1 AND t6.DISPLAY_VALUE = 'SECONDS'
   UNION
   SELECT t1.TARIFF_ID AS tariff_model_id,
          t3.DISPLAY_VALUE AS tariff_model_name,
          t2.RESELLER_VERSION_ID,                     -- AS resellerVersionId,
          --       t5.SERVICE_VERSION_ID AS serviceVersionId,
          --       t6.DISPLAY_VALUE AS unitsTypeKey,
          --       t2.UNIT_TYPE AS unitType,
          --       t8.ISO_CODE AS currencyIsoCode,
          --       t8.IMPLIED_DECIMAL AS currencyImpliedDecimal,
          --       t9.DISPLAY_VALUE AS rateCurrencyKey,
          --       t2.CURRENCY_CODE AS currencyCode,

          -- *** add and modify
          2 AS STEP,
          t2.FIRST_CON_AMOUNT AS TIER_FROM,                  -- firstConAmount
          86868686 AS TIER_TO,
          --        t2.FIRST_CON_AMOUNT as firstConAmount,
          --        t2.FIRST_CON_CHARGE as firstConCharge,
          t2.ADD_CON_AMOUNT AS BEAT,                          -- addConAmount,
          t2.ADD_CON_CHARGE AS FACTOR,                        -- addConCharge,
          t2.ADD_CON_AMOUNT AS CHARGE_BASE,                   -- addConAmount,
          -- ### add and modify


          --       t2.ALLOW_DISCOUNT AS allowDiscount,
          --       t2.IS_CHARGEBLE AS isChargeble,
          --       t2.CONVERSION_RQD AS conversionRqd,
          --       t11.DISPLAY_VALUE AS tariffCategory,
          --       t2.NON_MON_ALLOWED AS nonMonAllowed,
          --       t3.LANGUAGE_CODE AS languageCode,

          t3.DESCRIPTION AS description
     FROM cbs_owner.TARIFF_KEY t1
          INNER JOIN cbs_owner.TARIFF_REF t2 ON t1.TARIFF_ID = t2.TARIFF_ID
          INNER JOIN
          cbs_owner.TARIFF_VALUES t3
             ON     t2.TARIFF_ID = t3.TARIFF_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
             ON t2.UNIT_TYPE = t4.UNIT_TYPE
          INNER JOIN cbs_owner.UNITS_TYPE_REF t5
             ON t4.UNIT_TYPE = t5.UNIT_TYPE AND t5.SERVICE_VERSION_ID = 1
          INNER JOIN
          cbs_owner.UNITS_TYPE_VALUES t6
             ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.RATE_CURRENCY_KEY t7
             ON t2.CURRENCY_CODE = t7.CURRENCY_CODE
          INNER JOIN
          cbs_owner.RATE_CURRENCY_REF t8
             ON     t7.CURRENCY_CODE = t8.CURRENCY_CODE
                AND t8.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
          INNER JOIN
          cbs_owner.RATE_CURRENCY_VALUES t9
             ON     t7.CURRENCY_CODE = t9.CURRENCY_CODE
                AND t9.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t10
             ON     t10.enumeration_key = LOWER ('TARIFF_CATEGORY')
                AND t10.VALUE = t2.TARIFF_CATEGORY
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t11
             ON     t11.enumeration_key = t10.enumeration_key
                AND t11.VALUE = t10.VALUE
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t3.LANGUAGE_CODE = 1 AND t6.DISPLAY_VALUE = 'SECONDS'
   UNION
   SELECT t1.TARIFF_ID AS tariff_model_id,
          t3.DISPLAY_VALUE AS tariff_model_name,
          t2.RESELLER_VERSION_ID,                     -- AS resellerVersionId,
          --       t5.SERVICE_VERSION_ID AS serviceVersionId,
          --       t6.DISPLAY_VALUE AS unitsTypeKey,
          --       t2.UNIT_TYPE AS unitType,
          --       t8.ISO_CODE AS currencyIsoCode,
          --       t8.IMPLIED_DECIMAL AS currencyImpliedDecimal,
          --       t9.DISPLAY_VALUE AS rateCurrencyKey,
          --       t2.CURRENCY_CODE AS currencyCode,

          -- *** add and modify
          1 AS STEP,
          0 AS TIER_FROM,
          1 AS TIER_TO,
          t2.FIRST_CON_AMOUNT AS BEAT,                      -- firstConAmount,
          t2.FIRST_CON_CHARGE AS FACTOR,                    -- firstConCharge,
          t2.FIRST_CON_AMOUNT AS CHARGE_BASE,               -- firstConAmount,
          --    t2.ADD_CON_AMOUNT as addConAmount,
          --    t2.ADD_CON_CHARGE as addConCharge,
          -- ### add and modify


          --       t2.ALLOW_DISCOUNT AS allowDiscount,
          --       t2.IS_CHARGEBLE AS isChargeble,
          --       t2.CONVERSION_RQD AS conversionRqd,
          --       t11.DISPLAY_VALUE AS tariffCategory,
          --       t2.NON_MON_ALLOWED AS nonMonAllowed,
          --       t3.LANGUAGE_CODE AS languageCode,

          t3.DESCRIPTION AS description
     FROM cbs_owner.TARIFF_KEY t1
          INNER JOIN cbs_owner.TARIFF_REF t2 ON t1.TARIFF_ID = t2.TARIFF_ID
          INNER JOIN
          cbs_owner.TARIFF_VALUES t3
             ON     t2.TARIFF_ID = t3.TARIFF_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
             ON t2.UNIT_TYPE = t4.UNIT_TYPE
          INNER JOIN cbs_owner.UNITS_TYPE_REF t5
             ON t4.UNIT_TYPE = t5.UNIT_TYPE AND t5.SERVICE_VERSION_ID = 1
          INNER JOIN
          cbs_owner.UNITS_TYPE_VALUES t6
             ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.RATE_CURRENCY_KEY t7
             ON t2.CURRENCY_CODE = t7.CURRENCY_CODE
          INNER JOIN
          cbs_owner.RATE_CURRENCY_REF t8
             ON     t7.CURRENCY_CODE = t8.CURRENCY_CODE
                AND t8.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
          INNER JOIN
          cbs_owner.RATE_CURRENCY_VALUES t9
             ON     t7.CURRENCY_CODE = t9.CURRENCY_CODE
                AND t9.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t10
             ON     t10.enumeration_key = LOWER ('TARIFF_CATEGORY')
                AND t10.VALUE = t2.TARIFF_CATEGORY
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t11
             ON     t11.enumeration_key = t10.enumeration_key
                AND t11.VALUE = t10.VALUE
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t3.LANGUAGE_CODE = 1 AND t6.DISPLAY_VALUE = 'SMS'
   UNION
   SELECT t1.TARIFF_ID AS tariff_model_id,
          t3.DISPLAY_VALUE AS tariff_model_name,
          t2.RESELLER_VERSION_ID,                     -- AS resellerVersionId,
          --       t5.SERVICE_VERSION_ID AS serviceVersionId,
          --       t6.DISPLAY_VALUE AS unitsTypeKey,
          --       t2.UNIT_TYPE AS unitType,
          --       t8.ISO_CODE AS currencyIsoCode,
          --       t8.IMPLIED_DECIMAL AS currencyImpliedDecimal,
          --       t9.DISPLAY_VALUE AS rateCurrencyKey,
          --       t2.CURRENCY_CODE AS currencyCode,

          -- *** add and modify
          1 AS STEP,
          0 AS TIER_FROM,
          1 AS TIER_TO,
          t2.FIRST_CON_AMOUNT AS BEAT,                      -- firstConAmount,
          t2.FIRST_CON_CHARGE AS FACTOR,                    -- firstConCharge,
          t2.FIRST_CON_AMOUNT AS CHARGE_BASE,               -- firstConAmount,
          --    t2.ADD_CON_AMOUNT as addConAmount,
          --    t2.ADD_CON_CHARGE as addConCharge,
          -- ### add and modify


          --       t2.ALLOW_DISCOUNT AS allowDiscount,
          --       t2.IS_CHARGEBLE AS isChargeble,
          --       t2.CONVERSION_RQD AS conversionRqd,
          --       t11.DISPLAY_VALUE AS tariffCategory,
          --       t2.NON_MON_ALLOWED AS nonMonAllowed,
          --       t3.LANGUAGE_CODE AS languageCode,

          t3.DESCRIPTION AS description
     FROM cbs_owner.TARIFF_KEY t1
          INNER JOIN cbs_owner.TARIFF_REF t2 ON t1.TARIFF_ID = t2.TARIFF_ID
          INNER JOIN
          cbs_owner.TARIFF_VALUES t3
             ON     t2.TARIFF_ID = t3.TARIFF_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
             ON t2.UNIT_TYPE = t4.UNIT_TYPE
          INNER JOIN cbs_owner.UNITS_TYPE_REF t5
             ON t4.UNIT_TYPE = t5.UNIT_TYPE AND t5.SERVICE_VERSION_ID = 1
          INNER JOIN
          cbs_owner.UNITS_TYPE_VALUES t6
             ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.RATE_CURRENCY_KEY t7
             ON t2.CURRENCY_CODE = t7.CURRENCY_CODE
          INNER JOIN
          cbs_owner.RATE_CURRENCY_REF t8
             ON     t7.CURRENCY_CODE = t8.CURRENCY_CODE
                AND t8.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
          INNER JOIN
          cbs_owner.RATE_CURRENCY_VALUES t9
             ON     t7.CURRENCY_CODE = t9.CURRENCY_CODE
                AND t9.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t10
             ON     t10.enumeration_key = LOWER ('TARIFF_CATEGORY')
                AND t10.VALUE = t2.TARIFF_CATEGORY
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t11
             ON     t11.enumeration_key = t10.enumeration_key
                AND t11.VALUE = t10.VALUE
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t3.LANGUAGE_CODE = 1 AND t6.DISPLAY_VALUE = 'MMS'
   UNION
   SELECT t1.TARIFF_ID AS tariff_model_id,
          t3.DISPLAY_VALUE AS tariff_model_name,
          t2.RESELLER_VERSION_ID,                     -- AS resellerVersionId,
          --       t5.SERVICE_VERSION_ID AS serviceVersionId,
          --       t6.DISPLAY_VALUE AS unitsTypeKey,
          --       t2.UNIT_TYPE AS unitType,
          --       t8.ISO_CODE AS currencyIsoCode,
          --       t8.IMPLIED_DECIMAL AS currencyImpliedDecimal,
          --       t9.DISPLAY_VALUE AS rateCurrencyKey,
          --       t2.CURRENCY_CODE AS currencyCode,

          -- *** add and modify
          1 AS STEP,
          0 AS TIER_FROM,
          t2.FIRST_CON_AMOUNT AS TIER_TO,                   -- firstConAmount,
          t2.FIRST_CON_AMOUNT AS BEAT,                      -- firstConAmount,
          t2.FIRST_CON_CHARGE AS FACTOR,                    -- firstConCharge,
          t2.FIRST_CON_AMOUNT AS CHARGE_BASE,               -- firstConAmount,
          --       t2.ADD_CON_AMOUNT AS addConAmount,
          --       t2.ADD_CON_CHARGE AS addConCharge,
          -- ### add and modify


          --       t2.ALLOW_DISCOUNT AS allowDiscount,
          --       t2.IS_CHARGEBLE AS isChargeble,
          --       t2.CONVERSION_RQD AS conversionRqd,
          --       t11.DISPLAY_VALUE AS tariffCategory,
          --       t2.NON_MON_ALLOWED AS nonMonAllowed,
          --       t3.LANGUAGE_CODE AS languageCode,

          t3.DESCRIPTION AS description
     FROM cbs_owner.TARIFF_KEY t1
          INNER JOIN cbs_owner.TARIFF_REF t2 ON t1.TARIFF_ID = t2.TARIFF_ID
          INNER JOIN
          cbs_owner.TARIFF_VALUES t3
             ON     t2.TARIFF_ID = t3.TARIFF_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
             ON t2.UNIT_TYPE = t4.UNIT_TYPE
          INNER JOIN cbs_owner.UNITS_TYPE_REF t5
             ON t4.UNIT_TYPE = t5.UNIT_TYPE AND t5.SERVICE_VERSION_ID = 1
          INNER JOIN
          cbs_owner.UNITS_TYPE_VALUES t6
             ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.RATE_CURRENCY_KEY t7
             ON t2.CURRENCY_CODE = t7.CURRENCY_CODE
          INNER JOIN
          cbs_owner.RATE_CURRENCY_REF t8
             ON     t7.CURRENCY_CODE = t8.CURRENCY_CODE
                AND t8.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
          INNER JOIN
          cbs_owner.RATE_CURRENCY_VALUES t9
             ON     t7.CURRENCY_CODE = t9.CURRENCY_CODE
                AND t9.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t10
             ON     t10.enumeration_key = LOWER ('TARIFF_CATEGORY')
                AND t10.VALUE = t2.TARIFF_CATEGORY
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t11
             ON     t11.enumeration_key = t10.enumeration_key
                AND t11.VALUE = t10.VALUE
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t3.LANGUAGE_CODE = 1 AND t6.DISPLAY_VALUE = 'OCTET'
   UNION
   SELECT t1.TARIFF_ID AS tariff_model_id,
          t3.DISPLAY_VALUE AS tariff_model_name,
          t2.RESELLER_VERSION_ID,                     -- AS resellerVersionId,
          --       t5.SERVICE_VERSION_ID AS serviceVersionId,
          --       t6.DISPLAY_VALUE AS unitsTypeKey,
          --       t2.UNIT_TYPE AS unitType,
          --       t8.ISO_CODE AS currencyIsoCode,
          --       t8.IMPLIED_DECIMAL AS currencyImpliedDecimal,
          --       t9.DISPLAY_VALUE AS rateCurrencyKey,
          --       t2.CURRENCY_CODE AS currencyCode,

          -- *** add and modify
          2 AS STEP,
          t2.FIRST_CON_AMOUNT AS TIER_FROM,                  -- firstConAmount
          86868686 AS TIER_TO,
          --        t2.FIRST_CON_AMOUNT as firstConAmount,
          --        t2.FIRST_CON_CHARGE as firstConCharge,
          t2.ADD_CON_AMOUNT AS BEAT,                          -- addConAmount,
          t2.ADD_CON_CHARGE AS FACTOR,                        -- addConCharge,
          t2.ADD_CON_AMOUNT AS CHARGE_BASE,                   -- addConAmount,
          -- ### add and modify


          --       t2.ALLOW_DISCOUNT AS allowDiscount,
          --       t2.IS_CHARGEBLE AS isChargeble,
          --       t2.CONVERSION_RQD AS conversionRqd,
          --       t11.DISPLAY_VALUE AS tariffCategory,
          --       t2.NON_MON_ALLOWED AS nonMonAllowed,
          --       t3.LANGUAGE_CODE AS languageCode,

          t3.DESCRIPTION AS description
     FROM cbs_owner.TARIFF_KEY t1
          INNER JOIN cbs_owner.TARIFF_REF t2 ON t1.TARIFF_ID = t2.TARIFF_ID
          INNER JOIN
          cbs_owner.TARIFF_VALUES t3
             ON     t2.TARIFF_ID = t3.TARIFF_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
             ON t2.UNIT_TYPE = t4.UNIT_TYPE
          INNER JOIN cbs_owner.UNITS_TYPE_REF t5
             ON t4.UNIT_TYPE = t5.UNIT_TYPE AND t5.SERVICE_VERSION_ID = 1
          INNER JOIN
          cbs_owner.UNITS_TYPE_VALUES t6
             ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.RATE_CURRENCY_KEY t7
             ON t2.CURRENCY_CODE = t7.CURRENCY_CODE
          INNER JOIN
          cbs_owner.RATE_CURRENCY_REF t8
             ON     t7.CURRENCY_CODE = t8.CURRENCY_CODE
                AND t8.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
          INNER JOIN
          cbs_owner.RATE_CURRENCY_VALUES t9
             ON     t7.CURRENCY_CODE = t9.CURRENCY_CODE
                AND t9.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t10
             ON     t10.enumeration_key = LOWER ('TARIFF_CATEGORY')
                AND t10.VALUE = t2.TARIFF_CATEGORY
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t11
             ON     t11.enumeration_key = t10.enumeration_key
                AND t11.VALUE = t10.VALUE
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t3.LANGUAGE_CODE = 1 AND t6.DISPLAY_VALUE = 'OCTET';
