/* Formatted on 12/4/2014 22:40:17 (QP5 v5.227.12220.39754) */
SELECT t1.RC_TERM_ID AS rcTermId,
       t5.DISPLAY_VALUE AS levelCode,
       t2.DATE_ACTIVE AS dateActive,
       t2.DATE_INACTIVE AS dateInactive,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description,
       t7.DISPLAY_VALUE AS associationType
  FROM cbs_owner.RC_TERM_KEY t1
       INNER JOIN cbs_owner.RC_TERM_REF t2 ON t1.RC_TERM_ID = t2.RC_TERM_ID
       INNER JOIN
       cbs_owner.RC_TERM_VALUES t3
          ON     t2.RC_TERM_ID = t3.RC_TERM_ID
             AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
       LEFT OUTER JOIN
       cbs_owner.GUI_INDICATOR_REF t4
          ON     t4.table_name = 'RC_TERM_REF'
             AND t4.field_name = LOWER ('LEVEL_CODE')
             AND t4.integer_value = t2.LEVEL_CODE
       LEFT OUTER JOIN
       cbs_owner.GUI_INDICATOR_VALUES t5
          ON     t5.table_name = t4.table_name
             AND t5.field_name = t4.field_name
             AND t5.integer_value = t4.integer_value
             AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
       LEFT OUTER JOIN
       cbs_owner.GUI_INDICATOR_REF t6
          ON     t6.table_name = 'RC_TERM_REF'
             AND t6.field_name = LOWER ('ASSOCIATION_TYPE')
             AND t6.integer_value = t2.ASSOCIATION_TYPE
       LEFT OUTER JOIN
       cbs_owner.GUI_INDICATOR_VALUES t7
          ON     t7.table_name = t6.table_name
             AND t7.field_name = t6.field_name
             AND t7.integer_value = t6.integer_value
             AND t7.LANGUAGE_CODE = t3.LANGUAGE_CODE
 WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;