DROP VIEW VNP_DATA.TEMP_RATED_CDR_VIEW;

/* Formatted on 09/05/2014 18:53:11 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW VNP_DATA.TEMP_RATED_CDR_VIEW
(
   TOTAL_CDR,
   A_NUMBER,
   BILL_MONTH,
   CDR_TYPE,
   AUT_FINAL_ID,
   TOTAL_USAGE,
   SERVICE_FEE,
   CHARGE_FEE,
   OFFER_COST,
   OFFER_FREE_BLOCK,
   INTERNAL_COST,
   INTERNAL_FREE_BLOCK
)
AS
     SELECT COUNT (1) total_cdr,
            a_number,
            TO_DATE (TO_CHAR (cdr_start_time, 'MMyyyy'), 'MMyyyy') bill_month,
            CDR_TYPE,
            AUT_FINAL_ID,
            SUM (TOTAL_USAGE) AS TOTAL_USAGE,
            SUM (SERVICE_FEE) AS SERVICE_FEE,
            SUM (CHARGE_FEE) AS CHARGE_FEE,
            SUM (OFFER_COST) AS OFFER_COST,
            SUM (OFFER_FREE_BLOCK) AS OFFER_FREE_BLOCK,
            SUM (INTERNAL_COST) AS INTERNAL_COST,
            SUM (INTERNAL_FREE_BLOCK) INTERNAL_FREE_BLOCK
       FROM TEMP_RATED_CDR
   GROUP BY A_NUMBER,
            CDR_TYPE,
            AUT_FINAL_ID,
            TO_DATE (TO_CHAR (cdr_start_time, 'MMyyyy'), 'MMyyyy');
