/* Formatted on 12/4/2014 22:04:55 (QP5 v5.227.12220.39754) */
SELECT t1.OFFER_RC_AWARD_MAP_ID AS offerRcAwardMapId,
       t1.RESELLER_VERSION_ID AS resellerVersionId,
       t4.DISPLAY_VALUE AS offerKey,
       t1.OFFER_ID AS offerId,
       t7.DISPLAY_VALUE AS rcTermKey,
       t1.RC_TERM_ID AS rcTermId,
       t10.DISPLAY_VALUE AS balanceKey,
       t1.BALANCE_ID AS balanceId,
       t1.BILL_PERIOD AS billPeriod,
       t1.GENERATION_PERIOD_FREQUENCY AS periodFrequency,
       t1.APPLY_DAY AS applyDay,
       t1.PRO_AWARD_INSF_RC_BAL AS proAwardInsfRcBal,
       t1.AMOUNT AS amount,
       t14.SERVICE_VERSION_ID AS serviceVersionId,
       t14.ISO_CODE AS currencyIsoCode,
       t14.IMPLIED_DECIMAL AS currencyImpliedDecimal,
       t15.DISPLAY_VALUE AS rateCurrencyKey,
       t1.CURRENCY_CODE AS currencyCode,
       t18.DISPLAY_VALUE AS unitsTypeKey,
       t1.UNIT_TYPE AS unitType,
       t20.DISPLAY_VALUE AS grantOrder,
       t22.DISPLAY_VALUE AS action,
       t24.DISPLAY_VALUE AS awardActivationType,
       t1.AWARD_ACTIVATION_OFFSET AS awardActivationOffset,
       t26.DISPLAY_VALUE AS awardExpiryType,
       t28.DISPLAY_VALUE AS awardExpiryOffsetType,
       t1.AWARD_EXPIRY_OFFSET AS awardExpiryOffset,
       t1.AWARD_EXPIRY_DATE AS awardExpiryDate,
       t1.IS_ROLLABLE AS isRollable,
       t30.DISPLAY_VALUE AS rolloverGrouping,
       t1.MAXIMUM_GRANT_ROLLOVER AS maximumGrantRollover,
       t1.MAXIMUM_TOTAL_ROLLOVER AS maximumTotalRollover,
       t1.RC_MULTIPLICATIONS AS rcMultiplications,
       t1.CYCLES_ROLLOVER_EXPIRE AS cyclesRolloverExpire,
       t1.DEFAULT_SET_FUNCTION AS defaultSetFunction
  FROM cbs_owner.OFFER_RC_AWARD_MAP t1
       INNER JOIN cbs_owner.OFFER_KEY t2 ON t1.OFFER_ID = t2.OFFER_ID
       INNER JOIN
       cbs_owner.OFFER_REF t3
          ON     t2.OFFER_ID = t3.OFFER_ID
             AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       INNER JOIN
       cbs_owner.OFFER_VALUES t4
          ON     t2.OFFER_ID = t4.OFFER_ID
             AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t4.LANGUAGE_CODE = 1
       INNER JOIN cbs_owner.RC_TERM_KEY t5 ON t1.RC_TERM_ID = t5.RC_TERM_ID
       INNER JOIN
       cbs_owner.RC_TERM_REF t6
          ON     t5.RC_TERM_ID = t6.RC_TERM_ID
             AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       INNER JOIN
       cbs_owner.RC_TERM_VALUES t7
          ON     t5.RC_TERM_ID = t7.RC_TERM_ID
             AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
       INNER JOIN cbs_owner.BALANCE_KEY t8 ON t1.BALANCE_ID = t8.BALANCE_ID
       INNER JOIN
       cbs_owner.BALANCE_REF t9
          ON     t8.BALANCE_ID = t9.BALANCE_ID
             AND t9.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       INNER JOIN
       cbs_owner.BALANCE_VALUES t10
          ON     t8.BALANCE_ID = t10.BALANCE_ID
             AND t10.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t10.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_KEY t13
          ON t1.CURRENCY_CODE = t13.CURRENCY_CODE
       LEFT OUTER JOIN
       cbs_owner.RATE_CURRENCY_REF t14
          ON     t13.CURRENCY_CODE = t14.CURRENCY_CODE
             AND t14.SERVICE_VERSION_ID = 1
       LEFT OUTER JOIN
       cbs_owner.RATE_CURRENCY_VALUES t15
          ON     t13.CURRENCY_CODE = t15.CURRENCY_CODE
             AND t15.SERVICE_VERSION_ID = 1
             AND t15.LANGUAGE_CODE = t4.LANGUAGE_CODE
       INNER JOIN cbs_owner.UNITS_TYPE_KEY t16
          ON t1.UNIT_TYPE = t16.UNIT_TYPE
       INNER JOIN cbs_owner.UNITS_TYPE_REF t17
          ON t16.UNIT_TYPE = t17.UNIT_TYPE AND t17.SERVICE_VERSION_ID = 1
       INNER JOIN
       cbs_owner.UNITS_TYPE_VALUES t18
          ON     t16.UNIT_TYPE = t18.UNIT_TYPE
             AND t18.SERVICE_VERSION_ID = t17.SERVICE_VERSION_ID
             AND t18.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN
       cbs_owner.GUI_INDICATOR_REF t19
          ON     t19.table_name = 'OFFER_RC_AWARD_MAP'
             AND t19.field_name = LOWER ('GRANT_ORDER')
             AND t19.integer_value = t1.GRANT_ORDER
       LEFT OUTER JOIN
       cbs_owner.GUI_INDICATOR_VALUES t20
          ON     t20.table_name = t19.table_name
             AND t20.field_name = t19.field_name
             AND t20.integer_value = t19.integer_value
             AND t20.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN
       cbs_owner.GUI_INDICATOR_REF t21
          ON     t21.table_name = 'OFFER_RC_AWARD_MAP'
             AND t21.field_name = LOWER ('ACTION')
             AND t21.integer_value = t1.ACTION
       LEFT OUTER JOIN
       cbs_owner.GUI_INDICATOR_VALUES t22
          ON     t22.table_name = t21.table_name
             AND t22.field_name = t21.field_name
             AND t22.integer_value = t21.integer_value
             AND t22.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN
       cbs_owner.GUI_INDICATOR_REF t23
          ON     t23.table_name = 'OFFER_RC_AWARD_MAP'
             AND t23.field_name = LOWER ('AWARD_ACTIVATION_TYPE')
             AND t23.integer_value = t1.AWARD_ACTIVATION_TYPE
       LEFT OUTER JOIN
       cbs_owner.GUI_INDICATOR_VALUES t24
          ON     t24.table_name = t23.table_name
             AND t24.field_name = t23.field_name
             AND t24.integer_value = t23.integer_value
             AND t24.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN
       cbs_owner.GUI_INDICATOR_REF t25
          ON     t25.table_name = 'OFFER_RC_AWARD_MAP'
             AND t25.field_name = LOWER ('AWARD_EXPIRY_TYPE')
             AND t25.integer_value = t1.AWARD_EXPIRY_TYPE
       LEFT OUTER JOIN
       cbs_owner.GUI_INDICATOR_VALUES t26
          ON     t26.table_name = t25.table_name
             AND t26.field_name = t25.field_name
             AND t26.integer_value = t25.integer_value
             AND t26.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN
       cbs_owner.GUI_INDICATOR_REF t27
          ON     t27.table_name = 'OFFER_RC_AWARD_MAP'
             AND t27.field_name = LOWER ('AWARD_EXPIRY_OFFSET_TYPE')
             AND t27.integer_value = t1.AWARD_EXPIRY_OFFSET_TYPE
       LEFT OUTER JOIN
       cbs_owner.GUI_INDICATOR_VALUES t28
          ON     t28.table_name = t27.table_name
             AND t28.field_name = t27.field_name
             AND t28.integer_value = t27.integer_value
             AND t28.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN
       cbs_owner.GENERIC_ENUMERATION_REF t29
          ON     t29.enumeration_key = LOWER ('ROLLOVER_GROUPING')
             AND t29.VALUE = t1.ROLLOVER_GROUPING
       LEFT OUTER JOIN
       cbs_owner.GENERIC_ENUMERATION_VALUES t30
          ON     t30.enumeration_key = t29.enumeration_key
             AND t30.VALUE = t29.VALUE
             AND t30.LANGUAGE_CODE = t4.LANGUAGE_CODE
 WHERE t1.RESELLER_VERSION_ID = 2;