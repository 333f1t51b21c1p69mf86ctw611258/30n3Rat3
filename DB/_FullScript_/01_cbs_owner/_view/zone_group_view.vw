DROP VIEW ZONE_GROUP_VIEW;

/* Formatted on 28/12/2014 17:17:30 (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW ZONE_GROUP_VIEW
(
   GROUP_ID,
   GROUP_NAME,
   ZONE_A,
   ZONE_B,
   EXPRESSION_GROUP_ID,
   RESELLER_VERSION_ID,
   SERVICE_VERSION_ID,
   PRIORITY,
   HOME_OPPS_ID,
   HOME_OPPS_NAME
)
AS
   SELECT t1.EXPRESSION_TEMPLATE_ID AS GROUP_ID,
          t4.DISPLAY_VALUE AS group_name,
          --
          t41.LOCATION_A AS ZONE_A,
          t41.LOCATION_B AS ZONE_B,
          --
          t1.EXPRESSION_GROUP_ID AS expression_Group_Id,
          t1.RESELLER_VERSION_ID AS reseller_Version_Id,
          t41.SERVICE_VERSION_ID,                      -- AS serviceVersionId,
          T3.PRIORITY AS priority,
          --
          --       t22.ATTRIBUTE_ID AS attributeId,
          --       t22.ATTRIBUTE_QUALIFIER AS attributeQualifier,
          --       t22.VALUE AS VALUE,
          --       t22.ATTR_SRC AS attrSrc,
          --
          --       t41.LI_RELATION_ID AS liRelationId,


          --       t41.LIA AS lia,
          --       t41.LIB AS lib,
          --       t41.HOME_TPPS_ID AS homeTppsIdNum,
          --       t47.DISPLAY_VALUE AS homeTppsId,
          t41.HOME_OPPS_ID AS home_Opps_Id,
          t44.DISPLAY_VALUE AS home_Opps_name                             -- ,
     --       t41.ROAM_OPPS_ID AS roamOppsId,
     --       t41.ROAM_TPPS_ID AS roamTppsId,
     --       t41.NCF_OPPS_ID AS ncfOppsId,
     --       t41.NCF_TPPS_ID AS ncfTppsId,
     --       t41.USSD_CALLBACK_ID AS ussdCallbackId,
     --       t41.LR_CHARACTERISTIC AS lrCharacteristic,
     --       t41.GPRS AS gprs,
     --       t41.GPRS_ROAM AS gprsRoam
     FROM cbs_owner.EXPRESSION_TEMPLATE t1
          INNER JOIN cbs_owner.EXPRESSION_TEMPLATE_ID_KEY t2
             ON t1.EXPRESSION_TEMPLATE_ID = t2.EXPRESSION_TEMPLATE_ID
          INNER JOIN cbs_owner.EXPRESSION_TEMPLATE_ID_REF t3
             ON     t2.EXPRESSION_TEMPLATE_ID = t3.EXPRESSION_TEMPLATE_ID
                AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.RESELLER_VERSION T100
             ON t100.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t4
             ON     t2.EXPRESSION_TEMPLATE_ID = t4.EXPRESSION_TEMPLATE_ID
                AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t4.LANGUAGE_CODE = 1
          --
          INNER JOIN cbs_owner.EXPRESSION t22
             ON     t1.EXPRESSION_GROUP_ID = t22.EXPRESSION_GROUP_ID
                AND T22.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          --
          INNER JOIN cbs_owner.LI_RELATION t41
             ON t22.VALUE = TO_CHAR (T41.HOME_OPPS_ID)
          LEFT OUTER JOIN cbs_owner.LI_RELATION_ID_KEY t42
             ON t41.HOME_OPPS_ID = t42.LI_RELATION_ID
          LEFT OUTER JOIN cbs_owner.LI_RELATION_ID_REF t43
             ON     t41.HOME_OPPS_ID = t43.LI_RELATION_ID
                AND t41.SERVICE_VERSION_ID = t43.SERVICE_VERSION_ID
          LEFT OUTER JOIN cbs_owner.LI_RELATION_ID_VALUES t44
             ON     t41.HOME_OPPS_ID = t44.LI_RELATION_ID
                AND t41.SERVICE_VERSION_ID = t44.SERVICE_VERSION_ID
                AND t44.LANGUAGE_CODE = 1
          LEFT OUTER JOIN cbs_owner.LI_RELATION_ID_KEY t45
             ON t41.HOME_TPPS_ID = t45.LI_RELATION_ID
          LEFT OUTER JOIN cbs_owner.LI_RELATION_ID_REF t46
             ON     t41.HOME_TPPS_ID = t46.LI_RELATION_ID
                AND t41.SERVICE_VERSION_ID = t46.SERVICE_VERSION_ID
          LEFT OUTER JOIN cbs_owner.LI_RELATION_ID_VALUES t47
             ON     t41.HOME_TPPS_ID = t47.LI_RELATION_ID
                AND t41.SERVICE_VERSION_ID = t47.SERVICE_VERSION_ID
                AND t44.LANGUAGE_CODE = t47.LANGUAGE_CODE
    WHERE t41.SERVICE_VERSION_ID = t100.SERVICE_VERSION_ID;


GRANT SELECT ON ZONE_GROUP_VIEW TO VNP_COMMON;
