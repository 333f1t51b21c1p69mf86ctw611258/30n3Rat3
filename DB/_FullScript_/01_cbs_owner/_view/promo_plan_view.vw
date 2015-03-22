DROP VIEW PROMO_PLAN_VIEW;

/* Formatted on 28/12/2014 17:17:22 (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW PROMO_PLAN_VIEW
(
   OFFER_ID,
   OFFER_NAME,
   PROMO_PLAN_NAME,
   PROMO_PLAN_ID,
   RESELLER_VERSION_ID,
   BONUS_ITEM_NAME,
   BONUS_ITEM_ID,
   DISCOUNT_ITEM_NAME,
   DISCOUNT_ITEM_ID
)
AS
   SELECT t1.OFFER_ID AS offer_id,                                 -- offerId,
          t4.DISPLAY_VALUE AS offer_name,                         -- offerKey,
          t7.DISPLAY_VALUE AS promo_plan_name,          -- rtPromotionPlanKey,
          t1.RT_PROMOTION_PLAN_ID AS promo_plan_id,      -- rtPromotionPlanId,
          t1.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
          -- {{{ add promo plan item map
          --       t21.RT_PROMO_PI_MAP_ID AS rtPromoPiMapId,
          --       t21.RESELLER_VERSION_ID AS resellerVersionId,
          --       t24.DISPLAY_VALUE AS rtPromotionPlanKey,
          --       t21.RT_PROMOTION_PLAN_ID AS rtPromotionPlanId,
          t27.DISPLAY_VALUE AS bonus_item_name,             -- rtBonusItemKey,
          t21.BONUS_ITEM_ID AS bonus_item_id,                  -- bonusItemId,
          t30.DISPLAY_VALUE AS discount_item_name,       -- rtDiscountItemKey,
          t21.DISCOUNT_ITEM_ID AS discount_item_id           -- discountItemId
     FROM cbs_owner.OFFER_RT_PROMO_PLAN_MAP t1
          INNER JOIN cbs_owner.OFFER_KEY t2
             ON t1.OFFER_ID = t2.OFFER_ID
          INNER JOIN cbs_owner.OFFER_REF t3
             ON     t2.OFFER_ID = t3.OFFER_ID
                AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.OFFER_VALUES t4
             ON     t2.OFFER_ID = t4.OFFER_ID
                AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t4.LANGUAGE_CODE = 1
          INNER JOIN cbs_owner.RT_PROMOTION_PLAN_KEY t5
             ON t1.RT_PROMOTION_PLAN_ID = t5.RT_PROMOTION_PLAN_ID
          INNER JOIN cbs_owner.RT_PROMOTION_PLAN_REF t6
             ON     t5.RT_PROMOTION_PLAN_ID = t6.RT_PROMOTION_PLAN_ID
                AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.RT_PROMOTION_PLAN_VALUES t7
             ON     t5.RT_PROMOTION_PLAN_ID = t7.RT_PROMOTION_PLAN_ID
                AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
          -- {{{ add promo plan item map
          INNER JOIN cbs_owner.RT_PROMOTION_PLAN_ITEM_MAP t21
             ON     t1.RT_PROMOTION_PLAN_ID = T21.RT_PROMOTION_PLAN_ID
                AND T1.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.RT_PROMOTION_PLAN_KEY t22
             ON t21.RT_PROMOTION_PLAN_ID = t22.RT_PROMOTION_PLAN_ID
          INNER JOIN cbs_owner.RT_PROMOTION_PLAN_REF t23
             ON     t22.RT_PROMOTION_PLAN_ID = t23.RT_PROMOTION_PLAN_ID
                AND t23.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.RT_PROMOTION_PLAN_VALUES t24
             ON     t22.RT_PROMOTION_PLAN_ID = t24.RT_PROMOTION_PLAN_ID
                AND t24.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                AND t24.LANGUAGE_CODE = 1
          LEFT OUTER JOIN cbs_owner.RT_BONUS_ITEM_KEY t25
             ON t21.BONUS_ITEM_ID = t25.BONUS_ITEM_ID
          LEFT OUTER JOIN cbs_owner.RT_BONUS_ITEM_REF t26
             ON     t25.BONUS_ITEM_ID = t26.BONUS_ITEM_ID
                AND t26.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.RT_BONUS_ITEM_VALUES t27
             ON     t25.BONUS_ITEM_ID = t27.BONUS_ITEM_ID
                AND t27.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                AND t27.LANGUAGE_CODE = t24.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.RT_DISCOUNT_ITEM_KEY t28
             ON t21.DISCOUNT_ITEM_ID = t28.DISCOUNT_ITEM_ID
          LEFT OUTER JOIN cbs_owner.RT_DISCOUNT_ITEM_REF t29
             ON     t28.DISCOUNT_ITEM_ID = t29.DISCOUNT_ITEM_ID
                AND t29.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.RT_DISCOUNT_ITEM_VALUES t30
             ON     t28.DISCOUNT_ITEM_ID = t30.DISCOUNT_ITEM_ID
                AND t30.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                AND t30.LANGUAGE_CODE = t24.LANGUAGE_CODE;


GRANT SELECT ON PROMO_PLAN_VIEW TO VNP_COMMON;
