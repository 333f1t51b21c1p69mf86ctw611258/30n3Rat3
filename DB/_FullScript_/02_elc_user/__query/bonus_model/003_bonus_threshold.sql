/* Formatted on 3/23/2014 9:45:56 PM (QP5 v5.215.12089.38647) */
SELECT t1.BONUS_THRESHOLD_ID AS bonusThresholdId,
       t2.RESELLER_VERSION_ID AS resellerVersionId,
       t6.DISPLAY_VALUE AS rtBonusItemKey,
       t2.BONUS_ITEM_ID AS bonusItemId,
       t8.DISPLAY_VALUE AS rewardEvent,
       t2.UNICODE_FLAG AS unicodeFlag,
       t2.THRESHOLD AS threshold,
       t2.ADDON_THRES1 AS addonThres1,
       t2.ADDON_THRES2 AS addonThres2,
       t2.ADDON_THRES3 AS addonThres3,
       t2.ADDON_THRES4 AS addonThres4,
       t2.IS_DEFERRED AS isDeferred,
       t2.REWARD_NOTIF_TEXT AS rewardNotifText,
       t2.ACTIVE_DURATION_DAYS AS activeDurationDays,
       t2.ACTIVE_BONUS_CYCLES AS activeBonusCycles,
       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description
  FROM BONUS_THRESHOLD_KEY t1
       INNER JOIN BONUS_THRESHOLD_REF t2
          ON t1.BONUS_THRESHOLD_ID = t2.BONUS_THRESHOLD_ID
       INNER JOIN BONUS_THRESHOLD_VALUES t3
          ON     t2.BONUS_THRESHOLD_ID = t3.BONUS_THRESHOLD_ID
             AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
       INNER JOIN RT_BONUS_ITEM_KEY t4
          ON t2.BONUS_ITEM_ID = t4.BONUS_ITEM_ID
       INNER JOIN RT_BONUS_ITEM_REF t5
          ON     t4.BONUS_ITEM_ID = t5.BONUS_ITEM_ID
             AND t5.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
       INNER JOIN RT_BONUS_ITEM_VALUES t6
          ON     t4.BONUS_ITEM_ID = t6.BONUS_ITEM_ID
             AND t6.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
             AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
       LEFT OUTER JOIN GUI_INDICATOR_REF t7
          ON     t7.table_name = 'BONUS_THRESHOLD_REF'
             AND t7.field_name = LOWER ('REWARD_EVENT')
             AND t7.integer_value = t2.REWARD_EVENT
       LEFT OUTER JOIN GUI_INDICATOR_VALUES t8
          ON     t8.table_name = t7.table_name
             AND t8.field_name = t7.field_name
             AND t8.integer_value = t7.integer_value
             AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
 WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;