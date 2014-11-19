/* Formatted on 8/4/2014 11:39:49 (QP5 v5.227.12220.39754) */
SELECT * FROM tariff_plan;

--DROP TABLE tariff_plan;

CREATE TABLE tariff_plan
AS
   SELECT t1.TARIFF_PLAN_MAPPING_ID AS tariff_plan_mapping_id, -- tariffPlanMappingId,
          t1.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
          t4.DISPLAY_VALUE AS tariff_plan_name,              -- tariffPlanKey,
          t1.TARIFF_PLAN_ID AS tariff_plan_id,                -- tariffPlanId,
          t8.DISPLAY_VALUE AS default_currency_name,   -- defaultCurrencyCode,
          -- *** add
          T8.CURRENCY_CODE AS default_currency_code,
          T23.DISPLAY_VALUE AS calendar_name,
          T3.CALENDAR_ID,
          t43.DISPLAY_VALUE AS unit_type_name,
          T3.UNIT_TYPE AS UNIT_TYPE_ID,
          -- ### add
          t7.DISPLAY_VALUE AS tariff_set_name,              -- tariffSetIdKey,
          t1.TARIFF_SET_ID AS tariff_set_id,                   -- tariffSetId,
          t1.CHARGE_RATE_CODE AS charge_rate_code            -- chargeRateCode
     FROM cbs_owner.TARIFF_PLAN_MAPPING t1
          INNER JOIN cbs_owner.TARIFF_PLAN_KEY t2
             ON t1.TARIFF_PLAN_ID = t2.TARIFF_PLAN_ID
          INNER JOIN
          cbs_owner.TARIFF_PLAN_REF t3
             ON     t2.TARIFF_PLAN_ID = t3.TARIFF_PLAN_ID
                AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.TARIFF_PLAN_VALUES t4
             ON     t2.TARIFF_PLAN_ID = t4.TARIFF_PLAN_ID
                AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t4.LANGUAGE_CODE = 1
          INNER JOIN cbs_owner.TARIFF_SET_ID_KEY t5
             ON t1.TARIFF_SET_ID = t5.TARIFF_SET_ID
          INNER JOIN
          cbs_owner.TARIFF_SET_ID_REF t6
             ON     t5.TARIFF_SET_ID = t6.TARIFF_SET_ID
                AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.TARIFF_SET_ID_VALUES t7
             ON     t5.TARIFF_SET_ID = t7.TARIFF_SET_ID
                AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.RATE_CURRENCY_VALUES t8
             ON     t6.DEFAULT_CURRENCY_CODE = t8.CURRENCY_CODE
                AND t8.SERVICE_VERSION_ID = 1
                AND t8.LANGUAGE_CODE = t4.LANGUAGE_CODE
          -- *** add calendar
          INNER JOIN
          cbs_owner.CALENDAR_REF t22
             ON     t3.CALENDAR_ID = t22.CALENDAR_ID
                AND T1.RESELLER_VERSION_ID = T22.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.CALENDAR_VALUES t23
             ON     t22.CALENDAR_ID = t23.CALENDAR_ID
                AND t22.RESELLER_VERSION_ID = t23.RESELLER_VERSION_ID
          -- add unit type
          INNER JOIN
          cbs_owner.UNITS_TYPE_REF t42
             ON     t3.UNIT_TYPE = t42.UNIT_TYPE
                AND t42.SERVICE_VERSION_ID = t8.SERVICE_VERSION_ID
          INNER JOIN
          cbs_owner.UNITS_TYPE_VALUES t43
             ON     t42.UNIT_TYPE = t43.UNIT_TYPE
                AND t42.SERVICE_VERSION_ID = t43.SERVICE_VERSION_ID
                AND t43.LANGUAGE_CODE = t4.LANGUAGE_CODE
    WHERE t1.RESELLER_VERSION_ID = 2;