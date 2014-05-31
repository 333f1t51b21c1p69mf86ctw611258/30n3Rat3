/* Formatted on 25/03/2014 17:15:43 (QP5 v5.215.12089.38647) */

select * from tariff_plan;

CREATE TABLE tariff_plan
AS
   SELECT t1.TARIFF_PLAN_MAPPING_ID AS tariff_plan_mapping_id, -- tariffPlanMappingId,
          t1.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
          t4.DISPLAY_VALUE AS tariff_plan_name,              -- tariffPlanKey,
          t1.TARIFF_PLAN_ID AS tariff_plan_id,                -- tariffPlanId,
          t8.DISPLAY_VALUE AS default_currency_name,   -- defaultCurrencyCode,
          -- *** add
          T8.CURRENCY_CODE AS default_currency_code,
          -- ### add
          t7.DISPLAY_VALUE AS tariff_set_name,              -- tariffSetIdKey,
          t1.TARIFF_SET_ID AS tariff_set_id,                   -- tariffSetId,
          t1.CHARGE_RATE_CODE AS charge_rate_code            -- chargeRateCode
     FROM cbs_owner.TARIFF_PLAN_MAPPING t1
          INNER JOIN cbs_owner.TARIFF_PLAN_KEY t2
             ON t1.TARIFF_PLAN_ID = t2.TARIFF_PLAN_ID
          INNER JOIN cbs_owner.TARIFF_PLAN_REF t3
             ON     t2.TARIFF_PLAN_ID = t3.TARIFF_PLAN_ID
                AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.TARIFF_PLAN_VALUES t4
             ON     t2.TARIFF_PLAN_ID = t4.TARIFF_PLAN_ID
                AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t4.LANGUAGE_CODE = 1
          INNER JOIN cbs_owner.TARIFF_SET_ID_KEY t5
             ON t1.TARIFF_SET_ID = t5.TARIFF_SET_ID
          INNER JOIN cbs_owner.TARIFF_SET_ID_REF t6
             ON     t5.TARIFF_SET_ID = t6.TARIFF_SET_ID
                AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.TARIFF_SET_ID_VALUES t7
             ON     t5.TARIFF_SET_ID = t7.TARIFF_SET_ID
                AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_VALUES t8
             ON     t6.DEFAULT_CURRENCY_CODE = t8.CURRENCY_CODE
                AND t8.SERVICE_VERSION_ID = 1
                AND t8.LANGUAGE_CODE = t4.LANGUAGE_CODE
    WHERE t1.RESELLER_VERSION_ID = 2;