/* Formatted on 26/03/2014 15:33:41 (QP5 v5.215.12089.38647) */
SELECT t61.DISCOUNT_AWARD_ID AS discountAwardId,
       t62.RESELLER_VERSION_ID AS resellerVersionId,
       t66.DISPLAY_VALUE AS rtDiscountKey,
       t62.RT_DISCOUNT_ID AS rtDiscountId,
       t62.THRESHOLD AS threshold,
       t62.AMOUNT AS amount,
       t65.currency_code,
       t70.iso_code AS currencyIsoCode,
       t70.implied_decimal AS currencyImpliedDecimals,
       t62.ADDON_THRES1 AS addonThres1,
       t62.ADDON_THRES2 AS addonThres2,
       t62.ADDON_THRES3 AS addonThres3,
       t62.ADDON_THRES4 AS addonThres4,
       t68.DISPLAY_VALUE AS rewardEventType,
       t62.REWARD_NOTIF_TEXT AS rewardNotifText,
       t62.UNICODE_FLAG AS unicodeFlag,
       t63.LANGUAGE_CODE AS languageCode,
       t63.DISPLAY_VALUE AS displayValue,
       t63.DESCRIPTION AS description
  FROM cbs_owner.DISCOUNT_AWARD_KEY t61
       INNER JOIN cbs_owner.DISCOUNT_AWARD_REF t62
          ON t61.DISCOUNT_AWARD_ID = t62.DISCOUNT_AWARD_ID
       INNER JOIN cbs_owner.DISCOUNT_AWARD_VALUES t63
          ON     t62.DISCOUNT_AWARD_ID = t63.DISCOUNT_AWARD_ID
             AND t62.RESELLER_VERSION_ID = t63.RESELLER_VERSION_ID
       INNER JOIN cbs_owner.RT_DISCOUNT_KEY t64
          ON t62.RT_DISCOUNT_ID = t64.RT_DISCOUNT_ID
       INNER JOIN cbs_owner.RT_DISCOUNT_REF t65
          ON     t64.RT_DISCOUNT_ID = t65.RT_DISCOUNT_ID
             AND t65.RESELLER_VERSION_ID = t62.RESELLER_VERSION_ID
       LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_KEY t69
          ON t65.currency_code = t69.Currency_Code
       LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_REF t70
          ON     t69.currency_code = t70.currency_code
             AND t70.service_version_id = 1
       INNER JOIN cbs_owner.RT_DISCOUNT_VALUES t66
          ON     t64.RT_DISCOUNT_ID = t66.RT_DISCOUNT_ID
             AND t66.RESELLER_VERSION_ID = t62.RESELLER_VERSION_ID
             AND t66.LANGUAGE_CODE = t63.LANGUAGE_CODE
       LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_REF t67
          ON     t67.table_name = 'DISCOUNT_AWARD_REF'
             AND t67.field_name = LOWER ('REWARD_EVENT_TYPE')
             AND t67.integer_value = t62.REWARD_EVENT_TYPE
       LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_VALUES t68
          ON     t68.table_name = t67.table_name
             AND t68.field_name = t67.field_name
             AND t68.integer_value = t67.integer_value
             AND t68.LANGUAGE_CODE = t63.LANGUAGE_CODE
 WHERE t62.RESELLER_VERSION_ID = 2 AND t63.LANGUAGE_CODE = 1;