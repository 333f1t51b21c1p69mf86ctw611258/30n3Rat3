/* Formatted on 4/7/2014 1:40:01 PM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW ALIAS_SELECT
(
   ACCOUNT_VERSION_ID,
   ALIAS,
   ACCOUNT_ID,
   SUBSCRIBER_NO,
   FROM_DATE,
   TO_DATE,
   MODIFIED_DATE
)
AS
   SELECT ACCOUNT_VERSION_ID,
          SUBSCRIBER_NO AS ALIAS,
          ACCOUNT_ID,
          SUBSCRIBER_NO SUBSCRIBER_NO,
            (ACCOUNT_VERSION.FROM_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          * 24
          * 60
          * 60
             AS FROM_DATE,
            (ACCOUNT_VERSION.TO_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          * 24
          * 60
          * 60
             AS TO_DATE,
            (  ACCOUNT_VERSION.MODIFIED_DATE
             - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          * 24
          * 60
          * 60
             AS MODIFIED_DATE
     FROM SUBSCRIBER
          INNER JOIN ACCOUNT_VERSION
             ON (SUBSCRIBER.SUBSCRIBER_ID = ACCOUNT_VERSION.SUBSCRIBER_ID);