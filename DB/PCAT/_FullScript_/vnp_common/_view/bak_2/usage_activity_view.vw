DROP VIEW VNP_COMMON.USAGE_ACTIVITY_VIEW;

/* Formatted on 25/04/2014 16:23:27 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW VNP_COMMON.USAGE_ACTIVITY_VIEW
(
   UA_ID,
   UA_NAME,
   RESELLER_VERSION_ID,
   UNIT_TYPE_NAME,
   UNIT_TYPE_ID,
   SUB_TYPE_NAME,
   SUB_TYPE_ID,
   APP_NAME,
   APP_ID,
   UA_INITIAL_NAME,
   UA_INITIAL_ID,
   TAX_CLASS_NAME,
   TAX_CLASS_ID,
   ACCOUNT_GROUP_NAME,
   ACCOUNT_GROUP_ID,
   SUBS_GROUP_NAME,
   SUBS_GROUP_ID,
   MARKET_GROUP_NAME,
   MARKET_GROUP_ID,
   ZONE_GROUP_NAME,
   ZONE_GROUP_ID,
   ACCESS_METHOD_GROUP_NAME,
   ACCESS_METHOD_GROUP_ID,
   SPECIAL_FEATURE_GROUP_NAME,
   SPECIAL_FEATURE_GROUP_ID,
   OFFLINE_GROUP_NAME,
   OFFLINE_GROUP_ID
)
AS
   SELECT USAGE_ACTIVITY.UA_ID,
          USAGE_ACTIVITY.UA_NAME,
          USAGE_ACTIVITY.RESELLER_VERSION_ID,
          USAGE_ACTIVITY.UNIT_TYPE_NAME,
          USAGE_ACTIVITY.UNIT_TYPE_ID,
          SUB_TYPE_NAME,
          SUB_TYPE_ID,
          APP_NAME,
          APP_ID,
          USAGE_ACTIVITY.UA_INITIAL_NAME,
          USAGE_ACTIVITY.UA_INITIAL_ID,
          TAX_CLASS_NAME,
          TAX_CLASS_ID,
          ACCOUNT_GROUP_NAME,
          ACCOUNT_GROUP_ID,
          SUBS_GROUP_NAME,
          SUBS_GROUP_ID,
          MARKET_GROUP_NAME,
          MARKET_GROUP_ID,
          ZONE_GROUP_NAME,
          ZONE_GROUP_ID,
          ACCESS_METHOD_GROUP_NAME,
          ACCESS_METHOD_GROUP_ID,
          SPECIAL_FEATURE_GROUP_NAME,
          SPECIAL_FEATURE_GROUP_ID,
          OFFLINE_GROUP_NAME,
          OFFLINE_GROUP_ID
     FROM USAGE_ACTIVITY_TRANS
          RIGHT OUTER JOIN
          USAGE_ACTIVITY
             ON     (USAGE_ACTIVITY_TRANS.UA_ID = USAGE_ACTIVITY.UA_ID)
                AND (USAGE_ACTIVITY_TRANS.RESELLER_VERSION_ID =
                        USAGE_ACTIVITY.RESELLER_VERSION_ID);
