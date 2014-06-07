DROP VIEW VNP_COMMON.AUDIT_SEGMENT_SELECT;

/* Formatted on 7/5/2014 07:58:07 (QP5 v5.227.12220.39754) */
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
   MODIFIED_DATE
)
AS
   SELECT ACCOUNT_VERSION_ID,
          ACCOUNT_ID,
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
          ACCOUNT_VERSION.TO_DATE AS TO_DATE_TEST,
            (ACCOUNT_VERSION.TO_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
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
             AS MODIFIED_DATE
     FROM ACCOUNT_VERSION;
