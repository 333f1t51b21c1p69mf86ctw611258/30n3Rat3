/* Formatted on 3/18/2014 10:25:43 PM (QP5 v5.215.12089.38647) */
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
       t8.DISPLAY_VALUE AS rewardEventType,
       t2.REWARD_NOTIF_TEXT AS rewardNotifText,
       t2.UNICODE_FLAG AS unicodeFlag,
       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description
  FROM DISCOUNT_AWARD_KEY t1
       INNER JOIN DISCOUNT_AWARD_REF t2
          ON t1.DISCOUNT_AWARD_ID = t2.DISCOUNT_AWARD_ID
       INNER JOIN DISCOUNT_AWARD_VALUES t3
          ON     t2.DISCOUNT_AWARD_ID = t3.DISCOUNT_AWARD_ID
             AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
       INNER JOIN RT_DISCOUNT_KEY t4
          ON t2.RT_DISCOUNT_ID = t4.RT_DISCOUNT_ID
       INNER JOIN RT_DISCOUNT_REF t5
          ON     t4.RT_DISCOUNT_ID = t5.RT_DISCOUNT_ID
             AND t5.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
       LEFT OUTER JOIN RATE_CURRENCY_KEY t9
          ON t5.currency_code = t9.Currency_Code
       LEFT OUTER JOIN RATE_CURRENCY_REF t10
          ON     t9.currency_code = t10.currency_code
             AND t10.service_version_id = 1
       INNER JOIN RT_DISCOUNT_VALUES t6
          ON     t4.RT_DISCOUNT_ID = t6.RT_DISCOUNT_ID
             AND t6.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
             AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
       LEFT OUTER JOIN GUI_INDICATOR_REF t7
          ON     t7.table_name = 'DISCOUNT_AWARD_REF'
             AND t7.field_name = LOWER ('REWARD_EVENT_TYPE')
             AND t7.integer_value = t2.REWARD_EVENT_TYPE
       LEFT OUTER JOIN GUI_INDICATOR_VALUES t8
          ON     t8.table_name = t7.table_name
             AND t8.field_name = t7.field_name
             AND t8.integer_value = t7.integer_value
             AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
 WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;