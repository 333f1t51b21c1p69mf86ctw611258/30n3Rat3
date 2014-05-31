/* Formatted on 25/03/2014 16:05:29 (QP5 v5.215.12089.38647) */
select * from accumulator;

CREATE TABLE accumulator
AS
   SELECT t1.ACCUMULATOR_ID AS accumulator_id,               -- accumulatorId,
          t3.DISPLAY_VALUE AS accumulator_name,               -- displayValue,
          t2.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
          --    t5.SERVICE_VERSION_ID as serviceVersionId,
          t6.DISPLAY_VALUE AS unit_type_name,                 -- unitsTypeKey,
          t2.UNIT_TYPE AS unit_type_id,                           -- unitType,
          t8.DISPLAY_VALUE AS period,
          t2.RESET_POINT AS reset_point,                        -- resetPoint,
          t10.DISPLAY_VALUE AS accumulator_type,           -- accumulatorType,
          t12.DISPLAY_VALUE AS count_type,                       -- countType,
          --    t14.DISPLAY_VALUE as accQualifyType,
          --    t3.LANGUAGE_CODE as languageCode,

          t3.DESCRIPTION AS description
     FROM cbs_owner.ACCUMULATOR_KEY t1
          INNER JOIN cbs_owner.ACCUMULATOR_REF t2
             ON t1.ACCUMULATOR_ID = t2.ACCUMULATOR_ID
          INNER JOIN cbs_owner.ACCUMULATOR_VALUES t3
             ON     t2.ACCUMULATOR_ID = t3.ACCUMULATOR_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
             ON t2.UNIT_TYPE = t4.UNIT_TYPE
          INNER JOIN cbs_owner.UNITS_TYPE_REF t5
             ON t4.UNIT_TYPE = t5.UNIT_TYPE AND t5.SERVICE_VERSION_ID = 1
          INNER JOIN cbs_owner.UNITS_TYPE_VALUES t6
             ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_REF t7
             ON     t7.table_name = 'ACCUMULATOR_REF'
                AND t7.field_name = LOWER ('PERIOD')
                AND t7.integer_value = t2.PERIOD
          LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_VALUES t8
             ON     t8.table_name = t7.table_name
                AND t8.field_name = t7.field_name
                AND t8.integer_value = t7.integer_value
                AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_REF t9
             ON     t9.enumeration_key = LOWER ('ACCUMULATOR_TYPE')
                AND t9.VALUE = t2.ACCUMULATOR_TYPE
          LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_VALUES t10
             ON     t10.enumeration_key = t9.enumeration_key
                AND t10.VALUE = t9.VALUE
                AND t10.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_REF t11
             ON     t11.enumeration_key = LOWER ('COUNT_TYPE')
                AND t11.VALUE = t2.COUNT_TYPE
          LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_VALUES t12
             ON     t12.enumeration_key = t11.enumeration_key
                AND t12.VALUE = t11.VALUE
                AND t12.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_REF t13
             ON     t13.enumeration_key = LOWER ('ACC_QUALIFY_TYPE')
                AND t13.VALUE = t2.ACC_QUALIFY_TYPE
          LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_VALUES t14
             ON     t14.enumeration_key = t13.enumeration_key
                AND t14.VALUE = t13.VALUE
                AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;