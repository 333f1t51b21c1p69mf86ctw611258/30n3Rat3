DROP VIEW CBS_OWNER.BALANCE_EI_VIEW;

/* Formatted on 10/12/2014 9:02:51 AM (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW CBS_OWNER.BALANCE_EI_VIEW
(
   BALANCE_EI_ID,
   RESELLER_VERSION_ID,
   OFFER_NAME,
   OFFER_ID,
   BALANCE_NAME,
   BALANCE_ID,
   UA_NAME,
   UA_ID,
   UA_GROUP_NAME,
   UA_GROUP_ID,
   RC_TERM_NAME,
   RC_TERM_ID,
   NRC_TERM_NAME,
   NRC_TERM_ID,
   EI_FLAG,
   TIME_TYPE_NAME,
   TIME_TYPE_ID
)
AS
   SELECT t1.BALANCE_EXC_INC_ID AS BALANCE_EI_ID,          -- balanceExcIncId,
          t1.RESELLER_VERSION_ID AS RESELLER_VERSION_ID, -- resellerVersionId,
          t4.DISPLAY_VALUE AS OFFER_NAME,                         -- offerKey,
          t1.OFFER_ID AS OFFER_ID,                                 -- offerId,
          t7.DISPLAY_VALUE AS BALANCE_NAME,                     -- balanceKey,
          t1.BALANCE_ID AS BALANCE_ID,                           -- balanceId,
          t10.DISPLAY_VALUE AS UA_NAME,                        -- autFinalKey,
          t1.AUT_ID AS UA_ID,                                        -- autId,
          t13.DISPLAY_VALUE AS UA_GROUP_NAME,                  -- autGroupKey,
          t1.AUT_GROUP_ID AS UA_GROUP_ID,                      --  autGroupId,
          t16.DISPLAY_VALUE AS RC_TERM_NAME,                     -- rcTermKey,
          t1.RC_TERM_ID AS RC_TERM_ID,                            -- rcTermId,
          t19.DISPLAY_VALUE AS NRC_TERM_NAME,                   -- nrcTermKey,
          t1.NRC_TERM_ID AS NRC_TERM_ID,                         -- nrcTermId,
          (CASE t1.EXCL_INCL_FLAG WHEN 0 THEN 'INCL' WHEN 1 THEN 'EXCL' END)
             EI_FLAG,                                         -- exclInclFlag,
          t22.DISPLAY_VALUE AS TIME_TYPE_NAME,                 -- timeTypeKey,
          t1.TIME_TYPE_ID AS TIME_TYPE_ID                        -- timeTypeId
     FROM cbs_owner.BALANCE_EXCLUSION_INCLUSION t1
          INNER JOIN cbs_owner.OFFER_KEY t2
             ON t1.OFFER_ID = t2.OFFER_ID
          INNER JOIN cbs_owner.OFFER_REF t3
             ON     t2.OFFER_ID = t3.OFFER_ID
                AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.OFFER_VALUES t4
             ON     t2.OFFER_ID = t4.OFFER_ID
                AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t4.LANGUAGE_CODE = 1
          INNER JOIN cbs_owner.BALANCE_KEY t5
             ON t1.BALANCE_ID = t5.BALANCE_ID
          INNER JOIN cbs_owner.BALANCE_REF t6
             ON     t5.BALANCE_ID = t6.BALANCE_ID
                AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.BALANCE_VALUES t7
             ON     t5.BALANCE_ID = t7.BALANCE_ID
                AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.AUT_FINAL_KEY t8
             ON t1.AUT_ID = t8.AUT_ID
          LEFT OUTER JOIN cbs_owner.AUT_FINAL_REF t9
             ON     t8.AUT_ID = t9.AUT_ID
                AND t9.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.AUT_FINAL_VALUES t10
             ON     t8.AUT_ID = t10.AUT_ID
                AND t10.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t10.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.AUT_GROUP_KEY t11
             ON t1.AUT_GROUP_ID = t11.AUT_GROUP_ID
          LEFT OUTER JOIN cbs_owner.AUT_GROUP_REF t12
             ON     t11.AUT_GROUP_ID = t12.AUT_GROUP_ID
                AND t12.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.AUT_GROUP_VALUES t13
             ON     t11.AUT_GROUP_ID = t13.AUT_GROUP_ID
                AND t13.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t13.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.RC_TERM_KEY t14
             ON t1.RC_TERM_ID = t14.RC_TERM_ID
          LEFT OUTER JOIN cbs_owner.RC_TERM_REF t15
             ON     t14.RC_TERM_ID = t15.RC_TERM_ID
                AND t15.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.RC_TERM_VALUES t16
             ON     t14.RC_TERM_ID = t16.RC_TERM_ID
                AND t16.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t16.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.NRC_TERM_KEY t17
             ON t1.NRC_TERM_ID = t17.NRC_TERM_ID
          LEFT OUTER JOIN cbs_owner.NRC_TERM_REF t18
             ON     t17.NRC_TERM_ID = t18.NRC_TERM_ID
                AND t18.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.NRC_TERM_VALUES t19
             ON     t17.NRC_TERM_ID = t19.NRC_TERM_ID
                AND t19.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t19.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.TIME_TYPE_KEY t20
             ON t1.TIME_TYPE_ID = t20.TIME_TYPE_ID
          LEFT OUTER JOIN cbs_owner.TIME_TYPE_REF t21
             ON     t20.TIME_TYPE_ID = t21.TIME_TYPE_ID
                AND t21.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.TIME_TYPE_VALUES t22
             ON     t20.TIME_TYPE_ID = t22.TIME_TYPE_ID
                AND t22.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t22.LANGUAGE_CODE = t4.LANGUAGE_CODE;


GRANT SELECT ON CBS_OWNER.BALANCE_EI_VIEW TO VNP_COMMON;
