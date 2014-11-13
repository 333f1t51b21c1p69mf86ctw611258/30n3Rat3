DROP VIEW VNP_DATA.SECOND_RATED_CDR_VIEW;

/* Formatted on 09/05/2014 18:53:11 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW VNP_DATA.SECOND_RATED_CDR_VIEW
(
   TOTAL_CDR,
   A_NUMBER,
   BILL_MONTH,
   CDR_TYPE,
   PAYMENT_ITEM_ID,
   TO_TAL_USAGE,
   SERVICE_FREE,
   CHARGE_FEE,
   OFFER_COST,
   OFFER_FREE_BLOCK,
   INTERNAL_COST,
   INTERNAL_FREE_BLOCK
)
AS
     SELECT /*+ PARALLEL(FIRST_TEMP_RATED_CDR, 4) */
           COUNT (1) total_cdr,
            a_number,
            TO_DATE (TO_CHAR (cdr_start_time, 'MMyyyy'), 'MMyyyy') bill_month,
            cdr_type,
            payment_item_id,
            SUM (total_usage) to_tal_usage,
            SUM (service_fee) service_free,
            SUM (charge_fee) charge_fee,
            SUM (offer_cost) offer_cost,
            SUM (offer_free_block) offer_free_block,
            SUM (internal_cost) internal_cost,
            SUM (internal_free_block) internal_free_block
       FROM vnp_data.second_temp_rated_cdr
   GROUP BY a_number,
            cdr_type,
            payment_item_id,
            TO_DATE (TO_CHAR (cdr_start_time, 'MMyyyy'), 'MMyyyy');
