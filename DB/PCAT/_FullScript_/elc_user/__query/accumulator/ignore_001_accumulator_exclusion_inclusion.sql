/* Formatted on 11/4/2014 18:26:04 (QP5 v5.227.12220.39754) */
SELECT t1.ACCUMULATOR_EXC_INC_ID AS accumulatorExcIncId,
       t1.RESELLER_VERSION_ID AS resellerVersionId,
       t4.DISPLAY_VALUE AS accumulatorKey,
       t1.ACCUMULATOR_ID AS accumulatorId,
       t7.DISPLAY_VALUE AS autFinalKey,
       t1.AUT_ID AS autId,
       t10.DISPLAY_VALUE AS autGroupKey,
       t1.AUT_GROUP_ID AS autGroupId,
       t1.EXCL_INCL_FLAG AS exclInclFlag,        -- 0: Inclusion; 1: Exclusion
       t1.RATE AS rate,
       t12.DISPLAY_VALUE AS rateType,
       t1.ORDER_NO AS orderNo,
       t15.DISPLAY_VALUE AS timeTypeKey,
       t1.TIME_TYPE_ID AS timeTypeId,
       t1.MIN_CONSUMPTION_THRESHOLD AS minConsumptionThreshold,
       t1.MAX_CONSUMPTION_THRESHOLD AS maxConsumptionThreshold,
       t17.SERVICE_VERSION_ID AS serviceVersionId,
       t18.DISPLAY_VALUE AS unitsTypeKey,
       t1.UNIT_TYPE AS unitType,
       t20.DISPLAY_VALUE AS comparisonOperator,
       t22.DISPLAY_VALUE AS rechargeOriginatorRef,
       t1.RECH_TYPE_1 AS rechType1,
       t24.DISPLAY_VALUE AS rechargeOriginatorRefByRechTyp,
       t1.RECH_TYPE_2 AS rechType2
  FROM ACCUMULTR_EXCLUSION_INCLUSION t1
       INNER JOIN ACCUMULATOR_KEY t2 ON t1.ACCUMULATOR_ID = t2.ACCUMULATOR_ID
       INNER JOIN
       ACCUMULATOR_REF t3
          ON     t2.ACCUMULATOR_ID = t3.ACCUMULATOR_ID
             AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       INNER JOIN
       ACCUMULATOR_VALUES t4
          ON     t2.ACCUMULATOR_ID = t4.ACCUMULATOR_ID
             AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t4.LANGUAGE_CODE = 1
       LEFT OUTER JOIN AUT_FINAL_KEY t5 ON t1.AUT_ID = t5.AUT_ID
       LEFT OUTER JOIN
       AUT_FINAL_REF t6
          ON     t5.AUT_ID = t6.AUT_ID
             AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       LEFT OUTER JOIN
       AUT_FINAL_VALUES t7
          ON     t5.AUT_ID = t7.AUT_ID
             AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN AUT_GROUP_KEY t8 ON t1.AUT_GROUP_ID = t8.AUT_GROUP_ID
       LEFT OUTER JOIN
       AUT_GROUP_REF t9
          ON     t8.AUT_GROUP_ID = t9.AUT_GROUP_ID
             AND t9.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       LEFT OUTER JOIN
       AUT_GROUP_VALUES t10
          ON     t8.AUT_GROUP_ID = t10.AUT_GROUP_ID
             AND t10.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t10.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN
       GENERIC_ENUMERATION_REF t11
          ON     t11.enumeration_key = LOWER ('RATE_TYPE')
             AND t11.VALUE = t1.RATE_TYPE
       LEFT OUTER JOIN
       GENERIC_ENUMERATION_VALUES t12
          ON     t12.enumeration_key = t11.enumeration_key
             AND t12.VALUE = t11.VALUE
             AND t12.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN TIME_TYPE_KEY t13
          ON t1.TIME_TYPE_ID = t13.TIME_TYPE_ID
       LEFT OUTER JOIN
       TIME_TYPE_REF t14
          ON     t13.TIME_TYPE_ID = t14.TIME_TYPE_ID
             AND t14.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       LEFT OUTER JOIN
       TIME_TYPE_VALUES t15
          ON     t13.TIME_TYPE_ID = t15.TIME_TYPE_ID
             AND t15.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t15.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN UNITS_TYPE_KEY t16 ON t1.UNIT_TYPE = t16.UNIT_TYPE
       LEFT OUTER JOIN UNITS_TYPE_REF t17
          ON t16.UNIT_TYPE = t17.UNIT_TYPE AND t17.SERVICE_VERSION_ID = 1
       LEFT OUTER JOIN
       UNITS_TYPE_VALUES t18
          ON     t16.UNIT_TYPE = t18.UNIT_TYPE
             AND t18.SERVICE_VERSION_ID = 1
             AND t18.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN
       GUI_INDICATOR_REF t19
          ON     t19.table_name = 'ACCUMULTR_EXCLUSION_INCLUSION'
             AND t19.field_name = LOWER ('COMPARISON_OPERATOR')
             AND t19.integer_value = t1.COMPARISON_OPERATOR
       LEFT OUTER JOIN
       GUI_INDICATOR_VALUES t20
          ON     t20.table_name = t19.table_name
             AND t20.field_name = t19.field_name
             AND t20.integer_value = t19.integer_value
             AND t20.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN RECHARGE_ORIGINATOR_REF t21
          ON t1.RECH_TYPE_1 = t21.ORIGIN_ID
       LEFT OUTER JOIN
       RECHARGE_ORIGINATOR_VALUES t22
          ON     t21.ORIGIN_ID = t22.ORIGIN_ID
             AND t22.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN RECHARGE_ORIGINATOR_REF t23
          ON t1.RECH_TYPE_2 = t23.ORIGIN_ID
       LEFT OUTER JOIN
       RECHARGE_ORIGINATOR_VALUES t24
          ON     t23.ORIGIN_ID = t24.ORIGIN_ID
             AND t24.LANGUAGE_CODE = t4.LANGUAGE_CODE
 WHERE t1.RESELLER_VERSION_ID = 2;