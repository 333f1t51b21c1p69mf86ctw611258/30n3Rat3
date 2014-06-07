/* Formatted on 19/03/2014 09:49:34 (QP5 v5.215.12089.38647) */
SELECT t41.DISCOUNT_AWARD_ID AS discountAwardId,
       t42.RESELLER_VERSION_ID AS resellerVersionId,
       t46.DISPLAY_VALUE AS rtDiscountKey,
       t42.RT_DISCOUNT_ID AS rtDiscountId,
       t42.THRESHOLD AS threshold,
       t42.AMOUNT AS amount,
       t45.currency_code,
       t50.iso_code AS currencyIsoCode,
       t50.implied_decimal AS currencyImpliedDecimals,
       t42.ADDON_THRES1 AS addonThres1,
       t42.ADDON_THRES2 AS addonThres2,
       t42.ADDON_THRES3 AS addonThres3,
       t42.ADDON_THRES4 AS addonThres4,
       t48.DISPLAY_VALUE AS rewardEventType,
       t42.REWARD_NOTIF_TEXT AS rewardNotifText,
       t42.UNICODE_FLAG AS unicodeFlag,
       t43.LANGUAGE_CODE AS languageCode,
       t43.DISPLAY_VALUE AS displayValue,
       t43.DESCRIPTION AS description
  FROM DISCOUNT_AWARD_KEY t41
       INNER JOIN DISCOUNT_AWARD_REF t42
          ON t41.DISCOUNT_AWARD_ID = t42.DISCOUNT_AWARD_ID
       INNER JOIN DISCOUNT_AWARD_VALUES t43
          ON     t42.DISCOUNT_AWARD_ID = t43.DISCOUNT_AWARD_ID
             AND t42.RESELLER_VERSION_ID = t43.RESELLER_VERSION_ID
       INNER JOIN RT_DISCOUNT_KEY t44
          ON t42.RT_DISCOUNT_ID = t44.RT_DISCOUNT_ID
       INNER JOIN RT_DISCOUNT_REF t45
          ON     t44.RT_DISCOUNT_ID = t45.RT_DISCOUNT_ID
             AND t45.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
       LEFT OUTER JOIN RATE_CURRENCY_KEY t49
          ON t45.currency_code = t49.Currency_Code
       LEFT OUTER JOIN RATE_CURRENCY_REF t50
          ON     t49.currency_code = t50.currency_code
             AND t50.service_version_id = 1
       INNER JOIN RT_DISCOUNT_VALUES t46
          ON     t44.RT_DISCOUNT_ID = t46.RT_DISCOUNT_ID
             AND t46.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
             AND t46.LANGUAGE_CODE = t43.LANGUAGE_CODE
       LEFT OUTER JOIN GUI_INDICATOR_REF t47
          ON     t47.table_name = 'DISCOUNT_AWARD_REF'
             AND t47.field_name = LOWER ('REWARD_EVENT_TYPE')
             AND t47.integer_value = t42.REWARD_EVENT_TYPE
       LEFT OUTER JOIN GUI_INDICATOR_VALUES t48
          ON     t48.table_name = t47.table_name
             AND t48.field_name = t47.field_name
             AND t48.integer_value = t47.integer_value
             AND t48.LANGUAGE_CODE = t43.LANGUAGE_CODE
 WHERE t42.RESELLER_VERSION_ID = 2 AND t43.LANGUAGE_CODE = 1;