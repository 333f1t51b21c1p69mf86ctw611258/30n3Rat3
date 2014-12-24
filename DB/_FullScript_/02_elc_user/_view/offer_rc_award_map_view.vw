DROP VIEW ELC_USER.OFFER_RC_AWARD_MAP_VIEW;

/* Formatted on 22/05/2014 15:15:12 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW ELC_USER.OFFER_RC_AWARD_MAP_VIEW
(
   OFFER_RC_AWARD_MAP_ID,
   RESELLER_VERSION_ID,
   OFFER_NAME,
   OFFER_ID,
   RC_TERM_NAME,
   RC_TERM_ID,
   TERM_DATE_ACTIVE,
   TERM_DATE_INACTIVE,
   TERM_LEVEL_NAME,
   TERM_LEVEL_ID,
   BALANCE_NAME,
   BALANCE_ID,
   PERIOD_FREQUENCE_ID,
   PERIOD_FREQUENCE_NAME,
   APPLY_DAY,
   PRO_AWARD_INSF_RC_BAL,
   AMOUNT,
   CURRENCY_NAME,
   CURRENCY_CODE,
   UNIT_TYPE_NAME,
   UNIT_TYPE_ID,
   GRANT_ORDER,
   ACTION,
   AWARD_ACTIVATION_TYPE,
   AWARD_ACTIVATION_OFFSET,
   AWARD_EXPIRY_TYPE,
   AWARD_EXPIRY_OFFSET_TYPE,
   AWARD_EXPIRY_OFFSET,
   AWARD_EXPIRY_DATE,
   IS_ROLLABLE,
   ROLLOVER_GROUPING,
   MAXIMUM_GRANT_ROLLOVER,
   MAXIMUM_TOTAL_ROLLOVER,
   RC_MULTIPLICATIONS,
   CYCLES_ROLLOVER_EXPIRE,
   DEFAULT_SET_FUNCTION
)
AS
   SELECT t1.OFFER_RC_AWARD_MAP_ID AS offer_rc_award_map_id, -- offerRcAwardMapId,
          t1.RESELLER_VERSION_ID,                     -- AS resellerVersionId,
          t4.DISPLAY_VALUE AS offer_name,                         -- offerKey,
          t1.OFFER_ID AS offer_id,                                 -- offerId,
          t7.DISPLAY_VALUE AS rc_term_name,                      -- rcTermKey,
          t1.RC_TERM_ID AS rc_term_id,                            -- rcTermId,
          -- *** add rc term level
          t6.DATE_ACTIVE AS term_date_active,                   -- dateActive,
          t6.DATE_INACTIVE AS term_date_inactive,             -- dateInactive,
          T45.DISPLAY_VALUE AS TERM_LEVEL_NAME,
          T44.FIELD_NAME || '_' || T44.INTEGER_VALUE AS TERM_LEVEL_ID,
          -- ### add rc term level
          t10.DISPLAY_VALUE AS balance_name,                    -- balanceKey,
          t1.BALANCE_ID AS balance_id,                           -- balanceId,
          --       t1.BILL_PERIOD AS billPeriod,
          -- *** NOTE: Khong co trong DIC, dung tam cua RATE RC
          --       t1.GENERATION_PERIOD_FREQUENCY AS periodFrequency,
          t63.FIELD_NAME || '_' || T63.INTEGER_VALUE AS PERIOD_FREQUENCE_ID,
          T64.DISPLAY_VALUE AS PERIOD_FREQUENCE_NAME,
          -- ###

          t1.APPLY_DAY AS apply_day,                              -- applyDay,
          t1.PRO_AWARD_INSF_RC_BAL,                   -- AS proAwardInsfRcBal,
          t1.AMOUNT AS amount,
          --       t14.SERVICE_VERSION_ID AS serviceVersionId,
          --       t14.ISO_CODE AS currencyIsoCode,
          --       t14.IMPLIED_DECIMAL AS currencyImpliedDecimal,
          t15.DISPLAY_VALUE AS currency_name,              -- rateCurrencyKey,
          t1.CURRENCY_CODE AS currency_code,                  -- currencyCode,
          t18.DISPLAY_VALUE AS unit_type_name,                -- unitsTypeKey,
          t1.UNIT_TYPE AS unit_type_id,                           -- unitType,
          t20.DISPLAY_VALUE AS grant_order,                     -- grantOrder,
          t22.DISPLAY_VALUE AS action,
          t24.DISPLAY_VALUE AS award_activation_type,  -- awardActivationType,
          t1.AWARD_ACTIVATION_OFFSET AS award_activation_offset, -- awardActivationOffset,
          t26.DISPLAY_VALUE AS award_expiry_type,          -- awardExpiryType,
          t28.DISPLAY_VALUE AS award_expiry_offset_type, -- awardExpiryOffsetType,
          t1.AWARD_EXPIRY_OFFSET AS award_expiry_offset, -- awardExpiryOffset,
          t1.AWARD_EXPIRY_DATE AS award_expiry_date,       -- awardExpiryDate,
          t1.IS_ROLLABLE AS is_rollable,                        -- isRollable,
          t30.DISPLAY_VALUE AS rollover_grouping,         -- rolloverGrouping,
          t1.MAXIMUM_GRANT_ROLLOVER AS maximum_grant_rollover, -- maximumGrantRollover,
          t1.MAXIMUM_TOTAL_ROLLOVER AS maximum_total_rollover, -- maximumTotalRollover,
          t1.RC_MULTIPLICATIONS AS rc_multiplications,   -- rcMultiplications,
          t1.CYCLES_ROLLOVER_EXPIRE AS cycles_rollover_expire, -- cyclesRolloverExpire,
          t1.DEFAULT_SET_FUNCTION AS default_set_function -- defaultSetFunction
     FROM cbs_owner.OFFER_RC_AWARD_MAP t1
          INNER JOIN cbs_owner.OFFER_KEY t2 ON t1.OFFER_ID = t2.OFFER_ID
          INNER JOIN
          cbs_owner.OFFER_REF t3
             ON     t2.OFFER_ID = t3.OFFER_ID
                AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.OFFER_VALUES t4
             ON     t2.OFFER_ID = t4.OFFER_ID
                AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t4.LANGUAGE_CODE = 1
          INNER JOIN cbs_owner.RC_TERM_KEY t5
             ON t1.RC_TERM_ID = t5.RC_TERM_ID
          INNER JOIN
          cbs_owner.RC_TERM_REF t6
             ON     t5.RC_TERM_ID = t6.RC_TERM_ID
                AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.RC_TERM_VALUES t7
             ON     t5.RC_TERM_ID = t7.RC_TERM_ID
                AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
          INNER JOIN cbs_owner.BALANCE_KEY t8
             ON t1.BALANCE_ID = t8.BALANCE_ID
          INNER JOIN
          cbs_owner.BALANCE_REF t9
             ON     t8.BALANCE_ID = t9.BALANCE_ID
                AND t9.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.BALANCE_VALUES t10
             ON     t8.BALANCE_ID = t10.BALANCE_ID
                AND t10.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t10.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_KEY t13
             ON t1.CURRENCY_CODE = t13.CURRENCY_CODE
          LEFT OUTER JOIN
          cbs_owner.RATE_CURRENCY_REF t14
             ON     t13.CURRENCY_CODE = t14.CURRENCY_CODE
                AND t14.SERVICE_VERSION_ID = 1
          LEFT OUTER JOIN
          cbs_owner.RATE_CURRENCY_VALUES t15
             ON     t13.CURRENCY_CODE = t15.CURRENCY_CODE
                AND t15.SERVICE_VERSION_ID = 1
                AND t15.LANGUAGE_CODE = t4.LANGUAGE_CODE
          INNER JOIN cbs_owner.UNITS_TYPE_KEY t16
             ON t1.UNIT_TYPE = t16.UNIT_TYPE
          INNER JOIN cbs_owner.UNITS_TYPE_REF t17
             ON t16.UNIT_TYPE = t17.UNIT_TYPE AND t17.SERVICE_VERSION_ID = 1
          INNER JOIN
          cbs_owner.UNITS_TYPE_VALUES t18
             ON     t16.UNIT_TYPE = t18.UNIT_TYPE
                AND t18.SERVICE_VERSION_ID = t17.SERVICE_VERSION_ID
                AND t18.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_REF t19
             ON     t19.table_name = 'OFFER_RC_AWARD_MAP'
                AND t19.field_name = LOWER ('GRANT_ORDER')
                AND t19.integer_value = t1.GRANT_ORDER
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_VALUES t20
             ON     t20.table_name = t19.table_name
                AND t20.field_name = t19.field_name
                AND t20.integer_value = t19.integer_value
                AND t20.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_REF t21
             ON     t21.table_name = 'OFFER_RC_AWARD_MAP'
                AND t21.field_name = LOWER ('ACTION')
                AND t21.integer_value = t1.ACTION
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_VALUES t22
             ON     t22.table_name = t21.table_name
                AND t22.field_name = t21.field_name
                AND t22.integer_value = t21.integer_value
                AND t22.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_REF t23
             ON     t23.table_name = 'OFFER_RC_AWARD_MAP'
                AND t23.field_name = LOWER ('AWARD_ACTIVATION_TYPE')
                AND t23.integer_value = t1.AWARD_ACTIVATION_TYPE
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_VALUES t24
             ON     t24.table_name = t23.table_name
                AND t24.field_name = t23.field_name
                AND t24.integer_value = t23.integer_value
                AND t24.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_REF t25
             ON     t25.table_name = 'OFFER_RC_AWARD_MAP'
                AND t25.field_name = LOWER ('AWARD_EXPIRY_TYPE')
                AND t25.integer_value = t1.AWARD_EXPIRY_TYPE
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_VALUES t26
             ON     t26.table_name = t25.table_name
                AND t26.field_name = t25.field_name
                AND t26.integer_value = t25.integer_value
                AND t26.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_REF t27
             ON     t27.table_name = 'OFFER_RC_AWARD_MAP'
                AND t27.field_name = LOWER ('AWARD_EXPIRY_OFFSET_TYPE')
                AND t27.integer_value = t1.AWARD_EXPIRY_OFFSET_TYPE
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_VALUES t28
             ON     t28.table_name = t27.table_name
                AND t28.field_name = t27.field_name
                AND t28.integer_value = t27.integer_value
                AND t28.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t29
             ON     t29.enumeration_key = LOWER ('ROLLOVER_GROUPING')
                AND t29.VALUE = t1.ROLLOVER_GROUPING
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t30
             ON     t30.enumeration_key = t29.enumeration_key
                AND t30.VALUE = t29.VALUE
                AND t30.LANGUAGE_CODE = t4.LANGUAGE_CODE
          -- add rc term level dictionary
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_REF t44
             ON     t44.table_name = 'RC_TERM_REF'
                AND t44.field_name = LOWER ('LEVEL_CODE')
                AND t44.integer_value = t6.LEVEL_CODE
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_VALUES t45
             ON     t45.table_name = t44.table_name
                AND t45.field_name = t44.field_name
                AND t45.integer_value = t44.integer_value
                AND t45.LANGUAGE_CODE = t4.LANGUAGE_CODE
          -- add dic => period frequency
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_REF t63
             ON     t63.table_name = 'RATE_RC'
                AND t63.field_name = LOWER ('PERIOD_FREQUENCY')
                AND t63.integer_value = t1.GENERATION_PERIOD_FREQUENCY
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_VALUES t64
             ON     t64.table_name = t63.table_name
                AND t64.field_name = t63.field_name
                AND t64.integer_value = t63.integer_value
                AND t64.LANGUAGE_CODE = t4.LANGUAGE_CODE
          -- *** add offer_rc_term_map
          -- => Loai het nhung RC TERM khong duoc map trong GRAPH
          INNER JOIN
          CBS_OWNER.OFFER_RC_TERM_MAP t81
             ON     t81.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND T81.OFFER_ID = T1.OFFER_ID
                AND T81.RC_TERM_ID = T1.RC_TERM_ID;
