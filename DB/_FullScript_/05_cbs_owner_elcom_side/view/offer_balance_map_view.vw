DROP VIEW OFFER_BALANCE_MAP_VIEW;

/* Formatted on 05/12/2014 9:43:54 PM (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW OFFER_BALANCE_MAP_VIEW
(
   BALANCE_NAME,
   BALANCE_ID,
   OFFER_NAME,
   OFFER_ID,
   RESELLER_VERSION_ID,
   BALANCE_ORDER,
   IS_SHADOW,
   IS_CORE,
   EXPIRATION_DATE,
   MIN_BALANCE,
   MAX_BALANCE,
   EXPIRATION_OPTION,
   DEFAULT_EXPIRATION_OFFSET,
   IS_SHARED,
   DEFAULT_LIMIT_TYPE,
   DEFAULT_LIMIT_VALUE,
   DEFAULT_LIMIT_PERIOD
)
AS
     SELECT t4.DISPLAY_VALUE AS balance_name,                   -- balanceKey,
            t1.BALANCE_ID AS balance_id,                         -- balanceId,
            t7.DISPLAY_VALUE AS offer_name,                       -- offerKey,
            t1.OFFER_ID AS offer_id,                               -- offerId,
            t1.RESELLER_VERSION_ID,                      -- resellerVersionId,
            t1.BALANCE_ORDER,                                 -- balanceOrder,
            --         t9.DISPLAY_VALUE AS shadowRealOpt,
            CASE t9.DISPLAY_VALUE WHEN 'Real' THEN 0 ELSE 1 END AS is_shadow,
            t1.IS_CORE AS is_core,                                  -- isCore,
            t1.EXPIRATION_DATE AS expiration_date,          -- expirationDate,
            t1.MIN_BALANCE AS min_balance,                      -- minBalance,
            t1.MAX_BALANCE AS max_balance,                      -- maxBalance,
            --         t1.GRANT_AMOUNT AS grantAmount,
            --         t1.GRANT_START_DATE AS grantStartDate,
            --         t1.GRANT_END_DATE AS grantEndDate,
            --         t11.DISPLAY_VALUE AS grantExpirationType,
            t13.DISPLAY_VALUE AS expiration_option,           -- expireOption,
            t1.DEFAULT_EXPIRATION_OFFSET AS default_expiration_offset, -- defaultExpirationOffset,
            --         t15.DISPLAY_VALUE AS balancePaymentMode,
            t1.IS_SHARED AS is_shared,                             --isShared,
            --         t1.ALLOW_INST_AS_SHADOW AS allowInstAsShadow,
            t17.DISPLAY_VALUE AS default_limit_type,      -- defaultLimitType,
            t1.DEFAULT_LIMIT_VALUE AS default_limit_value, -- defaultLimitValue,
            t19.DISPLAY_VALUE AS default_limit_period -- , -- defaultLimitPeriod,
       --         t22.DISPLAY_VALUE AS offerKeyByAccountOfferId,
       --         t1.ACCOUNT_OFFER_ID AS accountOfferId,
       --         t25.DISPLAY_VALUE AS balanceKeyByAccountOfferBalanc,
       --         t1.ACCOUNT_OFFER_BALANCE_ID AS accountOfferBalanceId,
       --         t1.USG_EXCL_INCL AS usgExclIncl,
       --         t1.RC_EXCL_INCL AS rcExclIncl,
       --         t1.NRC_EXCL_INCL AS nrcExclIncl
       FROM cbs_owner.OFFER_BALANCE_MAP t1
            INNER JOIN cbs_owner.BALANCE_KEY t2
               ON t1.BALANCE_ID = t2.BALANCE_ID
            INNER JOIN cbs_owner.BALANCE_REF t3
               ON     t2.BALANCE_ID = t3.BALANCE_ID
                  AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
            INNER JOIN cbs_owner.BALANCE_VALUES t4
               ON     t2.BALANCE_ID = t4.BALANCE_ID
                  AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                  AND t4.LANGUAGE_CODE = 1
            INNER JOIN cbs_owner.OFFER_KEY t5
               ON t1.OFFER_ID = t5.OFFER_ID
            INNER JOIN cbs_owner.OFFER_REF t6
               ON     t5.OFFER_ID = t6.OFFER_ID
                  AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
            INNER JOIN cbs_owner.OFFER_VALUES t7
               ON     t5.OFFER_ID = t7.OFFER_ID
                  AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                  AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
            LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_REF t8
               ON     t8.enumeration_key = LOWER ('SHADOW_REAL_OPT')
                  AND t8.VALUE = t1.SHADOW_REAL_OPT
            LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_VALUES t9
               ON     t9.enumeration_key = t8.enumeration_key
                  AND t9.VALUE = t8.VALUE
                  AND t9.LANGUAGE_CODE = t4.LANGUAGE_CODE
            LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_REF t10
               ON     t10.table_name = 'OFFER_BALANCE_MAP'
                  AND t10.field_name = LOWER ('GRANT_EXPIRATION_TYPE')
                  AND t10.integer_value = t1.GRANT_EXPIRATION_TYPE
            LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_VALUES t11
               ON     t11.table_name = t10.table_name
                  AND t11.field_name = t10.field_name
                  AND t11.integer_value = t10.integer_value
                  AND t11.LANGUAGE_CODE = t4.LANGUAGE_CODE
            LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_REF t12
               ON     t12.table_name = 'OFFER_BALANCE_MAP'
                  AND t12.field_name = LOWER ('EXPIRE_OPTION')
                  AND t12.integer_value = t1.EXPIRE_OPTION
            LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_VALUES t13
               ON     t13.table_name = t12.table_name
                  AND t13.field_name = t12.field_name
                  AND t13.integer_value = t12.integer_value
                  AND t13.LANGUAGE_CODE = t4.LANGUAGE_CODE
            LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_REF t14
               ON     t14.enumeration_key = LOWER ('BALANCE_PAYMENT_MODE')
                  AND t14.VALUE = t1.BALANCE_PAYMENT_MODE
            LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_VALUES t15
               ON     t15.enumeration_key = t14.enumeration_key
                  AND t15.VALUE = t14.VALUE
                  AND t15.LANGUAGE_CODE = t4.LANGUAGE_CODE
            LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_REF t16
               ON     t16.table_name = 'OFFER_BALANCE_MAP'
                  AND t16.field_name = LOWER ('DEFAULT_LIMIT_TYPE')
                  AND t16.integer_value = t1.DEFAULT_LIMIT_TYPE
            LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_VALUES t17
               ON     t17.table_name = t16.table_name
                  AND t17.field_name = t16.field_name
                  AND t17.integer_value = t16.integer_value
                  AND t17.LANGUAGE_CODE = t4.LANGUAGE_CODE
            LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_REF t18
               ON     t18.table_name = 'OFFER_BALANCE_MAP'
                  AND t18.field_name = LOWER ('DEFAULT_LIMIT_PERIOD')
                  AND t18.integer_value = t1.DEFAULT_LIMIT_PERIOD
            LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_VALUES t19
               ON     t19.table_name = t18.table_name
                  AND t19.field_name = t18.field_name
                  AND t19.integer_value = t18.integer_value
                  AND t19.LANGUAGE_CODE = t4.LANGUAGE_CODE
            LEFT OUTER JOIN cbs_owner.OFFER_KEY t20
               ON t1.ACCOUNT_OFFER_ID = t20.OFFER_ID
            LEFT OUTER JOIN cbs_owner.OFFER_REF t21
               ON     t20.OFFER_ID = t21.OFFER_ID
                  AND t21.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
            LEFT OUTER JOIN cbs_owner.OFFER_VALUES t22
               ON     t20.OFFER_ID = t22.OFFER_ID
                  AND t22.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                  AND t22.LANGUAGE_CODE = t4.LANGUAGE_CODE
            LEFT OUTER JOIN cbs_owner.BALANCE_KEY t23
               ON t1.ACCOUNT_OFFER_BALANCE_ID = t23.BALANCE_ID
            LEFT OUTER JOIN cbs_owner.BALANCE_REF t24
               ON     t23.BALANCE_ID = t24.BALANCE_ID
                  AND t24.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
            LEFT OUTER JOIN cbs_owner.BALANCE_VALUES t25
               ON     t23.BALANCE_ID = t25.BALANCE_ID
                  AND t25.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                  AND t25.LANGUAGE_CODE = t4.LANGUAGE_CODE
      WHERE t15.DISPLAY_VALUE = 'Postpaid'
   ORDER BY t1.BALANCE_ORDER;
