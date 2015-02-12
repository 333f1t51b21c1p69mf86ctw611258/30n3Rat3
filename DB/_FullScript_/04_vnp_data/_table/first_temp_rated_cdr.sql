/* Formatted on 2/6/2015 10:47:15 AM (QP5 v5.269.14213.34746) */
DROP TABLE VNP_DATA.FIRST_TEMP_RATED_CDR CASCADE CONSTRAINTS;

CREATE TABLE VNP_DATA.FIRST_TEMP_RATED_CDR
(
   A_NUMBER               VARCHAR2 (31 BYTE),
   CDR_TYPE               NUMBER (2),
   CREATED_TIME           DATE DEFAULT SYSDATE,
   CDR_START_TIME         DATE,
   DURATION               NUMBER (11),
   TOTAL_USAGE            NUMBER (11),
   B_NUMBER               VARCHAR2 (31 BYTE),
   B_ZONE                 VARCHAR2 (127 BYTE),
   NW_GROUP               VARCHAR2 (7 BYTE),
   SERVICE_FEE            NUMBER (15, 3),
   SERVICE_FEE_ID         NUMBER (1),
   CHARGE_FEE             NUMBER (15, 3),
   CHARGE_FEE_ID          NUMBER (1),
   LAC                    VARCHAR2 (23 BYTE),
   CELL_ID                VARCHAR2 (23 BYTE),
   SUBSCRIBER_UNBILL      CHAR (1 BYTE),
   BU_ID                  NUMBER (3),
   OLD_BU_ID              NUMBER (3),
   OFFER_COST             NUMBER (15, 3),
   OFFER_FREE_BLOCK       NUMBER (11),
   INTERNAL_COST          NUMBER (15, 3),
   INTERNAL_FREE_BLOCK    NUMBER (11),
   DIAL_DIGIT             VARCHAR2 (31 BYTE),
   CDR_RECORD_HEADER_ID   NUMBER (11),
   CDR_SEQUENCE_NUMBER    NUMBER (11),
   LOCATION_NO            VARCHAR2 (31 BYTE),
   RERATE_FLAG            NUMBER (1),
   CALL_TYPE_ID           NUMBER (1),
   PAYMENT_ITEM_ID        NUMBER (3),
   MSC_ID                 VARCHAR2 (31 BYTE),
   ERROR_MESSAGE          VARCHAR2 (512 BYTE)
)
TABLESPACE VNP_DATA
RESULT_CACHE (MODE DEFAULT)
PCTUSED 0
PCTFREE 10
INITRANS 1
MAXTRANS 255
STORAGE (MAXSIZE UNLIMITED
         PCTINCREASE 0
         BUFFER_POOL DEFAULT
         FLASH_CACHE DEFAULT
         CELL_FLASH_CACHE DEFAULT)
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON COLUMN VNP_DATA.FIRST_TEMP_RATED_CDR.SERVICE_FEE IS
   'Phi goi cuoc dich vu';

COMMENT ON COLUMN VNP_DATA.FIRST_TEMP_RATED_CDR.SERVICE_FEE_ID IS
   'Ma cuoc goi dich vu';

COMMENT ON COLUMN VNP_DATA.FIRST_TEMP_RATED_CDR.CHARGE_FEE IS
   'Phi cuoi cung phai tra';

COMMENT ON COLUMN VNP_DATA.FIRST_TEMP_RATED_CDR.CHARGE_FEE_ID IS
   '1: Cuoc goi quoc te, 0: Cuoc goi trong nuoc';

COMMENT ON COLUMN VNP_DATA.FIRST_TEMP_RATED_CDR.SUBSCRIBER_UNBILL IS
   'La Thue bao nghiep vu? ''Y'' or ''N''';


CREATE INDEX VNP_DATA.F_RATED_CDR_A_NUMBER
   ON VNP_DATA.FIRST_TEMP_RATED_CDR (A_NUMBER)
   LOGGING
   TABLESPACE VNP_DATA
   PCTFREE 10
   INITRANS 2
   MAXTRANS 255
   STORAGE (INITIAL 1 M
            NEXT 1 M
            MAXSIZE UNLIMITED
            MINEXTENTS 1
            MAXEXTENTS UNLIMITED
            PCTINCREASE 0
            BUFFER_POOL DEFAULT
            FLASH_CACHE DEFAULT
            CELL_FLASH_CACHE DEFAULT)
   NOPARALLEL;

CREATE INDEX VNP_DATA.F_RATED_CDR_CDR_TYPE
   ON VNP_DATA.FIRST_TEMP_RATED_CDR (CDR_TYPE)
   LOGGING
   TABLESPACE VNP_DATA
   PCTFREE 10
   INITRANS 2
   MAXTRANS 255
   STORAGE (INITIAL 64 K
            NEXT 1 M
            MAXSIZE UNLIMITED
            MINEXTENTS 1
            MAXEXTENTS UNLIMITED
            PCTINCREASE 0
            BUFFER_POOL DEFAULT
            FLASH_CACHE DEFAULT
            CELL_FLASH_CACHE DEFAULT)
   NOPARALLEL;

CREATE INDEX VNP_DATA.F_RATED_CDR_CREATED_TIME
   ON VNP_DATA.FIRST_TEMP_RATED_CDR (CREATED_TIME)
   LOGGING
   TABLESPACE VNP_DATA
   PCTFREE 10
   INITRANS 2
   MAXTRANS 255
   STORAGE (INITIAL 64 K
            NEXT 1 M
            MAXSIZE UNLIMITED
            MINEXTENTS 1
            MAXEXTENTS UNLIMITED
            PCTINCREASE 0
            BUFFER_POOL DEFAULT
            FLASH_CACHE DEFAULT
            CELL_FLASH_CACHE DEFAULT)
   NOPARALLEL;

CREATE INDEX VNP_DATA.F_RATED_CDR_PAYMENT_ITEM_ID
   ON VNP_DATA.FIRST_TEMP_RATED_CDR (PAYMENT_ITEM_ID)
   LOGGING
   TABLESPACE VNP_DATA
   PCTFREE 10
   INITRANS 2
   MAXTRANS 255
   STORAGE (INITIAL 64 K
            NEXT 1 M
            MAXSIZE UNLIMITED
            MINEXTENTS 1
            MAXEXTENTS UNLIMITED
            PCTINCREASE 0
            BUFFER_POOL DEFAULT
            FLASH_CACHE DEFAULT
            CELL_FLASH_CACHE DEFAULT)
   NOPARALLEL;

CREATE OR REPLACE TRIGGER VNP_DATA.FIRST_TEMP_RATED_CDR_TRIGGER
   AFTER INSERT
   ON VNP_DATA.FIRST_TEMP_RATED_CDR
   FOR EACH ROW
   DISABLE
DECLARE
--v_username varchar2(10);

BEGIN
   --
   MERGE INTO vnp_data.aggregated_cdr a
        USING vnp_data.FIRST_TEMP_RATED_CDR b
           ON (    (a.a_number = b.a_number)
               AND (a.cdr_type = b.cdr_type)
               AND (a.payment_item_id = b.payment_item_id))
   WHEN MATCHED
   THEN
      UPDATE SET
         total_cdr = total_cdr + 1,
         bill_month = TO_DATE (TO_CHAR (b.cdr_start_time, 'MMyyyy'), 'MMyyyy'),
         total_usage = total_usage + b.total_usage,
         service_fee = service_fee + b.service_fee,
         charge_fee = charge_fee + b.charge_fee,
         offer_cost = offer_cost + b.offer_cost,
         offer_free_block = offer_free_block + b.offer_free_block,
         internal_cost = internal_cost + b.internal_cost,
         internal_free_block = internal_free_block + b.internal_free_block
              WHERE     a.a_number = b.a_number
                    AND a.cdr_type = b.cdr_type
                    AND a.payment_item_id = b.payment_item_id
   WHEN NOT MATCHED
   THEN
      INSERT     (a_number,
                  cdr_type,
                  total_cdr,
                  bill_month,
                  total_usage,
                  service_fee,
                  charge_fee,
                  offer_cost,
                  offer_free_block,
                  internal_cost,
                  internal_free_block,
                  payment_item_id)
          VALUES (b.a_number,
                  b.cdr_type,
                  1,
                  TO_DATE (TO_CHAR (b.cdr_start_time, 'MMyyyy'), 'MMyyyy'),
                  b.total_usage,
                  b.service_fee,
                  b.charge_fee,
                  b.offer_cost,
                  b.offer_free_block,
                  b.internal_cost,
                  b.internal_free_block,
                  b.payment_item_id);
END;
/


GRANT DELETE,
      INSERT,
      SELECT,
      UPDATE
   ON VNP_DATA.FIRST_TEMP_RATED_CDR
   TO VNP_COMMON;

GRANT SELECT ON VNP_DATA.FIRST_TEMP_RATED_CDR TO VNP_VIEW;