DROP VIEW CBS_OWNER.RC_RATE_VIEW;

/* Formatted on 10/12/2014 9:03:00 AM (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW CBS_OWNER.RC_RATE_VIEW
(
   RC_RATE_ID,
   RESELLER_VERSION_ID,
   SERVICE_VERSION_ID,
   RC_TERM_NAME,
   RC_TERM_ID,
   OFFER_ID,
   PERIOD_FREQUENCE,
   CURRENCY_NAME,
   CURRENCY_CODE,
   RATE
)
AS
   SELECT t1.RATE_RC_ID AS rc_rate_id,                            -- rateRcId,
          t1.RESELLER_VERSION_ID,                     -- AS resellerVersionId,
          t16.SERVICE_VERSION_ID,                      -- AS serviceVersionId,
          t4.DISPLAY_VALUE AS rc_term_name,                      -- rcTermKey,
          t1.RC_TERM_ID AS rc_term_id,                            -- rcTermId,
          --       t1.RATE_CLASS AS rateClass,
          t1.OFFER_ID,                                          -- AS offerId,
          --       t6.DISPLAY_VALUE AS equipTypeCodeRef,
          --       t1.EQUIP_TYPE_CODE AS equipTypeCode,
          --       t8.DISPLAY_VALUE AS equipClassCodeRef,
          --       t1.EQUIP_CLASS_CODE AS equipClassCode,
          --       t10.DISPLAY_VALUE AS classOfServiceCodeRef,
          --       t1.CLASS_OF_SERVICE_CODE AS classOfServiceCode,
          --       t12.DISPLAY_VALUE AS typeIdRc,
          t14.DISPLAY_VALUE AS period_frequence,           -- periodFrequency,
          --       t16.ISO_CODE AS currencyIsoCode,
          --       t16.IMPLIED_DECIMAL AS currencyImpliedDecimal,
          t17.DISPLAY_VALUE AS currency_name,              -- rateCurrencyKey,
          t1.CURRENCY_CODE AS currency_code,                  -- currencyCode,
          t1.RATE AS rate                                                 -- ,
     --       t1.JURISDICTION AS jurisdiction,
     --       t1.DISTANCE_INCREMENT AS distanceIncrement,
     --       t1.UNIT_TYPE AS unitType,
     --       t1.UNITS_LOWER_LIMIT AS unitsLowerLimit,
     --       t1.UNITS_UPPER_LIMIT AS unitsUpperLimit,
     --       t1.UNITS_RATE AS unitsRate,
     --       t1.POP_LOWER_LIMIT AS popLowerLimit,
     --       t1.POP_UPPER_LIMIT AS popUpperLimit,
     --       t1.DISTANCE_RATE AS distanceRate,
     --       t1.ADD_IMPLIED_DECIMALS AS addImpliedDecimals,
     --       t1.DATE_CREATED AS dateCreated,
     --       t1.FOREIGN_CODE AS foreignCode,
     --       t1.IS_DEFAULT_RATE AS isDefaultRate
     FROM cbs_owner.RATE_RC t1
          INNER JOIN cbs_owner.RC_TERM_KEY t2
             ON t1.RC_TERM_ID = t2.RC_TERM_ID
          INNER JOIN cbs_owner.RC_TERM_REF t3
             ON     t2.RC_TERM_ID = t3.RC_TERM_ID
                AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.RESELLER_VERSION T100
             ON t100.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.RC_TERM_VALUES t4
             ON     t2.RC_TERM_ID = t4.RC_TERM_ID
                AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t4.LANGUAGE_CODE = 1
          LEFT OUTER JOIN cbs_owner.EQUIP_TYPE_CODE_REF t5
             ON t1.EQUIP_TYPE_CODE = t5.EQUIP_TYPE_CODE
          LEFT OUTER JOIN cbs_owner.EQUIP_TYPE_CODE_VALUES t6
             ON     t5.EQUIP_TYPE_CODE = t6.EQUIP_TYPE_CODE
                AND t6.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.EQUIP_CLASS_CODE_REF t7
             ON t1.EQUIP_CLASS_CODE = t7.EQUIP_CLASS_CODE
          LEFT OUTER JOIN cbs_owner.EQUIP_CLASS_CODE_VALUES t8
             ON     t7.EQUIP_CLASS_CODE = t8.EQUIP_CLASS_CODE
                AND t8.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.CLASS_OF_SERVICE_CODE_REF t9
             ON t1.CLASS_OF_SERVICE_CODE = t9.CLASS_OF_SERVICE_CODE
          LEFT OUTER JOIN cbs_owner.CLASS_OF_SERVICE_CODE_VALUES t10
             ON     t9.CLASS_OF_SERVICE_CODE = t10.CLASS_OF_SERVICE_CODE
                AND t10.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_REF t11
             ON     t11.enumeration_key = LOWER ('TYPE_ID_RC')
                AND t11.VALUE = t1.TYPE_ID_RC
          LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_VALUES t12
             ON     t12.enumeration_key = t11.enumeration_key
                AND t12.VALUE = t11.VALUE
                AND t12.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_REF t13
             ON     t13.table_name = 'RATE_RC'
                AND t13.field_name = LOWER ('PERIOD_FREQUENCY')
                AND t13.integer_value = t1.PERIOD_FREQUENCY
          LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_VALUES t14
             ON     t14.table_name = t13.table_name
                AND t14.field_name = t13.field_name
                AND t14.integer_value = t13.integer_value
                AND t14.LANGUAGE_CODE = t4.LANGUAGE_CODE
          INNER JOIN cbs_owner.RATE_CURRENCY_KEY t15
             ON t1.CURRENCY_CODE = t15.CURRENCY_CODE
          INNER JOIN cbs_owner.RATE_CURRENCY_REF t16
             ON     t15.CURRENCY_CODE = t16.CURRENCY_CODE
                AND t16.SERVICE_VERSION_ID = t100.SERVICE_VERSION_ID
          INNER JOIN cbs_owner.RATE_CURRENCY_VALUES t17
             ON     t15.CURRENCY_CODE = t17.CURRENCY_CODE
                AND t17.SERVICE_VERSION_ID = t16.SERVICE_VERSION_ID
                AND t17.LANGUAGE_CODE = t4.LANGUAGE_CODE;


GRANT SELECT ON CBS_OWNER.RC_RATE_VIEW TO VNP_COMMON;
