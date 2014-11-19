/* Formatted on 11/4/2014 11:00:03 (QP5 v5.227.12220.39754) */
--DROP TABLE currency_type;
--

SELECT * FROM currency_type;

CREATE TABLE currency_type
AS
   SELECT t1.CURRENCY_CODE AS currency_code,
          t3.DISPLAY_VALUE AS currency_name,
          t5.DISPLAY_VALUE AS type_name,
          t2.CURRENCY_TYPE AS type_id,
          t2.ACTIVE_DATE AS active_Date,
          t2.INACTIVE_DATE AS inactive_Date,
          t2.ROUNDING_FACTOR AS rounding_Factor,
          --          t2.IS_DEFAULT AS is_Default,
          --          t2.IS_INTERNAL AS is_Internal,
          t2.ISO_CODE AS iso_Code,
          t2.ISO_NUMBER AS iso_Number,
          t3.DESCRIPTION AS description
     FROM cbs_owner.RATE_CURRENCY_KEY t1
          INNER JOIN cbs_owner.RATE_CURRENCY_REF t2
             ON t1.CURRENCY_CODE = t2.CURRENCY_CODE
          INNER JOIN
          cbs_owner.RATE_CURRENCY_VALUES t3
             ON     t2.CURRENCY_CODE = t3.CURRENCY_CODE
                AND t2.SERVICE_VERSION_ID = t3.SERVICE_VERSION_ID
          INNER JOIN cbs_owner.CURRENCY_TYPE_REF t4
             ON t2.CURRENCY_TYPE = t4.CURRENCY_TYPE
          INNER JOIN
          cbs_owner.CURRENCY_TYPE_VALUES t5
             ON     t4.CURRENCY_TYPE = t5.CURRENCY_TYPE
                AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t6
             ON     t6.enumeration_key = LOWER ('ROUNDING_METHOD')
                AND t6.VALUE = t2.ROUNDING_METHOD
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t7
             ON     t7.enumeration_key = t6.enumeration_key
                AND t7.VALUE = t6.VALUE
                AND t7.LANGUAGE_CODE = t3.LANGUAGE_CODE
    WHERE t2.SERVICE_VERSION_ID = 1 AND t3.LANGUAGE_CODE = 1;