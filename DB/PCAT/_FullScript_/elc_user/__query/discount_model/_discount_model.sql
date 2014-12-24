/* Formatted on 25/03/2014 16:51:26 (QP5 v5.215.12089.38647) */
CREATE TABLE discount_model
AS
   SELECT t41.DISCOUNT_AWARD_ID AS discount_award_id,      -- discountAwardId,
          -- *** add discount
          t44.RT_DISCOUNT_ID AS discount_id,                  -- rtDiscountId,
          t3.DISPLAY_VALUE AS discount_name,                  -- displayValue,
          t45.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
          t6.DISPLAY_VALUE AS accumulator_name, -- accumulatorKeyByAccumulatorId,
          t45.ACCUMULATOR_ID AS accumulator_id,              -- accumulatorId,
          t8.DISPLAY_VALUE AS discount_type,                  -- discountType,
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
          --       t3.LANGUAGE_CODE AS languageCode,

          t3.DESCRIPTION AS discount_description,
          -- ### discount

          --       t42.RESELLER_VERSION_ID AS resellerVersionId,
          --       t46.DISPLAY_VALUE AS rtDiscountKey,
          --       t42.RT_DISCOUNT_ID AS rtDiscountId,
          t42.THRESHOLD AS threshold,
          t42.AMOUNT AS amount,
          --       t45.currency_code,
          t50.iso_code AS currency_iso_code,               -- currencyIsoCode,
          --       t50.implied_decimal AS currencyImpliedDecimals,
          --       t42.ADDON_THRES1 AS addonThres1,
          --       t42.ADDON_THRES2 AS addonThres2,
          --       t42.ADDON_THRES3 AS addonThres3,
          --       t42.ADDON_THRES4 AS addonThres4,
          --       t48.DISPLAY_VALUE AS rewardEventType,
          --       t42.REWARD_NOTIF_TEXT AS rewardNotifText,
          --       t42.UNICODE_FLAG AS unicodeFlag,
          --       t43.LANGUAGE_CODE AS languageCode,
          --       t43.DISPLAY_VALUE AS displayValue,
          t43.DESCRIPTION AS award_description
     FROM cbs_owner.DISCOUNT_AWARD_KEY t41
          INNER JOIN cbs_owner.DISCOUNT_AWARD_REF t42
             ON t41.DISCOUNT_AWARD_ID = t42.DISCOUNT_AWARD_ID
          INNER JOIN cbs_owner.DISCOUNT_AWARD_VALUES t43
             ON     t42.DISCOUNT_AWARD_ID = t43.DISCOUNT_AWARD_ID
                AND t42.RESELLER_VERSION_ID = t43.RESELLER_VERSION_ID
          -- *** add discount

          -- modify
          INNER JOIN cbs_owner.RT_DISCOUNT_KEY t44
             ON t42.RT_DISCOUNT_ID = t44.RT_DISCOUNT_ID
          INNER JOIN cbs_owner.RT_DISCOUNT_REF t45
             ON     t44.RT_DISCOUNT_ID = t45.RT_DISCOUNT_ID
                AND t45.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
          -- modify

          INNER JOIN cbs_owner.RT_DISCOUNT_VALUES t3
             ON     t45.RT_DISCOUNT_ID = t3.RT_DISCOUNT_ID
                AND t45.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.ACCUMULATOR_KEY t4
             ON t45.ACCUMULATOR_ID = t4.ACCUMULATOR_ID
          INNER JOIN cbs_owner.ACCUMULATOR_REF t5
             ON     t4.ACCUMULATOR_ID = t5.ACCUMULATOR_ID
                AND t5.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.ACCUMULATOR_VALUES t6
             ON     t4.ACCUMULATOR_ID = t6.ACCUMULATOR_ID
                AND t6.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_REF t7
             ON     t7.enumeration_key = LOWER ('DISCOUNT_TYPE')
                AND t7.VALUE = t45.DISCOUNT_TYPE
          LEFT OUTER JOIN cbs_owner.GENERIC_ENUMERATION_VALUES t8
             ON     t8.enumeration_key = t7.enumeration_key
                AND t8.VALUE = t7.VALUE
                AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_KEY t9
             ON t45.CURRENCY_CODE = t9.CURRENCY_CODE
          LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_REF t10
             ON     t9.CURRENCY_CODE = t10.CURRENCY_CODE
                AND t10.SERVICE_VERSION_ID = 1
          LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_VALUES t11
             ON     t9.CURRENCY_CODE = t11.CURRENCY_CODE
                AND t11.SERVICE_VERSION_ID = 1
                AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t12
             ON t45.ADDON_ACC_ID1 = t12.ACCUMULATOR_ID
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_REF t13
             ON     t12.ACCUMULATOR_ID = t13.ACCUMULATOR_ID
                AND t13.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_VALUES t14
             ON     t12.ACCUMULATOR_ID = t14.ACCUMULATOR_ID
                AND t14.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t15
             ON t45.ADDON_ACC_ID2 = t15.ACCUMULATOR_ID
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_REF t16
             ON     t15.ACCUMULATOR_ID = t16.ACCUMULATOR_ID
                AND t16.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_VALUES t17
             ON     t15.ACCUMULATOR_ID = t17.ACCUMULATOR_ID
                AND t17.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t18
             ON t45.ADDON_ACC_ID3 = t18.ACCUMULATOR_ID
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_REF t19
             ON     t18.ACCUMULATOR_ID = t19.ACCUMULATOR_ID
                AND t19.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_VALUES t20
             ON     t18.ACCUMULATOR_ID = t20.ACCUMULATOR_ID
                AND t20.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t21
             ON t45.ADDON_ACC_ID4 = t21.ACCUMULATOR_ID
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_REF t22
             ON     t21.ACCUMULATOR_ID = t22.ACCUMULATOR_ID
                AND t22.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.ACCUMULATOR_VALUES t23
             ON     t21.ACCUMULATOR_ID = t23.ACCUMULATOR_ID
                AND t23.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
          -- ### add discount

          --       INNER JOIN cbs_owner.RT_DISCOUNT_KEY t44
          --          ON t42.RT_DISCOUNT_ID = t44.RT_DISCOUNT_ID
          --       INNER JOIN cbs_owner.RT_DISCOUNT_REF t45
          --          ON     t44.RT_DISCOUNT_ID = t45.RT_DISCOUNT_ID
          --             AND t45.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_KEY t49
             ON t45.currency_code = t49.Currency_Code
          LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_REF t50
             ON     t49.currency_code = t50.currency_code
                AND t50.service_version_id = 1
          INNER JOIN cbs_owner.RT_DISCOUNT_VALUES t46
             ON     t44.RT_DISCOUNT_ID = t46.RT_DISCOUNT_ID
                AND t46.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
                AND t46.LANGUAGE_CODE = t43.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_REF t47
             ON     t47.table_name = 'DISCOUNT_AWARD_REF'
                AND t47.field_name = LOWER ('REWARD_EVENT_TYPE')
                AND t47.integer_value = t42.REWARD_EVENT_TYPE
          LEFT OUTER JOIN cbs_owner.GUI_INDICATOR_VALUES t48
             ON     t48.table_name = t47.table_name
                AND t48.field_name = t47.field_name
                AND t48.integer_value = t47.integer_value
                AND t48.LANGUAGE_CODE = t43.LANGUAGE_CODE
    WHERE t42.RESELLER_VERSION_ID = 2 AND t43.LANGUAGE_CODE = 1;