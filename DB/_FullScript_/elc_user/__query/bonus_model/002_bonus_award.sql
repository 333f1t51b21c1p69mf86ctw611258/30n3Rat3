/* Formatted on 3/23/2014 9:22:53 PM (QP5 v5.215.12089.38647) */
SELECT t1.BONUS_AWARD_ID AS bonusAwardId,
       t1.RESELLER_VERSION_ID AS resellerVersionId,
       t3.DISPLAY_VALUE AS bonusType,
       t1.AWARD_TYPE AS awardType,
       t1.AWARD_INFO AS awardInfo,
       t6.DISPLAY_VALUE AS bonusThresholdKey,
       t1.BONUS_THRESHOLD_ID AS bonusThresholdId,
       t1.AMOUNT AS amount,
       t1.START_DATE AS startDate,
       t1.END_DATE AS endDate,
       t1.OFFSET AS offset,
       t1.DURATION AS duration,
       t8.DISPLAY_VALUE AS expirationType
  FROM BONUS_AWARD t1
       LEFT OUTER JOIN GUI_INDICATOR_REF t2
          ON     t2.table_name = 'BONUS_AWARD'
             AND t2.field_name = LOWER ('BONUS_TYPE')
             AND t2.integer_value = t1.BONUS_TYPE
       LEFT OUTER JOIN GUI_INDICATOR_VALUES t3
          ON     t3.table_name = t2.table_name
             AND t3.field_name = t2.field_name
             AND t3.integer_value = t2.integer_value
             AND t3.LANGUAGE_CODE = 1
       INNER JOIN BONUS_THRESHOLD_KEY t4
          ON t1.BONUS_THRESHOLD_ID = t4.BONUS_THRESHOLD_ID
       INNER JOIN BONUS_THRESHOLD_REF t5
          ON     t4.BONUS_THRESHOLD_ID = t5.BONUS_THRESHOLD_ID
             AND t5.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       INNER JOIN BONUS_THRESHOLD_VALUES t6
          ON     t4.BONUS_THRESHOLD_ID = t6.BONUS_THRESHOLD_ID
             AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t6.LANGUAGE_CODE = 1
       LEFT OUTER JOIN GUI_INDICATOR_REF t7
          ON     t7.table_name = 'BONUS_AWARD'
             AND t7.field_name = LOWER ('EXPIRATION_TYPE')
             AND t7.integer_value = t1.EXPIRATION_TYPE
       LEFT OUTER JOIN GUI_INDICATOR_VALUES t8
          ON     t8.table_name = t7.table_name
             AND t8.field_name = t7.field_name
             AND t8.integer_value = t7.integer_value
             AND t8.LANGUAGE_CODE = t6.LANGUAGE_CODE
 WHERE t1.RESELLER_VERSION_ID = 2;