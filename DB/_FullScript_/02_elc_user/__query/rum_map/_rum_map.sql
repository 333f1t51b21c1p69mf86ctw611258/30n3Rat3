/* Formatted on 3/24/2014 4:29:16 PM (QP5 v5.215.12089.38647) */
--CREATE TABLE rum_map
--AS

SELECT t3.DISPLAY_VALUE AS PRICE_GROUP,
       t3.DISPLAY_VALUE AS tariff_MODEL_name,
       t1.TARIFF_ID AS tariff_model_id,
       t2.RESELLER_VERSION_ID AS reseller_version_id,
       t6.DISPLAY_VALUE AS unit_type,
       CASE t6.DISPLAY_VALUE
          WHEN 'SECONDS' THEN 'DUR'
          WHEN 'SMS' THEN 'EVT'
          WHEN 'MMS' THEN 'EVT'
          WHEN 'OCTET' THEN 'VOL'
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
          WHEN t6.DISPLAY_VALUE = 'OCTET'
          THEN
             'Tiered'
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