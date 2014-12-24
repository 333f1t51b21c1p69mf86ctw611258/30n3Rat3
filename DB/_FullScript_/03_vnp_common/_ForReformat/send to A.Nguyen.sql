Note ngày 04 - 01 - 2014

PCAT lấy được cái gì, phải change cái gì? Phải làm thế nào đấy được các trường khác?

-- CÁC CÂU LỆNH SQL LẤY DỮ LIỆU ĐƯỢC DÙNG TRONG CHƯƠNG TRÌNH EoneReformat

-- load PO DATA SQL
SELECT b.product_offer_version_id, a.b_number_enrich zone, a.product_group_type nw_group 
FROM vnp_common.product_offer a, vnp_common.product_offer_version b 
WHERE a.product_offer_id = b.product_offer_id 
AND (a.b_number_enrich is not null AND a.product_group_type is not null)


-- Load Balance
SELECT (balance_id ||'_'|| product_offer_version_id) key, offer_cost, internal_cost,rerate_flag 
FROM vnp_common.po_balance_map


-- CDR log process: 
INSERT INTO vnp_data.CDR_LOG_PROCESS (CDR_LOG_PROCESS_ID , SOURCE_FILE_URL, OUTPUT_FILE_URL, START_TIME, STATUS, METHOD, 
SOURCE_FILE_BEHAVIOR, BACKUP_FILE_URL) VALUES (?,?,?,SYSDATE,?,?,?,?)

-- insert Header
INSERT INTO vnp_data.cdr_record_header(cdr_record_header_id, Record_ID , Xor_Checksum , host_Name, start_Rcd_Seq, end_Rcd_Seq, file_Creation_Timestamp,file_LastUpdate_Timestamp,number_Of_Record, Checksum_Valid, Cdr_FileName) 
VALUES ('113563','CDR','8','slu1','0000000001','0000000006','05/21/2012 16:58:56','05/21/2012 17:59:00','0000000036',0,'TruongDH_MAI.VOICE.charge1balance.Nrecord.QTE.009090')


-- enrichRest update data

-- Điền thông tin: Mã tỉnh, mã tỉnh cũ, Unbill - thuê bao nghiệp vụ
UPDATE vnp_data.TRUONGDH_TEMP_RATED_CDR x SET bu_id = (SELECT a.bu_id FROM vnp_common.subs_bu_map a, vnp_common.subscriber b              
   WHERE b.subscriber_id = a.subscriber_id               
      AND b.subscriber_no = x.a_number                  AND x.cdr_start_time 
      between a.from_date and  decode(a.to_date , null, sysdate,a.to_date)                ), old_bu_id 
      = (SELECT a.bu_id FROM vnp_common.subs_bu_map a, vnp_common.subscriber b                   WHERE x.a_number = b.subscriber_no              
	  AND a.subscriber_id=b.subscriber_id                     AND a.from_date < (SELECT max(from_date) FROM vnp_common.subs_bu_map                 
	  WHERE from_date < x.cdr_start_time                                          AND subscriber_id=b.subscriber_id)                   ),
	  subscriber_unbill = (SELECT decode(a.unbill, '0', '0', '1')                            FROM vnp_common.rating_type a, vnp_common.subscriber b    
	  WHERE  a.rating_type_id = b.rating_type_id                               AND x.a_number = b.subscriber_no                            ) 
	  WHERE cdr_record_header_id = 113563
	  
	  
-- ratedCDRDao vQuery

(SELECT COUNT (1) total_cdr, a_number, TO_DATE (TO_CHAR (cdr_start_time, 'MMyyyy'), 'MMyyyy') bill_month, CDR_TYPE,PAYMENT_ITEM_ID,
SUM (TOTAL_USAGE) AS TOTAL_USAGE,SUM (SERVICE_FEE) AS SERVICE_FEE,SUM (CHARGE_FEE) AS CHARGE_FEE,SUM (OFFER_COST) AS OFFER_COST,
SUM (OFFER_FREE_BLOCK) AS OFFER_FREE_BLOCK,SUM (INTERNAL_COST) AS INTERNAL_COST,SUM (INTERNAL_FREE_BLOCK) INTERNAL_FREE_BLOCK 
FROM TRUONGDH_TEMP_RATED_CDR WHERE CDR_RECORD_HEADER_ID=113563 GROUP BY A_NUMBER,       CDR_TYPE,      PAYMENT_ITEM_ID,    
 TO_DATE (TO_CHAR (cdr_start_time, 'MMyyyy'), 'MMyyyy') ) 
 
 -- ratedCDRDao aggregatedCDR: 
 -- Lấy temp_rated_cdr trước khi chuyển vào hot_rated
 INSERT /*+ append parallel(,2)*/ INTO vnp_data.TRUONGDH_HOT_RATED_CDR nologging  
 SELECT * FROM vnp_data.TRUONGDH_TEMP_RATED_CDR WHERE cdr_record_header_id = 113563
 
 -- ratedCDRDao aggregatedCDR update
 -- update bảng Tổng hợp
 UPDATE vnp_data.TRUONGDH_HOT_AGGREGATED_CDR ag      SET (ag.total_cdr, ag.total_usage, ag.service_fee, ag.charge_fee, ag.offer_cost,
  ag.offer_free_block, ag.internal_cost, ag.internal_free_block) =    
   (SELECT             ag.total_cdr + nvl(v.total_cdr,0),            ag.total_usage + nvl(v.total_usage,0),        
       ag.service_fee + nvl(v.service_fee,0),            ag.charge_fee + nvl(v.charge_fee,0),          
         ag.offer_cost + nvl(v.offer_cost,0),            ag.offer_free_block + nvl(v.offer_free_block,0),       
              ag.internal_cost + nvl(v.internal_cost,0),            ag.internal_free_block + nvl(v.internal_free_block,0)  
                FROM   (SELECT COUNT (1) total_cdr, a_number, TO_DATE (TO_CHAR (cdr_start_time, 'MMyyyy'), 'MMyyyy') bill_month,
                 CDR_TYPE,PAYMENT_ITEM_ID,SUM (TOTAL_USAGE) AS TOTAL_USAGE,SUM (SERVICE_FEE) AS SERVICE_FEE,
                 SUM (CHARGE_FEE) AS CHARGE_FEE,SUM (OFFER_COST) AS OFFER_COST,SUM (OFFER_FREE_BLOCK) AS OFFER_FREE_BLOCK,
                 SUM (INTERNAL_COST) AS INTERNAL_COST,SUM (INTERNAL_FREE_BLOCK) INTERNAL_FREE_BLOCK 
                 FROM TRUONGDH_TEMP_RATED_CDR WHERE CDR_RECORD_HEADER_ID=113563 GROUP BY A_NUMBER,       CDR_TYPE,      PAYMENT_ITEM_ID,  
                    TO_DATE (TO_CHAR (cdr_start_time, 'MMyyyy'), 'MMyyyy') )  v        WHERE ag.a_number = v.a_number            
                    AND ag.bill_month = v.bill_month         AND ag.cdr_type = v.cdr_type         AND ag.payment_item_id = v.payment_item_id) 
                    WHERE EXISTS  (SELECT 1 FROM   (SELECT COUNT (1) total_cdr, a_number, 
                    TO_DATE (TO_CHAR (cdr_start_time, 'MMyyyy'), 'MMyyyy') bill_month, CDR_TYPE,PAYMENT_ITEM_ID,
                    SUM (TOTAL_USAGE) AS TOTAL_USAGE,SUM (SERVICE_FEE) AS SERVICE_FEE,SUM (CHARGE_FEE) AS CHARGE_FEE,
                    SUM (OFFER_COST) AS OFFER_COST,SUM (OFFER_FREE_BLOCK) AS OFFER_FREE_BLOCK,SUM (INTERNAL_COST) AS INTERNAL_COST,
                    SUM (INTERNAL_FREE_BLOCK) INTERNAL_FREE_BLOCK FROM TRUONGDH_TEMP_RATED_CDR WHERE CDR_RECORD_HEADER_ID=113563 
                    GROUP BY A_NUMBER,       CDR_TYPE,      PAYMENT_ITEM_ID,     TO_DATE (TO_CHAR (cdr_start_time, 'MMyyyy'), 'MMyyyy') )
                      x                  WHERE  x.a_number = ag.a_number AND x.bill_month = ag.bill_month AND x.cdr_type = ag.cdr_type 
                      AND x.payment_item_id = ag.payment_item_id                )
                      
                      
   -- insert Query_1
   -- Thêm mới vào bảng tổng hợp
   INSERT  /*+ PARALLEL(, 2) */ INTO vnp_data.TRUONGDH_HOT_AGGREGATED_CDR(a_number, cdr_type, total_cdr, bill_month, total_usage,
    service_fee, charge_fee, offer_cost, offer_free_block, internal_cost, internal_free_block, payment_item_id) 
    SELECT a_number, cdr_type, total_cdr, bill_month, total_usage, service_fee, charge_fee, offer_cost, offer_free_block,
     internal_cost, internal_free_block, payment_item_id FROM    (SELECT COUNT (1) total_cdr, a_number, 
     TO_DATE (TO_CHAR (cdr_start_time, 'MMyyyy'), 'MMyyyy') bill_month, CDR_TYPE,PAYMENT_ITEM_ID,SUM (TOTAL_USAGE) AS TOTAL_USAGE,
     SUM (SERVICE_FEE) AS SERVICE_FEE,SUM (CHARGE_FEE) AS CHARGE_FEE,SUM (OFFER_COST) AS OFFER_COST,SUM (OFFER_FREE_BLOCK)
      AS OFFER_FREE_BLOCK,SUM (INTERNAL_COST) AS INTERNAL_COST,SUM (INTERNAL_FREE_BLOCK) INTERNAL_FREE_BLOCK FROM TRUONGDH_TEMP_RATED_CDR 
      WHERE CDR_RECORD_HEADER_ID=113563 GROUP BY A_NUMBER,       CDR_TYPE,      PAYMENT_ITEM_ID,     TO_DATE (TO_CHAR (cdr_start_time, 'MMyyyy'),
       'MMyyyy') )  a  WHERE NOT EXISTS     (SELECT 1 FROM vnp_data.TRUONGDH_HOT_AGGREGATED_CDR x WHERE x.a_number = a.a_number 
       AND x.bill_month=a.bill_month AND x.cdr_type= a.cdr_type AND x.payment_item_id = a.payment_item_id)