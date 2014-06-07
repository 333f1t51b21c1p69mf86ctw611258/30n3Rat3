/* Formatted on 13/4/2014 11:03:22 (QP5 v5.227.12220.39754) */
SELECT T4.FIELD_NAME || '_' || T4.INTEGER_VALUE AS TERM_LEVEL_ID,
       T5.DISPLAY_VALUE AS TERM_LEVEL_NAME
  FROM GUI_INDICATOR_REF t4
       LEFT OUTER JOIN
       GUI_INDICATOR_VALUES t5
          ON     t5.table_name = t4.table_name
             AND t5.field_name = t4.field_name
             AND t5.integer_value = t4.integer_value
 WHERE t4.table_name = 'RC_TERM_REF' AND t4.field_name = LOWER ('LEVEL_CODE');

SELECT t13.FIELD_NAME || '_' || T13.INTEGER_VALUE AS TERM_LEVEL_ID,
       T14.DISPLAY_VALUE AS TERM_LEVEL_NAME
  FROM GUI_INDICATOR_REF t13
       LEFT OUTER JOIN
       GUI_INDICATOR_VALUES t14
          ON     t14.table_name = t13.table_name
             AND t14.field_name = t13.field_name
             AND t14.integer_value = t13.integer_value
 WHERE     t13.table_name = 'RATE_RC'
       AND t13.field_name = LOWER ('PERIOD_FREQUENCY');

SELECT *
  FROM GUI_INDICATOR_REF t13
 WHERE table_name LIKE '%AWARD%';