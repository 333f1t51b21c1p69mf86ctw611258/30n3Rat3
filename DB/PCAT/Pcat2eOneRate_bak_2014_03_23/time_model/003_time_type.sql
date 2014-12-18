/* Formatted on 3/19/2014 11:14:00 PM (QP5 v5.227.12220.39754) */
SELECT t1.TIME_TYPE_ID AS timeTypeId,
       t2.RESELLER_VERSION_ID AS resellerVersionId,
       t2.IS_INTERNAL AS isInternal,
       t2.IS_DEFAULT AS isDefault,
       t2.RATE_PERIOD AS ratePeriod,
       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description
  FROM TIME_TYPE_KEY t1
       INNER JOIN TIME_TYPE_REF t2 ON t1.TIME_TYPE_ID = t2.TIME_TYPE_ID
       INNER JOIN
       TIME_TYPE_VALUES t3
          ON     t2.TIME_TYPE_ID = t3.TIME_TYPE_ID
             AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
 WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;