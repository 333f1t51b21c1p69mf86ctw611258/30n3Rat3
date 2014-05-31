/* Formatted on 4/7/2014 1:42:08 PM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW AUDIT_SEGMENT_SELECT
(
   ACCOUNT_VERSION_ID,
   ACCOUNT_ID,
   MSN,
   EFFECTIVE_DATE,
   FROM_DATE,
   TO_DATE,
   MODIFIED_DATE
)
AS
   SELECT ACCOUNT_VERSION_ID,
          ACCOUNT_ID,
          NULL MSN,
            (  ACCOUNT_VERSION.EFFECTIVE_DATE
             - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          * 24
          * 60
          * 60
             AS EFFECTIVE_DATE,
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
     FROM ACCOUNT_VERSION;