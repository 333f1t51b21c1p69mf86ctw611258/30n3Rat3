DROP VIEW ELC_USER.USAGE_ACTIVITY_TRANS_VIEW;

/* Formatted on 22/05/2014 15:15:16 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW ELC_USER.USAGE_ACTIVITY_TRANS_VIEW
(
   AUT_TRANS_ID,
   UA_NAME,
   UA_ID,
   RESELLER_VERSION_ID,
   UNIT_TYPE_NAME,
   UNIT_TYPE_ID,
   UA_INITIAL_NAME,
   UA_INITIAL_ID,
   PRIORITY,
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
   SELECT t1.AUT_TRANS_ID,                                   -- AS autTransId,
          t8.DISPLAY_VALUE AS ua_name,                         -- autFinalKey,
          t2.FINAL_AUT_ID AS ua_id,                             -- finalAutId,
          t2.RESELLER_VERSION_ID,                     -- AS resellerVersionId,
          --       t4.SERVICE_VERSION_ID AS serviceVersionId,
          -- *** unit type
          t28.DISPLAY_VALUE AS unit_Type_name,
          t4.UNIT_TYPE AS unit_Type_id,
          -- ### unit type
          t5.DISPLAY_VALUE AS ua_initial_name,               -- autInitialKey,
          t2.INITIAL_AUT_ID AS ua_initial_id,                 -- initialAutId,
          t2.PRIORITY AS priority,
          --       t10.AUT_TRANS_SET_ID AS autTransSetId,
          t12.DISPLAY_VALUE AS account_group_name,           -- accountSegKey,
          T12.EXPRESSION_TEMPLATE_ID AS account_group_id,
          t14.DISPLAY_VALUE AS subs_group_name,           -- subscriberSegKey,
          T14.EXPRESSION_TEMPLATE_ID AS subs_group_id,
          t16.DISPLAY_VALUE AS market_group_name,             -- marketSegKey,
          T16.EXPRESSION_TEMPLATE_ID AS market_group_id,
          t18.DISPLAY_VALUE AS zone_group_name,             -- locationSegKey,
          T18.EXPRESSION_TEMPLATE_ID AS zone_group_id,
          t20.DISPLAY_VALUE AS access_method_group_name, -- accessMethodSegKey,
          T20.EXPRESSION_TEMPLATE_ID AS access_method_group_id,
          t22.DISPLAY_VALUE AS special_feature_group_name, -- specialFeatureSegKey,
          T22.EXPRESSION_TEMPLATE_ID AS special_feature_group_id,
          t24.DISPLAY_VALUE AS offline_group_name,            -- offlineSegKey
          T24.EXPRESSION_TEMPLATE_ID AS offline_group_id
     FROM cbs_owner.AUT_TRANSLATION_KEY t1
          INNER JOIN cbs_owner.AUT_TRANSLATION t2
             ON t1.AUT_TRANS_ID = t2.AUT_TRANS_ID
          INNER JOIN cbs_owner.AUT_INITIAL_KEY t3
             ON t2.INITIAL_AUT_ID = t3.INITIAL_AUT_ID
          INNER JOIN
          cbs_owner.AUT_INITIAL_REF t4
             ON     t3.INITIAL_AUT_ID = t4.INITIAL_AUT_ID
                AND t4.SERVICE_VERSION_ID = 1
          INNER JOIN
          cbs_owner.AUT_INITIAL_VALUES t5
             ON     t3.INITIAL_AUT_ID = t5.INITIAL_AUT_ID
                AND t5.SERVICE_VERSION_ID = t4.SERVICE_VERSION_ID
                AND t5.LANGUAGE_CODE = 1
          INNER JOIN cbs_owner.AUT_FINAL_KEY t6
             ON t2.FINAL_AUT_ID = t6.AUT_ID
          INNER JOIN
          cbs_owner.AUT_FINAL_REF t7
             ON     t6.AUT_ID = t7.AUT_ID
                AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.AUT_FINAL_VALUES t8
             ON     t6.AUT_ID = t8.AUT_ID
                AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t8.LANGUAGE_CODE = t5.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.AUT_TRANSLATION_SET t9
             ON     t9.AUT_TRANS_ID = t2.AUT_TRANS_ID
                AND t9.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t9.AUT_TRANS_SET_ID IN
                       (SELECT aut_trans_set_id
                          FROM cbs_owner.aut_translation_set_map
                         WHERE expression_template_id IN
                                  (SELECT expression_template_id
                                     FROM cbs_owner.expression_template_id_ref
                                    WHERE segmentation_key_id = 0))
          LEFT OUTER JOIN
          cbs_owner.AUT_TRANSLATION_SET_MAP t10
             ON     t10.AUT_TRANS_SET_ID = t9.AUT_TRANS_SET_ID
                AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_REF t11
             ON     t11.EXPRESSION_TEMPLATE_ID = t10.EXPRESSION_TEMPLATE_ID
                AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t12
             ON     t12.EXPRESSION_TEMPLATE_ID = t11.EXPRESSION_TEMPLATE_ID
                AND t12.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t12.LANGUAGE_CODE = t5.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.AUT_TRANSLATION_SET t25
             ON     t25.AUT_TRANS_ID = t2.AUT_TRANS_ID
                AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t25.AUT_TRANS_SET_ID IN
                       (SELECT aut_trans_set_id
                          FROM cbs_owner.aut_translation_set_map
                         WHERE expression_template_id IN
                                  (SELECT expression_template_id
                                     FROM cbs_owner.expression_template_id_ref
                                    WHERE segmentation_key_id = 1))
          LEFT OUTER JOIN
          cbs_owner.AUT_TRANSLATION_SET_MAP t26
             ON     t26.AUT_TRANS_SET_ID = t25.AUT_TRANS_SET_ID
                AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_REF t13
             ON     t13.EXPRESSION_TEMPLATE_ID = t26.EXPRESSION_TEMPLATE_ID
                AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t14
             ON     t14.EXPRESSION_TEMPLATE_ID = t13.EXPRESSION_TEMPLATE_ID
                AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t14.LANGUAGE_CODE = t5.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.AUT_TRANSLATION_SET t27
             ON     t27.AUT_TRANS_ID = t2.AUT_TRANS_ID
                AND t27.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t27.AUT_TRANS_SET_ID IN
                       (SELECT aut_trans_set_id
                          FROM cbs_owner.aut_translation_set_map
                         WHERE expression_template_id IN
                                  (SELECT expression_template_id
                                     FROM cbs_owner.expression_template_id_ref
                                    WHERE segmentation_key_id = 2))
          LEFT OUTER JOIN
          cbs_owner.AUT_TRANSLATION_SET_MAP t28
             ON     t28.AUT_TRANS_SET_ID = t27.AUT_TRANS_SET_ID
                AND t28.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_REF t15
             ON     t15.EXPRESSION_TEMPLATE_ID = t28.EXPRESSION_TEMPLATE_ID
                AND t15.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t16
             ON     t16.EXPRESSION_TEMPLATE_ID = t15.EXPRESSION_TEMPLATE_ID
                AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t16.LANGUAGE_CODE = t5.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.AUT_TRANSLATION_SET t29
             ON     t29.AUT_TRANS_ID = t2.AUT_TRANS_ID
                AND t29.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t29.AUT_TRANS_SET_ID IN
                       (SELECT aut_trans_set_id
                          FROM cbs_owner.aut_translation_set_map
                         WHERE expression_template_id IN
                                  (SELECT expression_template_id
                                     FROM cbs_owner.expression_template_id_ref
                                    WHERE segmentation_key_id = 3))
          LEFT OUTER JOIN
          cbs_owner.AUT_TRANSLATION_SET_MAP t30
             ON     t30.AUT_TRANS_SET_ID = t29.AUT_TRANS_SET_ID
                AND t30.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_REF t17
             ON     t17.EXPRESSION_TEMPLATE_ID = t30.EXPRESSION_TEMPLATE_ID
                AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t18
             ON     t18.EXPRESSION_TEMPLATE_ID = t17.EXPRESSION_TEMPLATE_ID
                AND t18.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t18.LANGUAGE_CODE = t5.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.AUT_TRANSLATION_SET t31
             ON     t31.AUT_TRANS_ID = t2.AUT_TRANS_ID
                AND t31.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t31.AUT_TRANS_SET_ID IN
                       (SELECT aut_trans_set_id
                          FROM cbs_owner.aut_translation_set_map
                         WHERE expression_template_id IN
                                  (SELECT expression_template_id
                                     FROM cbs_owner.expression_template_id_ref
                                    WHERE segmentation_key_id = 4))
          LEFT OUTER JOIN
          cbs_owner.AUT_TRANSLATION_SET_MAP t32
             ON     t32.AUT_TRANS_SET_ID = t31.AUT_TRANS_SET_ID
                AND t32.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_REF t19
             ON     t19.EXPRESSION_TEMPLATE_ID = t32.EXPRESSION_TEMPLATE_ID
                AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t20
             ON     t20.EXPRESSION_TEMPLATE_ID = t19.EXPRESSION_TEMPLATE_ID
                AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t20.LANGUAGE_CODE = t5.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.AUT_TRANSLATION_SET t33
             ON     t33.AUT_TRANS_ID = t2.AUT_TRANS_ID
                AND t33.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t33.AUT_TRANS_SET_ID IN
                       (SELECT aut_trans_set_id
                          FROM cbs_owner.aut_translation_set_map
                         WHERE expression_template_id IN
                                  (SELECT expression_template_id
                                     FROM cbs_owner.expression_template_id_ref
                                    WHERE segmentation_key_id = 5))
          LEFT OUTER JOIN
          cbs_owner.AUT_TRANSLATION_SET_MAP t34
             ON     t34.AUT_TRANS_SET_ID = t33.AUT_TRANS_SET_ID
                AND t34.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_REF t21
             ON     t21.EXPRESSION_TEMPLATE_ID = t34.EXPRESSION_TEMPLATE_ID
                AND t21.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t22
             ON     t22.EXPRESSION_TEMPLATE_ID = t21.EXPRESSION_TEMPLATE_ID
                AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t22.LANGUAGE_CODE = t5.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.AUT_TRANSLATION_SET t35
             ON     t35.AUT_TRANS_ID = t2.AUT_TRANS_ID
                AND t35.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t35.AUT_TRANS_SET_ID IN
                       (SELECT aut_trans_set_id
                          FROM cbs_owner.aut_translation_set_map
                         WHERE expression_template_id IN
                                  (SELECT expression_template_id
                                     FROM cbs_owner.expression_template_id_ref
                                    WHERE segmentation_key_id = 6))
          LEFT OUTER JOIN
          cbs_owner.AUT_TRANSLATION_SET_MAP t36
             ON     t36.AUT_TRANS_SET_ID = t35.AUT_TRANS_SET_ID
                AND t36.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_REF t23
             ON     t23.EXPRESSION_TEMPLATE_ID = t36.EXPRESSION_TEMPLATE_ID
                AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t24
             ON     t24.EXPRESSION_TEMPLATE_ID = t23.EXPRESSION_TEMPLATE_ID
                AND t24.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t24.LANGUAGE_CODE = t5.LANGUAGE_CODE
          -- *** unit type
          INNER JOIN cbs_owner.UNITS_TYPE_KEY t26
             ON t4.UNIT_TYPE = t26.UNIT_TYPE
          INNER JOIN
          cbs_owner.UNITS_TYPE_REF t27
             ON     t26.UNIT_TYPE = t27.UNIT_TYPE
                AND t27.SERVICE_VERSION_ID = t4.SERVICE_VERSION_ID
          INNER JOIN
          cbs_owner.UNITS_TYPE_VALUES t28
             ON     t26.UNIT_TYPE = t28.UNIT_TYPE
                AND t28.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                AND t28.LANGUAGE_CODE = t5.LANGUAGE_CODE;
