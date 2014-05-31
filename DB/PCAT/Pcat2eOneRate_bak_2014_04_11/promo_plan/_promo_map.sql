/* Formatted on 25/03/2014 17:12:42 (QP5 v5.215.12089.38647) */
DROP TABLE promo_map;

CREATE TABLE promo_map
AS
   SELECT t4.DISPLAY_VALUE AS offer_name,                         -- offerKey,
          t1.OFFER_ID AS offer_id,                                 -- offerId,
          --       t7.DISPLAY_VALUE AS rtPromotionPlanKey,
          --       t1.RT_PROMOTION_PLAN_ID AS rtPromotionPlanId,
          t1.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
          -- *** add promotion plan map
          t27.DISPLAY_VALUE AS bonus_name,                  -- rtBonusItemKey,
          t21.BONUS_ITEM_ID AS bonus_id,                       -- bonusItemId,
          t30.DISPLAY_VALUE AS discount_name,            -- rtDiscountItemKey,
          t21.DISCOUNT_ITEM_ID AS discount_id,              -- discountItemId,
          -- *** add discount item
          --       t46.DISPLAY_VALUE AS rtDiscountKey,
          --       t29.RT_DISCOUNT_ID AS rtDiscountId,
          t49.DISPLAY_VALUE AS ua_name,                        -- autFinalKey,
          t29.AUT_ID AS ua_id,                                       -- autId,
          t52.DISPLAY_VALUE AS ua_group_name,                  -- autGroupKey,
          t29.AUT_GROUP_ID AS ua_group_id,                      -- autGroupId,
          --       t29.IS_DEFAULT AS isDefault,
          --       t29.IS_INTERNAL AS isInternal,
          --       t30.LANGUAGE_CODE AS languageCode,
          --       t30.DISPLAY_VALUE AS displayValue,
          t30.DESCRIPTION AS description
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
          -- *** add promotion plan map
          INNER JOIN cbs_owner.RT_PROMOTION_PLAN_ITEM_MAP t21
             ON T21.RT_PROMOTION_PLAN_ID = t7.RT_PROMOTION_PLAN_ID
          LEFT OUTER JOIN cbs_owner.RT_BONUS_ITEM_KEY t25
             ON t21.BONUS_ITEM_ID = t25.BONUS_ITEM_ID
          LEFT OUTER JOIN cbs_owner.RT_BONUS_ITEM_REF t26
             ON     t25.BONUS_ITEM_ID = t26.BONUS_ITEM_ID
                AND t26.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.RT_BONUS_ITEM_VALUES t27
             ON     t25.BONUS_ITEM_ID = t27.BONUS_ITEM_ID
                AND t27.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                AND t27.LANGUAGE_CODE = t7.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.RT_DISCOUNT_ITEM_KEY t28
             ON t21.DISCOUNT_ITEM_ID = t28.DISCOUNT_ITEM_ID
          LEFT OUTER JOIN cbs_owner.RT_DISCOUNT_ITEM_REF t29
             ON     t28.DISCOUNT_ITEM_ID = t29.DISCOUNT_ITEM_ID
                AND t29.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.RT_DISCOUNT_ITEM_VALUES t30
             ON     t28.DISCOUNT_ITEM_ID = t30.DISCOUNT_ITEM_ID
                AND t30.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                AND t30.LANGUAGE_CODE = t7.LANGUAGE_CODE
          -- *** add discount item
          INNER JOIN cbs_owner.RT_DISCOUNT_KEY t44
             ON T29.RT_DISCOUNT_ID = t44.RT_DISCOUNT_ID
          INNER JOIN cbs_owner.RT_DISCOUNT_REF t45
             ON     t44.RT_DISCOUNT_ID = t45.RT_DISCOUNT_ID
                AND t45.RESELLER_VERSION_ID = t29.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.RT_DISCOUNT_VALUES t46
             ON     t44.RT_DISCOUNT_ID = t46.RT_DISCOUNT_ID
                AND t46.RESELLER_VERSION_ID = t29.RESELLER_VERSION_ID
                AND t46.LANGUAGE_CODE = t30.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.AUT_FINAL_KEY t47
             ON t29.AUT_ID = t47.AUT_ID
          LEFT OUTER JOIN cbs_owner.AUT_FINAL_REF t48
             ON     t47.AUT_ID = t48.AUT_ID
                AND t48.RESELLER_VERSION_ID = t29.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.AUT_FINAL_VALUES t49
             ON     t47.AUT_ID = t49.AUT_ID
                AND t49.RESELLER_VERSION_ID = t29.RESELLER_VERSION_ID
                AND t49.LANGUAGE_CODE = t30.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.AUT_GROUP_KEY t50
             ON t29.AUT_GROUP_ID = t50.AUT_GROUP_ID
          LEFT OUTER JOIN cbs_owner.AUT_GROUP_REF t51
             ON     t50.AUT_GROUP_ID = t51.AUT_GROUP_ID
                AND t51.RESELLER_VERSION_ID = t29.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.AUT_GROUP_VALUES t52
             ON     t50.AUT_GROUP_ID = t52.AUT_GROUP_ID
                AND t52.RESELLER_VERSION_ID = t29.RESELLER_VERSION_ID
                AND t52.LANGUAGE_CODE = t30.LANGUAGE_CODE
    WHERE t1.RESELLER_VERSION_ID = 2 AND t30.LANGUAGE_CODE = 1;