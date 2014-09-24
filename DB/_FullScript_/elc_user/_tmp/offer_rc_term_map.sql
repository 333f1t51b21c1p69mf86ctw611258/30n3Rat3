
   SELECT t4.DISPLAY_VALUE AS offer_name,                         -- offerKey,
          t1.OFFER_ID AS offer_id,                                 -- offerId,
          t7.DISPLAY_VALUE AS rc_term_name,                      -- rcTermKey,
          t1.RC_TERM_ID AS rc_term_id,                            -- rcTermId,
          t1.RESELLER_VERSION_ID,                     -- AS resellerVersionId,
          -- *** add date range
          T6.DATE_ACTIVE,
          T6.DATE_INACTIVE                                                -- ,
     -- ### add date range
     --       t1.ASSOCIATION_TYPE AS associationType,
     --       t9.DISPLAY_VALUE AS autoActivationOverride,
     --       t11.DISPLAY_VALUE AS billPeriodRef,
     --       t1.BILL_PERIOD AS billPeriod,
     --       t13.DISPLAY_VALUE AS billingFrequencyRef,
     --       t1.PERIOD_FREQUENCY AS periodFrequency,
     --       t1.APPLY_DAY AS applyDay,
     --       t1.FROM_DATE_OFFSET AS fromDateOffset,
     --       t1.ADVANCE_PERIODS AS advancePeriods,
     --       t15.DISPLAY_VALUE AS chargePostactive,
     --       t1.RECOVERY_DURATION AS recoveryDuration,
     --       t17.DISPLAY_VALUE AS balanceDistributionMethod,
     --       t1.IS_FOR_CONTRACT AS isForContract,
     --       t1.CHARGE_ORDER AS chargeOrder,
     --       t1.IS_SUBSCRIPTION AS isSubscription
     FROM cbs_owner.OFFER_RC_TERM_MAP t1
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
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_REF t8
             ON     t8.table_name = 'OFFER_RC_TERM_MAP'
                AND t8.field_name = LOWER ('AUTO_ACTIVATION_OVERRIDE')
                AND t8.integer_value = t1.AUTO_ACTIVATION_OVERRIDE
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_VALUES t9
             ON     t9.table_name = t8.table_name
                AND t9.field_name = t8.field_name
                AND t9.integer_value = t8.integer_value
                AND t9.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.BILL_PERIOD_REF t10
             ON t1.BILL_PERIOD = t10.BILL_PERIOD
          LEFT OUTER JOIN
          cbs_owner.BILL_PERIOD_VALUES t11
             ON     t10.BILL_PERIOD = t11.BILL_PERIOD
                AND t11.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.BILLING_FREQUENCY_REF t12
             ON t1.PERIOD_FREQUENCY = t12.BILLING_FREQUENCY
          LEFT OUTER JOIN
          cbs_owner.BILLING_FREQUENCY_VALUES t13
             ON     t12.BILLING_FREQUENCY = t13.BILLING_FREQUENCY
                AND t13.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_REF t14
             ON     t14.enumeration_key = LOWER ('CHARGE_POSTACTIVE')
                AND t14.VALUE = t1.CHARGE_POSTACTIVE
          LEFT OUTER JOIN
          cbs_owner.GENERIC_ENUMERATION_VALUES t15
             ON     t15.enumeration_key = t14.enumeration_key
                AND t15.VALUE = t14.VALUE
                AND t15.LANGUAGE_CODE = t4.LANGUAGE_CODE
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_REF t16
             ON     t16.table_name = 'OFFER_RC_TERM_MAP'
                AND t16.field_name = LOWER ('BALANCE_DISTRIBUTION_METHOD')
                AND t16.integer_value = t1.BALANCE_DISTRIBUTION_METHOD
          LEFT OUTER JOIN
          cbs_owner.GUI_INDICATOR_VALUES t17
             ON     t17.table_name = t16.table_name
                AND t17.field_name = t16.field_name
                AND t17.integer_value = t16.integer_value
                AND t17.LANGUAGE_CODE = t4.LANGUAGE_CODE;
