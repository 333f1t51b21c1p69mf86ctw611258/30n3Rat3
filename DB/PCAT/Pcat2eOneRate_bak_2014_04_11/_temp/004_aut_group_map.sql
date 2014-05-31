/* Formatted on 3/16/2014 2:25:03 PM (QP5 v5.215.12089.38647) */
SELECT t1.AUT_GROUP_MAP_ID AS autGroupMapId,
       t4.DISPLAY_VALUE AS autGroupKey,
       t1.AUT_GROUP_ID AS autGroupId,
       t6.SERVICE_VERSION_ID AS serviceVersionId,
       t7.DISPLAY_VALUE AS applicationIdKey,
       t1.APPLICATION_ID AS applicationId,
       t10.DISPLAY_VALUE AS autFinalKey,
       t1.AUT_ID AS autId,
       t1.RESELLER_VERSION_ID AS resellerVersionId
  FROM cbs_owner.AUT_GROUP_MAP t1
       inner join cbs_owner.AUT_GROUP_KEY t2
          ON t1.AUT_GROUP_ID = t2.AUT_GROUP_ID
       inner join cbs_owner.AUT_GROUP_REF t3
          ON     t2.AUT_GROUP_ID = t3.AUT_GROUP_ID
             AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       inner join cbs_owner.AUT_GROUP_VALUES t4
          ON     t2.AUT_GROUP_ID = t4.AUT_GROUP_ID
             AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t4.LANGUAGE_CODE = 1
       LEFT OUTER JOIN  cbs_owner.APPLICATION_ID_KEY t5
          ON t1.APPLICATION_ID = t5.APPLICATION_ID
       LEFT OUTER JOIN  cbs_owner.APPLICATION_ID_REF t6
          ON     t5.APPLICATION_ID = t6.APPLICATION_ID
             AND t6.SERVICE_VERSION_ID = 1
       LEFT OUTER JOIN  cbs_owner.APPLICATION_ID_VALUES t7
          ON     t5.APPLICATION_ID = t7.APPLICATION_ID
             AND t7.SERVICE_VERSION_ID = 1
             AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
       LEFT OUTER JOIN  cbs_owner.AUT_FINAL_KEY t8
          ON t1.AUT_ID = t8.AUT_ID
       LEFT OUTER JOIN  cbs_owner.AUT_FINAL_REF t9
          ON     t8.AUT_ID = t9.AUT_ID
             AND t9.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
       LEFT OUTER JOIN  cbs_owner.AUT_FINAL_VALUES t10
          ON     t8.AUT_ID = t10.AUT_ID
             AND t10.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
             AND t10.LANGUAGE_CODE = t4.LANGUAGE_CODE
 WHERE t1.RESELLER_VERSION_ID = 2;