/* Formatted on 06/03/2014 11:24:55 (QP5 v5.215.12089.38647) */
--   PRICE_GROUP     VARCHAR2 (31 BYTE),
--   PRICE_MODEL     VARCHAR2 (31 BYTE),
--   RUM_ID          VARCHAR2 (31 BYTE),
--   RESOURCE_NAME   VARCHAR2 (15 BYTE),
--   RESOURCE_ID     NUMBER (3),
--   RUM_TYPE        VARCHAR2 (15 BYTE),
--   CONSUME_FLAG    NUMBER (11),
--   STEP            NUMBER (2)

SELECT * FROM RUM_MAP; 

CREATE TABLE RUM_MAP
AS
   SELECT t3.DISPLAY_VALUE AS PRICE_GROUP,
          t3.DISPLAY_VALUE AS PRICE_MODEL,
          CASE t6.DISPLAY_VALUE
             WHEN 'SECONDS' THEN 'DUR'
             WHEN 'SMS' THEN 'EVT'
             WHEN 'MMS' THEN 'EVT'
             ELSE 'UNKNOWN'
          END
             RUM_ID,
          t8.ISO_CODE AS RESOURCE_NAME,
          t8.ISO_NUMBER AS RESOURCE_ID,
          CASE
             WHEN t6.DISPLAY_VALUE = 'SECONDS' AND t2.ADD_CON_AMOUNT > 0
             THEN
                'Tiered'
             WHEN t6.DISPLAY_VALUE = 'SECONDS' AND t2.ADD_CON_AMOUNT = 0
             THEN
                'Flat'
             WHEN t6.DISPLAY_VALUE = 'SMS'
             THEN
                'Event'
             WHEN t6.DISPLAY_VALUE = 'MMS'
             THEN
                'Event'
             ELSE
                'UNKNOWN'
          END
             RUM_TYPE,
          0 AS CONSUME_FLAG,
          1 AS STEP
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