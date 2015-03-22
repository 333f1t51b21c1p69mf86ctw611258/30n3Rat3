DROP VIEW VNP_COMMON.AUDIT_SEGMENT_2_SELECT;

/* Formatted on 2/6/2015 9:56:50 AM (QP5 v5.269.14213.34746) */
CREATE OR REPLACE FORCE VIEW VNP_COMMON.AUDIT_SEGMENT_2_SELECT
(
   SUBSCRIBER_ID,
   SUBSCRIBER_NO,
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
   SELECT SUBSCRIBER_ID,
          SUBSCRIBER_NO,
          NULL MSN,
          EFFECTIVE_DATE AS EFFECTIVE_DATE_TEST,
            (EFFECTIVE_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          * 24
          * 60
          * 60
             AS EFFECTIVE_DATE,
          FROM_DATE AS FROM_DATE_TEST,
          (FROM_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd')) * 24 * 60 * 60
             AS FROM_DATE,
          NVL (TO_DATE, TO_DATE ('2030-01-01', 'yyyy-mm-dd')) AS TO_DATE_TEST,
            (  NVL (TO_DATE, TO_DATE ('2030-01-01', 'yyyy-mm-dd'))
             - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          * 24
          * 60
          * 60
             AS TO_DATE,
          --       TO_DATE AS TO_DATE_TEST,
          --         (TO_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          --       * 24
          --       * 60
          --       * 60
          --          AS TO_DATE,

          MODIFIED_DATE AS MODIFIED_DATE_TEST,
            (MODIFIED_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          * 24
          * 60
          * 60
             AS MODIFIED_DATE,
          DATA_PART
     FROM SUBSCRIBER;
