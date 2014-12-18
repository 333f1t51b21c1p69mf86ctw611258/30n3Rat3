/* Formatted on 3/24/2014 11:18:18 AM (QP5 v5.215.12089.38647) */
--CREATE TABLE tariff_plan
--AS

SELECT t1.TARIFF_SET_MEMBER_ID AS tariff_set_member_id,  -- tariffSetMemberId,
       t1.RESELLER_VERSION_ID AS reseller_version_id,    -- resellerVersionId,
       --       t27.DISPLAY_VALUE AS tariffSetIdKey,
       --       t1.TARIFF_SET_ID AS tariffSetId,
       -- ***
       --       t21.TARIFF_PLAN_MAPPING_ID AS tariff_plan_mapping_id, -- tariffPlanMappingId,
       --       t21.RESELLER_VERSION_ID AS resellerVersionId,
       t24.DISPLAY_VALUE AS tariff_plan_name,                -- tariffPlanKey,
       t21.TARIFF_PLAN_ID AS tariff_plan_id,                  -- tariffPlanId,
       t27.DISPLAY_VALUE AS tariff_set_name,                -- tariffSetIdKey,
       t21.TARIFF_SET_ID AS tariff_set_id,                     -- tariffSetId,
       t28.DISPLAY_VALUE AS default_currency_code,     -- defaultCurrencyCode,
       --       t21.CHARGE_RATE_CODE AS chargeRateCode,
       -- *** add tariff plan
       t23.UNIT_TYPE AS unit_type,                                -- unitType,
       -- ###
       t7.DISPLAY_VALUE AS tariff_name,                          -- tariffKey,
       t1.TARIFF_ID AS tariff_id,                                 -- tariffId,
       t10.DISPLAY_VALUE AS time_model_name,                   -- timeTypeKey,
       t1.TIME_TYPE_ID AS time_model_id,                        -- timeTypeId,
       t1.IS_PRIMARY AS is_primary                                -- isPrimary
  FROM cbs_owner.TARIFF_PLAN_MAPPING t21
       INNER JOIN cbs_owner.TARIFF_PLAN_KEY t22
          ON t21.TARIFF_PLAN_ID = t22.TARIFF_PLAN_ID
       INNER JOIN cbs_owner.TARIFF_PLAN_REF t23
          ON     t22.TARIFF_PLAN_ID = t23.TARIFF_PLAN_ID
             AND t23.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
       INNER JOIN cbs_owner.TARIFF_PLAN_VALUES t24
          ON     t22.TARIFF_PLAN_ID = t24.TARIFF_PLAN_ID
             AND t24.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
             AND t24.LANGUAGE_CODE = 1
       -- ### add tariff plan mapping + tariff set
       INNER JOIN cbs_owner.TARIFF_SET_MEMBER t1
          -- *** add tariff set
       ON     T1.RESELLER_VERSION_ID = T21.RESELLER_VERSION_ID
          AND T1.TARIFF_SET_ID = T21.TARIFF_SET_ID
       -- ### add tariff set
       INNER JOIN cbs_owner.TARIFF_SET_ID_KEY t25
          ON t1.TARIFF_SET_ID = t25.TARIFF_SET_ID
       INNER JOIN cbs_owner.TARIFF_SET_ID_REF t26
          ON     t25.TARIFF_SET_ID = t26.TARIFF_SET_ID
             AND t26.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       INNER JOIN cbs_owner.TARIFF_SET_ID_VALUES t27
          ON     t25.TARIFF_SET_ID = t27.TARIFF_SET_ID
             AND t27.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t27.LANGUAGE_CODE = 1
       LEFT OUTER JOIN cbs_owner.TARIFF_KEY t5
          ON t1.TARIFF_ID = t5.TARIFF_ID
       LEFT OUTER JOIN cbs_owner.TARIFF_REF t6
          ON     t5.TARIFF_ID = t6.TARIFF_ID
             AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       LEFT OUTER JOIN cbs_owner.TARIFF_VALUES t7
          ON     t5.TARIFF_ID = t7.TARIFF_ID
             AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t7.LANGUAGE_CODE = t27.LANGUAGE_CODE
       INNER JOIN cbs_owner.TIME_TYPE_KEY t8
          ON t1.TIME_TYPE_ID = t8.TIME_TYPE_ID
       INNER JOIN cbs_owner.TIME_TYPE_REF t9
          ON     t8.TIME_TYPE_ID = t9.TIME_TYPE_ID
             AND t9.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       INNER JOIN cbs_owner.TIME_TYPE_VALUES t10
          ON     t8.TIME_TYPE_ID = t10.TIME_TYPE_ID
             AND t10.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t10.LANGUAGE_CODE = t27.LANGUAGE_CODE
       -- *** add tariff plan mapping
       LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_VALUES t28
          ON     t26.DEFAULT_CURRENCY_CODE = t28.CURRENCY_CODE
             AND t28.SERVICE_VERSION_ID = 1
             AND t28.LANGUAGE_CODE = t24.LANGUAGE_CODE
 -- ### add tariff plan mapping
 WHERE T21.RESELLER_VERSION_ID = 2;                                                                                                                                                                                                                                                                                                                                                                                                     -- t1.RESELLER_VERSION_ID = 2;