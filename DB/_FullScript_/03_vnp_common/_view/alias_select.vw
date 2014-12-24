DROP VIEW ALIAS_SELECT;

/* Formatted on 12/20/2014 2:52:20 AM (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW ALIAS_SELECT
(
   ACCOUNT_VERSION_ID,
   ALIAS,
   ACCOUNT_ID,
   SUBSCRIBER_NO,
   FROM_DATE_TEST,
   FROM_DATE,
   TO_DATE_TEST,
   TO_DATE,
   MODIFIED_DATE_TEST,
   MODIFIED_DATE,
   DATA_PART
)
AS
   SELECT ACCOUNT_VERSION_ID,
          SUBSCRIBER_NO AS ALIAS,
          ACCOUNT_ID,
          SUBSCRIBER_NO SUBSCRIBER_NO,
          ACCOUNT_VERSION.FROM_DATE AS FROM_DATE_TEST,
            (ACCOUNT_VERSION.FROM_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          * 24
          * 60
          * 60
             AS FROM_DATE,
          NVL (ACCOUNT_VERSION.TO_DATE, TO_DATE ('2030-01-01', 'yyyy-mm-dd'))
             AS TO_DATE_TEST,
            (  NVL (ACCOUNT_VERSION.TO_DATE,
                    TO_DATE ('2030-01-01', 'yyyy-mm-dd'))
             - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          * 24
          * 60
          * 60
             AS TO_DATE,
          ACCOUNT_VERSION.MODIFIED_DATE AS MODIFIED_DATE_TEST,
            (  ACCOUNT_VERSION.MODIFIED_DATE
             - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          * 24
          * 60
          * 60
             AS MODIFIED_DATE,
          SUBSCRIBER.DATA_PART
     FROM    SUBSCRIBER
          INNER JOIN
             ACCOUNT_VERSION
          ON (SUBSCRIBER.SUBSCRIBER_ID = ACCOUNT_VERSION.SUBSCRIBER_ID);
