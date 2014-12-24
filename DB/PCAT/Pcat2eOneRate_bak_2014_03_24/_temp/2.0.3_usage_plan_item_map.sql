/* Formatted on 3/15/2014 4:05:22 PM (QP5 v5.215.12089.38647) */
  SELECT t4.DISPLAY_VALUE AS usagePlanKey,
         t1.USAGE_PLAN_ID AS usagePlanId,
         t7.DISPLAY_VALUE AS usageItemKey,
         t1.USAGE_ITEM_ID AS usageItemId,
         t1.RESELLER_VERSION_ID AS resellerVersionId,
         t1.IS_USAGE_SPLIT AS isUsageSplit,
         t1.RESERVATION_AMT AS reservationAmt,
         t1.RESERVATION_LIFETIME AS reservationLifetime,
         t1.RESERVATION_MAX_NUM AS reservationMaxNum,
         t1.RESERVATION_MIN_AMT AS reservationMinAmt,
         t1.RESERVATION_MAX_AMT AS reservationMaxAmt,
         t1.ASSUME_CONSUMPTION AS assumeConsumption,
         t1.INHIBIT_REFUND AS inhibitRefund
    FROM cbs_owner.USAGE_PLAN_ITEM_MAP t1
         INNER JOIN cbs_owner.USAGE_PLAN_KEY t2
            ON t1.USAGE_PLAN_ID = t2.USAGE_PLAN_ID
         INNER JOIN cbs_owner.USAGE_PLAN_REF t3
            ON     t2.USAGE_PLAN_ID = t3.USAGE_PLAN_ID
               AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
         INNER JOIN cbs_owner.USAGE_PLAN_VALUES t4
            ON     t2.USAGE_PLAN_ID = t4.USAGE_PLAN_ID
               AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
               AND t4.LANGUAGE_CODE = 1
         INNER JOIN cbs_owner.USAGE_ITEM_KEY t5
            ON t1.USAGE_ITEM_ID = t5.USAGE_ITEM_ID
         INNER JOIN cbs_owner.USAGE_ITEM_REF t6
            ON     t5.USAGE_ITEM_ID = t6.USAGE_ITEM_ID
               AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
         INNER JOIN cbs_owner.USAGE_ITEM_VALUES t7
            ON     t5.USAGE_ITEM_ID = t7.USAGE_ITEM_ID
               AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
               AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
   WHERE t1.RESELLER_VERSION_ID = 2
ORDER BY t1.USAGE_PLAN_ID, t1.USAGE_ITEM_ID;