/* Formatted on 3/16/2014 5:42:01 PM (QP5 v5.215.12089.38647) */
SELECT t41.LI_RELATION_ID AS liRelationId,
       t41.LOCATION_A AS locationA,
       t41.LOCATION_B AS locationB,
       t41.SERVICE_VERSION_ID AS serviceVersionId,
       t41.LIA AS lia,
       t41.LIB AS lib,
       t41.HOME_TPPS_ID AS homeTppsIdNum,
       t47.DISPLAY_VALUE AS homeTppsId,
       t41.HOME_OPPS_ID AS homeOppsIdNum,
       t44.DISPLAY_VALUE AS homeOppsId,
       t41.ROAM_OPPS_ID AS roamOppsId,
       t41.ROAM_TPPS_ID AS roamTppsId,
       t41.NCF_OPPS_ID AS ncfOppsId,
       t41.NCF_TPPS_ID AS ncfTppsId,
       t41.USSD_CALLBACK_ID AS ussdCallbackId,
       t41.LR_CHARACTERISTIC AS lrCharacteristic,
       t41.GPRS AS gprs,
       t41.GPRS_ROAM AS gprsRoam
  FROM cbs_owner.LI_RELATION t41
       LEFT OUTER JOIN cbs_owner. LI_RELATION_ID_KEY t42
          ON t41.HOME_OPPS_ID = t42.LI_RELATION_ID
       LEFT OUTER JOIN cbs_owner. LI_RELATION_ID_REF t43
          ON     t41.HOME_OPPS_ID = t43.LI_RELATION_ID
             AND t41.SERVICE_VERSION_ID = t43.SERVICE_VERSION_ID
       LEFT OUTER JOIN cbs_owner. LI_RELATION_ID_VALUES t44
          ON     t41.HOME_OPPS_ID = t44.LI_RELATION_ID
             AND t41.SERVICE_VERSION_ID = t44.SERVICE_VERSION_ID
             AND t44.LANGUAGE_CODE = 1
       LEFT OUTER JOIN cbs_owner. LI_RELATION_ID_KEY t45
          ON t41.HOME_TPPS_ID = t45.LI_RELATION_ID
       LEFT OUTER JOIN cbs_owner. LI_RELATION_ID_REF t46
          ON     t41.HOME_TPPS_ID = t46.LI_RELATION_ID
             AND t41.SERVICE_VERSION_ID = t46.SERVICE_VERSION_ID
       LEFT OUTER JOIN cbs_owner. LI_RELATION_ID_VALUES t47
          ON     t41.HOME_TPPS_ID = t47.LI_RELATION_ID
             AND t41.SERVICE_VERSION_ID = t47.SERVICE_VERSION_ID
             AND t44.LANGUAGE_CODE = t47.LANGUAGE_CODE
 WHERE t41.SERVICE_VERSION_ID = 1;