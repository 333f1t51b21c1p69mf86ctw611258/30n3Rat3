/* Formatted on 26/03/2014 14:44:46 (QP5 v5.215.12089.38647) */
SELECT t4.DISPLAY_VALUE AS offerKey,
       t1.OFFER_ID AS offerId,
       t7.DISPLAY_VALUE AS rtPromotionPlanKey,
       t1.RT_PROMOTION_PLAN_ID AS rtPromotionPlanId,
       t1.RESELLER_VERSION_ID AS resellerVersionId
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
 WHERE t1.RESELLER_VERSION_ID = 2;