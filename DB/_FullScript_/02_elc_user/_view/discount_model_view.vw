DROP VIEW ELC_USER.DISCOUNT_MODEL_VIEW;

/* Formatted on 22/05/2014 15:15:11 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW ELC_USER.DISCOUNT_MODEL_VIEW
(
   DISCOUNT_ITEM_ID,
   DISCOUNT_ITEM_NAME,
   RESELLER_VERSION_ID,
   DISCOUNT_NAME,
   DISCOUNT_ID,
   UA_NAME,
   UA_ID,
   UA_GROUP_NAME,
   UA_GROUP_ID,
   ITEM_DESC,
   ACCUMULATOR_NAME,
   ACCUMULATOR_ID,
   DISCOUNT_TYPE_ID,
   DISCOUNT_TYPE_NAME,
   CURRENCY_NAME,
   CURRENCY_CODE,
   DISCOUNT_DESC,
   AWARD_ID,
   AWARD_NAME,
   THRESHOLD,
   AMOUNT,
   AWARD_DESC
)
AS
   SELECT t41.DISCOUNT_ITEM_ID AS discount_item_id,         -- discountItemId,
          t43.DISPLAY_VALUE AS discount_item_name,            -- displayValue,
          t42.RESELLER_VERSION_ID,                    -- AS resellerVersionId,
          t46.DISPLAY_VALUE AS discount_name,                -- rtDiscountKey,
          t42.RT_DISCOUNT_ID AS discount_id,                  -- rtDiscountId,
          t49.DISPLAY_VALUE AS ua_name,                        -- autFinalKey,
          t42.AUT_ID AS ua_id,                                       -- autId,
          t52.DISPLAY_VALUE AS ua_group_name,                  -- autGroupKey,
          t42.AUT_GROUP_ID AS ua_group_id,                      -- autGroupId,
          --       t42.IS_DEFAULT AS isDefault,
          --       t42.IS_INTERNAL AS isInternal,
          --       t43.LANGUAGE_CODE AS languageCode,

          t43.DESCRIPTION AS item_desc,                        -- description,
          -- {{{ add discount
          --       t44.RT_DISCOUNT_ID AS discount_id,
          --       t46.DISPLAY_VALUE AS discount_name,
          --       t45.RESELLER_VERSION_ID AS resellerVersionId,
          t6.DISPLAY_VALUE AS accumulator_name, -- accumulatorKeyByAccumulatorId,
          t45.ACCUMULATOR_ID AS accumulator_id,              -- accumulatorId,
          T7.ENUMERATION_KEY || '_' || T7.VALUE AS discount_type_id,
          t8.DISPLAY_VALUE AS discount_type_name,             -- discountType,
          --       t10.SERVICE_VERSION_ID AS serviceVersionId,
          --       t10.ISO_CODE AS currencyIsoCode,
          --       t10.IMPLIED_DECIMAL AS currencyImpliedDecimal,
          t11.DISPLAY_VALUE AS currency_name,              -- rateCurrencyKey,
          t45.CURRENCY_CODE AS currency_code,                 -- currencyCode,
          --       t14.DISPLAY_VALUE AS accumulatorKeyByAddonAccId1,
          --       t45.ADDON_ACC_ID1 AS addonAccId1,
          --       t17.DISPLAY_VALUE AS accumulatorKeyByAddonAccId2,
          --       t45.ADDON_ACC_ID2 AS addonAccId2,
          --       t20.DISPLAY_VALUE AS accumulatorKeyByAddonAccId3,
          --       t45.ADDON_ACC_ID3 AS addonAccId3,
          --       t23.DISPLAY_VALUE AS accumulatorKeyByAddonAccId4,
          --       t45.ADDON_ACC_ID4 AS addonAccId4,
          --       t45.RESET_FLAG AS resetFlag,
          --       t45.IS_DEFAULT AS isDefault,
          --       t45.IS_INTERNAL AS isInternal,
          --       t46.LANGUAGE_CODE AS languageCode,

          t46.DESCRIPTION AS discount_desc,                    -- description,
          -- }}} add discount
          -- {{{ add discount award
          t62.DISCOUNT_AWARD_ID AS award_id,               -- discountAwardId,
          t63.DISPLAY_VALUE AS award_name,                    -- displayValue,
          --       t62.RESELLER_VERSION_ID AS resellerVersionId,
          --       t66.DISPLAY_VALUE AS rtDiscountKey,
          --       t62.RT_DISCOUNT_ID AS rtDiscountId,
          t62.THRESHOLD AS threshold,
          t62.AMOUNT AS amount,
          --       t45.currency_code,
          --       t70.iso_code AS currencyIsoCode,
          --       t70.implied_decimal AS currencyImpliedDecimals,
          --       t62.ADDON_THRES1 AS addonThres1,
          --       t62.ADDON_THRES2 AS addonThres2,
          --       t62.ADDON_THRES3 AS addonThres3,
          --       t62.ADDON_THRES4 AS addonThres4,
          --       t68.DISPLAY_VALUE AS rewardEventType,
          --       t62.REWARD_NOTIF_TEXT AS rewardNotifText,
          --       t62.UNICODE_FLAG AS unicodeFlag,
          --       t63.LANGUAGE_CODE AS languageCode,

          t63.DESCRIPTION AS award_desc                         -- description
     FROM cbs_owner.RT_DISCOUNT_ITEM_KEY t41
          INNER JOIN cbs_owner.RT_DISCOUNT_ITEM_REF t42
             ON t41.DISCOUNT_ITEM_ID = t42.DISCOUNT_ITEM_ID
          INNER JOIN
          cbs_owner.RT_DISCOUNT_ITEM_VALUES t43
             ON     t42.DISCOUNT_ITEM_ID = t43.DISCOUNT_ITEM_ID
                AND t42.RESELLER_VERSION_ID = t43.RESELLER_VERSION_ID
          -- {{{ add discount

          -- { modify
          INNER JOIN cbs_owner.RT_DISCOUNT_KEY t44
             ON t42.RT_DISCOUNT_ID = t44.RT_DISCOUNT_ID
          INNER JOIN
          cbs_owner.RT_DISCOUNT_REF t45
             ON     t44.RT_DISCOUNT_ID = t45.RT_DISCOUNT_ID
                AND t45.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.RT_DISCOUNT_VALUES t46
             ON     t44.RT_DISCOUNT_ID = t46.RT_DISCOUNT_ID
                AND t46.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
                AND t46.LANGUAGE_CODE = t43.LANGUAGE_CODE
          -- } modify

          INNER JOIN cbs_owner.ACCUMULATOR_KEY t4
             ON t45.ACCUMULATOR_ID = t4.ACCUMULATOR_ID
          INNER JOIN
          cbs_owner.ACCUMULATOR_REF t5
             ON     t4.ACCUMULATOR_ID = t5.ACCUMULATOR_ID
                AND t5.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.ACCUMULATOR_VALUES t6
             ON     t4.ACCUMULATOR_ID = t6.ACCUMULATOR_ID
                AND t6.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                AND t6.LANGUAGE_CODE = t46.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t7
             ON     t7.enumeration_key = LOWER ('DISCOUNT_TYPE')
                AND t7.VALUE = t45.DISCOUNT_TYPE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t8
             ON     t8.enumeration_key = t7.enumeration_key
                AND t8.VALUE = t7.VALUE
                AND t8.LANGUAGE_CODE = t46.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_KEY t9
             ON t45.CURRENCY_CODE = t9.CURRENCY_CODE
          LEFT OUTER JOIN
          cbs_owner.RATE_CURRENCY_REF t10
             ON     t9.CURRENCY_CODE = t10.CURRENCY_CODE
                AND t10.SERVICE_VERSION_ID = 1
          LEFT OUTER JOIN
          cbs_owner.RATE_CURRENCY_VALUES t11
             ON     t9.CURRENCY_CODE = t11.CURRENCY_CODE
                AND t11.SERVICE_VERSION_ID = 1
                AND t11.LANGUAGE_CODE = t46.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t12
             ON t45.ADDON_ACC_ID1 = t12.ACCUMULATOR_ID
          LEFT OUTER JOIN
          cbs_owner.ACCUMULATOR_REF t13
             ON     t12.ACCUMULATOR_ID = t13.ACCUMULATOR_ID
                AND t13.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.ACCUMULATOR_VALUES t14
             ON     t12.ACCUMULATOR_ID = t14.ACCUMULATOR_ID
                AND t14.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                AND t14.LANGUAGE_CODE = t46.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t15
             ON t45.ADDON_ACC_ID2 = t15.ACCUMULATOR_ID
          LEFT OUTER JOIN
          cbs_owner.ACCUMULATOR_REF t16
             ON     t15.ACCUMULATOR_ID = t16.ACCUMULATOR_ID
                AND t16.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.ACCUMULATOR_VALUES t17
             ON     t15.ACCUMULATOR_ID = t17.ACCUMULATOR_ID
                AND t17.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                AND t17.LANGUAGE_CODE = t46.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t18
             ON t45.ADDON_ACC_ID3 = t18.ACCUMULATOR_ID
          LEFT OUTER JOIN
          cbs_owner.ACCUMULATOR_REF t19
             ON     t18.ACCUMULATOR_ID = t19.ACCUMULATOR_ID
                AND t19.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.ACCUMULATOR_VALUES t20
             ON     t18.ACCUMULATOR_ID = t20.ACCUMULATOR_ID
                AND t20.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                AND t20.LANGUAGE_CODE = t46.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t21
             ON t45.ADDON_ACC_ID4 = t21.ACCUMULATOR_ID
          LEFT OUTER JOIN
          cbs_owner.ACCUMULATOR_REF t22
             ON     t21.ACCUMULATOR_ID = t22.ACCUMULATOR_ID
                AND t22.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.ACCUMULATOR_VALUES t23
             ON     t21.ACCUMULATOR_ID = t23.ACCUMULATOR_ID
                AND t23.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                AND t23.LANGUAGE_CODE = t46.LANGUAGE_CODE
          -- }}} add discount

          LEFT OUTER JOIN cbs_owner.AUT_FINAL_KEY t47
             ON t42.AUT_ID = t47.AUT_ID
          LEFT OUTER JOIN
          cbs_owner.AUT_FINAL_REF t48
             ON     t47.AUT_ID = t48.AUT_ID
                AND t48.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.AUT_FINAL_VALUES t49
             ON     t47.AUT_ID = t49.AUT_ID
                AND t49.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
                AND t49.LANGUAGE_CODE = t43.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.AUT_GROUP_KEY t50
             ON t42.AUT_GROUP_ID = t50.AUT_GROUP_ID
          LEFT OUTER JOIN
          cbs_owner.AUT_GROUP_REF t51
             ON     t50.AUT_GROUP_ID = t51.AUT_GROUP_ID
                AND t51.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
          LEFT OUTER JOIN
          cbs_owner.AUT_GROUP_VALUES t52
             ON     t50.AUT_GROUP_ID = t52.AUT_GROUP_ID
                AND t52.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
                AND t52.LANGUAGE_CODE = t43.LANGUAGE_CODE
          -- {{{ add discount award
          --  cbs_owner.DISCOUNT_AWARD_KEY t61
          INNER JOIN
          cbs_owner.DISCOUNT_AWARD_REF t62 --          ON     t61.DISCOUNT_AWARD_ID = t62.DISCOUNT_AWARD_ID
             /*AND*/
             ON     t62.RT_DISCOUNT_ID = t44.RT_DISCOUNT_ID
                AND t45.RESELLER_VERSION_ID = t62.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.DISCOUNT_AWARD_VALUES t63
             ON     t62.DISCOUNT_AWARD_ID = t63.DISCOUNT_AWARD_ID
                AND t62.RESELLER_VERSION_ID = t63.RESELLER_VERSION_ID
          --       INNER JOIN cbs_owner.RT_DISCOUNT_KEY t44
          --          ON t62.RT_DISCOUNT_ID = t44.RT_DISCOUNT_ID
          --       INNER JOIN cbs_owner.RT_DISCOUNT_REF t45
          --          ON     t44.RT_DISCOUNT_ID = t45.RT_DISCOUNT_ID
          --             AND t45.RESELLER_VERSION_ID = t62.RESELLER_VERSION_ID

          LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_KEY t69
             ON t45.currency_code = t69.Currency_Code
          LEFT OUTER JOIN
          cbs_owner.RATE_CURRENCY_REF t70
             ON     t69.currency_code = t70.currency_code
                AND t70.service_version_id = 1
          INNER JOIN
          cbs_owner.RT_DISCOUNT_VALUES t66
             ON     t44.RT_DISCOUNT_ID = t66.RT_DISCOUNT_ID
                AND t66.RESELLER_VERSION_ID = t62.RESELLER_VERSION_ID
                AND t66.LANGUAGE_CODE = t63.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_REF t67
             ON     t67.table_name = 'DISCOUNT_AWARD_REF'
                AND t67.field_name = LOWER ('REWARD_EVENT_TYPE')
                AND t67.integer_value = t62.REWARD_EVENT_TYPE
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_VALUES t68
             ON     t68.table_name = t67.table_name
                AND t68.field_name = t67.field_name
                AND t68.integer_value = t67.integer_value
                AND t68.LANGUAGE_CODE = t63.LANGUAGE_CODE
    WHERE t43.LANGUAGE_CODE = 1;
