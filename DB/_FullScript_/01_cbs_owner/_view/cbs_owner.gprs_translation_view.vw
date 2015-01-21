/* Formatted on 20/1/2015 19:38:03 (QP5 v5.227.12220.39754) */
DROP VIEW GPRS_TRANSLATION_VIEW;


CREATE OR REPLACE FORCE VIEW GPRS_TRANSLATION_VIEW
(
   GPRS_TRANSLATION_ID,
   APN_ID,
   GPRSAPNNAMEIDKEY,
   QOS_ID,
   QOS,
   AUTIDVOLUME,
   SERVICE_VERSION_ID,
   APPLICATION_ID,
   SUB_TYPE_ID
)
AS
   SELECT t1.GPRS_TRANSLATION_ID,                     -- AS gprsTranslationId,
          t1.APN_ID,                                              -- AS apnId,
          t12.APN AS gprsApnNameIdKey,
          t1.QOS_ID,                                              -- AS qosId,
          t13.QOS,                                     -- AS gprsQosNameIdKey,
          -- t6.DISPLAY_VALUE AS autInitialKeyByAutIdDuration,
          -- t1.AUT_ID_DURATION AS autIdDuration,
          -- t9.DISPLAY_VALUE AS autInitialKeyByAutIdVolume,
          t1.AUT_ID_VOLUME AS autIdVolume,
          -- t11.DISPLAY_VALUE AS gprsChargeType,
          t1.SERVICE_VERSION_ID,                       -- AS serviceVersionId,
          t5.APPLICATION_ID,
          t5.SUB_TYPE_ID
     FROM cbs_owner.GPRS_TRANSLATION t1
          INNER JOIN cbs_owner.GPRS_APN_NAME_ID_KEY t2
             ON t1.APN_ID = t2.APN_ID
          INNER JOIN cbs_owner.GPRS_QOS_NAME_ID_KEY t3
             ON t1.QOS_ID = t3.QOS_ID
          LEFT OUTER JOIN cbs_owner.AUT_INITIAL_KEY t4
             ON t1.AUT_ID_DURATION = t4.INITIAL_AUT_ID
          LEFT OUTER JOIN
          cbs_owner.AUT_INITIAL_REF t5
             ON     t4.INITIAL_AUT_ID = t5.INITIAL_AUT_ID
                AND t5.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.AUT_INITIAL_VALUES t6
             ON     t4.INITIAL_AUT_ID = t6.INITIAL_AUT_ID
                AND t6.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
                AND t6.LANGUAGE_CODE = 1
          LEFT OUTER JOIN cbs_owner.AUT_INITIAL_KEY t7
             ON t1.AUT_ID_VOLUME = t7.INITIAL_AUT_ID
          LEFT OUTER JOIN
          cbs_owner.AUT_INITIAL_REF t8
             ON     t7.INITIAL_AUT_ID = t8.INITIAL_AUT_ID
                AND t8.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.AUT_INITIAL_VALUES t9
             ON     t7.INITIAL_AUT_ID = t9.INITIAL_AUT_ID
                AND t9.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
                AND t9.LANGUAGE_CODE = 1
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_REF t10
             ON     t10.table_name = 'GPRS_TRANSLATION'
                AND t10.field_name = LOWER ('GPRS_CHARGE_TYPE')
                AND t10.integer_value = t1.GPRS_CHARGE_TYPE
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_VALUES t11
             ON     t11.table_name = t10.table_name
                AND t11.field_name = t10.field_name
                AND t11.integer_value = t10.integer_value
                AND t11.LANGUAGE_CODE = 1
          INNER JOIN
          cbs_owner.GPRS_APN_NAME_ID t12
             ON     t1.APN_ID = t12.APN_ID
                AND t12.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
          INNER JOIN
          cbs_owner.GPRS_QOS_NAME_ID t13
             ON     t1.QOS_ID = t13.QOS_ID
                AND t13.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID;


GRANT SELECT ON GPRS_TRANSLATION_VIEW TO VNP_COMMON;