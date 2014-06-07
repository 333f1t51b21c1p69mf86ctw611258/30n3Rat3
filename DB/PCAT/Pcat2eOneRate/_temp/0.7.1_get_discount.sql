/* Formatted on 06/03/2014 17:10:51 (QP5 v5.215.12089.38647) */
-- OLD DISCOUNT

SELECT discount_award_id,
       dar.rt_discount_id,
       threshold,
       amount,
       addon_thres1,
       addon_thres2,
       addon_thres3,
       addon_thres4,
       reward_event_type,
       reward_notif_text,
       unicode_flag,
       rdiv.short_display,
       rdiv.description
  FROM cbs_owner.discount_award_ref dar,
       cbs_owner.rt_discount_item_ref rdir,
       cbs_owner.rt_discount_item_values rdiv,
       cbs_owner.rt_promotion_plan_item_map rppim,
       cbs_owner.offer_rt_promo_plan_map orppm
 WHERE     orppm.reseller_version_id = 2
       AND dar.rt_discount_id = rdir.rt_discount_id
       AND dar.reseller_version_id = rdir.reseller_version_id
       AND rdiv.discount_item_id = rdir.discount_item_id
       AND rdir.reseller_version_id = rdiv.reseller_version_id
       AND rdiv.discount_item_id = rppim.discount_item_id
       AND rppim.reseller_version_id = rdiv.reseller_version_id
       AND orppm.rt_promotion_plan_id = rppim.rt_promotion_plan_id
       AND rppim.reseller_version_id = orppm.reseller_version_id;

-- DISCOUNT AWARD

SELECT t1.DISCOUNT_AWARD_ID AS discountAwardId,
       t2.RESELLER_VERSION_ID AS resellerVersionId,
       t6.DISPLAY_VALUE AS rtDiscountKey,
       t2.RT_DISCOUNT_ID AS rtDiscountId,
       t2.THRESHOLD AS threshold,
       t2.AMOUNT AS amount,
       t5.currency_code,
       t10.iso_code AS currencyIsoCode,
       t10.implied_decimal AS currencyImpliedDecimals,
       t2.ADDON_THRES1 AS addonThres1,
       t2.ADDON_THRES2 AS addonThres2,
       t2.ADDON_THRES3 AS addonThres3,
       t2.ADDON_THRES4 AS addonThres4,
       t2.REWARD_NOTIF_TEXT AS rewardNotifText,
       t2.UNICODE_FLAG AS unicodeFlag,
       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description
  FROM cbs_owner.DISCOUNT_AWARD_KEY t1
       INNER JOIN cbs_owner.DISCOUNT_AWARD_REF t2
          ON t1.DISCOUNT_AWARD_ID = t2.DISCOUNT_AWARD_ID
       INNER JOIN cbs_owner.DISCOUNT_AWARD_VALUES t3
          ON     t2.DISCOUNT_AWARD_ID = t3.DISCOUNT_AWARD_ID
             AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
       INNER JOIN cbs_owner.RT_DISCOUNT_KEY t4
          ON t2.RT_DISCOUNT_ID = t4.RT_DISCOUNT_ID
       INNER JOIN cbs_owner.RT_DISCOUNT_REF t5
          ON     t4.RT_DISCOUNT_ID = t5.RT_DISCOUNT_ID
             AND t5.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
       LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_KEY t9
          ON t5.currency_code = t9.Currency_Code
       LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_REF t10
          ON     t9.currency_code = t10.currency_code
             AND t10.service_version_id = 1
       INNER JOIN cbs_owner.RT_DISCOUNT_VALUES t6
          ON     t4.RT_DISCOUNT_ID = t6.RT_DISCOUNT_ID
             AND t6.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
             AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
 WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;

-- DISCOUNT

SELECT t1.DISCOUNT_ITEM_ID AS discountItemId,
       t2.RESELLER_VERSION_ID AS resellerVersionId,
       t6.DISPLAY_VALUE AS rtDiscountKey,
       t2.RT_DISCOUNT_ID AS rtDiscountId,
       t9.DISPLAY_VALUE AS autFinalKey,
       t2.AUT_ID AS autId,
       t12.DISPLAY_VALUE AS autGroupKey,
       t2.AUT_GROUP_ID AS autGroupId,
       t2.IS_DEFAULT AS isDefault,
       t2.IS_INTERNAL AS isInternal,
       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description
  FROM cbs_owner.RT_DISCOUNT_ITEM_KEY t1
       INNER JOIN cbs_owner.RT_DISCOUNT_ITEM_REF t2
          ON t1.DISCOUNT_ITEM_ID = t2.DISCOUNT_ITEM_ID
       INNER JOIN cbs_owner.RT_DISCOUNT_ITEM_VALUES t3
          ON     t2.DISCOUNT_ITEM_ID = t3.DISCOUNT_ITEM_ID
             AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
       INNER JOIN cbs_owner.RT_DISCOUNT_KEY t4
          ON t2.RT_DISCOUNT_ID = t4.RT_DISCOUNT_ID
       INNER JOIN cbs_owner.RT_DISCOUNT_REF t5
          ON     t4.RT_DISCOUNT_ID = t5.RT_DISCOUNT_ID
             AND t5.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
       INNER JOIN cbs_owner.RT_DISCOUNT_VALUES t6
          ON     t4.RT_DISCOUNT_ID = t6.RT_DISCOUNT_ID
             AND t6.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
             AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
       LEFT OUTER JOIN cbs_owner.AUT_FINAL_KEY t7
          ON t2.AUT_ID = t7.AUT_ID
       LEFT OUTER JOIN cbs_owner.AUT_FINAL_REF t8
          ON     t7.AUT_ID = t8.AUT_ID
             AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
       LEFT OUTER JOIN cbs_owner.AUT_FINAL_VALUES t9
          ON     t7.AUT_ID = t9.AUT_ID
             AND t9.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
             AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
       LEFT OUTER JOIN cbs_owner.AUT_GROUP_KEY t10
          ON t2.AUT_GROUP_ID = t10.AUT_GROUP_ID
       LEFT OUTER JOIN cbs_owner.AUT_GROUP_REF t11
          ON     t10.AUT_GROUP_ID = t11.AUT_GROUP_ID
             AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
       LEFT OUTER JOIN cbs_owner.AUT_GROUP_VALUES t12
          ON     t10.AUT_GROUP_ID = t12.AUT_GROUP_ID
             AND t12.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
             AND t12.LANGUAGE_CODE = t3.LANGUAGE_CODE
 WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;


-- DISCOUNT ITEM

SELECT t1.RT_DISCOUNT_ID AS rtDiscountId,
       t2.RESELLER_VERSION_ID AS resellerVersionId,
       t6.DISPLAY_VALUE AS accumulatorKeyByAccumulatorId,
       t2.ACCUMULATOR_ID AS accumulatorId,
       t8.DISPLAY_VALUE AS discountType,
       t10.SERVICE_VERSION_ID AS serviceVersionId,
       t10.ISO_CODE AS currencyIsoCode,
       t10.IMPLIED_DECIMAL AS currencyImpliedDecimal,
       t11.DISPLAY_VALUE AS rateCurrencyKey,
       t2.CURRENCY_CODE AS currencyCode,
       t14.DISPLAY_VALUE AS accumulatorKeyByAddonAccId1,
       t2.ADDON_ACC_ID1 AS addonAccId1,
       t17.DISPLAY_VALUE AS accumulatorKeyByAddonAccId2,
       t2.ADDON_ACC_ID2 AS addonAccId2,
       t20.DISPLAY_VALUE AS accumulatorKeyByAddonAccId3,
       t2.ADDON_ACC_ID3 AS addonAccId3,
       t23.DISPLAY_VALUE AS accumulatorKeyByAddonAccId4,
       t2.ADDON_ACC_ID4 AS addonAccId4,
       t2.RESET_FLAG AS resetFlag,
       t2.IS_DEFAULT AS isDefault,
       t2.IS_INTERNAL AS isInternal,
       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description
  FROM cbs_owner.RT_DISCOUNT_KEY t1
       INNER JOIN cbs_owner.RT_DISCOUNT_REF t2
          ON t1.RT_DISCOUNT_ID = t2.RT_DISCOUNT_ID
       INNER JOIN cbs_owner.RT_DISCOUNT_VALUES t3
          ON     t2.RT_DISCOUNT_ID = t3.RT_DISCOUNT_ID
             AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
       INNER JOIN cbs_owner.ACCUMULATOR_KEY t4
          ON t2.ACCUMULATOR_ID = t4.ACCUMULATOR_ID
       INNER JOIN cbs_owner.ACCUMULATOR_REF t5
          ON     t4.ACCUMULATOR_ID = t5.ACCUMULATOR_ID
             AND t5.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
       INNER JOIN cbs_owner.ACCUMULATOR_VALUES t6
          ON     t4.ACCUMULATOR_ID = t6.ACCUMULATOR_ID
             AND t6.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
             AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
       LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_REF t7
          ON     t7.enumeration_key = LOWER ('' || DISCOUNT_TYPE || '')
             AND t7.VALUE = t2.DISCOUNT_TYPE
       LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_VALUES t8
          ON     t8.enumeration_key = t7.enumeration_key
             AND t8.VALUE = t7.VALUE
             AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
       LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_KEY t9
          ON t2.CURRENCY_CODE = t9.CURRENCY_CODE
       LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_REF t10
          ON     t9.CURRENCY_CODE = t10.CURRENCY_CODE
             AND t10.SERVICE_VERSION_ID = 1
       LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_VALUES t11
          ON     t9.CURRENCY_CODE = t11.CURRENCY_CODE
             AND t11.SERVICE_VERSION_ID = 1
             AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
       LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t12
          ON t2.ADDON_ACC_ID1 = t12.ACCUMULATOR_ID
       LEFT OUTER JOIN cbs_owner.ACCUMULATOR_REF t13
          ON     t12.ACCUMULATOR_ID = t13.ACCUMULATOR_ID
             AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
       LEFT OUTER JOIN cbs_owner.ACCUMULATOR_VALUES t14
          ON     t12.ACCUMULATOR_ID = t14.ACCUMULATOR_ID
             AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
             AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
       LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t15
          ON t2.ADDON_ACC_ID2 = t15.ACCUMULATOR_ID
       LEFT OUTER JOIN cbs_owner.ACCUMULATOR_REF t16
          ON     t15.ACCUMULATOR_ID = t16.ACCUMULATOR_ID
             AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
       LEFT OUTER JOIN cbs_owner.ACCUMULATOR_VALUES t17
          ON     t15.ACCUMULATOR_ID = t17.ACCUMULATOR_ID
             AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
             AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
       LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t18
          ON t2.ADDON_ACC_ID3 = t18.ACCUMULATOR_ID
       LEFT OUTER JOIN cbs_owner.ACCUMULATOR_REF t19
          ON     t18.ACCUMULATOR_ID = t19.ACCUMULATOR_ID
             AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
       LEFT OUTER JOIN cbs_owner.ACCUMULATOR_VALUES t20
          ON     t18.ACCUMULATOR_ID = t20.ACCUMULATOR_ID
             AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
             AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
       LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t21
          ON t2.ADDON_ACC_ID4 = t21.ACCUMULATOR_ID
       LEFT OUTER JOIN cbs_owner.ACCUMULATOR_REF t22
          ON     t21.ACCUMULATOR_ID = t22.ACCUMULATOR_ID
             AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
       LEFT OUTER JOIN cbs_owner.ACCUMULATOR_VALUES t23
          ON     t21.ACCUMULATOR_ID = t23.ACCUMULATOR_ID
             AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
             AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
 WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;