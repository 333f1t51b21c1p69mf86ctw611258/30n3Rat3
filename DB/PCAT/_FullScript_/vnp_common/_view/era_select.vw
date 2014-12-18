DROP VIEW VNP_COMMON.ERA_SELECT;

/* Formatted on 09/05/2014 18:31:51 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW VNP_COMMON.ERA_SELECT
(
   ACCOUNT_VERSION_ID,
   ERA_KEY,
   ERA_VALUE,
   MODIFIED_DATE
)
AS
   SELECT ACCOUNT_VERSION_ID,
          ERA_KEY,
          ERA_VALUE,
            (MODIFIED_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
          * 24
          * 60
          * 60
             AS MODIFIED_DATE
     FROM ERA;
