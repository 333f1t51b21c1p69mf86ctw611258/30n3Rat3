DROP VIEW VNP_COMMON.AUDIT_SEGMENT_SELECT;

/* Formatted on 2/6/2015 9:56:51 AM (QP5 v5.269.14213.34746) */
CREATE OR REPLACE FORCE VIEW VNP_COMMON.AUDIT_SEGMENT_SELECT
(
   ACCOUNT_VERSION_ID,
   ACCOUNT_ID,
   MSN,
   EFFECTIVE_DATE_TEST,
   EFFECTIVE_DATE,
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
          SUBSCRIBER.ACCOUNT_ID,
          NULL MSN,
          ACCOUNT_VERSION.EFFECTIVE_DATE AS EFFECTIVE_DATE_TEST,
            (  ACCOUNT_VERSION.EFFECTIVE_DATE
             - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          * 24
          * 60
          * 60
             AS EFFECTIVE_DATE,
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
          --       ACCOUNT_VERSION.TO_DATE AS TO_DATE_TEST,
          --         (ACCOUNT_VERSION.TO_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          --       * 24
          --       * 60
          --       * 60
          --          AS TO_DATE,

          ACCOUNT_VERSION.MODIFIED_DATE AS MODIFIED_DATE_TEST,
            (  ACCOUNT_VERSION.MODIFIED_DATE
             - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          * 24
          * 60
          * 60
             AS MODIFIED_DATE,
          DATA_PART
     FROM SUBSCRIBER
          INNER JOIN ACCOUNT_VERSION
             ON (SUBSCRIBER.SUBSCRIBER_ID = ACCOUNT_VERSION.SUBSCRIBER_ID);
