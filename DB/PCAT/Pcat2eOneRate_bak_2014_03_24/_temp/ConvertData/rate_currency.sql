/* Formatted on 04/03/2014 16:49:56 (QP5 v5.215.12089.38647) */
SELECT t1.CURRENCY_CODE AS currencyCode,
       t2.SERVICE_VERSION_ID AS serviceVersionId,
       t5.DISPLAY_VALUE AS currencyTypeRef,
       t2.CURRENCY_TYPE AS currencyType,
       t2.IMPLIED_DECIMAL AS impliedDecimal,
       t2.ACTIVE_DATE AS activeDate,
       t2.INACTIVE_DATE AS inactiveDate,
       t2.FORMAT_CODE AS formatCode,
       t2.ROUNDING_FACTOR AS roundingFactor,
       t2.IS_CONVERSION_DEFAULT AS isConversionDefault,
       t2.IS_SYMBOL_FIRST AS isSymbolFirst,
       t2.IS_DEFAULT AS isDefault,
       t2.IS_INTERNAL AS isInternal,
       t2.EXT_DISPLAY_IMPLIED_DECIMAL AS extDisplayImpliedDecimal,
       t2.ISO_CODE AS isoCode,
       t2.ISO_NUMBER AS isoNumber,
       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description
  FROM cbs_owner.RATE_CURRENCY_KEY t1
       INNER JOIN cbs_owner.RATE_CURRENCY_REF t2
          ON t1.CURRENCY_CODE = t2.CURRENCY_CODE
       INNER JOIN cbs_owner.RATE_CURRENCY_VALUES t3
          ON     t2.CURRENCY_CODE = t3.CURRENCY_CODE
             AND t2.SERVICE_VERSION_ID = t3.SERVICE_VERSION_ID
       INNER JOIN cbs_owner.CURRENCY_TYPE_REF t4
          ON t2.CURRENCY_TYPE = t4.CURRENCY_TYPE
       INNER JOIN cbs_owner.CURRENCY_TYPE_VALUES t5
          ON     t4.CURRENCY_TYPE = t5.CURRENCY_TYPE
             AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
 WHERE t2.SERVICE_VERSION_ID = 1 AND t3.LANGUAGE_CODE = 1 and t1.CURRENCY_CODE = 267;