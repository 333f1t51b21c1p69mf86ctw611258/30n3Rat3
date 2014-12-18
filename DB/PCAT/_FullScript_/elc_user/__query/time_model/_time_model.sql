/* Formatted on 8/4/2014 18:04:43 (QP5 v5.227.12220.39754) */
DROP TABLE TIME_MODEL;

SELECT * FROM TIME_MODEL;

CREATE TABLE time_model
AS
   SELECT t1.CALENDAR_ID AS CALENDAR_ID,
          t3.DISPLAY_VALUE AS CALENDAR_NAME,
          t5.DISPLAY_VALUE AS MODEL_Type,
          0 AS DAY_IN,                                              -- DAY_IN,
          t8.DISPLAY_VALUE AS day_Type_NAME,
          t2.MONDAY_ID AS DAY_TYPE_ID,
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
          t3.DESCRIPTION AS description,
          -- TIME SLOT
          t31.TIME_SLOT_ID AS time_Slot_Id,
          t33.DISPLAY_VALUE AS time_slot_NAME,
          CASE t32.BEGIN_TIME
             WHEN 0 THEN '00:00'
             ELSE TO_CHAR (TO_DATE (t32.BEGIN_TIME - 1, 'sssss'), 'hh24:mi')
          END
             AS FROM_IN,
          CASE t32.END_TIME
             WHEN 0 THEN '00:00'
             ELSE TO_CHAR (TO_DATE (t32.END_TIME - 1, 'sssss'), 'hh24:mi')
          END
             AS TO_IN,
          -- TIME TYPE
          t28.TIME_TYPE_ID AS time_Type_Id,
          t30.DISPLAY_VALUE AS TIME_TYPE_name,
          t2.RESELLER_VERSION_ID
     FROM cbs_owner.CALENDAR_KEY t1
          INNER JOIN cbs_owner.CALENDAR_REF t2
             ON t1.CALENDAR_ID = t2.CALENDAR_ID
          -- DAY_TIME_MAPPING
          INNER JOIN cbs_owner.DAY_TIME_MAPPING t27
             ON t2.MONDAY_ID = t27.DAY_TYPE_ID
          -- TIME_TYPE
          INNER JOIN cbs_owner.TIME_TYPE_KEY t28
             ON t28.TIME_TYPE_ID = t27.TIME_TYPE_ID
          INNER JOIN cbs_owner.TIME_TYPE_REF t29
             ON t28.TIME_TYPE_ID = t29.TIME_TYPE_ID
          INNER JOIN
          cbs_owner.TIME_TYPE_VALUES t30
             ON     t29.TIME_TYPE_ID = t30.TIME_TYPE_ID
                AND t29.RESELLER_VERSION_ID = t30.RESELLER_VERSION_ID
          -- TIME SLOT
          INNER JOIN cbs_owner.TIME_SLOT_KEY t31
             ON t31.TIME_SLOT_ID = t27.TIME_SLOT_ID
          INNER JOIN cbs_owner.TIME_SLOT_REF t32
             ON t31.TIME_SLOT_ID = t32.TIME_SLOT_ID
          INNER JOIN
          cbs_owner.TIME_SLOT_VALUES t33
             ON     t32.TIME_SLOT_ID = t33.TIME_SLOT_ID
                AND t32.RESELLER_VERSION_ID = t33.RESELLER_VERSION_ID
          --
          INNER JOIN
          cbs_owner.CALENDAR_VALUES t3
             ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t4
             ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                AND t4.VALUE = t2.CALENDAR_TYPE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t5
             ON     t5.enumeration_key = t4.enumeration_key
                AND t5.VALUE = t4.VALUE
                AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
             ON t2.MONDAY_ID = t6.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t7
             ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t8
             ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
             ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t10
             ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t11
             ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
             ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t13
             ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t14
             ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
             ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t16
             ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t17
             ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
             ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t19
             ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t20
             ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
             ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t22
             ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t23
             ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
             ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t25
             ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t26
             ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1
   UNION
   SELECT t1.CALENDAR_ID AS TIME_MODEL_ID,
          t3.DISPLAY_VALUE AS TIME_MODEL_IN,
          t5.DISPLAY_VALUE AS MODEL_Type,
          1 AS DAY_IN,                                              -- DAY_IN,
          t11.DISPLAY_VALUE AS day_Type_NAME,
          t2.TUESDAY_ID AS DAY_TYPE_ID,
          t3.DESCRIPTION AS description,
          -- TIME SLOT
          t31.TIME_SLOT_ID AS time_Slot_Id,
          t33.DISPLAY_VALUE AS time_slot_NAME,
          CASE t32.BEGIN_TIME
             WHEN 0 THEN '00:00'
             ELSE TO_CHAR (TO_DATE (t32.BEGIN_TIME - 1, 'sssss'), 'hh24:mi')
          END
             AS FROM_IN,
          CASE t32.END_TIME
             WHEN 0 THEN '00:00'
             ELSE TO_CHAR (TO_DATE (t32.END_TIME - 1, 'sssss'), 'hh24:mi')
          END
             AS TO_IN,
          -- TIME TYPE
          t28.TIME_TYPE_ID AS time_Type_Id,
          t30.DISPLAY_VALUE AS TIME_TYPE_OUT,
          t2.RESELLER_VERSION_ID
     FROM cbs_owner.CALENDAR_KEY t1
          INNER JOIN cbs_owner.CALENDAR_REF t2
             ON t1.CALENDAR_ID = t2.CALENDAR_ID
          -- DAY_TIME_MAPPING
          INNER JOIN cbs_owner.DAY_TIME_MAPPING t27
             ON t2.MONDAY_ID = t27.DAY_TYPE_ID
          -- TIME_TYPE
          INNER JOIN cbs_owner.TIME_TYPE_KEY t28
             ON t28.TIME_TYPE_ID = t27.TIME_TYPE_ID
          INNER JOIN cbs_owner.TIME_TYPE_REF t29
             ON t28.TIME_TYPE_ID = t29.TIME_TYPE_ID
          INNER JOIN
          cbs_owner.TIME_TYPE_VALUES t30
             ON     t29.TIME_TYPE_ID = t30.TIME_TYPE_ID
                AND t29.RESELLER_VERSION_ID = t30.RESELLER_VERSION_ID
          -- TIME SLOT
          INNER JOIN cbs_owner.TIME_SLOT_KEY t31
             ON t31.TIME_SLOT_ID = t27.TIME_SLOT_ID
          INNER JOIN cbs_owner.TIME_SLOT_REF t32
             ON t31.TIME_SLOT_ID = t32.TIME_SLOT_ID
          INNER JOIN
          cbs_owner.TIME_SLOT_VALUES t33
             ON     t32.TIME_SLOT_ID = t33.TIME_SLOT_ID
                AND t32.RESELLER_VERSION_ID = t33.RESELLER_VERSION_ID
          --
          INNER JOIN
          cbs_owner.CALENDAR_VALUES t3
             ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t4
             ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                AND t4.VALUE = t2.CALENDAR_TYPE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t5
             ON     t5.enumeration_key = t4.enumeration_key
                AND t5.VALUE = t4.VALUE
                AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
             ON t2.MONDAY_ID = t6.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t7
             ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t8
             ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
             ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t10
             ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t11
             ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
             ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t13
             ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t14
             ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
             ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t16
             ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t17
             ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
             ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t19
             ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t20
             ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
             ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t22
             ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t23
             ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
             ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t25
             ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t26
             ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1
   UNION
   SELECT t1.CALENDAR_ID AS TIME_MODEL_ID,
          t3.DISPLAY_VALUE AS TIME_MODEL_IN,
          t5.DISPLAY_VALUE AS MODEL_Type,
          2 AS DAY_IN,                                              -- DAY_IN,
          t14.DISPLAY_VALUE AS day_Type_NAME,
          t2.TUESDAY_ID AS DAY_TYPE_ID,
          t3.DESCRIPTION AS description,
          -- TIME SLOT
          t31.TIME_SLOT_ID AS time_Slot_Id,
          t33.DISPLAY_VALUE AS time_slot_NAME,
          CASE t32.BEGIN_TIME
             WHEN 0 THEN '00:00'
             ELSE TO_CHAR (TO_DATE (t32.BEGIN_TIME - 1, 'sssss'), 'hh24:mi')
          END
             AS FROM_IN,
          CASE t32.END_TIME
             WHEN 0 THEN '00:00'
             ELSE TO_CHAR (TO_DATE (t32.END_TIME - 1, 'sssss'), 'hh24:mi')
          END
             AS TO_IN,
          -- TIME TYPE
          t28.TIME_TYPE_ID AS time_Type_Id,
          t30.DISPLAY_VALUE AS TIME_TYPE_OUT,
          t2.RESELLER_VERSION_ID
     FROM cbs_owner.CALENDAR_KEY t1
          INNER JOIN cbs_owner.CALENDAR_REF t2
             ON t1.CALENDAR_ID = t2.CALENDAR_ID
          -- DAY_TIME_MAPPING
          INNER JOIN cbs_owner.DAY_TIME_MAPPING t27
             ON t2.MONDAY_ID = t27.DAY_TYPE_ID
          -- TIME_TYPE
          INNER JOIN cbs_owner.TIME_TYPE_KEY t28
             ON t28.TIME_TYPE_ID = t27.TIME_TYPE_ID
          INNER JOIN cbs_owner.TIME_TYPE_REF t29
             ON t28.TIME_TYPE_ID = t29.TIME_TYPE_ID
          INNER JOIN
          cbs_owner.TIME_TYPE_VALUES t30
             ON     t29.TIME_TYPE_ID = t30.TIME_TYPE_ID
                AND t29.RESELLER_VERSION_ID = t30.RESELLER_VERSION_ID
          -- TIME SLOT
          INNER JOIN cbs_owner.TIME_SLOT_KEY t31
             ON t31.TIME_SLOT_ID = t27.TIME_SLOT_ID
          INNER JOIN cbs_owner.TIME_SLOT_REF t32
             ON t31.TIME_SLOT_ID = t32.TIME_SLOT_ID
          INNER JOIN
          cbs_owner.TIME_SLOT_VALUES t33
             ON     t32.TIME_SLOT_ID = t33.TIME_SLOT_ID
                AND t32.RESELLER_VERSION_ID = t33.RESELLER_VERSION_ID
          --
          INNER JOIN
          cbs_owner.CALENDAR_VALUES t3
             ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t4
             ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                AND t4.VALUE = t2.CALENDAR_TYPE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t5
             ON     t5.enumeration_key = t4.enumeration_key
                AND t5.VALUE = t4.VALUE
                AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
             ON t2.MONDAY_ID = t6.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t7
             ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t8
             ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
             ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t10
             ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t11
             ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
             ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t13
             ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t14
             ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
             ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t16
             ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t17
             ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
             ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t19
             ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t20
             ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
             ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t22
             ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t23
             ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
             ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t25
             ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t26
             ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1
   UNION
   SELECT t1.CALENDAR_ID AS TIME_MODEL_ID,
          t3.DISPLAY_VALUE AS TIME_MODEL_IN,
          t5.DISPLAY_VALUE AS MODEL_Type,
          3 AS DAY_IN,                                              -- DAY_IN,
          t20.DISPLAY_VALUE AS day_Type_NAME,
          t2.THURSDAY_ID AS DAY_TYPE_ID,
          t3.DESCRIPTION AS description,
          -- TIME SLOT
          t31.TIME_SLOT_ID AS time_Slot_Id,
          t33.DISPLAY_VALUE AS time_slot_NAME,
          CASE t32.BEGIN_TIME
             WHEN 0 THEN '00:00'
             ELSE TO_CHAR (TO_DATE (t32.BEGIN_TIME - 1, 'sssss'), 'hh24:mi')
          END
             AS FROM_IN,
          CASE t32.END_TIME
             WHEN 0 THEN '00:00'
             ELSE TO_CHAR (TO_DATE (t32.END_TIME - 1, 'sssss'), 'hh24:mi')
          END
             AS TO_IN,
          -- TIME TYPE
          t28.TIME_TYPE_ID AS time_Type_Id,
          t30.DISPLAY_VALUE AS TIME_TYPE_OUT,
          t2.RESELLER_VERSION_ID
     FROM cbs_owner.CALENDAR_KEY t1
          INNER JOIN cbs_owner.CALENDAR_REF t2
             ON t1.CALENDAR_ID = t2.CALENDAR_ID
          -- DAY_TIME_MAPPING
          INNER JOIN cbs_owner.DAY_TIME_MAPPING t27
             ON t2.MONDAY_ID = t27.DAY_TYPE_ID
          -- TIME_TYPE
          INNER JOIN cbs_owner.TIME_TYPE_KEY t28
             ON t28.TIME_TYPE_ID = t27.TIME_TYPE_ID
          INNER JOIN cbs_owner.TIME_TYPE_REF t29
             ON t28.TIME_TYPE_ID = t29.TIME_TYPE_ID
          INNER JOIN
          cbs_owner.TIME_TYPE_VALUES t30
             ON     t29.TIME_TYPE_ID = t30.TIME_TYPE_ID
                AND t29.RESELLER_VERSION_ID = t30.RESELLER_VERSION_ID
          -- TIME SLOT
          INNER JOIN cbs_owner.TIME_SLOT_KEY t31
             ON t31.TIME_SLOT_ID = t27.TIME_SLOT_ID
          INNER JOIN cbs_owner.TIME_SLOT_REF t32
             ON t31.TIME_SLOT_ID = t32.TIME_SLOT_ID
          INNER JOIN
          cbs_owner.TIME_SLOT_VALUES t33
             ON     t32.TIME_SLOT_ID = t33.TIME_SLOT_ID
                AND t32.RESELLER_VERSION_ID = t33.RESELLER_VERSION_ID
          --
          INNER JOIN
          cbs_owner.CALENDAR_VALUES t3
             ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t4
             ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                AND t4.VALUE = t2.CALENDAR_TYPE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t5
             ON     t5.enumeration_key = t4.enumeration_key
                AND t5.VALUE = t4.VALUE
                AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
             ON t2.MONDAY_ID = t6.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t7
             ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t8
             ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
             ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t10
             ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t11
             ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
             ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t13
             ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t14
             ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
             ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t16
             ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t17
             ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
             ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t19
             ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t20
             ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
             ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t22
             ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t23
             ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
             ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t25
             ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t26
             ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1
   UNION
   SELECT t1.CALENDAR_ID AS TIME_MODEL_ID,
          t3.DISPLAY_VALUE AS TIME_MODEL_IN,
          t5.DISPLAY_VALUE AS MODEL_Type,
          4 AS DAY_IN,                                              -- DAY_IN,
          t20.DISPLAY_VALUE AS day_Type_NAME,
          t2.FRIDAY_ID AS DAY_TYPE_ID,
          t3.DESCRIPTION AS description,
          -- TIME SLOT
          t31.TIME_SLOT_ID AS time_Slot_Id,
          t33.DISPLAY_VALUE AS time_slot_NAME,
          CASE t32.BEGIN_TIME
             WHEN 0 THEN '00:00'
             ELSE TO_CHAR (TO_DATE (t32.BEGIN_TIME - 1, 'sssss'), 'hh24:mi')
          END
             AS FROM_IN,
          CASE t32.END_TIME
             WHEN 0 THEN '00:00'
             ELSE TO_CHAR (TO_DATE (t32.END_TIME - 1, 'sssss'), 'hh24:mi')
          END
             AS TO_IN,
          -- TIME TYPE
          t28.TIME_TYPE_ID AS time_Type_Id,
          t30.DISPLAY_VALUE AS TIME_TYPE_OUT,
          t2.RESELLER_VERSION_ID
     FROM cbs_owner.CALENDAR_KEY t1
          INNER JOIN cbs_owner.CALENDAR_REF t2
             ON t1.CALENDAR_ID = t2.CALENDAR_ID
          -- DAY_TIME_MAPPING
          INNER JOIN cbs_owner.DAY_TIME_MAPPING t27
             ON t2.MONDAY_ID = t27.DAY_TYPE_ID
          -- TIME_TYPE
          INNER JOIN cbs_owner.TIME_TYPE_KEY t28
             ON t28.TIME_TYPE_ID = t27.TIME_TYPE_ID
          INNER JOIN cbs_owner.TIME_TYPE_REF t29
             ON t28.TIME_TYPE_ID = t29.TIME_TYPE_ID
          INNER JOIN
          cbs_owner.TIME_TYPE_VALUES t30
             ON     t29.TIME_TYPE_ID = t30.TIME_TYPE_ID
                AND t29.RESELLER_VERSION_ID = t30.RESELLER_VERSION_ID
          -- TIME SLOT
          INNER JOIN cbs_owner.TIME_SLOT_KEY t31
             ON t31.TIME_SLOT_ID = t27.TIME_SLOT_ID
          INNER JOIN cbs_owner.TIME_SLOT_REF t32
             ON t31.TIME_SLOT_ID = t32.TIME_SLOT_ID
          INNER JOIN
          cbs_owner.TIME_SLOT_VALUES t33
             ON     t32.TIME_SLOT_ID = t33.TIME_SLOT_ID
                AND t32.RESELLER_VERSION_ID = t33.RESELLER_VERSION_ID
          --
          INNER JOIN
          cbs_owner.CALENDAR_VALUES t3
             ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t4
             ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                AND t4.VALUE = t2.CALENDAR_TYPE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t5
             ON     t5.enumeration_key = t4.enumeration_key
                AND t5.VALUE = t4.VALUE
                AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
             ON t2.MONDAY_ID = t6.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t7
             ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t8
             ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
             ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t10
             ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t11
             ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
             ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t13
             ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t14
             ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
             ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t16
             ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t17
             ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
             ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t19
             ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t20
             ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
             ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t22
             ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t23
             ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
             ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t25
             ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t26
             ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1
   UNION
   SELECT t1.CALENDAR_ID AS TIME_MODEL_ID,
          t3.DISPLAY_VALUE AS TIME_MODEL_IN,
          t5.DISPLAY_VALUE AS MODEL_Type,
          5 AS DAY_IN,                                              -- DAY_IN,
          t23.DISPLAY_VALUE AS day_Type_NAME,
          t2.SATURDAY_ID AS DAY_TYPE_ID,
          t3.DESCRIPTION AS description,
          -- TIME SLOT
          t31.TIME_SLOT_ID AS time_Slot_Id,
          t33.DISPLAY_VALUE AS time_slot_NAME,
          CASE t32.BEGIN_TIME
             WHEN 0 THEN '00:00'
             ELSE TO_CHAR (TO_DATE (t32.BEGIN_TIME - 1, 'sssss'), 'hh24:mi')
          END
             AS FROM_IN,
          CASE t32.END_TIME
             WHEN 0 THEN '00:00'
             ELSE TO_CHAR (TO_DATE (t32.END_TIME - 1, 'sssss'), 'hh24:mi')
          END
             AS TO_IN,
          -- TIME TYPE
          t28.TIME_TYPE_ID AS time_Type_Id,
          t30.DISPLAY_VALUE AS TIME_TYPE_OUT,
          t2.RESELLER_VERSION_ID
     FROM cbs_owner.CALENDAR_KEY t1
          INNER JOIN cbs_owner.CALENDAR_REF t2
             ON t1.CALENDAR_ID = t2.CALENDAR_ID
          -- DAY_TIME_MAPPING
          INNER JOIN cbs_owner.DAY_TIME_MAPPING t27
             ON t2.MONDAY_ID = t27.DAY_TYPE_ID
          -- TIME_TYPE
          INNER JOIN cbs_owner.TIME_TYPE_KEY t28
             ON t28.TIME_TYPE_ID = t27.TIME_TYPE_ID
          INNER JOIN cbs_owner.TIME_TYPE_REF t29
             ON t28.TIME_TYPE_ID = t29.TIME_TYPE_ID
          INNER JOIN
          cbs_owner.TIME_TYPE_VALUES t30
             ON     t29.TIME_TYPE_ID = t30.TIME_TYPE_ID
                AND t29.RESELLER_VERSION_ID = t30.RESELLER_VERSION_ID
          -- TIME SLOT
          INNER JOIN cbs_owner.TIME_SLOT_KEY t31
             ON t31.TIME_SLOT_ID = t27.TIME_SLOT_ID
          INNER JOIN cbs_owner.TIME_SLOT_REF t32
             ON t31.TIME_SLOT_ID = t32.TIME_SLOT_ID
          INNER JOIN
          cbs_owner.TIME_SLOT_VALUES t33
             ON     t32.TIME_SLOT_ID = t33.TIME_SLOT_ID
                AND t32.RESELLER_VERSION_ID = t33.RESELLER_VERSION_ID
          --
          INNER JOIN
          cbs_owner.CALENDAR_VALUES t3
             ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t4
             ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                AND t4.VALUE = t2.CALENDAR_TYPE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t5
             ON     t5.enumeration_key = t4.enumeration_key
                AND t5.VALUE = t4.VALUE
                AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
             ON t2.MONDAY_ID = t6.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t7
             ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t8
             ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
             ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t10
             ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t11
             ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
             ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t13
             ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t14
             ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
             ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t16
             ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t17
             ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
             ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t19
             ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t20
             ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
             ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t22
             ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t23
             ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
             ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t25
             ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t26
             ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1
   UNION
   SELECT t1.CALENDAR_ID AS TIME_MODEL_ID,
          t3.DISPLAY_VALUE AS TIME_MODEL_IN,
          t5.DISPLAY_VALUE AS MODEL_Type,
          6 AS DAY_IN,                                              -- DAY_IN,
          t26.DISPLAY_VALUE AS day_Type_NAME,
          t2.SUNDAY_ID AS DAY_TYPE_ID,
          t3.DESCRIPTION AS description,
          -- TIME SLOT
          t31.TIME_SLOT_ID AS time_Slot_Id,
          t33.DISPLAY_VALUE AS time_slot_NAME,
          CASE t32.BEGIN_TIME
             WHEN 0 THEN '00:00'
             ELSE TO_CHAR (TO_DATE (t32.BEGIN_TIME - 1, 'sssss'), 'hh24:mi')
          END
             AS FROM_IN,
          CASE t32.END_TIME
             WHEN 0 THEN '00:00'
             ELSE TO_CHAR (TO_DATE (t32.END_TIME - 1, 'sssss'), 'hh24:mi')
          END
             AS TO_IN,
          -- TIME TYPE
          t28.TIME_TYPE_ID AS time_Type_Id,
          t30.DISPLAY_VALUE AS TIME_TYPE_OUT,
          t2.RESELLER_VERSION_ID
     FROM cbs_owner.CALENDAR_KEY t1
          INNER JOIN cbs_owner.CALENDAR_REF t2
             ON t1.CALENDAR_ID = t2.CALENDAR_ID
          -- DAY_TIME_MAPPING
          INNER JOIN cbs_owner.DAY_TIME_MAPPING t27
             ON t2.MONDAY_ID = t27.DAY_TYPE_ID
          -- TIME_TYPE
          INNER JOIN cbs_owner.TIME_TYPE_KEY t28
             ON t28.TIME_TYPE_ID = t27.TIME_TYPE_ID
          INNER JOIN cbs_owner.TIME_TYPE_REF t29
             ON t28.TIME_TYPE_ID = t29.TIME_TYPE_ID
          INNER JOIN
          cbs_owner.TIME_TYPE_VALUES t30
             ON     t29.TIME_TYPE_ID = t30.TIME_TYPE_ID
                AND t29.RESELLER_VERSION_ID = t30.RESELLER_VERSION_ID
          -- TIME SLOT
          INNER JOIN cbs_owner.TIME_SLOT_KEY t31
             ON t31.TIME_SLOT_ID = t27.TIME_SLOT_ID
          INNER JOIN cbs_owner.TIME_SLOT_REF t32
             ON t31.TIME_SLOT_ID = t32.TIME_SLOT_ID
          INNER JOIN
          cbs_owner.TIME_SLOT_VALUES t33
             ON     t32.TIME_SLOT_ID = t33.TIME_SLOT_ID
                AND t32.RESELLER_VERSION_ID = t33.RESELLER_VERSION_ID
          --
          INNER JOIN
          cbs_owner.CALENDAR_VALUES t3
             ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t4
             ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                AND t4.VALUE = t2.CALENDAR_TYPE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t5
             ON     t5.enumeration_key = t4.enumeration_key
                AND t5.VALUE = t4.VALUE
                AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
             ON t2.MONDAY_ID = t6.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t7
             ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t8
             ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
             ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t10
             ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t11
             ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
             ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t13
             ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t14
             ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
             ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t16
             ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t17
             ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
             ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t19
             ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t20
             ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
             ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t22
             ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t23
             ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
          INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
             ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_REF t25
             ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DAY_TYPE_ID_VALUES t26
             ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;