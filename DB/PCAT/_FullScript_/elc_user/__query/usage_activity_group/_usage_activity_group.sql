/* Formatted on 4/23/2014 2:11:21 PM (QP5 v5.227.12220.39754) */
drop table usage_activity_group;

SELECT * FROM usage_activity_group;

CREATE TABLE usage_activity_group
AS
   SELECT t1.AUT_GROUP_MAP_ID AS ua_map_id,                  -- autGroupMapId,
          t4.DISPLAY_VALUE AS ua_group_name,                   -- autGroupKey,
          t1.AUT_GROUP_ID AS ua_group_id,                       -- autGroupId,
          --       t6.SERVICE_VERSION_ID AS serviceVersionId,
          --       t7.DISPLAY_VALUE AS applicationIdKey,
          --       t1.APPLICATION_ID AS applicationId,
          t10.DISPLAY_VALUE AS ua_name,                        -- autFinalKey,
          t1.AUT_ID AS ua_id,                                        -- autId,
          t1.RESELLER_VERSION_ID AS reseller_Version_Id
     FROM cbs_owner.AUT_GROUP_MAP t1
          INNER JOIN cbs_owner.AUT_GROUP_KEY t2
             ON t1.AUT_GROUP_ID = t2.AUT_GROUP_ID
          INNER JOIN
          cbs_owner.AUT_GROUP_REF t3
             ON     t2.AUT_GROUP_ID = t3.AUT_GROUP_ID
                AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.AUT_GROUP_VALUES t4
             ON     t2.AUT_GROUP_ID = t4.AUT_GROUP_ID
                AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t4.LANGUAGE_CODE = 1
          LEFT OUTER JOIN cbs_owner.APPLICATION_ID_KEY t5
             ON t1.APPLICATION_ID = t5.APPLICATION_ID
          LEFT OUTER JOIN
          cbs_owner.APPLICATION_ID_REF t6
             ON     t5.APPLICATION_ID = t6.APPLICATION_ID
                AND t6.SERVICE_VERSION_ID = 1
          LEFT OUTER JOIN
          cbs_owner.APPLICATION_ID_VALUES t7
             ON     t5.APPLICATION_ID = t7.APPLICATION_ID
                AND t7.SERVICE_VERSION_ID = 1
                AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.AUT_FINAL_KEY t8 ON t1.AUT_ID = t8.AUT_ID
          LEFT OUTER JOIN
          cbs_owner.AUT_FINAL_REF t9
             ON     t8.AUT_ID = t9.AUT_ID
                AND t9.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.AUT_FINAL_VALUES t10
             ON     t8.AUT_ID = t10.AUT_ID
                AND t10.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t10.LANGUAGE_CODE = t4.LANGUAGE_CODE
    WHERE t1.RESELLER_VERSION_ID = 2;