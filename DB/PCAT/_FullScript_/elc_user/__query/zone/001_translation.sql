/* Formatted on 3/25/2014 10:13:03 AM (QP5 v5.215.12089.38647) */
SELECT t21.GLOBAL_TRANSLATION_ID AS globalTranslationId,
       t21.GLT_NUMBER AS gltNumber,
       t23.DISPLAY_VALUE AS TYPE,
       t21.SERVICE_VERSION_ID AS serviceVersionId,
       t21.LOCATION AS location,
       t25.DISPLAY_VALUE AS oppsQueryType,
       t27.DISPLAY_VALUE AS tppsQueryType
  FROM cbs_owner.GLOBAL_TRANSLATION t21
       LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_REF t22
          ON t22.enumeration_key = LOWER ('TYPE') AND t22.VALUE = t21.TYPE
       LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_VALUES t23
          ON     t23.enumeration_key = t22.enumeration_key
             AND t23.VALUE = t22.VALUE
             AND t23.LANGUAGE_CODE = 1
       LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_REF t24
          ON     t24.enumeration_key = LOWER ('OPPS_QUERY_TYPE')
             AND t24.VALUE = t21.OPPS_QUERY_TYPE
       LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_VALUES t25
          ON     t25.enumeration_key = t24.enumeration_key
             AND t25.VALUE = t24.VALUE
             AND t25.LANGUAGE_CODE = 1
       LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_REF t26
          ON     t26.enumeration_key = LOWER ('TPPS_QUERY_TYPE')
             AND t26.VALUE = t21.TPPS_QUERY_TYPE
       LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_VALUES t27
          ON     t27.enumeration_key = t26.enumeration_key
             AND t27.VALUE = t26.VALUE
             AND t27.LANGUAGE_CODE = 1
 WHERE t21.SERVICE_VERSION_ID = 1;