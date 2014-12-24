/* Formatted on 3/24/2014 5:39:09 PM (QP5 v5.215.12089.38647) */
SELECT t1.TIME_SLOT_ID AS timeSlotId,
       t2.RESELLER_VERSION_ID AS resellerVersionId,
       t2.BEGIN_TIME AS beginTime,
       t2.END_TIME AS endTime,
       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description
  FROM cbs_owner.TIME_SLOT_KEY t1
       INNER JOIN cbs_owner.TIME_SLOT_REF t2
          ON t1.TIME_SLOT_ID = t2.TIME_SLOT_ID
       INNER JOIN cbs_owner.TIME_SLOT_VALUES t3
          ON     t2.TIME_SLOT_ID = t3.TIME_SLOT_ID
             AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
 WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;