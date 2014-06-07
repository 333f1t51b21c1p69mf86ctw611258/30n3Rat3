/* Formatted on 24/4/2014 00:25:17 (QP5 v5.227.12220.39754) */
--DROP TABLE rum_map;

SELECT * FROM rum_map;

--CREATE TABLE rum_map
--AS

SELECT t1.TARIFF_SET_MEMBER_ID AS tariff_set_member_id,  -- tariffSetMemberId,
       t1.RESELLER_VERSION_ID AS reseller_version_id,    -- resellerVersionId,
       t4.DISPLAY_VALUE AS tariff_set_name,                 -- tariffSetIdKey,
       t1.TARIFF_SET_ID AS tariff_set_id,                      -- tariffSetId,
       -- *** add unit type
       t22.display_value AS unit_type_name,
       T20.UNIT_TYPE AS unit_type_id,
       CASE t22.DISPLAY_VALUE
          WHEN 'SECONDS' THEN 'DUR'
          WHEN 'SMS' THEN 'EVT'
          WHEN 'MMS' THEN 'EVT'
          WHEN 'OCTET' THEN 'VOL'
          ELSE 'UNKNOWN'
       END
          RUM_ID,
       T43.DISPLAY_VALUE AS currency_name,
       T6.CURRENCY_CODE AS currency_id,
       -- ### add unit type
       t10.DISPLAY_VALUE AS time_type_name,                    -- timeTypeKey,
       t1.TIME_TYPE_ID AS time_type_id,                         -- timeTypeId,
       t7.DISPLAY_VALUE AS tariff_model_name,                    -- tariffKey,
       t1.TARIFF_ID AS tariff_model_id,                           -- tariffId,
       t1.IS_PRIMARY AS is_primary,                               -- isPrimary
       CASE
          WHEN t22.DISPLAY_VALUE = 'SECONDS' AND t6.ADD_CON_AMOUNT > 0
          THEN
             'Tiered'
          WHEN t22.DISPLAY_VALUE = 'SECONDS' AND t6.ADD_CON_AMOUNT = 0
          THEN
             'Flat'
          WHEN t22.DISPLAY_VALUE = 'SMS'
          THEN
             'Event'
          WHEN t22.DISPLAY_VALUE = 'MMS'
          THEN
             'Event'
          WHEN t22.DISPLAY_VALUE = 'OCTET'
          THEN
             'Tiered'
          ELSE
             'UNKNOWN'
       END
          AS RUM_TYPE,
       0 AS CONSUME_FLAG,
       1 AS STEP
  FROM cbs_owner.TARIFF_SET_MEMBER t1
       INNER JOIN cbs_owner.TARIFF_SET_ID_KEY t2
          ON t1.TARIFF_SET_ID = t2.TARIFF_SET_ID
       INNER JOIN
       cbs_owner.TARIFF_SET_ID_REF t3
          ON     t2.TARIFF_SET_ID = t3.TARIFF_SET_ID
             AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       INNER JOIN
       cbs_owner.TARIFF_SET_ID_VALUES t4
          ON     t2.TARIFF_SET_ID = t4.TARIFF_SET_ID
             AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t4.LANGUAGE_CODE = 1
       LEFT OUTER JOIN cbs_owner.TARIFF_KEY t5 ON t1.TARIFF_ID = t5.TARIFF_ID
       LEFT OUTER JOIN
       cbs_owner.TARIFF_REF t6
          ON     t5.TARIFF_ID = t6.TARIFF_ID
             AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       LEFT OUTER JOIN
       cbs_owner.TARIFF_VALUES t7
          ON     t5.TARIFF_ID = t7.TARIFF_ID
             AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
       INNER JOIN cbs_owner.TIME_TYPE_KEY t8
          ON t1.TIME_TYPE_ID = t8.TIME_TYPE_ID
       INNER JOIN
       cbs_owner.TIME_TYPE_REF t9
          ON     t8.TIME_TYPE_ID = t9.TIME_TYPE_ID
             AND t9.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       INNER JOIN
       cbs_owner.TIME_TYPE_VALUES t10
          ON     t8.TIME_TYPE_ID = t10.TIME_TYPE_ID
             AND t10.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t10.LANGUAGE_CODE = t4.LANGUAGE_CODE
       -- *** add unit type
       INNER JOIN cbs_owner.UNITS_TYPE_KEY t20
          ON t6.UNIT_TYPE = t20.UNIT_TYPE
       INNER JOIN cbs_owner.UNITS_TYPE_REF t21
          ON t20.UNIT_TYPE = t21.UNIT_TYPE AND t21.SERVICE_VERSION_ID = 1
       INNER JOIN
       cbs_owner.UNITS_TYPE_VALUES t22
          ON     t20.UNIT_TYPE = t22.UNIT_TYPE
             AND t22.SERVICE_VERSION_ID = t21.SERVICE_VERSION_ID
             AND t22.LANGUAGE_CODE = t4.LANGUAGE_CODE
       -- *** add currency
       INNER JOIN
       cbs_owner.RATE_CURRENCY_REF t42
          ON     t6.CURRENCY_CODE = t42.CURRENCY_CODE
             AND t42.SERVICE_VERSION_ID = t21.SERVICE_VERSION_ID
       INNER JOIN
       cbs_owner.RATE_CURRENCY_VALUES t43
          ON     t42.CURRENCY_CODE = t43.CURRENCY_CODE
             AND t42.SERVICE_VERSION_ID = t43.SERVICE_VERSION_ID
             AND t43.LANGUAGE_CODE = t4.LANGUAGE_CODE
 WHERE t1.RESELLER_VERSION_ID = 2;