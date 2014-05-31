/* Formatted on 24/4/2014 00:21:25 (QP5 v5.227.12220.39754) */
SELECT t1.TARIFF_PLAN_MAPPING_ID AS tariffPlanMappingId,
       t1.RESELLER_VERSION_ID AS resellerVersionId,
       t4.DISPLAY_VALUE AS tariffPlanKey,
       t1.TARIFF_PLAN_ID AS tariffPlanId,
       t7.DISPLAY_VALUE AS tariffSetIdKey,
       t8.DISPLAY_VALUE AS defaultCurrencyCode,
       t1.TARIFF_SET_ID AS tariffSetId,
       t1.CHARGE_RATE_CODE AS chargeRateCode
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
       INNER JOIN
       cbs_owner.RATE_CURRENCY_VALUES t8
          ON     T6.DEFAULT_CURRENCY_CODE = t8.CURRENCY_CODE
             AND t8.SERVICE_VERSION_ID = 1
             AND t8.LANGUAGE_CODE = t4.LANGUAGE_CODE
 WHERE t1.RESELLER_VERSION_ID = 2;