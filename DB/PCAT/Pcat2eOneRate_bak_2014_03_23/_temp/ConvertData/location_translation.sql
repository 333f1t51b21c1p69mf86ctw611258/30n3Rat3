SELECT t1. GLOBAL_TRANSLATION_ID AS globalTranslationId ,
       t1 .GLT_NUMBER AS gltNumber ,
       --       t3.DISPLAY_VALUE AS TYPE,
       t1 .SERVICE_VERSION_ID AS serviceVersionId ,
       t1 .LOCATION AS location                                             -- ,
  --       t5.DISPLAY_VALUE AS oppsQueryType,
  --       t7.DISPLAY_VALUE AS tppsQueryType
  FROM GLOBAL_TRANSLATION t1
 --       LEFT OUTER JOIN GENERIC_ENUMERATION_REF t2
 --          ON     t2.enumeration_key = LOWER ('' || TYPE || '')
 --             AND t2.VALUE = t1.TYPE
 --       LEFT OUTER JOIN GENERIC_ENUMERATION_VALUES t3
 --          ON     t3.enumeration_key = t2.enumeration_key
 --             AND t3.VALUE = t2.VALUE
 --             AND t3.LANGUAGE_CODE = 1
 --       LEFT OUTER JOIN GENERIC_ENUMERATION_REF t4
 --          ON     t4.enumeration_key = LOWER ('' || OPPS_QUERY_TYPE || '')
 --             AND t4.VALUE = t1.OPPS_QUERY_TYPE
 --       LEFT OUTER JOIN GENERIC_ENUMERATION_VALUES t5
 --          ON     t5.enumeration_key = t4.enumeration_key
 --             AND t5.VALUE = t4.VALUE
 --             AND t5.LANGUAGE_CODE = 1
 --       LEFT OUTER JOIN GENERIC_ENUMERATION_REF t6
 --          ON     t6.enumeration_key = LOWER ('' || TPPS_QUERY_TYPE || '')
 --             AND t6.VALUE = t1.TPPS_QUERY_TYPE
 --       LEFT OUTER JOIN GENERIC_ENUMERATION_VALUES t7
 --          ON     t7.enumeration_key = t6.enumeration_key
 --             AND t7.VALUE = t6.VALUE
 --             AND t7.LANGUAGE_CODE = 1
 WHERE t1.SERVICE_VERSION_ID = 1;
