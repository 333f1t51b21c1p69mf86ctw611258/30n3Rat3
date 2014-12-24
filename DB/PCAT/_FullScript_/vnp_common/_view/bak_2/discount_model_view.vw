DROP VIEW VNP_COMMON.DISCOUNT_MODEL_VIEW;

/* Formatted on 3/5/2014 16:39:00 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW VNP_COMMON.DISCOUNT_MODEL_VIEW
(
   OFFER_ID,
   OFFER_NAME,
   RESELLER_VERSION_ID,
   PROMO_PLAN_ID,
   PROMO_PLAN_NAME,
   DISCOUNT_ITEM_ID,
   DISCOUNT_ITEM_NAME,
   DISCOUNT_ID,
   DISCOUNT_NAME,
   DISCOUNT_TYPE_ID,
   DISCOUNT_TYPE_NAME,
   CURRENCY_NAME,
   CURRENCY_CODE,
   AWARD_ID,
   AWARD_NAME,
   THRESHOLD,
   AMOUNT,
   ACCUMULATOR_ID,
   ACCUMULATOR_NAME,
   UNIT_TYPE_NAME,
   UNIT_TYPE_ID,
   RUM_ID,
   COUNT_TYPE_ID,
   COUNT_TYPE_NAME,
   UA_NAME_ALIAS,
   UA_ID_ALIAS,
   PERIOD_ID,
   PERIOD_NAME,
   PERIOD
)
AS
   SELECT OFFER_ID,
          OFFER_NAME,
          PROMO_PLAN.RESELLER_VERSION_ID,
          PROMO_PLAN_ID,
          PROMO_PLAN_NAME,
          DISCOUNT_MODEL.DISCOUNT_ITEM_ID,
          DISCOUNT_MODEL.DISCOUNT_ITEM_NAME,
          DISCOUNT_ID,
          DISCOUNT_NAME,
          DISCOUNT_TYPE_ID,
          DISCOUNT_TYPE_NAME,
          CURRENCY_NAME,
          CURRENCY_CODE,
          AWARD_ID,
          AWARD_NAME,
          THRESHOLD,
          AMOUNT,
          ACCUMULATOR.ACCUMULATOR_ID,
          ACCUMULATOR.ACCUMULATOR_NAME,
          UNIT_TYPE_NAME,
          UNIT_TYPE_ID,
          CASE UNIT_TYPE_NAME
             WHEN 'SECONDS' THEN 'DUR'
             WHEN 'SMS' THEN 'SMS'
             WHEN 'MMS' THEN 'MMS'
             WHEN 'OCTET' THEN 'VOL'
             WHEN 'Money/Currency' THEN 'MONEY'
             ELSE 'UNKNOWN'
          END
             RUM_ID,
          COUNT_TYPE_ID,
          COUNT_TYPE_NAME,
          USAGE_ACTIVITY_GROUP.UA_NAME UA_NAME_ALIAS,
          USAGE_ACTIVITY_GROUP.UA_ID UA_ID_ALIAS,
          PERIOD_ID,
          PERIOD_NAME,
          CASE PERIOD_NAME
             WHEN 'Monthly' THEN 'M'
             WHEN 'Weekly' THEN 'W'
             WHEN 'Daily' THEN 'D'
             WHEN 'Activity End' THEN 'A'
             ELSE 'UNKNOWN'
          END
             PERIOD
     FROM DISCOUNT_MODEL
          INNER JOIN
          ACCUMULATOR
             ON     (DISCOUNT_MODEL.RESELLER_VERSION_ID =
                        ACCUMULATOR.RESELLER_VERSION_ID)
                AND (DISCOUNT_MODEL.ACCUMULATOR_ID =
                        ACCUMULATOR.ACCUMULATOR_ID)
          INNER JOIN
          USAGE_ACTIVITY_GROUP
             ON     (USAGE_ACTIVITY_GROUP.UA_GROUP_ID =
                        DISCOUNT_MODEL.UA_GROUP_ID)
                AND (USAGE_ACTIVITY_GROUP.RESELLER_VERSION_ID =
                        DISCOUNT_MODEL.RESELLER_VERSION_ID)
          INNER JOIN
          PROMO_PLAN
             ON     (DISCOUNT_MODEL.DISCOUNT_ITEM_ID =
                        PROMO_PLAN.DISCOUNT_ITEM_ID)
                AND (DISCOUNT_MODEL.RESELLER_VERSION_ID =
                        PROMO_PLAN.RESELLER_VERSION_ID)
    WHERE DISCOUNT_MODEL.UA_GROUP_ID IS NOT NULL
   UNION
   SELECT OFFER_ID,
          OFFER_NAME,
          PROMO_PLAN.RESELLER_VERSION_ID,
          PROMO_PLAN_ID,
          PROMO_PLAN_NAME,
          DISCOUNT_MODEL.DISCOUNT_ITEM_ID,
          DISCOUNT_MODEL.DISCOUNT_ITEM_NAME,
          DISCOUNT_ID,
          DISCOUNT_NAME,
          DISCOUNT_TYPE_ID,
          DISCOUNT_TYPE_NAME,
          CURRENCY_NAME,
          CURRENCY_CODE,
          AWARD_ID,
          AWARD_NAME,
          THRESHOLD,
          AMOUNT,
          ACCUMULATOR.ACCUMULATOR_ID,
          ACCUMULATOR.ACCUMULATOR_NAME,
          UNIT_TYPE_NAME,
          UNIT_TYPE_ID,
          CASE UNIT_TYPE_NAME
             WHEN 'SECONDS' THEN 'DUR'
             WHEN 'SMS' THEN 'SMS'
             WHEN 'MMS' THEN 'MMS'
             WHEN 'OCTET' THEN 'VOL'
             WHEN 'Money/Currency' THEN 'MONEY'
             ELSE 'UNKNOWN'
          END
             RUM_ID,
          COUNT_TYPE_ID,
          COUNT_TYPE_NAME,
          DISCOUNT_MODEL.UA_NAME UA_NAME_ALIAS,
          DISCOUNT_MODEL.UA_ID UA_ID_ALIAS,
          PERIOD_ID,
          PERIOD_NAME,
          CASE PERIOD_NAME
             WHEN 'Monthly' THEN 'M'
             WHEN 'Weekly' THEN 'W'
             WHEN 'Daily' THEN 'D'
             WHEN 'Activity End' THEN 'C'
             ELSE 'UNKNOWN'
          END
             PERIOD
     FROM DISCOUNT_MODEL
          INNER JOIN
          ACCUMULATOR
             ON     (DISCOUNT_MODEL.RESELLER_VERSION_ID =
                        ACCUMULATOR.RESELLER_VERSION_ID)
                AND (DISCOUNT_MODEL.ACCUMULATOR_ID =
                        ACCUMULATOR.ACCUMULATOR_ID)
          INNER JOIN
          PROMO_PLAN
             ON     (DISCOUNT_MODEL.DISCOUNT_ITEM_ID =
                        PROMO_PLAN.DISCOUNT_ITEM_ID)
                AND (DISCOUNT_MODEL.RESELLER_VERSION_ID =
                        PROMO_PLAN.RESELLER_VERSION_ID)
    WHERE DISCOUNT_MODEL.UA_ID IS NOT NULL;
