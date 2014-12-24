DROP VIEW VNP_COMMON.PROMO_PLAN_VIEW;

/* Formatted on 3/5/2014 17:22:32 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW VNP_COMMON.PROMO_PLAN_VIEW
(
   RESELLER_VERSION_ID,
   OFFER_ID,
   REGEX_RESULT
)
AS
   SELECT DISTINCT
          PROMO_PLAN.RESELLER_VERSION_ID,
          PROMO_PLAN.OFFER_ID,
             IS_INTERNAL
          || ':'
          || BONUS_ITEM_ID
          || ':'
          || PROMO_PLAN.DISCOUNT_ITEM_ID
          || ':'
          || CASE PERIOD_NAME
                WHEN 'Monthly' THEN 'M'
                WHEN 'Weekly' THEN 'W'
                WHEN 'Daily' THEN 'D'
                WHEN 'Activity End' THEN 'A'
                ELSE 'UNKNOWN'
             END
             REGEX_RESULT
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
          INNER JOIN
          PRODUCT_OFFER
             ON     (PROMO_PLAN.OFFER_ID = PRODUCT_OFFER.OFFER_ID)
                AND (PROMO_PLAN.RESELLER_VERSION_ID =
                        PRODUCT_OFFER.RESELLER_VERSION_ID);
