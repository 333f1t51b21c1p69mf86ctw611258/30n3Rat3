DROP PROCEDURE VNP_DATA.INSERT_2_ACCURATE_1;

CREATE OR REPLACE PROCEDURE VNP_DATA.insert_2_accurate_1
   (cdr_record_header_id IN NUMBER)
   IS
BEGIN
MERGE INTO  VNP_DATA.HOT_AGGREGATED_CDR ag
                            USING (SELECT   COUNT (1) total_cdr,
                            a_number,TO_NUMBER (SUBSTR (a_number, LENGTH (a_number), 1))
                            data_part, TO_CHAR ( (cdr_start_time), 'yyMM') bill_month,
                            cdr_type, SUM (total_usage) AS total_usage,
                            SUM (service_fee) AS service_fee,
                            SUM (charge_fee) AS charge_fee,
                            SUM (offer_cost) AS offer_cost,
                            SUM (offer_free_block) AS offer_free_block,
                            SUM (internal_cost) AS internal_cost,
                            SUM (internal_free_block) internal_free_block,
                            SUM (INTL_VND) INTL_VND,
                            payment_id
                            FROM  VNP_DATA.TEMP_RATED_CDR_1
                            WHERE   cdr_record_header_id =  cdr_record_header_id
                            GROUP BY   a_number,
                            cdr_type,
                            TO_CHAR ( (cdr_start_time), 'yyMM'),
                            payment_id) v
                            ON (ag.a_number = v.a_number
                            AND ag.bill_month = v.bill_month
                            AND ag.cdr_type = v.cdr_type
                            AND ag.payment_id = v.payment_id)
                            WHEN MATCHED THEN
                            UPDATE SET ag.total_cdr= ag.total_cdr + NVL (v.total_cdr, 0),
                            ag.total_usage= ag.total_usage + NVL (v.total_usage, 0),
                            ag.service_fee= ag.service_fee + NVL (v.service_fee, 0),
                            ag.charge_fee= ag.charge_fee + NVL (v.charge_fee, 0),
                            ag.offer_cost= ag.offer_cost + NVL (v.offer_cost, 0),
                            ag.offer_free_block= ag.offer_free_block + NVL (v.offer_free_block, 0),
                            ag.internal_cost= ag.internal_cost + NVL (v.internal_cost, 0),
                            ag.internal_free_block= ag.internal_free_block + NVL (v.internal_free_block, 0),
                            ag.INTL_VND= ag.INTL_VND + NVL (v.INTL_VND, 0)
                            WHEN NOT MATCHED THEN
                            INSERT (ag.a_number, ag.data_part, ag.cdr_type, ag.total_cdr, ag.bill_month, ag.total_usage, ag.service_fee, ag.charge_fee, ag.offer_cost, ag.offer_free_block, ag.internal_cost, ag.internal_free_block,ag.INTL_VND,ag.payment_id)
                            VALUES (v.a_number, v.data_part, v.cdr_type, v.total_cdr, v.bill_month, v.total_usage, v.service_fee, v.charge_fee, v.offer_cost, v.offer_free_block, v.internal_cost, v.internal_free_block,v.INTL_VND,v.payment_id);
EXCEPTION
   WHEN OTHERS
   THEN
      ROLLBACK;
END; -- Procedure
/
