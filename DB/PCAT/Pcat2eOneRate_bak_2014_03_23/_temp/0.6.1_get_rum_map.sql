
SELECT t1.TARIFF_ID AS tariffId,
       t2.RESELLER_VERSION_ID AS resellerVersionId,
       t5.SERVICE_VERSION_ID AS serviceVersionId,
       t6.DISPLAY_VALUE AS unitsTypeKey,
       t2.UNIT_TYPE AS unitType,
       t8.ISO_CODE AS currencyIsoCode,
       t8.IMPLIED_DECIMAL AS currencyImpliedDecimal,
       t9.DISPLAY_VALUE AS rateCurrencyKey,
       t2.CURRENCY_CODE AS currencyCode,
       t2.FIRST_CON_AMOUNT AS firstConAmount,
       t2.FIRST_CON_CHARGE AS firstConCharge,
       t2.ADD_CON_AMOUNT AS addConAmount,
       t2.ADD_CON_CHARGE AS addConCharge,
       t2.ALLOW_DISCOUNT AS allowDiscount,
       t2.IS_CHARGEBLE AS isChargeble,
       t2.CONVERSION_RQD AS conversionRqd,
       t2.NON_MON_ALLOWED AS nonMonAllowed,
       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description
  FROM cbs_owner.TARIFF_KEY t1
       INNER JOIN cbs_owner.TARIFF_REF t2
          ON t1.TARIFF_ID = t2.TARIFF_ID
       INNER JOIN cbs_owner.TARIFF_VALUES t3
          ON     t2.TARIFF_ID = t3.TARIFF_ID
             AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
       INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
          ON t2.UNIT_TYPE = t4.UNIT_TYPE
       INNER JOIN cbs_owner.UNITS_TYPE_REF t5
          ON t4.UNIT_TYPE = t5.UNIT_TYPE AND t5.SERVICE_VERSION_ID = 1
       INNER JOIN cbs_owner.UNITS_TYPE_VALUES t6
          ON     t4.UNIT_TYPE = t6.UNIT_TYPE
             AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
             AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
       INNER JOIN cbs_owner.RATE_CURRENCY_KEY t7
          ON t2.CURRENCY_CODE = t7.CURRENCY_CODE
       INNER JOIN cbs_owner.RATE_CURRENCY_REF t8
          ON     t7.CURRENCY_CODE = t8.CURRENCY_CODE
             AND t8.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
       INNER JOIN cbs_owner.RATE_CURRENCY_VALUES t9
          ON     t7.CURRENCY_CODE = t9.CURRENCY_CODE
             AND t9.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
             AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
 WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;