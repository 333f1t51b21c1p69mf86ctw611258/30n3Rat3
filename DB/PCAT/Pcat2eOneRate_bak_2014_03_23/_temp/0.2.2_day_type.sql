/* Formatted on 06/03/2014 08:51:44 (QP5 v5.215.12089.38647) */
-- DAY_TYPE

SELECT t1.DAY_TYPE_ID AS dayTypeId,
       t2.RESELLER_VERSION_ID AS resellerVersionId,
       t2.IS_DEFAULT AS isDefault,
       t2.IS_INTERNAL AS isInternal,
       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description
  FROM cbs_owner.DAY_TYPE_ID_KEY t1
       INNER JOIN cbs_owner.DAY_TYPE_ID_REF t2
          ON t1.DAY_TYPE_ID = t2.DAY_TYPE_ID
       INNER JOIN cbs_owner.DAY_TYPE_ID_VALUES t3
          ON     t2.DAY_TYPE_ID = t3.DAY_TYPE_ID
             AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
 WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;

-- *** DAY_TIME_MAPPING

SELECT t1.DAY_TIME_MAPPING_ID AS dayTimeMappingId,
       t4.DISPLAY_VALUE AS timeSlotKey,
       t1.TIME_SLOT_ID AS timeSlotId,
       t7.DISPLAY_VALUE AS timeTypeKey,
       t1.TIME_TYPE_ID AS timeTypeId,
       t10.DISPLAY_VALUE AS dayTypeIdKey,
       t1.DAY_TYPE_ID AS dayTypeId,
       t1.RESELLER_VERSION_ID AS resellerVersionId
  FROM cbs_owner.DAY_TIME_MAPPING t1
       INNER JOIN cbs_owner.TIME_SLOT_KEY t2
          ON t1.TIME_SLOT_ID = t2.TIME_SLOT_ID
       INNER JOIN cbs_owner.TIME_SLOT_REF t3
          ON     t2.TIME_SLOT_ID = t3.TIME_SLOT_ID
             AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       INNER JOIN cbs_owner.TIME_SLOT_VALUES t4
          ON     t2.TIME_SLOT_ID = t4.TIME_SLOT_ID
             AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t4.LANGUAGE_CODE = 1
       INNER JOIN cbs_owner.TIME_TYPE_KEY t5
          ON t1.TIME_TYPE_ID = t5.TIME_TYPE_ID
       INNER JOIN cbs_owner.TIME_TYPE_REF t6
          ON     t5.TIME_TYPE_ID = t6.TIME_TYPE_ID
             AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       INNER JOIN cbs_owner.TIME_TYPE_VALUES t7
          ON     t5.TIME_TYPE_ID = t7.TIME_TYPE_ID
             AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
       INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t8
          ON t1.DAY_TYPE_ID = t8.DAY_TYPE_ID
       INNER JOIN cbs_owner.DAY_TYPE_ID_REF t9
          ON     t8.DAY_TYPE_ID = t9.DAY_TYPE_ID
             AND t9.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       INNER JOIN cbs_owner.DAY_TYPE_ID_VALUES t10
          ON     t8.DAY_TYPE_ID = t10.DAY_TYPE_ID
             AND t10.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t10.LANGUAGE_CODE = t4.LANGUAGE_CODE
 WHERE t1.RESELLER_VERSION_ID = 2;

-- *** TIME_TYPE

SELECT t1.TIME_TYPE_ID AS timeTypeId,
       t2.RESELLER_VERSION_ID AS resellerVersionId,
       t2.IS_INTERNAL AS isInternal,
       t2.IS_DEFAULT AS isDefault,
       t2.RATE_PERIOD AS ratePeriod,
       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description
  FROM cbs_owner.TIME_TYPE_KEY t1
       INNER JOIN cbs_owner.TIME_TYPE_REF t2
          ON t1.TIME_TYPE_ID = t2.TIME_TYPE_ID
       INNER JOIN cbs_owner.TIME_TYPE_VALUES t3
          ON     t2.TIME_TYPE_ID = t3.TIME_TYPE_ID
             AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
 WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;

-- *** TIME_SLOT

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