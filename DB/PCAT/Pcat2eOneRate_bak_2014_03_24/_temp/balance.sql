/* Formatted on 11/03/2014 22:09:03 (QP5 v5.215.12089.38647) */
SELECT t4.DISPLAY_VALUE AS balanceKey,
       t1.BALANCE_ID AS balanceId,
       t7.DISPLAY_VALUE AS offerKey,
       t1.OFFER_ID AS offerId,
       t1.RESELLER_VERSION_ID AS resellerVersionId,
       t1.BALANCE_ORDER AS balanceOrder,
       t9.DISPLAY_VALUE AS shadowRealOpt,
       t1.IS_CORE AS isCore,
       t1.EXPIRATION_DATE AS expirationDate,
       t1.MIN_BALANCE AS minBalance,
       t1.MAX_BALANCE AS maxBalance,
       t1.GRANT_AMOUNT AS grantAmount,
       t1.GRANT_START_DATE AS grantStartDate,
       t1.GRANT_END_DATE AS grantEndDate,
       t1.DEFAULT_EXPIRATION_OFFSET AS defaultExpirationOffset,
       t1.IS_SHARED AS isShared,
       t1.ALLOW_INST_AS_SHADOW AS allowInstAsShadow,
       t1.DEFAULT_LIMIT_VALUE AS defaultLimitValue,
       t22.DISPLAY_VALUE AS offerKeyByAccountOfferId,
       t1.ACCOUNT_OFFER_ID AS accountOfferId,
       t25.DISPLAY_VALUE AS balanceKeyByAccountOfferBalanc,
       t1.ACCOUNT_OFFER_BALANCE_ID AS accountOfferBalanceId,
       t1.USG_EXCL_INCL AS usgExclIncl,
       t1.RC_EXCL_INCL AS rcExclIncl,
       t1.NRC_EXCL_INCL AS nrcExclIncl
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
          ON     t8.enumeration_key = LOWER ('' || SHADOW_REAL_OPT || '')
             AND t8.VALUE = t1.SHADOW_REAL_OPT
       LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_VALUES t9
          ON     t9.enumeration_key = t8.enumeration_key
             AND t9.VALUE = t8.VALUE
             AND t9.LANGUAGE_CODE = t4.LANGUAGE_CODE
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
 WHERE t1.RESELLER_VERSION_ID = 2;