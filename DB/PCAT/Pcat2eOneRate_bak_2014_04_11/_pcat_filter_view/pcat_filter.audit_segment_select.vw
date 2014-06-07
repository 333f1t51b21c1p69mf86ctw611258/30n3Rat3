DROP VIEW PCAT_FILTER.AUDIT_SEGMENT_SELECT;

/* Formatted on 8/4/2014 15:32:17 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW PCAT_FILTER.AUDIT_SEGMENT_SELECT
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
