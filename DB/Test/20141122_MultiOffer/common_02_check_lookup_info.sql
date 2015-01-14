/* Formatted on 12/28/2014 2:14:37 PM (QP5 v5.215.12089.38647) */
SELECT *
  FROM usage_activity
 WHERE ua_id = 30048;

SELECT BALANCE_EI_ID,
       RESELLER_VERSION_ID,
       OFFER_NAME,
       OFFER_ID,
       BALANCE_NAME,
       BALANCE_ID,
       RC_TERM_NAME,
       RC_TERM_ID,
       NRC_TERM_NAME,
       NRC_TERM_ID,
       EI_FLAG,
       TIME_TYPE_NAME,
       TIME_TYPE_ID,
       UA_NAME,
       UA_ID,
       UA_GROUP_NAME,
       UA_GROUP_ID
  FROM BALANCE_EI_VIEW
 WHERE     (offer_id = 51004284 OR offer_id = 51004284 OR offer_id = 51004284)
       AND ua_id = 30234;

SELECT OFFER_RC_AWARD_MAP_ID,
       oba.RESELLER_VERSION_ID,
       OFFER_ID,
       RC_TERM_ID,
       TERM_FROM_DATE,
       TERM_TO_DATE,
       TERM_LEVEL_ID,
       oba.BALANCE_ID,
       b.balance_name,
       PERIOD,
       AMOUNT,
       CURRENCY_CODE,
       oba.UNIT_TYPE_ID,
       RUM_ID,
       IS_INTERNAL
  FROM    VNP_COMMON.OFFER_BALANCE_AWARD_VIEW oba
       INNER JOIN
          VNP_COMMON.BALANCE b
       ON (    oba.reseller_version_id = b.reseller_version_id
           AND oba.balance_id = b.balance_id)
 WHERE OFFER_RC_AWARD_MAP_ID = 1508;

-- WHERE AMOUNT > 0 AND OFFER_ID = 51004508;

SELECT *
  FROM usage_activity_group
 WHERE ua_group_name = 'Voice_ALO_1';

-- Voice: Vina to mobi

SELECT *
  FROM usage_activity
 WHERE ua_id = 30224;

-- SMS: Onnet

SELECT *
  FROM usage_activity
 WHERE ua_id = 30234;

-- SMS: Mobifone

SELECT *
  FROM usage_activity
 WHERE ua_id = 30235;

SELECT *
  FROM usage_activity
 WHERE ua_name = 'FAUT_VC_Onnet_talk_24_FF';