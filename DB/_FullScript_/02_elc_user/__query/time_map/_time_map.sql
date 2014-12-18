/* Formatted on 25/03/2014 17:16:05 (QP5 v5.215.12089.38647) */
SELECT * FROM time_map;

--DROP TABLE TIME_MAP;

CREATE TABLE time_map
AS
   SELECT t1.CALENDAR_ID AS calendar_id,                        -- calendarId,
          t2.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
          t5.DISPLAY_VALUE AS calendar_type,                  -- calendarType,
          --       t8.DISPLAY_VALUE AS dayTypeIdKey,
          --       t2.MONDAY_ID AS mondayId,
          --       t11.DISPLAY_VALUE AS dayTypeIdKeyByTuesdayId,
          --       t2.TUESDAY_ID AS tuesdayId,
          --       t14.DISPLAY_VALUE AS dayTypeIdKeyByWednesdayId,
          --       t2.WEDNESDAY_ID AS wednesdayId,
          --       t17.DISPLAY_VALUE AS dayTypeIdKeyByThursdayId,
          --       t2.THURSDAY_ID AS thursdayId,
          --       t20.DISPLAY_VALUE AS dayTypeIdKeyByFridayId,
          --       t2.FRIDAY_ID AS fridayId,
          --       t23.DISPLAY_VALUE AS dayTypeIdKeyBySaturdayId,
          --       t2.SATURDAY_ID AS saturdayId,
          --       t26.DISPLAY_VALUE AS dayTypeIdKeyBySundayId,
          --       t2.SUNDAY_ID AS sundayId,
          --       t3.LANGUAGE_CODE AS languageCode,
          t3.DISPLAY_VALUE AS calendar_name,                  -- displayValue,
          t3.DESCRIPTION AS description
     FROM cbs_owner.CALENDAR_KEY t1
          INNER JOIN cbs_owner.CALENDAR_REF t2
             ON t1.CALENDAR_ID = t2.CALENDAR_ID
          INNER JOIN cbs_owner.CALENDAR_VALUES t3
             ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_REF t4
             ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                AND t4.VALUE = t2.CALENDAR_TYPE
          LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_VALUES t5
             ON     t5.enumeration_key = t4.enumeration_key
                AND t5.VALUE = t4.VALUE
                AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
             ON t2.MONDAY_ID = t6.DAY_TYPE_ID
          INNER JOIN cbs_owner.DAY_TYPE_ID_REF t7
             ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.DAY_TYPE_ID_VALUES t8
             ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
             ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
          INNER JOIN cbs_owner.DAY_TYPE_ID_REF t10
             ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.DAY_TYPE_ID_VALUES t11
             ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
             ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
          INNER JOIN cbs_owner.DAY_TYPE_ID_REF t13
             ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.DAY_TYPE_ID_VALUES t14
             ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
             ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
          INNER JOIN cbs_owner.DAY_TYPE_ID_REF t16
             ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.DAY_TYPE_ID_VALUES t17
             ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
             ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
          INNER JOIN cbs_owner.DAY_TYPE_ID_REF t19
             ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.DAY_TYPE_ID_VALUES t20
             ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
             ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
          INNER JOIN cbs_owner.DAY_TYPE_ID_REF t22
             ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.DAY_TYPE_ID_VALUES t23
             ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
             ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
          INNER JOIN cbs_owner.DAY_TYPE_ID_REF t25
             ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.DAY_TYPE_ID_VALUES t26
             ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;