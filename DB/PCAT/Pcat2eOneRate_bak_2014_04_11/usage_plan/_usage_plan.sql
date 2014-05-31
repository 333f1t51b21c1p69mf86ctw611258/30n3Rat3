/* Formatted on 25/03/2014 17:20:45 (QP5 v5.215.12089.38647) */
DROP TABLE usage_plan;

SELECT * FROM usage_plan;

CREATE TABLE usage_plan
AS
   SELECT t7.DISPLAY_VALUE AS usage_plan_name,                -- usagePlanKey,
          t1.USAGE_PLAN_ID AS usage_plan_id,                   -- usagePlanId,
          t4.DISPLAY_VALUE AS offer_name,                         -- offerKey,
          t1.OFFER_ID AS offer_id,                                 -- offerId,
          t1.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
          -- *** add usage plan item map
          --       t7.DISPLAY_VALUE AS usagePlanKey,
          --       t21.USAGE_PLAN_ID AS usagePlanId,
          t27.DISPLAY_VALUE AS usage_item_name,               -- usageItemKey,
          t21.USAGE_ITEM_ID AS usage_item_id,                  -- usageItemId,
          --       t21.RESELLER_VERSION_ID AS resellerVersionId,
          --       t21.IS_USAGE_SPLIT AS isUsageSplit,
          --       t21.RESERVATION_AMT AS reservationAmt,
          --       t21.RESERVATION_LIFETIME AS reservationLifetime,
          --       t21.RESERVATION_MAX_NUM AS reservationMaxNum,
          --       t21.RESERVATION_MIN_AMT AS reservationMinAmt,
          --       t21.RESERVATION_MAX_AMT AS reservationMaxAmt,
          t21.ASSUME_CONSUMPTION AS assume_consumption,  -- assumeConsumption,
          t21.INHIBIT_REFUND AS inhibit_refund,              -- inhibitRefund,
          -- *** add usage item
          --       t25.USAGE_ITEM_ID AS usageItemId,
          --       t26.RESELLER_VERSION_ID AS resellerVersionId,
          t46.DISPLAY_VALUE AS ua_name,                        -- autFinalKey,
          t26.AUT_ID AS ua_id,                                       -- autId,
          t49.DISPLAY_VALUE AS tariff_plan_name,             -- tariffPlanKey,
          t26.TARIFF_PLAN_ID AS tariff_plan_id,               -- tariffPlanId,
          --       t26.IS_DEFAULT_ACTIVITY AS isDefaultActivity,
          --       t26.CHARGE_CODE AS chargeCode,
          --       t27.LANGUAGE_CODE AS languageCode,
          --       t27.DISPLAY_VALUE AS displayValue,
          t27.DESCRIPTION AS description
     FROM cbs_owner.OFFER_USAGE_PLAN_MAP t1
          INNER JOIN cbs_owner.OFFER_KEY t2
             ON t1.OFFER_ID = t2.OFFER_ID
          INNER JOIN cbs_owner.OFFER_REF t3
             ON     t2.OFFER_ID = t3.OFFER_ID
                AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.OFFER_VALUES t4
             ON     t2.OFFER_ID = t4.OFFER_ID
                AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t4.LANGUAGE_CODE = 1
          INNER JOIN cbs_owner.USAGE_PLAN_KEY t5
             ON t1.USAGE_PLAN_ID = t5.USAGE_PLAN_ID
          INNER JOIN cbs_owner.USAGE_PLAN_REF t6
             ON     t5.USAGE_PLAN_ID = t6.USAGE_PLAN_ID
                AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.USAGE_PLAN_VALUES t7
             ON     t5.USAGE_PLAN_ID = t7.USAGE_PLAN_ID
                AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
          -- *** add usage plan item map
          INNER JOIN cbs_owner.USAGE_PLAN_ITEM_MAP t21
             ON     T21.RESELLER_VERSION_ID = T1.RESELLER_VERSION_ID
                AND T21.USAGE_PLAN_ID = T5.USAGE_PLAN_ID
          INNER JOIN cbs_owner.USAGE_ITEM_KEY t25
             ON t21.USAGE_ITEM_ID = t25.USAGE_ITEM_ID
          INNER JOIN cbs_owner.USAGE_ITEM_REF t26
             ON     t25.USAGE_ITEM_ID = t26.USAGE_ITEM_ID
                AND t26.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.USAGE_ITEM_VALUES t27
             ON     t25.USAGE_ITEM_ID = t27.USAGE_ITEM_ID
                AND t27.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                AND t27.LANGUAGE_CODE = t7.LANGUAGE_CODE
          -- *** add usage item
          INNER JOIN cbs_owner.AUT_FINAL_KEY t44
             ON t26.AUT_ID = t44.AUT_ID
          INNER JOIN cbs_owner.AUT_FINAL_REF t45
             ON     t44.AUT_ID = t45.AUT_ID
                AND t45.RESELLER_VERSION_ID = t26.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.AUT_FINAL_VALUES t46
             ON     t44.AUT_ID = t46.AUT_ID
                AND t46.RESELLER_VERSION_ID = t26.RESELLER_VERSION_ID
                AND t46.LANGUAGE_CODE = t27.LANGUAGE_CODE
          INNER JOIN cbs_owner.TARIFF_PLAN_KEY t47
             ON t26.TARIFF_PLAN_ID = t47.TARIFF_PLAN_ID
          INNER JOIN cbs_owner.TARIFF_PLAN_REF t48
             ON     t47.TARIFF_PLAN_ID = t48.TARIFF_PLAN_ID
                AND t48.RESELLER_VERSION_ID = t26.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.TARIFF_PLAN_VALUES t49
             ON     t47.TARIFF_PLAN_ID = t49.TARIFF_PLAN_ID
                AND t49.RESELLER_VERSION_ID = t26.RESELLER_VERSION_ID
                AND t49.LANGUAGE_CODE = t27.LANGUAGE_CODE
    WHERE t1.RESELLER_VERSION_ID = 2;